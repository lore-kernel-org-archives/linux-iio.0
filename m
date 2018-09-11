Return-Path: <SRS0=gxlc=LZ=az8.co=afonsobordado@kernel.org>
From: Afonso Bordado <afonsobordado@az8.co>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 4/5] iio: fxas21002c: add ODR/Scale support
Date: Tue, 11 Sep 2018 16:00:10 +0100
Message-Id: <20180911150011.31964-4-afonsobordado@az8.co>
In-Reply-To: <20180911150011.31964-1-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for reading/writing ODR/Scale

We don't support the scale boost modes.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 drivers/iio/gyro/fxas21002c.c | 143 +++++++++++++++++++++++++++++++---
 1 file changed, 131 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
index e2ce0622944b..ea9934b91789 100644
--- a/drivers/iio/gyro/fxas21002c.c
+++ b/drivers/iio/gyro/fxas21002c.c
@@ -7,7 +7,6 @@
  * IIO driver for FXAS21002C (7-bit I2C slave address 0x20 or 0x21).
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
  * TODO:
- *        ODR / Scale Support
  *        Scale Boost Mode
  *        Power management
  *        GPIO Reset
@@ -66,12 +65,14 @@
 #define FXAS21002C_REG_CTRL_REG2       0x14
 #define FXAS21002C_REG_CTRL_REG3       0x15
 
-#define FXAS21002C_DEFAULT_ODR_HZ      800
+#define FXAS21002C_TEMP_SCALE          1000
 
-/* 0.0625 deg/s */
-#define FXAS21002C_DEFAULT_SENSITIVITY IIO_DEGREE_TO_RAD(62500)
 
-#define FXAS21002C_TEMP_SCALE          1000
+#define FXAS21002C_SCALE(scale) (IIO_DEGREE_TO_RAD(62500 >> (scale)))
+
+#define FXAS21002C_SAMPLE_FREQ(odr) (800 >> (odr))
+#define FXAS21002C_SAMPLE_FREQ_MICRO(odr) ( \
+		((odr) == FXAS21002C_ODR_12_5) ? 500000 : 0)
 
 enum {
 	ID_FXAS21002C,
@@ -89,6 +90,25 @@ struct fxas21002c_data {
 	struct regmap *regmap;
 };
 
+enum fxas21002c_scale {
+	FXAS21002C_SCALE_62MDPS,
+	FXAS21002C_SCALE_31MDPS,
+	FXAS21002C_SCALE_15MDPS,
+	FXAS21002C_SCALE_7MDPS,
+	__FXAS21002C_SCALE_MAX,
+};
+
+enum fxas21002c_odr {
+	FXAS21002C_ODR_800,
+	FXAS21002C_ODR_400,
+	FXAS21002C_ODR_200,
+	FXAS21002C_ODR_100,
+	FXAS21002C_ODR_50,
+	FXAS21002C_ODR_25,
+	FXAS21002C_ODR_12_5,
+	__FXAS21002C_ODR_MAX,
+};
+
 static const struct regmap_range fxas21002c_writable_ranges[] = {
 	regmap_reg_range(FXAS21002C_REG_F_SETUP, FXAS21002C_REG_F_SETUP),
 	regmap_reg_range(FXAS21002C_REG_CTRL_REG0, FXAS21002C_REG_RT_CFG),
@@ -261,6 +281,49 @@ static int fxas21002c_read_oneshot(struct fxas21002c_data *data,
 	}
 }
 
+static int fxas21002c_scale_read(struct fxas21002c_data *data, int *val,
+				 int *val2)
+{
+	int ret;
+	unsigned int raw;
+
+	ret = regmap_read(data->regmap, FXAS21002C_REG_CTRL_REG0, &raw);
+	if (ret)
+		return ret;
+
+	raw &= FXAS21002C_SCALE_MASK;
+
+	*val = 0;
+	*val2 = FXAS21002C_SCALE(raw);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int fxas21002c_odr_read(struct fxas21002c_data *data, int *val,
+			       int *val2)
+{
+	int ret;
+	unsigned int raw;
+
+	ret = regmap_read(data->regmap, FXAS21002C_REG_CTRL_REG1, &raw);
+	if (ret)
+		return ret;
+
+	raw = (raw & FXAS21002C_ODR_MASK) >> FXAS21002C_ODR_SHIFT;
+
+	/*
+	 * We don't use this mode but according to the datasheet its
+	 * also a 12.5Hz
+	 */
+	if (raw == 7)
+		raw = FXAS21002C_ODR_12_5;
+
+	*val = FXAS21002C_SAMPLE_FREQ(raw);
+	*val2 = FXAS21002C_SAMPLE_FREQ_MICRO(raw);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
 static int fxas21002c_read_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan, int *val,
 			       int *val2, long mask)
@@ -273,10 +336,7 @@ static int fxas21002c_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			*val = 0;
-			*val2 = FXAS21002C_DEFAULT_SENSITIVITY;
-
-			return IIO_VAL_INT_PLUS_MICRO;
+			return fxas21002c_scale_read(data, val, val2);
 		case IIO_TEMP:
 			*val = FXAS21002C_TEMP_SCALE;
 
@@ -288,16 +348,75 @@ static int fxas21002c_read_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_ANGL_VEL)
 			return -EINVAL;
 
-		*val = FXAS21002C_DEFAULT_ODR_HZ;
-
-		return IIO_VAL_INT;
+		return fxas21002c_odr_read(data, val, val2);
 	}
 
 	return -EINVAL;
 }
 
+
+static int fxas21002c_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int val,
+				int val2, long mask)
+{
+	struct fxas21002c_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < __FXAS21002C_ODR_MAX; i++) {
+			if (FXAS21002C_SAMPLE_FREQ(i) == val &&
+			    FXAS21002C_SAMPLE_FREQ_MICRO(i) == val2)
+				break;
+		}
+
+		if (i == __FXAS21002C_ODR_MAX)
+			break;
+
+		return regmap_update_bits(data->regmap,
+					  FXAS21002C_REG_CTRL_REG1,
+					  FXAS21002C_ODR_MASK,
+					  i << FXAS21002C_ODR_SHIFT);
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < __FXAS21002C_SCALE_MAX; i++) {
+			if (val == 0 && FXAS21002C_SCALE(i) == val2)
+				break;
+		}
+
+		if (i == __FXAS21002C_SCALE_MAX)
+			break;
+
+		return regmap_update_bits(data->regmap,
+					  FXAS21002C_REG_CTRL_REG0,
+					  FXAS21002C_SCALE_MASK, i);
+	}
+
+	return ret;
+}
+
+static IIO_CONST_ATTR(anglevel_scale_available,
+		      "0.001090831 "  /* 62.5    mdps */
+		      "0.000545415 "  /* 31.25   mdps */
+		      "0.000272708 "  /* 15.625  mdps */
+		      "0.000136354"); /*  7.8125 mdps */
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("800 400 200 100 50 25 12.5");
+
+static struct attribute *fxas21002c_attributes[] = {
+	&iio_const_attr_anglevel_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group fxas21002c_attribute_group = {
+	.attrs = fxas21002c_attributes,
+};
+
 static const struct iio_info fxas21002c_info = {
 	.read_raw		= fxas21002c_read_raw,
+	.write_raw              = fxas21002c_write_raw,
+	.attrs                  = &fxas21002c_attribute_group,
 };
 
 static int fxas21002c_probe(struct i2c_client *client,
-- 
2.18.0
