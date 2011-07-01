Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:49295 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab1GAKDN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jul 2011 06:03:13 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/25] staging:iio:magnetometer: remove unused header magnet.h
Date: Fri,  1 Jul 2011 11:11:02 +0100
Message-Id: <1309515076-12323-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now all magnetomers are using iio_chan_spec there is no need for
the macros in magnet.h

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/magnetometer/magnet.h |   31 -----------------------------
 1 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/magnet.h b/drivers/staging/iio/magnetometer/magnet.h
deleted file mode 100644
index 1260eb7..0000000
--- a/drivers/staging/iio/magnetometer/magnet.h
+++ /dev/null
@@ -1,31 +0,0 @@
-
-#include "../sysfs.h"
-
-/* Magnetometer types of attribute */
-
-#define IIO_DEV_ATTR_MAGN_X_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(magn_x_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_MAGN_Y_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(magn_y_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_MAGN_Z_OFFSET(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(magn_z_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_MAGN_X_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_x_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_MAGN_Y_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_y_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_MAGN_Z_SCALE(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_z_scale, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_MAGN_X(_show, _addr)				\
-	IIO_DEVICE_ATTR(magn_x_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_MAGN_Y(_show, _addr)				\
-	IIO_DEVICE_ATTR(magn_y_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_MAGN_Z(_show, _addr)				\
-	IIO_DEVICE_ATTR(magn_z_raw, S_IRUGO, _show, NULL, _addr)
-- 
1.7.3.4

