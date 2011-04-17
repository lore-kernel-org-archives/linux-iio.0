Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 69/70] staging:iio:buffer - remove unused event code for buffer events.
Date: Sun, 17 Apr 2011 20:06:42 +0100
Message-Id: <1303067203-4894-70-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

These events are no longer passed up to userspace.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h   |    4 ----
 drivers/staging/iio/sysfs.h |    1 -
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 47ca59a..7f94197 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -28,10 +28,6 @@
 /* naughty temporary hack to match these against the event version
    - need to flattern these together */
 enum iio_chan_type {
-	/* Need this here for now to support buffer events
-	 * set to 0  to avoid changes to ring_generic.c */
-	IIO_BUFFER = 0,
-
 	/* real channel types */
 	IIO_IN,
 	IIO_ACCEL,
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 1dc32eb..8bbb286 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -170,7 +170,6 @@ struct iio_const_attr {
 #define IIO_EV_CLASS_LIGHT		IIO_LIGHT
 #define IIO_EV_CLASS_PROXIMITY		IIO_PROXIMITY
 #define IIO_EV_CLASS_TEMP		IIO_TEMP
-#define IIO_EV_CLASS_BUFFER		IIO_BUFFER
 
 #define IIO_EV_MOD_X			0
 #define IIO_EV_MOD_Y			1
-- 
1.7.3.4
