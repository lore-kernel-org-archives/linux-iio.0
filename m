Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org,
	lars@metafoo.de,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com,
	daniel.baluta@intel.com
Subject: [PATCH 2/3] iio: trigger: Add support for highres timer trigger
Date: Wed, 25 Mar 2015 19:00:31 +0200
Message-Id: <1427302832-9336-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com>
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds an IIO trigger driver which uses a high resolution
timer to provide a frequency based trigger.

Signed-off-by: Marten Svanfeldt <marten@intuitiveaerial.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/industrialio-configfs.c      |   4 +
 drivers/iio/trigger/Kconfig              |   8 ++
 drivers/iio/trigger/Makefile             |   2 +
 drivers/iio/trigger/iio-trig-hrtimer.c   | 146 +++++++++++++++++++++++++++++++
 include/linux/iio/iio_configfs_trigger.h |   1 +
 5 files changed, 161 insertions(+)
 create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c

diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
index 4d2133a..22740c0 100644
--- a/drivers/iio/industrialio-configfs.c
+++ b/drivers/iio/industrialio-configfs.c
@@ -17,6 +17,7 @@
 static const char *trigger_types[] =
 {
 	"none",
+	"hrtimer",
 };
 
 struct iio_configfs_ops iio_none_ops = {
@@ -59,6 +60,9 @@ void iio_trigger_set_configfs_ops(struct iio_configfs_trigger_info *trig_info,
 	case IIO_TRIGGER_TYPE_NONE:
 		trig_info->configfs_ops = &iio_none_ops;
 		break;
+	case IIO_TRIGGER_TYPE_HRTIMER:
+		trig_info->configfs_ops = &iio_hrtimer_ops;
+		break;
 	default:
 		pr_err("Setting configfs ops failed! Unknown type %d\n", type);
 		break;
diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index 7999612..c856664 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -5,6 +5,14 @@
 
 menu "Triggers - standalone"
 
+config IIO_TRIGGER_HRTIMER
+	tristate "High resolution timer trigger"
+	help
+	  Provides a frequency based IIO trigger using hrtimers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-trig-hrtimer.
+
 config IIO_INTERRUPT_TRIGGER
 	tristate "Generic interrupt trigger"
 	help
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index 0694dae..3d289f6 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -3,5 +3,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_IIO_TRIGGER_HRTIMER) += iio-trig-hrtimer.o
 obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
new file mode 100644
index 0000000..1a8beaf
--- /dev/null
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -0,0 +1,146 @@
+/**
+ * The industrial I/O periodic hrtimer trigger driver
+ *
+ * Copyright (C) Intuitive Aerial AB
+ * Written by Marten Svanfeldt, marten@intuitiveaerial.com
+ * Copyright (C) 2012, Analog Device Inc.
+ *	Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/hrtimer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/iio_configfs_trigger.h>
+
+struct iio_hrtimer_trig_info {
+	struct iio_configfs_trigger_info *configfs_info;
+	unsigned int frequency;
+	struct hrtimer timer;
+	ktime_t period;
+};
+
+static enum hrtimer_restart iio_trig_hrtimer_trig(struct hrtimer *timer)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = container_of(timer, struct iio_hrtimer_trig_info, timer);
+
+	hrtimer_forward_now(timer, trig_info->period);
+	iio_trigger_poll(trig_info->configfs_info->trigger);
+
+	return HRTIMER_RESTART;
+}
+
+static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(trig);
+
+	if (trig_info->frequency == 0)
+		return -EINVAL;
+
+	if (state) {
+		hrtimer_start(&trig_info->timer, trig_info->period,
+			HRTIMER_MODE_REL);
+	} else {
+		hrtimer_cancel(&trig_info->timer);
+	}
+
+	return 0;
+}
+
+int iio_trig_hrtimer_read_freq(struct iio_configfs_trigger_info *cinfo)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(cinfo->trigger);
+	return trig_info->frequency;
+}
+
+int iio_trig_hrtimer_write_freq(struct iio_configfs_trigger_info *cinfo,
+				unsigned long freq)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(cinfo->trigger);
+
+	if (freq > NSEC_PER_SEC)
+		return -EINVAL;
+
+	if (freq != 0)
+		trig_info->period = ktime_set(0, NSEC_PER_SEC / freq);
+	trig_info->frequency = freq;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops iio_hrtimer_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = iio_trig_hrtimer_set_state,
+};
+
+static int iio_trig_hrtimer_probe(struct iio_configfs_trigger_info *cinfo)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+	int ret;
+
+	trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
+	if (!trig_info)
+		return -ENOMEM;
+
+	trig_info->configfs_info = cinfo;
+
+	cinfo->trigger = iio_trigger_alloc("%s", cinfo->name);
+	if (!cinfo->trigger)
+		return -ENOMEM;
+
+	iio_trigger_set_drvdata(cinfo->trigger, trig_info);
+	cinfo->trigger->ops = &iio_hrtimer_trigger_ops;
+
+	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	trig_info->timer.function = iio_trig_hrtimer_trig;
+	ret = iio_trigger_register(cinfo->trigger);
+	if (ret)
+		goto err_free_trigger;
+
+	return 0;
+err_free_trigger:
+	iio_trigger_free(cinfo->trigger);
+
+	return ret;
+}
+
+static int iio_trig_hrtimer_remove(struct iio_configfs_trigger_info *cinfo)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(cinfo->trigger);
+
+	iio_trigger_unregister(cinfo->trigger);
+	hrtimer_cancel(&trig_info->timer);
+	iio_trigger_free(cinfo->trigger);
+
+	return 0;
+}
+
+struct iio_configfs_ops iio_hrtimer_ops = {
+	.get_freq = iio_trig_hrtimer_read_freq,
+	.set_freq = iio_trig_hrtimer_write_freq,
+	.probe = iio_trig_hrtimer_probe,
+	.remove = iio_trig_hrtimer_remove,
+};
+EXPORT_SYMBOL(iio_hrtimer_ops);
+
+MODULE_AUTHOR("Marten Svanfeldt <marten@intuitiveaerial.com>");
+MODULE_DESCRIPTION("Periodic hrtimer trigger for the IIO subsystem");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/iio_configfs_trigger.h b/include/linux/iio/iio_configfs_trigger.h
index e7b5777..1390474 100644
--- a/include/linux/iio/iio_configfs_trigger.h
+++ b/include/linux/iio/iio_configfs_trigger.h
@@ -2,6 +2,7 @@
 #define __IIO_CONFIGFS_TRIGGER
 
 #define IIO_TRIGGER_TYPE_NONE		0
+#define IIO_TRIGGER_TYPE_HRTIMER	1
 
 struct iio_configfs_trigger_info {
 	const char *name;
-- 
1.9.1
