Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-072.synserver.de ([212.40.185.72]:1056 "EHLO
	smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbcBZJgo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2016 04:36:44 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Remove periodic RTC trigger driver
Date: Fri, 26 Feb 2016 10:36:36 +0100
Message-Id: <1456479396-17252-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

With the recently introduced hrtimer based trigger we have a fully
functional replacement for the RTC timer trigger that is more flexible and
has a better interface to instantiate and manage the trigger instances. The
RTC trigger timer could only be instantiated using platform devices which
makes it unsuitable for modern devicetree based platforms, while the
hrtimer trigger has a configfs based interface that allows creating and
deletion of triggers at runtime.

In addition since a few years the periodic RTC timer is internally always
emulated using a hrtimer using the hrtimer interface directly will yield
the same timing precision. So using the RTC timer won't have any advantages
on this front either.

There is also no evidence that the periodic RTC trigger is currently
actually being used on any system. So considering all this remove the
driver. Also remove the related item from the TODO list.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/TODO                           |   8 -
 drivers/staging/iio/trigger/Kconfig                |  10 -
 drivers/staging/iio/trigger/Makefile               |   1 -
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    | 216 ---------------------
 4 files changed, 235 deletions(-)
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index c22a0ed..93a8968 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -58,14 +58,6 @@ different requirements.  This one suits mid range
 frequencies (100Hz - 4kHz).
 2) Lots of testing
 
-Periodic Timer trigger
-1) Move to a more general hardware periodic timer request
-subsystem. Current approach is abusing purpose of RTC.
-Initial discussions have taken place, but no actual code
-is in place as yet. This topic will be reopened on lkml
-shortly. I don't really envision this patch being merged
-in anything like its current form.
-
 GPIO trigger
 1) Add control over the type of interrupt etc.  This will
 necessitate a header that is also visible from arch board
diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
index 710a2f3..0b01d24 100644
--- a/drivers/staging/iio/trigger/Kconfig
+++ b/drivers/staging/iio/trigger/Kconfig
@@ -5,16 +5,6 @@ comment "Triggers - standalone"
 
 if IIO_TRIGGER
 
-config IIO_PERIODIC_RTC_TRIGGER
-	tristate "Periodic RTC triggers"
-	depends on RTC_CLASS
-	help
-	  Provides support for using periodic capable real time
-	  clocks as IIO triggers.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called iio-trig-periodic-rtc.
-
 config IIO_BFIN_TMR_TRIGGER
 	tristate "Blackfin TIMER trigger"
 	depends on BLACKFIN
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
index 238481b..1300a21 100644
--- a/drivers/staging/iio/trigger/Makefile
+++ b/drivers/staging/iio/trigger/Makefile
@@ -2,5 +2,4 @@
 # Makefile for triggers not associated with iio-devices
 #
 
-obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
 obj-$(CONFIG_IIO_BFIN_TMR_TRIGGER) += iio-trig-bfin-timer.o
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
deleted file mode 100644
index 00d1393..0000000
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/* The industrial I/O periodic RTC trigger driver
- *
- * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This is a heavily rewritten version of the periodic timer system in
- * earlier version of industrialio.  It supplies the same functionality
- * but via a trigger rather than a specific periodic timer system.
- */
-
-#include <linux/platform_device.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/rtc.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
-
-static LIST_HEAD(iio_prtc_trigger_list);
-static DEFINE_MUTEX(iio_prtc_trigger_list_lock);
-
-struct iio_prtc_trigger_info {
-	struct rtc_device *rtc;
-	unsigned int frequency;
-	struct rtc_task task;
-	bool state;
-};
-
-static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
-{
-	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
-	int ret;
-
-	if (trig_info->frequency == 0 && state)
-		return -EINVAL;
-	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %u\n",
-		trig_info->frequency);
-	ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
-	if (!ret)
-		trig_info->state = state;
-
-	return ret;
-}
-
-static ssize_t iio_trig_periodic_read_freq(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
-
-	return sprintf(buf, "%u\n", trig_info->frequency);
-}
-
-static ssize_t iio_trig_periodic_write_freq(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf,
-					    size_t len)
-{
-	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
-	unsigned int val;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-
-	if (val > 0) {
-		ret = rtc_irq_set_freq(trig_info->rtc, &trig_info->task, val);
-		if (ret == 0 && trig_info->state && trig_info->frequency == 0)
-			ret = rtc_irq_set_state(trig_info->rtc,
-						&trig_info->task, 1);
-	} else {
-		ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 0);
-	}
-	if (ret)
-		goto error_ret;
-
-	trig_info->frequency = val;
-
-	return len;
-
-error_ret:
-	return ret;
-}
-
-static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
-	    iio_trig_periodic_read_freq,
-	    iio_trig_periodic_write_freq);
-
-static struct attribute *iio_trig_prtc_attrs[] = {
-	&dev_attr_frequency.attr,
-	NULL,
-};
-
-static const struct attribute_group iio_trig_prtc_attr_group = {
-	.attrs = iio_trig_prtc_attrs,
-};
-
-static const struct attribute_group *iio_trig_prtc_attr_groups[] = {
-	&iio_trig_prtc_attr_group,
-	NULL
-};
-
-static void iio_prtc_trigger_poll(void *private_data)
-{
-	iio_trigger_poll(private_data);
-}
-
-static const struct iio_trigger_ops iio_prtc_trigger_ops = {
-	.owner = THIS_MODULE,
-	.set_trigger_state = &iio_trig_periodic_rtc_set_state,
-};
-
-static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
-{
-	char **pdata = dev->dev.platform_data;
-	struct iio_prtc_trigger_info *trig_info;
-	struct iio_trigger *trig, *trig2;
-
-	int i, ret;
-
-	for (i = 0;; i++) {
-		if (!pdata[i])
-			break;
-		trig = iio_trigger_alloc("periodic%s", pdata[i]);
-		if (!trig) {
-			ret = -ENOMEM;
-			goto error_free_completed_registrations;
-		}
-		list_add(&trig->alloc_list, &iio_prtc_trigger_list);
-
-		trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
-		if (!trig_info) {
-			ret = -ENOMEM;
-			goto error_put_trigger_and_remove_from_list;
-		}
-		iio_trigger_set_drvdata(trig, trig_info);
-		trig->ops = &iio_prtc_trigger_ops;
-		/* RTC access */
-		trig_info->rtc = rtc_class_open(pdata[i]);
-		if (!trig_info->rtc) {
-			ret = -EINVAL;
-			goto error_free_trig_info;
-		}
-		trig_info->task.func = iio_prtc_trigger_poll;
-		trig_info->task.private_data = trig;
-		ret = rtc_irq_register(trig_info->rtc, &trig_info->task);
-		if (ret)
-			goto error_close_rtc;
-		trig->dev.groups = iio_trig_prtc_attr_groups;
-		ret = iio_trigger_register(trig);
-		if (ret)
-			goto error_unregister_rtc_irq;
-	}
-	return 0;
-error_unregister_rtc_irq:
-	rtc_irq_unregister(trig_info->rtc, &trig_info->task);
-error_close_rtc:
-	rtc_class_close(trig_info->rtc);
-error_free_trig_info:
-	kfree(trig_info);
-error_put_trigger_and_remove_from_list:
-	list_del(&trig->alloc_list);
-	iio_trigger_put(trig);
-error_free_completed_registrations:
-	list_for_each_entry_safe(trig,
-				 trig2,
-				 &iio_prtc_trigger_list,
-				 alloc_list) {
-		trig_info = iio_trigger_get_drvdata(trig);
-		rtc_irq_unregister(trig_info->rtc, &trig_info->task);
-		rtc_class_close(trig_info->rtc);
-		kfree(trig_info);
-		iio_trigger_unregister(trig);
-	}
-	return ret;
-}
-
-static int iio_trig_periodic_rtc_remove(struct platform_device *dev)
-{
-	struct iio_trigger *trig, *trig2;
-	struct iio_prtc_trigger_info *trig_info;
-
-	mutex_lock(&iio_prtc_trigger_list_lock);
-	list_for_each_entry_safe(trig,
-				 trig2,
-				 &iio_prtc_trigger_list,
-				 alloc_list) {
-		trig_info = iio_trigger_get_drvdata(trig);
-		rtc_irq_unregister(trig_info->rtc, &trig_info->task);
-		rtc_class_close(trig_info->rtc);
-		kfree(trig_info);
-		iio_trigger_unregister(trig);
-	}
-	mutex_unlock(&iio_prtc_trigger_list_lock);
-	return 0;
-}
-
-static struct platform_driver iio_trig_periodic_rtc_driver = {
-	.probe = iio_trig_periodic_rtc_probe,
-	.remove = iio_trig_periodic_rtc_remove,
-	.driver = {
-		.name = "iio_prtc_trigger",
-	},
-};
-
-module_platform_driver(iio_trig_periodic_rtc_driver);
-
-MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
-MODULE_DESCRIPTION("Periodic realtime clock trigger for the iio subsystem");
-MODULE_LICENSE("GPL v2");
-- 
2.1.4

