Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:dummy: Remove outdated comment
Date: Fri, 11 May 2012 15:12:29 +0200
Message-Id: <1336741949-30181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

iio_device_free has to be called regardless of whether the device has been
registered or not when freeing it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio_simple_dummy.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 3b4513c..3104119 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -470,8 +470,6 @@ error_unconfigure_buffer:
 error_unregister_events:
 	iio_simple_dummy_events_unregister(indio_dev);
 error_free_device:
-	/* Note free device should only be called, before registration
-	 * has succeeded. */
 	iio_device_free(indio_dev);
 error_ret:
 	return ret;
-- 
1.7.10
