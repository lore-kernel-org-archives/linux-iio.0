Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40234 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab1JCO7y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2011 10:59:54 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/6] staging:iio:triggers Remove unecessary existence checks and return val
Date: Mon,  3 Oct 2011 16:08:11 +0100
Message-Id: <1317654496-14484-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
References: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Postenable and predisable are called via buffer->ops so  don't
need to check if buffer exists.

The return value of iio_device_register_trigger_consumer is
always zero and it isn't checked anyway so get rid of it.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio_core_trigger.h     |    2 +-
 drivers/staging/iio/industrialio-trigger.c |   16 +++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/iio_core_trigger.h b/drivers/staging/iio/iio_core_trigger.h
index 3e5195a..7f1bdc7 100644
--- a/drivers/staging/iio/iio_core_trigger.h
+++ b/drivers/staging/iio/iio_core_trigger.h
@@ -13,7 +13,7 @@
  * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
  * @dev_info: iio_dev associated with the device that will consume the trigger
  **/
-int iio_device_register_trigger_consumer(struct iio_dev *dev_info);
+void iio_device_register_trigger_consumer(struct iio_dev *dev_info);
 
 /**
  * iio_device_unregister_trigger_consumer() - reverse the registration process
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 3926649..97aaf8d 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -473,12 +473,10 @@ void iio_free_trigger(struct iio_trigger *trig)
 }
 EXPORT_SYMBOL(iio_free_trigger);
 
-int iio_device_register_trigger_consumer(struct iio_dev *dev_info)
+void iio_device_register_trigger_consumer(struct iio_dev *dev_info)
 {
 	dev_info->groups[dev_info->groupcounter++] =
 		&iio_trigger_consumer_attr_group;
-
-	return 0;
 }
 
 void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
@@ -490,18 +488,14 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
 
 int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
 {
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-					       indio_dev->pollfunc)
-		: 0;
+	return iio_trigger_attach_poll_func(indio_dev->trig,
+					    indio_dev->pollfunc);
 }
 EXPORT_SYMBOL(iio_triggered_buffer_postenable);
 
 int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
 {
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-						indio_dev->pollfunc)
-		: 0;
+	return iio_trigger_dettach_poll_func(indio_dev->trig,
+					     indio_dev->pollfunc);
 }
 EXPORT_SYMBOL(iio_triggered_buffer_predisable);
-- 
1.7.3.4

