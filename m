Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 4/5] iio: ad7152: Add proper locking
Date: Wed, 24 Aug 2011 14:45:55 +0200
Message-ID: <1314189956-26511-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314189956-26511-1-git-send-email-michael.hennerich@analog.com>
References: <1314189956-26511-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add proper locking.
Consistently use indio_dev.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7152.c |  109 ++++++++++++++++++++++++-------------
 1 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index d3ffcdf..bf26d38 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -18,7 +18,7 @@
 #include "../sysfs.h"
 
 /*
- * TODO: Check compliance of calibscale and calibbias with abi (units)
+ * TODO: Check compliance of calibbias with abi (units)
  */
 /*
  * AD7152 registers definition
@@ -93,8 +93,8 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
 					 size_t len,
 					 u8 regval)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	bool doit;
 	int ret, timeout = 10;
@@ -111,17 +111,23 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
 	else
 		regval |= AD7152_CONF_CH2EN;
 
+	mutex_lock(&indio_dev->mlock);
 	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
-	if (ret < 0)
+	if (ret < 0) {
+		mutex_unlock(&indio_dev->mlock);
 		return ret;
+	}
 
 	do {
 		mdelay(20);
 		ret = i2c_smbus_read_byte_data(chip->client, AD7152_REG_CFG);
-		if (ret < 0)
+		if (ret < 0) {
+			mutex_unlock(&indio_dev->mlock);
 			return ret;
+		}
 	} while ((ret == regval) && timeout--);
 
+	mutex_unlock(&indio_dev->mlock);
 	return len;
 }
 static ssize_t ad7152_start_offset_calib(struct device *dev,
@@ -157,8 +163,8 @@ static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "0x%02x\n", chip->filter_rate_setup);
 }
@@ -168,8 +174,8 @@ static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
 	u8 data;
 	int ret;
 
@@ -177,11 +183,13 @@ static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	mutex_lock(&indio_dev->mlock);
 	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG2, data);
 	if (ret < 0)
 		return ret;
 
 	chip->filter_rate_setup = data;
+	mutex_unlock(&indio_dev->mlock);
 
 	return len;
 }
@@ -219,19 +227,23 @@ static const int ad7152_scale_table[] = {
 	30525, 7631, 15263, 61050
 };
 
-static int ad7152_write_raw(struct iio_dev *dev_info,
+static int ad7152_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
 			    int val2,
 			    long mask)
 {
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
 	int ret, i;
 
+	mutex_lock(&indio_dev->mlock);
+
 	switch (mask) {
 	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
-		if (val != 1)
-			return -EINVAL;
+		if (val != 1) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		val = (val2 * 1024) / 15625;
 
@@ -239,23 +251,29 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
 				ad7152_addresses[chan->channel][AD7152_GAIN],
 				swab16(val));
 		if (ret < 0)
-			return ret;
+			goto out;
 
-		return 0;
+		ret = 0;
+		break;
 
 	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
-		if ((val < 0) | (val > 0xFFFF))
-			return -EINVAL;
+		if ((val < 0) | (val > 0xFFFF)) {
+			ret = -EINVAL;
+			goto out;
+		}
 		ret = i2c_smbus_write_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_OFFS],
 				swab16(val));
 		if (ret < 0)
-			return ret;
+			goto out;
 
-		return 0;
+		ret = 0;
+		break;
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-		if (val != 0)
-			return -EINVAL;
+		if (val != 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 		for (i = 0; i < ARRAY_SIZE(ad7152_scale_table); i++)
 			if (val2 == ad7152_scale_table[i])
 				break;
@@ -267,21 +285,29 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
 				ad7152_addresses[chan->channel][AD7152_SETUP],
 				chip->setup[chan->channel]);
 		if (ret < 0)
-			return ret;
-		else
-			return 0;
+			goto out;
+
+		ret = 0;
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
 }
-static int ad7152_read_raw(struct iio_dev *dev_info,
+static int ad7152_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2,
 			   long mask)
 {
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
 	int ret;
 	u8 regval = 0;
+
+	mutex_lock(&indio_dev->mlock);
+
 	switch (mask) {
 	case 0:
 		/* First set whether in differential mode */
@@ -298,7 +324,7 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 				ad7152_addresses[chan->channel][AD7152_SETUP],
 				chip->setup[chan->channel]);
 			if (ret < 0)
-				return ret;
+				goto out;
 		}
 		/* Make sure the channel is enabled */
 		if (chan->channel == 0)
@@ -311,48 +337,55 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 		ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG,
 				regval);
 		if (ret < 0)
-			return ret;
+			goto out;
 
 		msleep(60); /* Slowest conversion time */
 		/* Now read the actual register */
 		ret = i2c_smbus_read_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_DATA]);
 		if (ret < 0)
-			return ret;
+			goto out;
 		*val = swab16(ret);
 
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
 	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
 
 		ret = i2c_smbus_read_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_GAIN]);
 		if (ret < 0)
-			return ret;
+			goto out;
 		/* 1 + gain_val / 2^16 */
 		*val = 1;
 		*val2 = (15625 * swab16(ret)) / 1024;
 
-		return IIO_VAL_INT_PLUS_MICRO;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
 		ret = i2c_smbus_read_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_OFFS]);
 		if (ret < 0)
-			return ret;
+			goto out;
 		*val = swab16(ret);
 
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 		ret = i2c_smbus_read_byte_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_SETUP]);
 		if (ret < 0)
-			return ret;
+			goto out;
 		*val = 0;
 		*val2 = ad7152_scale_table[ret >> 6];
 
-		return IIO_VAL_INT_PLUS_NANO;
+		ret = IIO_VAL_INT_PLUS_NANO;
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	};
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
 }
 
 static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
-- 
1.7.0.4
