Return-Path: <Cliff.Cai@analog.com>
From: Cliff Cai <cliff.cai@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/3] IIO: GYRO: Add MACRO for gyro quadrature correction
Date: Wed, 6 Apr 2011 10:39:18 +0200
Message-ID: <1302079160-2881-1-git-send-email-cliff.cai@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add gyro_z_quadrature_correction_raw define.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/gyro.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/gyro.h b/drivers/staging/iio/gyro/gyro.h
index b4ea5bf..b549561 100644
--- a/drivers/staging/iio/gyro/gyro.h
+++ b/drivers/staging/iio/gyro/gyro.h
@@ -57,6 +57,9 @@
 #define IIO_DEV_ATTR_GYRO_Z_CALIBSCALE(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(gyro_z_calibscale, _mode, _show, _store, _addr)

+#define IIO_DEV_ATTR_GYRO_Z_QUADRATURE_CORRECTION(_show, _addr)		\
+	IIO_DEVICE_ATTR(gyro_z_quadrature_correction_raw, S_IRUGO, _show, NULL, _addr)
+
 #define IIO_DEV_ATTR_GYRO(_show, _addr)			\
 	IIO_DEVICE_ATTR(gyro_raw, S_IRUGO, _show, NULL, _addr)

--
1.6.0.2
