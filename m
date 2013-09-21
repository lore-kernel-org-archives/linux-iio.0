Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: Remove debugfs entries in iio_device_unregister()
Date: Sat, 21 Sep 2013 17:21:41 +0200
Message-Id: <1379776901-19429-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1379776901-19429-1-git-send-email-lars@metafoo.de>
References: <1379776901-19429-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Remove the the debugfs entries in iio_device_unregister(). Otherwise the debugfs
entries might still be accessible even though the device used in the debugfs
callback has already been freed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d189f6c..b8a16d7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -853,7 +853,6 @@ static void iio_dev_release(struct device *device)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
-	iio_device_unregister_debugfs(indio_dev);
 
 	if (indio_dev->buffer)
 		iio_buffer_put(indio_dev->buffer);
@@ -1091,6 +1090,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	if (indio_dev->chrdev.dev)
 		cdev_del(&indio_dev->chrdev);
+	iio_device_unregister_debugfs(indio_dev);
 
 	iio_disable_all_buffers(indio_dev);
 
-- 
1.8.0
