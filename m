Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41829 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeF3QdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2018 12:33:09 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so5289562pgl.8
        for <linux-iio@vger.kernel.org>; Sat, 30 Jun 2018 09:33:08 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 4/4] iio: accel: adxl345: add sampling frequency support
Date: Sun,  1 Jul 2018 01:32:45 +0900
Message-Id: <1530376365-23946-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
References: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADXL345 provides selectable output data rate.  This adds the iio
channel information for the sampling frequency with that feature.

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v5 (Suggested by Andy Shevchenko)
- Introduce constant for nHZ per HZ
- Find an register setting without looping over all available frequencies
- Allow all user supplied values and round to an available frequency

 drivers/iio/accel/adxl345_core.c | 57 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7b29ae8..fba1ae2 100644
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
@@ -30,6 +32,10 @@
 #define ADXL345_REG_DATA_AXIS(index)	\
 	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
 
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+#define NHZ_PER_HZ			1000000000LL
+
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
 
@@ -62,7 +68,8 @@ struct adxl345_data {
 	.address = index,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 }
 
 static const struct iio_chan_spec adxl345_channels[] = {
@@ -77,6 +84,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
 	__le16 accel;
+	long long samp_freq_nhz;
 	unsigned int regval;
 	int ret;
 
@@ -112,6 +120,16 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		*val = sign_extend32(regval, 7) * 4;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);
+		if (ret < 0)
+			return ret;
+
+		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
+				(regval & ADXL345_BW_RATE);
+		*val = div_s64_rem(samp_freq_nhz, NHZ_PER_HZ, val2);
+
+		return IIO_VAL_INT_PLUS_NANO;
 	}
 
 	return -EINVAL;
@@ -122,6 +140,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
+	s64 n;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -132,14 +151,50 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		return regmap_write(data->regmap,
 				    ADXL345_REG_OFS_AXIS(chan->address),
 				    val / 4);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		n = div_s64(val * NHZ_PER_HZ + val2, ADXL345_BASE_RATE_NANO_HZ);
+		n = ilog2(max_t(s64, n, 1));
+
+		return regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,
+					  ADXL345_BW_RATE,
+					  min_t(int, n, ADXL345_BW_RATE));
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

