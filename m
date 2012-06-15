Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] staging:iio:adis16400: Fix ADIS163xx AUX_ADC address
Date: Fri, 15 Jun 2012 18:11:52 +0200
Message-Id: <1339776712-26059-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1339776712-26059-1-git-send-email-lars@metafoo.de>
References: <1339776712-26059-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The ADIS163xx variants use a different register address for the auxiliary ADC
channel than the ADIS16400. This patch fixes them to use the correct address.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/imu/adis16400.h      |    1 +
 drivers/staging/iio/imu/adis16400_core.c |    8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 1f4e987..9dd9f14 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -43,6 +43,7 @@
 
 #define ADIS16300_PITCH_OUT 0x12 /* X axis inclinometer output measurement */
 #define ADIS16300_ROLL_OUT  0x14 /* Y axis inclinometer output measurement */
+#define ADIS16300_AUX_ADC   0x16 /* Auxiliary ADC measurement */
 
 /* Calibration parameters */
 #define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 7aa3a9a..3873014 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -472,11 +472,12 @@ enum adis16400_chan {
 	temp,
 	temp0, temp1, temp2,
 	in1,
+	in2,
 	incli_x,
 	incli_y,
 };
 
-static u8 adis16400_addresses[17][2] = {
+static u8 adis16400_addresses[18][2] = {
 	[in_supply] = { ADIS16400_SUPPLY_OUT },
 	[gyro_x] = { ADIS16400_XGYRO_OUT, ADIS16400_XGYRO_OFF },
 	[gyro_y] = { ADIS16400_YGYRO_OUT, ADIS16400_YGYRO_OFF },
@@ -491,7 +492,8 @@ static u8 adis16400_addresses[17][2] = {
 	[temp0] = { ADIS16350_XTEMP_OUT },
 	[temp1] = { ADIS16350_YTEMP_OUT },
 	[temp2] = { ADIS16350_ZTEMP_OUT },
-	[in1] = { ADIS16400_AUX_ADC },
+	[in1] = { ADIS16300_AUX_ADC },
+	[in2] = { ADIS16400_AUX_ADC },
 	[incli_x] = { ADIS16300_PITCH_OUT },
 	[incli_y] = { ADIS16300_ROLL_OUT }
 };
@@ -752,7 +754,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.channel = 1,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = in1,
+		.address = in2,
 		.scan_index = ADIS16400_SCAN_ADC_0,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	},
-- 
1.7.10
