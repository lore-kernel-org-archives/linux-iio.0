Return-Path: <SRS0=H6oV=JE=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Eva Rachel Retuya <eraretuya@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 3/4] iio: accel: adxl345: add calibration offset support
Date: Tue, 19 Jun 2018 00:59:11 +0900
Message-Id: <1529337552-23726-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com>
References: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The ADXL345 provides the offset adjustment registers for each axis.
This adds the iio channel information for the calibraion offsets with
that feature.

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- Adjust the value for the calibbias to make the same scale as the _raw
  measurement, and remove misused calibscale.

 drivers/iio/accel/adxl345_core.c | 47 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6b62f82..a6cdf1b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -18,6 +18,9 @@
 #include "adxl345.h"
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_OFSX		0x1e
+#define ADXL345_REG_OFSY		0x1f
+#define ADXL345_REG_OFSZ		0x20
 #define ADXL345_REG_POWER_CTL		0x2D
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_DATAX0		0x32
@@ -53,7 +56,8 @@ struct adxl345_data {
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 	.scan_index = si,						\
 }
@@ -69,7 +73,8 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
-	__le16 regval;
+	__le16 accel;
+	unsigned int regval;
 	int ret;
 
 	switch (mask) {
@@ -80,18 +85,49 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
 		 */
 		ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0 +
-				       sizeof(regval) * chan->scan_index,
-				       &regval, sizeof(regval));
+				       sizeof(accel) * chan->scan_index, &accel,
+				       sizeof(accel));
 		if (ret < 0)
 			return ret;
 
-		*val = sign_extend32(le16_to_cpu(regval), 12);
+		*val = sign_extend32(le16_to_cpu(accel), 12);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = adxl345_uscale;
 
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(data->regmap,
+				  ADXL345_REG_OFSX + chan->scan_index, &regval);
+		if (ret < 0)
+			return ret;
+		/*
+		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
+		 * factor
+		 */
+		*val = sign_extend32(regval, 7) * 4;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl345_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct adxl345_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		/*
+		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
+		 * factor
+		 */
+		return regmap_write(data->regmap,
+				    ADXL345_REG_OFSX + chan->scan_index,
+				    val / 4);
 	}
 
 	return -EINVAL;
@@ -99,6 +135,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
+	.write_raw	= adxl345_write_raw,
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-- 
2.7.4
