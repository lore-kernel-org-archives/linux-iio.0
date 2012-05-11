Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-184.synserver.de ([212.40.185.184]:1306 "EHLO
	smtp-out-167.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754192Ab2EKLoL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 07:44:11 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: Fix potential use after free
Date: Fri, 11 May 2012 13:46:56 +0200
Message-Id: <1336736816-15678-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1336736816-15678-1-git-send-email-lars@metafoo.de>
References: <1336736816-15678-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no guarantee that the last reference to the iio device has already been
dropped when iio_device_free is called. This means that we can up calling
iio_dev_release after iio_device_free which will lead to a use after free. As
the general rule the struct containing the device should always be freed in the
release callback.

This is what this patch does it moves freeing the iio device struct as well as
releasing the idr reference to the release callback. To ensure that the device
is not freed before calling iio_device_free the device_unregister call in
iio_device_unregister is broken apart. iio_device_unregister will now only call
device_del to remove the device from the system and iio_device_free will call
put_device to drop the reference we obtained in iio_devce_alloc.

We also have to take care that calling iio_device_free without having called
iio_device_register still works (i.e. this can happen if something failed during
device initialization). For this to work properly two minor changes were
necessary: channel_attr_list needs to be initialized in iio_device_alloc and we
have to check whether the chrdev has been registered before releasing it in
iio_device_release.

This change also brings iio_device_unregister and iio_device_free more in sync
with iio_device_register and iio_device_alloc which call device_add and
device_initialize respectively.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b39a587..3b57f80 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -653,7 +653,6 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	 * New channel registration method - relies on the fact a group does
 	 * not need to be initialized if it is name is NULL.
 	 */
-	INIT_LIST_HEAD(&indio_dev->channel_attr_list);
 	if (indio_dev->channels)
 		for (i = 0; i < indio_dev->num_channels; i++) {
 			ret = iio_device_add_channel_sysfs(indio_dev,
@@ -717,12 +716,16 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *indio_dev = container_of(device, struct iio_dev, dev);
-	cdev_del(&indio_dev->chrdev);
+	if (indio_dev->chrdev.dev)
+		cdev_del(&indio_dev->chrdev);
 	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
 	iio_device_unregister_debugfs(indio_dev);
+
+	ida_simple_remove(&iio_ida, indio_dev->id);
+	kfree(indio_dev);
 }
 
 static struct device_type iio_dev_type = {
@@ -753,6 +756,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 		dev_set_drvdata(&dev->dev, (void *)dev);
 		mutex_init(&dev->mlock);
 		mutex_init(&dev->info_exist_lock);
+		INIT_LIST_HEAD(&dev->channel_attr_list);
 
 		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
 		if (dev->id < 0) {
@@ -770,10 +774,8 @@ EXPORT_SYMBOL(iio_device_alloc);
 
 void iio_device_free(struct iio_dev *dev)
 {
-	if (dev) {
-		ida_simple_remove(&iio_ida, dev->id);
-		kfree(dev);
-	}
+	if (dev)
+		put_device(&dev->dev);
 }
 EXPORT_SYMBOL(iio_device_free);
 
@@ -894,7 +896,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	mutex_lock(&indio_dev->info_exist_lock);
 	indio_dev->info = NULL;
 	mutex_unlock(&indio_dev->info_exist_lock);
-	device_unregister(&indio_dev->dev);
+	device_del(&indio_dev->dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
 subsys_initcall(iio_init);
-- 
1.7.10

