Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, stable@kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/6] IIO: IMU: ADIS16400: Fix addresses of GYRO and ACCEL calibration offset
Date: Mon, 21 Mar 2011 16:44:37 +0100
Message-ID: <1300722280-10720-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
References: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
CC: stable <stable@kernel.org>
---
 drivers/staging/iio/imu/adis16400_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 633b3a4..2107edb 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -495,12 +495,12 @@ err_ret:
 			_reg)

 static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_X, ADIS16400_XGYRO_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Y, ADIS16400_XGYRO_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Z, ADIS16400_XGYRO_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Y, ADIS16400_YGYRO_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Z, ADIS16400_ZGYRO_OFF);

 static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_X, ADIS16400_XACCL_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Y, ADIS16400_XACCL_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Z, ADIS16400_XACCL_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Y, ADIS16400_YACCL_OFF);
+static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Z, ADIS16400_ZACCL_OFF);


 static IIO_DEV_ATTR_IN_NAMED_RAW(0, supply, adis16400_read_14bit_signed,
--
1.6.0.2
