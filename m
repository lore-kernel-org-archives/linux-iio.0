Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-014.synserver.de ([212.40.185.14]:1089 "EHLO
	smtp-out-011.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753650Ab3IRUB1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 16:01:27 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/10] iio: Remove debugfs entries in iio_device_unregister()
Date: Wed, 18 Sep 2013 22:02:50 +0200
Message-Id: <1379534574-11213-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-1-git-send-email-lars@metafoo.de>
References: <1379534574-11213-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove the the debugfs entries in iio_device_unregister(). Otherwise the debugfs
entries might still be accessible even though the device used in the debugfs
callback has already been freed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e4c8a6c..3e581a76 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -895,7 +895,6 @@ static void iio_dev_release(struct device *device)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
-	iio_device_unregister_debugfs(indio_dev);
 
 	if (indio_dev->buffer)
 		iio_buffer_put(indio_dev->buffer);
@@ -1133,6 +1132,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	if (indio_dev->chrdev.dev)
 		cdev_del(&indio_dev->chrdev);
+	iio_device_unregister_debugfs(indio_dev);
 
 	iio_disable_all_buffers(indio_dev);
 
-- 
1.8.0

