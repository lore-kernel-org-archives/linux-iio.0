Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 24/24] iio: Free up drvdata for driver usage
Date: Fri, 11 May 2012 14:58:47 +0200
Message-Id: <1336741127-29552-24-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-1-git-send-email-lars@metafoo.de>
References: <1336741127-29552-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Now that all drivers have been converted to dev_to_iio_dev we do no longer have
to set the device's drvdata to the iio device pointer. So remove it, this will
allow drivers to use it for driver specific purposes.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
I intend to send this patch with a delay of maybe one release or so, so we don't
randomly break drivers which are currently in development.
---
 drivers/iio/industrialio-core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ae3f5ed..f5656a0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -753,7 +753,6 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 		dev->dev.type = &iio_dev_type;
 		dev->dev.bus = &iio_bus_type;
 		device_initialize(&dev->dev);
-		dev_set_drvdata(&dev->dev, (void *)dev);
 		mutex_init(&dev->mlock);
 		mutex_init(&dev->info_exist_lock);
 
-- 
1.7.10
