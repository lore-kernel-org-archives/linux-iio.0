Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:42954 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab1H3LdL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2011 07:33:11 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/14] staging:iio: remove defunct iio_put and iio_get.
Date: Tue, 30 Aug 2011 12:41:08 +0100
Message-Id: <1314704479-15956-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
References: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All iio dependent modules statically depend on industrialio
so these aren't needed. Not sure why they originally existed,
but they aren't now.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio_core.h             |   10 ----------
 drivers/staging/iio/industrialio-core.c    |   17 +----------------
 drivers/staging/iio/industrialio-trigger.c |    2 --
 3 files changed, 1 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index 433952b..edc295e 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -13,16 +13,6 @@
 #ifndef _IIO_CORE_H_
 #define _IIO_CORE_H_
 
-/**
- * iio_put() - internal module reference count reduce
- **/
-void iio_put(void);
-
-/**
- * iio_get() - internal module reference count increase
- **/
-void iio_get(void);
-
 int __iio_add_chan_devattr(const char *postfix,
 			   const char *group,
 			   struct iio_chan_spec const *chan,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 13f8c82..8b8e1fb 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1018,7 +1018,6 @@ static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *dev_info = container_of(device, struct iio_dev, dev);
 	cdev_del(&dev_info->chrdev);
-	iio_put();
 	kfree(dev_info);
 }
 
@@ -1048,7 +1047,6 @@ struct iio_dev *iio_allocate_device(int sizeof_priv)
 		device_initialize(&dev->dev);
 		dev_set_drvdata(&dev->dev, (void *)dev);
 		mutex_init(&dev->mlock);
-		iio_get();
 	}
 
 	return dev;
@@ -1057,10 +1055,8 @@ EXPORT_SYMBOL(iio_allocate_device);
 
 void iio_free_device(struct iio_dev *dev)
 {
-	if (dev) {
-		iio_put();
+	if (dev)
 		kfree(dev);
-	}
 }
 EXPORT_SYMBOL(iio_free_device);
 
@@ -1173,17 +1169,6 @@ void iio_device_unregister(struct iio_dev *dev_info)
 	device_unregister(&dev_info->dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
-
-void iio_put(void)
-{
-	module_put(THIS_MODULE);
-}
-
-void iio_get(void)
-{
-	__module_get(THIS_MODULE);
-}
-
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index b99d14e..3e60406 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -394,7 +394,6 @@ static void iio_trig_release(struct device *device)
 	}
 	kfree(trig->name);
 	kfree(trig);
-	iio_put();
 }
 
 static struct device_type iio_trig_type = {
@@ -461,7 +460,6 @@ struct iio_trigger *iio_allocate_trigger(const char *fmt, ...)
 					  IRQ_NOREQUEST | IRQ_NOAUTOEN,
 					  IRQ_NOPROBE);
 		}
-		iio_get();
 		get_device(&trig->dev);
 	}
 	return trig;
-- 
1.7.3.4

