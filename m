Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57264 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1HLQBA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:01:00 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/19] staging:iio:inclinometer.h remove as now unused.
Date: Fri, 12 Aug 2011 17:08:44 +0100
Message-Id: <1313165333-3951-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
References: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/inclinometer.h |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/accel/inclinometer.h b/drivers/staging/iio/accel/inclinometer.h
deleted file mode 100644
index faf73d7..0000000
--- a/drivers/staging/iio/accel/inclinometer.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Inclinometer related attributes
- */
-#include "../sysfs.h"
-
-#define IIO_DEV_ATTR_INCLI_X(_show, _addr)			\
-	IIO_DEVICE_ATTR(incli_x_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_INCLI_Y(_show, _addr)			\
-	IIO_DEVICE_ATTR(incli_y_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_INCLI_Z(_show, _addr)			\
-	IIO_DEVICE_ATTR(incli_z_raw, S_IRUGO, _show, NULL, _addr)
-
-#define IIO_DEV_ATTR_INCLI_X_OFFSET(_mode, _show, _store, _addr) \
-	IIO_DEVICE_ATTR(incli_x_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_INCLI_Y_OFFSET(_mode, _show, _store, _addr) \
-	IIO_DEVICE_ATTR(incli_y_offset, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_INCLI_Z_OFFSET(_mode, _show, _store, _addr) \
-	IIO_DEVICE_ATTR(incli_z_offset, _mode, _show, _store, _addr)
-
-#define IIO_CONST_ATTR_INCLI_SCALE(_string) \
-	IIO_CONST_ATTR(incli_scale, _string)
-- 
1.7.3.4

