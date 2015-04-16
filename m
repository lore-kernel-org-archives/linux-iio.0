Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH v2 2/3] staging: iio: light: isl29018: Rename lux_scale to calibscale
Date: Thu, 16 Apr 2015 22:20:58 +0300
Message-Id: <1429212059-13010-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch renames lux_scale to calibscale and lux_uscale to
ucalibscale.

This is done in order to avoid confusion since these parameters are
used for hardware applied calibration.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/staging/iio/light/isl29018.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index d3d0611..ffc3d1b 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -71,8 +71,8 @@ struct isl29018_chip {
 	struct regmap		*regmap;
 	struct mutex		lock;
 	int			type;
-	unsigned int		lux_scale;
-	unsigned int		lux_uscale;
+	unsigned int		calibscale;
+	unsigned int		ucalibscale;
 	unsigned int		range;
 	unsigned int		adc_bit;
 	int			prox_scheme;
@@ -165,12 +165,12 @@ static int isl29018_read_lux(struct isl29018_chip *chip, int *lux)
 
 	/* To support fractional scaling, separate the unshifted lux
 	 * into two calculations: int scaling and micro-scaling.
-	 * lux_uscale ranges from 0-999999, so about 20 bits.  Split
+	 * ucalibscale ranges from 0-999999, so about 20 bits.  Split
 	 * the /1,000,000 in two to reduce the risk of over/underflow.
 	 */
 	data_x_range = lux_data * chip->range;
-	lux_unshifted = data_x_range * chip->lux_scale;
-	lux_unshifted += data_x_range / 1000 * chip->lux_uscale / 1000;
+	lux_unshifted = data_x_range * chip->calibscale;
+	lux_unshifted += data_x_range / 1000 * chip->ucalibscale / 1000;
 	*lux = lux_unshifted >> chip->adc_bit;
 
 	return 0;
@@ -277,9 +277,9 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->lock);
 	if (mask == IIO_CHAN_INFO_CALIBSCALE && chan->type == IIO_LIGHT) {
-		chip->lux_scale = val;
+		chip->calibscale = val;
 		/* With no write_raw_get_fmt(), val2 is a MICRO fraction. */
-		chip->lux_uscale = val2;
+		chip->ucalibscale = val2;
 		ret = 0;
 	}
 	mutex_unlock(&chip->lock);
@@ -323,8 +323,8 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		if (chan->type == IIO_LIGHT) {
-			*val = chip->lux_scale;
-			*val2 = chip->lux_uscale;
+			*val = chip->calibscale;
+			*val2 = chip->ucalibscale;
 			ret = IIO_VAL_INT_PLUS_MICRO;
 		}
 		break;
@@ -607,8 +607,8 @@ static int isl29018_probe(struct i2c_client *client,
 	mutex_init(&chip->lock);
 
 	chip->type = dev_id;
-	chip->lux_scale = 1;
-	chip->lux_uscale = 0;
+	chip->calibscale = 1;
+	chip->ucalibscale = 0;
 	chip->range = 1000;
 	chip->adc_bit = 16;
 	chip->suspended = false;
-- 
1.9.1
