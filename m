Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: Remove unused iio_device_put()
Date: Fri, 11 May 2012 15:13:13 +0200
Message-Id: <1336741993-30310-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

This function is currently unused and we do not have a matching iio_device_get()
function either, so just remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 include/linux/iio/iio.h |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 6fdbdb8..eff2a39 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -412,16 +412,6 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 
 extern struct bus_type iio_bus_type;
 
-/**
- * iio_device_put() - reference counted deallocation of struct device
- * @dev: the iio_device containing the device
- **/
-static inline void iio_device_put(struct iio_dev *indio_dev)
-{
-	if (indio_dev)
-		put_device(&indio_dev->dev);
-};
-
 /* Can we make this smaller? */
 #define IIO_ALIGN L1_CACHE_BYTES
 /**
-- 
1.7.10
