Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: move id and device name setting to iio_device_allocate.
Date: Fri,  9 Sep 2011 15:56:07 +0100
Message-Id: <1315580167-26422-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <4E6A2560.1050204@cam.ac.uk>
References: <4E6A2560.1050204@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The recent reorganization of the sysfs attribute registration had
the side effect of moving iio_device_register after registration of
triggers etc.  The side effect of this is that the id hadn't been
allocated by the time of trigger registration. Thus all triggers
based on device got the name <dev_name>-dev0 instead of <dev_name>-devN
where N is the iio device id.

This should also fix the lack of device name for some error messages
that we have been seeing (and I'd been meaning to track down) as
that has now moved earlier as well.

Reported-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index fd4aada..8486914 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1033,6 +1033,15 @@ struct iio_dev *iio_allocate_device(int sizeof_priv)
 		device_initialize(&dev->dev);
 		dev_set_drvdata(&dev->dev, (void *)dev);
 		mutex_init(&dev->mlock);
+
+		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
+		if (dev->id < 0) {
+			/* cannot use a dev_err as the name isn't available */
+			printk(KERN_ERR "Failed to get id\n");
+			kfree(dev);
+			return NULL; 
+		}
+		dev_set_name(&dev->dev, "iio:device%d", dev->id);
 	}
 
 	return dev;
@@ -1041,8 +1050,10 @@ EXPORT_SYMBOL(iio_allocate_device);
 
 void iio_free_device(struct iio_dev *dev)
 {
-	if (dev)
+	if (dev) {
+		ida_simple_remove(&iio_ida, dev->id);
 		kfree(dev);
+	}
 }
 EXPORT_SYMBOL(iio_free_device);
 
@@ -1100,14 +1111,6 @@ int iio_device_register(struct iio_dev *dev_info)
 {
 	int ret;
 
-	dev_info->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
-	if (dev_info->id < 0) {
-		ret = dev_info->id;
-		dev_err(&dev_info->dev, "Failed to get id\n");
-		goto error_ret;
-	}
-	dev_set_name(&dev_info->dev, "iio:device%d", dev_info->id);
-
 	/* configure elements for the chrdev */
 	dev_info->dev.devt = MKDEV(MAJOR(iio_devt), dev_info->id);
 
@@ -1115,7 +1118,7 @@ int iio_device_register(struct iio_dev *dev_info)
 	if (ret) {
 		dev_err(dev_info->dev.parent,
 			"Failed to register sysfs interfaces\n");
-		goto error_free_ida;
+		goto error_ret;
 	}
 	ret = iio_device_register_eventset(dev_info);
 	if (ret) {
@@ -1142,8 +1145,6 @@ error_unreg_eventset:
 	iio_device_unregister_eventset(dev_info);
 error_free_sysfs:
 	iio_device_unregister_sysfs(dev_info);
-error_free_ida:
-	ida_simple_remove(&iio_ida, dev_info->id);
 error_ret:
 	return ret;
 }
-- 
1.7.3.4
