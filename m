Return-Path: <SRS0=H6oV=JE=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Eva Rachel Retuya <eraretuya@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 4/4] iio: accel: adxl345: add sampling frequency support
Date: Tue, 19 Jun 2018 00:59:12 +0900
Message-Id: <1529337552-23726-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com>
References: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The ADXL345 provides selectable output data rate.  This adds the iio
channel information for the sampling frequency with that feature.

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- No changes from v1

 drivers/iio/accel/adxl345_core.c | 63 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index a6cdf1b..25cbaa5 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #include "adxl345.h"
 
@@ -21,12 +22,15 @@
 #define ADXL345_REG_OFSX		0x1e
 #define ADXL345_REG_OFSY		0x1f
 #define ADXL345_REG_OFSZ		0x20
+#define ADXL345_REG_BW_RATE		0x2C
 #define ADXL345_REG_POWER_CTL		0x2D
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_DATAX0		0x32
 #define ADXL345_REG_DATAY0		0x34
 #define ADXL345_REG_DATAZ0		0x36
 
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
 
@@ -58,7 +62,8 @@ struct adxl345_data {
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 	.scan_index = si,						\
 }
 
@@ -68,6 +73,28 @@ static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(2, Z),
 };
 
+static const struct {
+	int val;
+	int val2;
+} adxl345_samp_freq_table[] = {
+	{ 0, 97656 },
+	{ 0, 195313 },
+	{ 0, 390625 },
+	{ 0, 781250 },
+	{ 1, 562500 },
+	{ 3, 125000 },
+	{ 6, 250000 },
+	{ 12, 500000 },
+	{ 25, 0 },
+	{ 50, 0 },
+	{ 100, 0 },
+	{ 200, 0 },
+	{ 400, 0 },
+	{ 800, 0 },
+	{ 1600, 0 },
+	{ 3200, 0 },
+};
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -108,6 +135,15 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		 */
 		*val = sign_extend32(regval, 7) * 4;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);
+		if (ret < 0)
+			return ret;
+		regval &= ADXL345_BW_RATE;
+		*val = adxl345_samp_freq_table[regval].val;
+		*val2 = adxl345_samp_freq_table[regval].val2;
+
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return -EINVAL;
@@ -118,6 +154,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
+	int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -128,12 +165,36 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		return regmap_write(data->regmap,
 				    ADXL345_REG_OFSX + chan->scan_index,
 				    val / 4);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < ARRAY_SIZE(adxl345_samp_freq_table); i++) {
+			if (adxl345_samp_freq_table[i].val == val &&
+			    adxl345_samp_freq_table[i].val2 == val2) {
+				return regmap_update_bits(data->regmap,
+							ADXL345_REG_BW_RATE,
+							ADXL345_BW_RATE, i);
+			}
+		}
+		return -EINVAL;
 	}
 
 	return -EINVAL;
 }
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
+"0.097656 0.195313 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
+);
+
+static struct attribute *adxl345_attrs[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adxl345_attrs_group = {
+	.attrs = adxl345_attrs,
+};
+
 static const struct iio_info adxl345_info = {
+	.attrs		= &adxl345_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 };
-- 
2.7.4
