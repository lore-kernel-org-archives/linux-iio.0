Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/22] staging:iio:ad7793: Fix temperature scale and offset
Date: Fri, 10 Aug 2012 18:36:18 +0200
Message-Id: <1344616596-8026-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The temperature channel uses the internal 1.17V reference with 0.81 mv/C. The
reported temperature is in Kevlin, so we need to add the Kelvin to Celcius
offset when reporting the offset for the temperature channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 56014a8..3c8d1d4 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -617,30 +617,37 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 				return IIO_VAL_INT_PLUS_NANO;
 			} else {
 				/* 1170mV / 2^23 * 6 */
-				scale_uv = (1170ULL * 100000000ULL * 6ULL)
-					>> (chan->scan_type.realbits -
-					    (unipolar ? 0 : 1));
+				scale_uv = (1170ULL * 100000000ULL * 6ULL);
 			}
 			break;
 		case IIO_TEMP:
-			/* Always uses unity gain and internal ref */
-			scale_uv = (2500ULL * 100000000ULL)
-				>> (chan->scan_type.realbits -
-				(unipolar ? 0 : 1));
+				/* 1170mV / 0.81 mV/C / 2^23 */
+				scale_uv = 1444444444444ULL;
 			break;
 		default:
 			return -EINVAL;
 		}
 
-		*val2 = do_div(scale_uv, 100000000) * 10;
-		*val =  scale_uv;
-
+		scale_uv >>= (chan->scan_type.realbits - (unipolar ? 0 : 1));
+		*val = 0;
+		*val2 = scale_uv;
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		if (!unipolar)
-			*val -= (1 << (chan->scan_type.realbits - 1));
+			*val = -(1 << (chan->scan_type.realbits - 1));
 		else
 			*val = 0;
+
+		/* Kelvin to Celsius */
+		if (chan->type == IIO_TEMP) {
+			unsigned long long offset;
+			unsigned int shift;
+
+			shift = chan->scan_type.realbits - (unipolar ? 0 : 1);
+			offset = 273ULL << shift;
+			do_div(offset, 1444);
+			*val -= offset;
+		}
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
1.7.10.4
