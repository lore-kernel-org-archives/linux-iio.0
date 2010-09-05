Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:7433 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab0IEWGB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Sep 2010 18:06:01 -0400
From: achew@nvidia.com
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, Andrew Chew <achew@nvidia.com>
Subject: [PATCH 1/1] iio: Change GAIN macros to SCALE.
Date: Sun,  5 Sep 2010 15:05:26 -0700
Message-Id: <1283724326-31998-1-git-send-email-achew@nvidia.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Andrew Chew <achew@nvidia.com>

Per email exchange with Jonathan Cameron, GAIN should instead be SCALE, to
be consistent with documentation.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
 drivers/staging/iio/magnetometer/magnet.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/magnet.h b/drivers/staging/iio/magnetometer/magnet.h
index 6433830..1260eb7 100644
--- a/drivers/staging/iio/magnetometer/magnet.h
+++ b/drivers/staging/iio/magnetometer/magnet.h
@@ -12,14 +12,14 @@
 #define IIO_DEV_ATTR_MAGN_Z_OFFSET(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(magn_z_offset, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_MAGN_X_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_x_gain, _mode, _show, _store, _addr)
+#define IIO_DEV_ATTR_MAGN_X_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(magn_x_scale, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_MAGN_Y_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_y_gain, _mode, _show, _store, _addr)
+#define IIO_DEV_ATTR_MAGN_Y_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(magn_y_scale, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_MAGN_Z_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_z_gain, _mode, _show, _store, _addr)
+#define IIO_DEV_ATTR_MAGN_Z_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(magn_z_scale, _mode, _show, _store, _addr)
 
 #define IIO_DEV_ATTR_MAGN_X(_show, _addr)				\
 	IIO_DEVICE_ATTR(magn_x_raw, S_IRUGO, _show, NULL, _addr)
-- 
1.7.0.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
