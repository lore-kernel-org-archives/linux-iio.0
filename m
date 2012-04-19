Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:59727 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab2DSQGD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Apr 2012 12:06:03 -0400
Received: from localhost (col31-4-88-188-83-94.fbx.proxad.net [88.188.83.94])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 7F32815C
	for <linux-iio@vger.kernel.org>; Thu, 19 Apr 2012 18:04:52 +0200 (CEST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org
Subject: [PATCH 2/2] Move RTC trigger to in-core frequency support
Date: Thu, 19 Apr 2012 18:05:38 +0200
Message-Id: <1334851538-21408-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   50 ++++----------------
 1 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index a80cf67..ffabf80 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -24,7 +24,6 @@ static DEFINE_MUTEX(iio_prtc_trigger_list_lock);
 
 struct iio_prtc_trigger_info {
 	struct rtc_device *rtc;
-	int frequency;
 	struct rtc_task task;
 };
 
@@ -37,50 +36,19 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
 	return rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
 }
 
-static ssize_t iio_trig_periodic_read_freq(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static int update_infos(struct iio_trigger *trig, const unsigned long mask)
 {
-	struct iio_trigger *trig = dev_get_drvdata(dev);
 	struct iio_prtc_trigger_info *trig_info = trig->private_data;
-	return sprintf(buf, "%u\n", trig_info->frequency);
-}
-
-static ssize_t iio_trig_periodic_write_freq(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf,
-					    size_t len)
-{
-	struct iio_trigger *trig = dev_get_drvdata(dev);
-	struct iio_prtc_trigger_info *trig_info = trig->private_data;
-	unsigned long val;
-	int ret;
-
-	ret = strict_strtoul(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-
-	ret = rtc_irq_set_freq(trig_info->rtc, &trig_info->task, val);
-	if (ret)
-		goto error_ret;
-
-	trig_info->frequency = val;
 
-	return len;
-
-error_ret:
-	return ret;
+	switch (mask) {
+	case IIO_TRIGGER_INFO_FREQUENCY:
+		return rtc_irq_set_freq(trig_info->rtc, &trig_info->task,
+					trig->frequency);
+	default:
+		return 0;
+	}
 }
 
-static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
-	    iio_trig_periodic_read_freq,
-	    iio_trig_periodic_write_freq);
-
-static struct attribute *iio_trig_prtc_attrs[] = {
-	&dev_attr_frequency.attr,
-	NULL,
-};
-
 static const struct attribute_group iio_trig_prtc_attr_group = {
 	.attrs = iio_trig_prtc_attrs,
 };
@@ -99,6 +67,7 @@ static void iio_prtc_trigger_poll(void *private_data)
 static const struct iio_trigger_ops iio_prtc_trigger_ops = {
 	.owner = THIS_MODULE,
 	.set_trigger_state = &iio_trig_periodic_rtc_set_state,
+	.update_infos = &iio_trig_periodic_rtc_update_infos,
 };
 
 static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
@@ -124,6 +93,7 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 			ret = -ENOMEM;
 			goto error_put_trigger_and_remove_from_list;
 		}
+		trig->info_mask = IIO_TRIGGER_INFO_FREQUENCY;
 		trig->private_data = trig_info;
 		trig->ops = &iio_prtc_trigger_ops;
 		/* RTC access */
-- 
1.7.5.4

