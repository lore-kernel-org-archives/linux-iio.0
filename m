Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49232 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab1HXQUc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2011 12:20:32 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 8/9] staging:iio:trigger core. Trivial code cleanups.
Date: Wed, 24 Aug 2011 17:28:40 +0100
Message-Id: <1314203321-21926-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
References: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Stop exporting functions only intended for core usage.
Return void from function which can never return anything other than 0.
Trivial stype cleanups.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio_core_trigger.h     |    5 ++---
 drivers/staging/iio/industrialio-trigger.c |   22 +++++++---------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/iio_core_trigger.h b/drivers/staging/iio/iio_core_trigger.h
index 9d52d96..3e5195a 100644
--- a/drivers/staging/iio/iio_core_trigger.h
+++ b/drivers/staging/iio/iio_core_trigger.h
@@ -19,7 +19,7 @@ int iio_device_register_trigger_consumer(struct iio_dev *dev_info);
  * iio_device_unregister_trigger_consumer() - reverse the registration process
  * @dev_info: iio_dev associated with the device that consumed the trigger
  **/
-int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info);
+void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info);
 
 #else
 
@@ -36,9 +36,8 @@ static int iio_device_register_trigger_consumer(struct iio_dev *dev_info)
  * iio_device_unregister_trigger_consumer() - reverse the registration process
  * @dev_info: iio_dev associated with the device that consumed the trigger
  **/
-static int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
+static void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
 {
-	return 0;
 };
 
 #endif /* CONFIG_TRIGGER_CONSUMER */
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 1013442..72ea106 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -174,13 +174,12 @@ static struct iio_trigger *iio_trigger_find_by_name(const char *name,
 void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 {
 	int i;
-	if (!trig->use_count) {
+	if (!trig->use_count)
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
 			if (trig->subirqs[i].enabled) {
 				trig->use_count++;
 				generic_handle_irq(trig->subirq_base + i);
 			}
-	}
 }
 EXPORT_SYMBOL(iio_trigger_poll);
 
@@ -322,12 +321,10 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 					char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	int len = 0;
+
 	if (dev_info->trig)
-		len = sprintf(buf,
-			      "%s\n",
-			      dev_info->trig->name);
-	return len;
+		return sprintf(buf, "%s\n", dev_info->trig->name);
+	return 0;
 }
 
 /**
@@ -496,23 +493,18 @@ EXPORT_SYMBOL(iio_free_trigger);
 
 int iio_device_register_trigger_consumer(struct iio_dev *dev_info)
 {
-	int ret;
-	ret = sysfs_create_group(&dev_info->dev.kobj,
-				 &iio_trigger_consumer_attr_group);
-	return ret;
+	return sysfs_create_group(&dev_info->dev.kobj,
+				  &iio_trigger_consumer_attr_group);
 }
-EXPORT_SYMBOL(iio_device_register_trigger_consumer);
 
-int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
+void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
 {
 	/* Clean up and associated but not attached triggers references */
 	if (dev_info->trig)
 		iio_put_trigger(dev_info->trig);
 	sysfs_remove_group(&dev_info->dev.kobj,
 			   &iio_trigger_consumer_attr_group);
-	return 0;
 }
-EXPORT_SYMBOL(iio_device_unregister_trigger_consumer);
 
 int iio_triggered_ring_postenable(struct iio_dev *indio_dev)
 {
-- 
1.7.3.4

