Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:59721 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab2DSQF4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Apr 2012 12:05:56 -0400
Received: from localhost (col31-4-88-188-83-94.fbx.proxad.net [88.188.83.94])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 7BA08158
	for <linux-iio@vger.kernel.org>; Thu, 19 Apr 2012 18:04:51 +0200 (CEST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org
Subject: [PATCH 1/2] IIO: Add frequency sysfs files to triggers
Date: Thu, 19 Apr 2012 18:05:37 +0200
Message-Id: <1334851538-21408-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This allows to easily set the frequency for hardware triggers supporting
it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/staging/iio/industrialio-trigger.c |   65 ++++++++++++++++++++++++++-
 drivers/staging/iio/trigger.h              |    9 ++++
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 47ecadd..457ab15 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -51,6 +51,42 @@ static ssize_t iio_trigger_read_name(struct device *dev,
 
 static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
 
+static ssize_t iio_trigger_read_frequency(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_trigger *trig = dev_get_drvdata(dev);
+	return sprintf(buf, "%lu\n", trig->frequency);
+}
+
+static ssize_t iio_trigger_write_frequency(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t len)
+{
+	struct iio_trigger *trig = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	trig->frequency = val;
+
+	if (trig->ops->update_infos) {
+		ret = trig->ops->update_infos(trig, IIO_TRIGGER_INFO_FREQUENCY);
+		if (ret)
+			return ret;
+	}
+
+	return len;
+}
+
+static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
+		   iio_trigger_read_frequency,
+		   iio_trigger_write_frequency);
+
 /**
  * iio_trigger_register_sysfs() - create a device for this trigger
  * @trig_info:	the trigger
@@ -59,9 +95,29 @@ static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
  **/
 static int iio_trigger_register_sysfs(struct iio_trigger *trig_info)
 {
-	return sysfs_add_file_to_group(&trig_info->dev.kobj,
-				       &dev_attr_name.attr,
-				       NULL);
+	int ret;
+	ret = sysfs_add_file_to_group(&trig_info->dev.kobj,
+				      &dev_attr_name.attr,
+				      NULL);
+	if (ret)
+		goto name_error;
+
+	if (trig_info->info_mask & IIO_TRIGGER_INFO_FREQUENCY) {
+		ret = sysfs_add_file_to_group(&trig_info->dev.kobj,
+					      &dev_attr_frequency.attr,
+					      NULL);
+		if (ret)
+			goto frequency_error;
+	}
+
+	return 0;
+
+frequency_error:
+	sysfs_remove_file_from_group(&trig_info->dev.kobj,
+				     &dev_attr_name.attr,
+				     NULL);
+name_error:
+	return ret;
 }
 
 static void iio_trigger_unregister_sysfs(struct iio_trigger *trig_info)
@@ -69,6 +125,9 @@ static void iio_trigger_unregister_sysfs(struct iio_trigger *trig_info)
 	sysfs_remove_file_from_group(&trig_info->dev.kobj,
 					   &dev_attr_name.attr,
 					   NULL);
+	sysfs_remove_file_from_group(&trig_info->dev.kobj,
+					   &dev_attr_frequency.attr,
+					   NULL);
 }
 
 int iio_trigger_register(struct iio_trigger *trig_info)
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 1cfca23..a258ef8 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -16,6 +16,8 @@ struct iio_subirq {
 	bool enabled;
 };
 
+#define IIO_TRIGGER_INFO_FREQUENCY	(1 << 0)
+
 /**
  * struct iio_trigger_ops - operations structure for an iio_trigger.
  * @owner:		used to monitor usage count of the trigger.
@@ -32,6 +34,8 @@ struct iio_trigger_ops {
 	struct module			*owner;
 	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
 	int (*try_reenable)(struct iio_trigger *trig);
+	int (*update_infos)(struct iio_trigger *trig,
+			    const unsigned long info_mask);
 	int (*validate_device)(struct iio_trigger *trig,
 			       struct iio_dev *indio_dev);
 };
@@ -52,6 +56,9 @@ struct iio_trigger_ops {
  * @subirqs:		[INTERN] information about the 'child' irqs.
  * @pool:		[INTERN] bitmap of irqs currently in use.
  * @pool_lock:		[INTERN] protection of the irq pool.
+ * @frequency:		[DRIVER] frequency of the trigger in Hz.
+ * @info_mask:		[DRIVER] What informations are to be exported in the
+ *			sysfs directory: frequency, etc....
  **/
 struct iio_trigger {
 	const struct iio_trigger_ops	*ops;
@@ -70,6 +77,8 @@ struct iio_trigger {
 	struct iio_subirq subirqs[CONFIG_IIO_CONSUMERS_PER_TRIGGER];
 	unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
 	struct mutex			pool_lock;
+	unsigned long			frequency;
+	long				info_mask;
 };
 
 
-- 
1.7.5.4

