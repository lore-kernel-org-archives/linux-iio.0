Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:49324 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213Ab1GAKDO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jul 2011 06:03:14 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 23/25] staging:iio:accel remove unused accel.h header.
Date: Fri,  1 Jul 2011 11:11:14 +0100
Message-Id: <1309515076-12323-24-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The chan spec conversions and a small amount of pushdown of defines
mean this header is no longer used.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/accel.h |   87 -------------------------------------
 1 files changed, 0 insertions(+), 87 deletions(-)

diff --git a/drivers/staging/iio/accel/accel.h b/drivers/staging/iio/accel/accel.h
deleted file mode 100644
index 50651f8..0000000
--- a/drivers/staging/iio/accel/accel.h
+++ /dev/null
@@ -1,87 +0,0 @@
-
-#include "../sysfs.h"
-
-/* Accelerometer types of attribute */
-#define IIO_DEV_ATTR_ACCEL_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(accel_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_X_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(accel_x_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Y_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(accel_y_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Z_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(accel_z_offset, _mode, _show, _store, _addr)
-
-#define IIO_CONST_ATTR_ACCEL_SCALE(_string)		\
-	IIO_CONST_ATTR(accel_scale, _string)
-
-#define IIO_DEV_ATTR_ACCEL_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_X_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_x_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Y_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_y_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Z_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_z_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_CALIBBIAS(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_calibbias, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_X_CALIBBIAS(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_x_calibbias, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Y_CALIBBIAS(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_y_calibbias, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Z_CALIBBIAS(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_z_calibbias, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_CALIBSCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_calibscale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_X_CALIBSCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_x_calibscale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Y_CALIBSCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_y_calibscale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Z_CALIBSCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(accel_z_calibscale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_X(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_x_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Y(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_y_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_Z(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_z_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_XY(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_xy, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_PEAK(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_peak, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_XPEAK(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_xpeak, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_YPEAK(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_ypeak, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_ZPEAK(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_zpeak, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_XYPEAK(_show, _addr)		\
-	IIO_DEVICE_ATTR(accel_xypeak, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_XYZPEAK(_show, _addr)		\
-	IIO_DEVICE_ATTR(accel_xyzpeak, S_IRUGO, _show, NULL, _addr)
-- 
1.7.3.4

