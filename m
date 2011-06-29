Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 16/24] staging:iio:gyro: remove gyro.h
Date: Wed, 29 Jun 2011 12:51:48 +0100
Message-Id: <1309348316-7699-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
References: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Not longer needed now all devices with gyro channels are using
iio_chan_spec registration.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/gyro.h |   85 ---------------------------------------
 1 files changed, 0 insertions(+), 85 deletions(-)

diff --git a/drivers/staging/iio/gyro/gyro.h b/drivers/staging/iio/gyro/gyro.h
deleted file mode 100644
index b5495613..0000000
--- a/drivers/staging/iio/gyro/gyro.h
+++ /dev/null
@@ -1,85 +0,0 @@
-
-#include "../sysfs.h"
-
-/* Gyroscope types of attribute */
-
-#define IIO_CONST_ATTR_GYRO_OFFSET(_string)	\
-	IIO_CONST_ATTR(gyro_offset, _string)
-
-#define IIO_DEV_ATTR_GYRO_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(gyro_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_X_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(gyro_x_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Y_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(gyro_y_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Z_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(gyro_z_offset, _mode, _show, _store, _addr)
-
-#define IIO_CONST_ATTR_GYRO_SCALE(_string)		\
-	IIO_CONST_ATTR(gyro_scale, _string)
-
-#define IIO_DEV_ATTR_GYRO_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_scale, S_IRUGO, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_X_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_x_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Y_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_y_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Z_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_z_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_CALIBBIAS(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_calibbias, S_IRUGO, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_X_CALIBBIAS(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_x_calibbias, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Y_CALIBBIAS(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_y_calibbias, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Z_CALIBBIAS(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_z_calibbias, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_CALIBSCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_calibscale, S_IRUGO, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_X_CALIBSCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_x_calibscale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Y_CALIBSCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_y_calibscale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Z_CALIBSCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(gyro_z_calibscale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Z_QUADRATURE_CORRECTION(_show, _addr)		\
-	IIO_DEVICE_ATTR(gyro_z_quadrature_correction_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_GYRO(_show, _addr)			\
-	IIO_DEVICE_ATTR(gyro_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_GYRO_X(_show, _addr)			\
-	IIO_DEVICE_ATTR(gyro_x_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Y(_show, _addr)			\
-	IIO_DEVICE_ATTR(gyro_y_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_GYRO_Z(_show, _addr)			\
-	IIO_DEVICE_ATTR(gyro_z_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ANGL(_show, _addr)                         \
-	IIO_DEVICE_ATTR(angl_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ANGL_X(_show, _addr)				\
-	IIO_DEVICE_ATTR(angl_x_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ANGL_Y(_show, _addr)				\
-	IIO_DEVICE_ATTR(angl_y_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ANGL_Z(_show, _addr)				\
-	IIO_DEVICE_ATTR(angl_z_raw, S_IRUGO, _show, NULL, _addr)
-- 
1.7.3.4
