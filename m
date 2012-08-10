Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/22] staging:iio:ad7793: Report channel offset
Date: Fri, 10 Aug 2012 18:36:17 +0200
Message-Id: <1344616596-8026-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

In bipolar mode there is a a binary offset of 2**(N-1) (with N being the number
of bits) on the reported value. Currently this value is subtracted when doing a
manual read. While this works for manual channel readings it does not work for
buffered mode. So report the offset in the channels offset property, which will
work in both modes.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c |   39 +++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 5e457a4..56014a8 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -604,9 +604,6 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 		*val = (smpl >> chan->scan_type.shift) &
 			((1 << (chan->scan_type.realbits)) - 1);
 
-		if (!unipolar)
-			*val -= (1 << (chan->scan_type.realbits - 1));
-
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -639,6 +636,12 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 		*val =  scale_uv;
 
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		if (!unipolar)
+			*val -= (1 << (chan->scan_type.realbits - 1));
+		else
+			*val = 0;
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -720,7 +723,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel2 = 0,
 			.address = AD7793_CH_AIN1P_AIN1M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 0,
 			.scan_type = IIO_ST('u', 24, 32, 0)
 		},
@@ -732,7 +736,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel2 = 1,
 			.address = AD7793_CH_AIN2P_AIN2M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 1,
 			.scan_type = IIO_ST('u', 24, 32, 0)
 		},
@@ -744,7 +749,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel2 = 2,
 			.address = AD7793_CH_AIN3P_AIN3M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 2,
 			.scan_type = IIO_ST('u', 24, 32, 0)
 		},
@@ -757,7 +763,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel2 = 2,
 			.address = AD7793_CH_AIN1M_AIN1M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 3,
 			.scan_type = IIO_ST('u', 24, 32, 0)
 		},
@@ -778,7 +785,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 4,
 			.address = AD7793_CH_AVDD_MONITOR,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 5,
 			.scan_type = IIO_ST('u', 24, 32, 0),
 		},
@@ -793,7 +801,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel2 = 0,
 			.address = AD7793_CH_AIN1P_AIN1M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 0,
 			.scan_type = IIO_ST('u', 16, 32, 0)
 		},
@@ -805,7 +814,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel2 = 1,
 			.address = AD7793_CH_AIN2P_AIN2M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 1,
 			.scan_type = IIO_ST('u', 16, 32, 0)
 		},
@@ -817,7 +827,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel2 = 2,
 			.address = AD7793_CH_AIN3P_AIN3M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 2,
 			.scan_type = IIO_ST('u', 16, 32, 0)
 		},
@@ -830,7 +841,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel2 = 2,
 			.address = AD7793_CH_AIN1M_AIN1M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 3,
 			.scan_type = IIO_ST('u', 16, 32, 0)
 		},
@@ -851,7 +863,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 4,
 			.address = AD7793_CH_AVDD_MONITOR,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_index = 5,
 			.scan_type = IIO_ST('u', 16, 32, 0),
 		},
-- 
1.7.10.4
