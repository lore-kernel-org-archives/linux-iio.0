Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/22] staging:iio:ad7192: Report offset and scale for temperature channel
Date: Fri, 10 Aug 2012 18:36:26 +0200
Message-Id: <1344616596-8026-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The temperature channel reports values in degree Kelvin with sensitivity of 5630
codes per degree. If the chip is configured in bipolar mode there is an
additional binary offset of 0x800000 and the sensitivity is divided by two.

Currently the driver does the mapping from the raw value to degree Celsius when
doing a manual conversion. This has several disadvantages, the major one being
that it does not work for buffered mode, also by doing the division by the
sensitivity in the driver the precession of the reported value is needlessly
reduced.

Furthermore the current calculation only works in bipolar mode and the current
scale is of by a factor of 1000.

This patch modifies the driver to report correct offset and scale values in
both unipolar and bipolar mode and to report the raw temperature value
for manual conversions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7192.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index fb59d36..405d9a8 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -798,6 +798,11 @@ static const struct attribute_group ad7195_attribute_group = {
 	.attrs = ad7195_attributes,
 };
 
+static unsigned int ad7192_get_temp_scale(bool unipolar)
+{
+	return unipolar ? 2815 * 2 : 2815;
+}
+
 static int ad7192_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -824,17 +829,6 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		*val = (smpl >> chan->scan_type.shift) &
 			((1 << (chan->scan_type.realbits)) - 1);
 
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			break;
-		case IIO_TEMP:
-			*val -= 0x800000;
-			*val /= 2815; /* temp Kelvin */
-			*val -= 273; /* temp Celsius */
-			break;
-		default:
-			return -EINVAL;
-		}
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -846,16 +840,20 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&indio_dev->mlock);
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_TEMP:
-			*val =  1000;
-			return IIO_VAL_INT;
+			*val = 0;
+			*val2 = 1000000000 / ad7192_get_temp_scale(unipolar);
+			return IIO_VAL_INT_PLUS_NANO;
 		default:
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		if (!unipolar)
-			*val -= (1 << (chan->scan_type.realbits - 1));
+			*val = -(1 << (chan->scan_type.realbits - 1));
 		else
 			*val = 0;
+		/* Kelvin to Celsius */
+		if (chan->type == IIO_TEMP)
+			*val -= 273 * ad7192_get_temp_scale(unipolar);
 		return IIO_VAL_INT;
 	}
 
-- 
1.7.10.4
