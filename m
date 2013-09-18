Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-014.synserver.de ([212.40.185.14]:1077 "EHLO
	smtp-out-011.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753334Ab3IRUBX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 16:01:23 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/10] iio: Set the IIO device as the parent for the character device
Date: Wed, 18 Sep 2013 22:02:47 +0200
Message-Id: <1379534574-11213-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-1-git-send-email-lars@metafoo.de>
References: <1379534574-11213-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We need to make sure that the IIO device is not freed while the character device
exists, otherwise the freeing of the IIO device might race against the file open
callback. Do this by setting the character device's parent to the IIO device,
this will cause the character device to grab a reference to the IIO device and
only release it once the character device itself has been removed.

Also move the registration of the character device before the registration of
the IIO device to avoid the (rather theoretical case) that the IIO device is
already freed again before we can add the character device and grab a reference
to the IIO device.

We also need to move the call to cdev_del() from iio_dev_release() to
iio_device_unregister() (where it should have been in the first place anyway) to
avoid a reference cycle. As iio_dev_release() is only called once all reference
are dropped, but the character device holds a reference to the IIO device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 5ea741c..863aa01 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -890,8 +890,6 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(device);
-	if (indio_dev->chrdev.dev)
-		cdev_del(&indio_dev->chrdev);
 	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
@@ -1098,18 +1096,20 @@ int iio_device_register(struct iio_dev *indio_dev)
 		indio_dev->setup_ops == NULL)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
-	ret = device_add(&indio_dev->dev);
-	if (ret < 0)
-		goto error_unreg_eventset;
 	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
 	indio_dev->chrdev.owner = indio_dev->info->driver_module;
+	indio_dev->chrdev.kobj.parent = &indio_dev->dev.kobj;
 	ret = cdev_add(&indio_dev->chrdev, indio_dev->dev.devt, 1);
 	if (ret < 0)
-		goto error_del_device;
-	return 0;
+		goto error_unreg_eventset;
 
-error_del_device:
-	device_del(&indio_dev->dev);
+	ret = device_add(&indio_dev->dev);
+	if (ret < 0)
+		goto error_cdev_del;
+
+	return 0;
+error_cdev_del:
+	cdev_del(&indio_dev->chrdev);
 error_unreg_eventset:
 	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
@@ -1127,6 +1127,9 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	device_del(&indio_dev->dev);
 
+	if (indio_dev->chrdev.dev)
+		cdev_del(&indio_dev->chrdev);
+
 	iio_disable_all_buffers(indio_dev);
 
 	indio_dev->info = NULL;
-- 
1.8.0

