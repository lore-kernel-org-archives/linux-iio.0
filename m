Return-Path: <SRS0=bVbn=JL=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Eva Rachel Retuya <eraretuya@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 4/4] iio: accel: adxl345: add sampling frequency support
Date: Tue, 26 Jun 2018 00:22:43 +0900
Message-Id: <1529940163-5149-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1529940163-5149-1-git-send-email-akinobu.mita@gmail.com>
References: <1529940163-5149-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The ADXL345 provides selectable output data rate.  This adds the iio
channel information for the sampling frequency with that feature.

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- No changes from v3

 drivers/iio/accel/adxl345_core.c | 63 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7b29ae8..0a46791 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #include "adxl345.h"
 
@@ -22,6 +23,7 @@
 #define ADXL345_REG_OFSY		0x1f
 #define ADXL345_REG_OFSZ		0x20
 #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+#define ADXL345_REG_BW_RATE		0x2C
 #define ADXL345_REG_POWER_CTL		0x2D
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_DATAX0		0x32
@@ -30,6 +32,9 @@
 #define ADXL345_REG_DATA_AXIS(index)	\
 	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
 
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
 
@@ -62,7 +67,8 @@ struct adxl345_data {
 	.address = index,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 }
 
 static const struct iio_chan_spec adxl345_channels[] = {
@@ -77,6 +83,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
 	__le16 accel;
+	long long samp_freq_nhz;
 	unsigned int regval;
 	int ret;
 
@@ -112,6 +119,16 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		*val = sign_extend32(regval, 7) * 4;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);
+		if (ret < 0)
+			return ret;
+
+		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
+				(regval & ADXL345_BW_RATE);
+		*val = div_s64_rem(samp_freq_nhz, 1000000000, val2);
+
+		return IIO_VAL_INT_PLUS_NANO;
 	}
 
 	return -EINVAL;
@@ -122,6 +139,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
+	int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -132,14 +150,57 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		return regmap_write(data->regmap,
 				    ADXL345_REG_OFS_AXIS(chan->address),
 				    val / 4);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i <= ADXL345_BW_RATE; i++) {
+			int nhz;
+			int hz;
+
+			hz = div_s64_rem(ADXL345_BASE_RATE_NANO_HZ << i,
+					 1000000000, &nhz);
+			if (hz == val && nhz == val2) {
+				return regmap_update_bits(data->regmap,
+							ADXL345_REG_BW_RATE,
+							ADXL345_BW_RATE, i);
+			}
+		}
+		return -EINVAL;
 	}
 
 	return -EINVAL;
 }
 
+static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
+"0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
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
+	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-- 
2.7.4
