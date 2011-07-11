Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58862 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757974Ab1GKP6O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2011 11:58:14 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/4] staging:iio:imu fix missing register table index for some channels
Date: Mon, 11 Jul 2011 16:58:04 +0100
Message-Id: <1310399887-4049-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
References: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A number of these register indexes were not set or actually wrong.
This only effects sysfs reads.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400.h      |    3 ++
 drivers/staging/iio/imu/adis16400_core.c |   50 ++++++++++++++++--------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index e87715b..1f8f0c6 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -41,6 +41,9 @@
 #define ADIS16350_YTEMP_OUT 0x12 /* Y-axis gyroscope temperature measurement */
 #define ADIS16350_ZTEMP_OUT 0x14 /* Z-axis gyroscope temperature measurement */
 
+#define ADIS16300_PITCH_OUT 0x12 /* X axis inclinometer output measurement */
+#define ADIS16300_ROLL_OUT  0x12 /* Y axis inclinometer output measurement */
+
 /* Calibration parameters */
 #define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
 #define ADIS16400_YGYRO_OFF 0x1C /* Y-axis gyroscope bias offset factor */
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 8477549..66fc156 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -436,10 +436,12 @@ enum adis16400_chan {
 	magn_z,
 	temp,
 	temp0, temp1, temp2,
-	in1
+	in1,
+	incli_x,
+	incli_y,
 };
 
-static u8 adis16400_addresses[16][2] = {
+static u8 adis16400_addresses[17][2] = {
 	[in_supply] = { ADIS16400_SUPPLY_OUT, 0 },
 	[gyro_x] = { ADIS16400_XGYRO_OUT, ADIS16400_XGYRO_OFF },
 	[gyro_y] = { ADIS16400_YGYRO_OUT, ADIS16400_YGYRO_OFF },
@@ -454,7 +456,9 @@ static u8 adis16400_addresses[16][2] = {
 	[temp0] = { ADIS16350_XTEMP_OUT },
 	[temp1] = { ADIS16350_YTEMP_OUT },
 	[temp2] = { ADIS16350_ZTEMP_OUT },
-	[in1] = { ADIS16400_AUX_ADC , 0 },
+	[in1] = { ADIS16400_AUX_ADC, 0 },
+	[incli_x] = { ADIS16300_PITCH_OUT, 0 },
+	[incli_y] = { ADIS16300_ROLL_OUT, 0 }
 };
 
 static int adis16400_write_raw(struct iio_dev *indio_dev,
@@ -607,82 +611,82 @@ static struct iio_chan_spec adis16400_channels[] = {
 static struct iio_chan_spec adis16350_channels[] = {
 	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 0, ADIS16400_SCAN_SUPPLY, IIO_ST('u', 12, 16, 0), 0),
+		 in_supply, ADIS16400_SCAN_SUPPLY, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 1, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
+		 gyro_x, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Y,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 2, ADIS16400_SCAN_GYRO_Y, IIO_ST('s', 14, 16, 0), 0),
+		 gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Z,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 3, ADIS16400_SCAN_GYRO_Z, IIO_ST('s', 14, 16, 0), 0),
+		 gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 4, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
+		 accel_x, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
+		 accel_y, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
+		 accel_z, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, "x", 0, 0,
 		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 0, ADIS16350_SCAN_TEMP_X, IIO_ST('s', 12, 16, 0), 0),
+		 temp0, ADIS16350_SCAN_TEMP_X, IIO_ST('s', 12, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, "y", 1, 0,
 		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 0, ADIS16350_SCAN_TEMP_Y, IIO_ST('s', 12, 16, 0), 0),
+		 temp1, ADIS16350_SCAN_TEMP_Y, IIO_ST('s', 12, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, "z", 2, 0,
 		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 0, ADIS16350_SCAN_TEMP_Z, IIO_ST('s', 12, 16, 0), 0),
+		 temp2, ADIS16350_SCAN_TEMP_Z, IIO_ST('s', 12, 16, 0), 0),
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 0, ADIS16350_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
+		 in1, ADIS16350_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(11)
 };
 
 static struct iio_chan_spec adis16300_channels[] = {
 	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 0, ADIS16400_SCAN_SUPPLY, IIO_ST('u', 12, 16, 0), 0),
+		 in_supply, ADIS16400_SCAN_SUPPLY, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 1, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
+		 gyro_x, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 4, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
+		 accel_x, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
+		 accel_y, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
+		 accel_z, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
 		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 0, ADIS16400_SCAN_TEMP, IIO_ST('s', 12, 16, 0), 0),
+		 temp, ADIS16400_SCAN_TEMP, IIO_ST('s', 12, 16, 0), 0),
 	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 0, ADIS16350_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
+		 in1, ADIS16350_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
 	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, ADIS16300_SCAN_INCLI_X, IIO_ST('s', 13, 16, 0), 0),
+		 incli_x, ADIS16300_SCAN_INCLI_X, IIO_ST('s', 13, 16, 0), 0),
 	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, ADIS16300_SCAN_INCLI_Y, IIO_ST('s', 13, 16, 0), 0),
+		 incli_y, ADIS16300_SCAN_INCLI_Y, IIO_ST('s', 13, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(14)
 };
 
-- 
1.7.3.4

