Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 8/8] staging:iio: Add some missing peak elements to the info_mask
Date: Wed, 30 May 2012 20:41:06 +0100
Message-Id: <1338406866-3833-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-1-git-send-email-jic23@kernel.org>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

These are supported by raw_read but not actually there.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16240_core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 2df39d1..3f30a99 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -481,7 +481,8 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.channel2 = IIO_MOD_X,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16240_SCAN_ACC_X,
 		.scan_type = {
@@ -495,7 +496,8 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.channel2 = IIO_MOD_Y,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16240_SCAN_ACC_Y,
 		.scan_type = {
@@ -509,7 +511,8 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16240_SCAN_ACC_Z,
 		.scan_type = {
-- 
1.7.10.2
