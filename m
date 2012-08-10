Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/22] staging:iio:ad7192: Report channel offset
Date: Fri, 10 Aug 2012 18:36:25 +0200
Message-Id: <1344616596-8026-11-git-send-email-lars@metafoo.de>
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
 drivers/staging/iio/adc/ad7192.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index b103f58..fb59d36 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -826,8 +826,6 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			if (!unipolar)
-				*val -= (1 << (chan->scan_type.realbits - 1));
 			break;
 		case IIO_TEMP:
 			*val -= 0x800000;
@@ -853,6 +851,12 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_OFFSET:
+		if (!unipolar)
+			*val -= (1 << (chan->scan_type.realbits - 1));
+		else
+			*val = 0;
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -942,7 +946,8 @@ static const struct iio_info ad7195_info = {
 	  .channel = _chan,						\
 	  .channel2 = _chan2,						\
 	  .info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |			\
-	  IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
+	  IIO_CHAN_INFO_SCALE_SHARED_BIT |				\
+	  IIO_CHAN_INFO_OFFSET_SHARED_BIT,				\
 	  .address = _address,						\
 	  .scan_index = _si,						\
 	  .scan_type =  IIO_ST('u', 24, 32, 0)}
@@ -952,7 +957,8 @@ static const struct iio_info ad7195_info = {
 	  .indexed = 1,							\
 	  .channel = _chan,						\
 	  .info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |			\
-	  IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
+	  IIO_CHAN_INFO_SCALE_SHARED_BIT |				\
+	  IIO_CHAN_INFO_OFFSET_SHARED_BIT,				\
 	  .address = _address,						\
 	  .scan_index = _si,						\
 	  .scan_type =  IIO_ST('u', 24, 32, 0)}
-- 
1.7.10.4
