Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] iio: light: tsl2583: change functions to only have a single exit point
Date: Wed, 19 Oct 2016 06:32:05 -0400
Message-Id: <1476873130-24926-2-git-send-email-masneyb@onstation.org>
In-Reply-To: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Change the following functions to only have a single exit point:
taos_i2c_read(), taos_als_calibrate(), taos_chip_on(),
taos_gain_store(), taos_gain_available_show(), taos_luxtable_store()
and taos_probe().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 96 +++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 1e42a19..8448a87 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -159,7 +159,7 @@ static void taos_defaults(struct tsl2583_chip *chip)
 static int
 taos_i2c_read(struct i2c_client *client, u8 reg, u8 *val, unsigned int len)
 {
-	int i, ret;
+	int i, ret = 0;
 
 	for (i = 0; i < len; i++) {
 		/* select register to write */
@@ -168,14 +168,16 @@ taos_i2c_read(struct i2c_client *client, u8 reg, u8 *val, unsigned int len)
 			dev_err(&client->dev,
 				"taos_i2c_read failed to write register %x\n",
 				reg);
-			return ret;
+			goto read_done;
 		}
 		/* read the data */
 		*val = i2c_smbus_read_byte(client);
 		val++;
 		reg++;
 	}
-	return 0;
+
+read_done:
+	return ret;
 }
 
 /*
@@ -351,7 +353,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed to reach the CNTRL register, ret=%d\n",
 			ret);
-		return ret;
+		goto calibrate_done;
 	}
 
 	reg_val = i2c_smbus_read_byte(chip->client);
@@ -359,7 +361,8 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
-		return -ENODATA;
+		ret = -ENODATA;
+		goto calibrate_done;
 	}
 
 	ret = i2c_smbus_write_byte(chip->client,
@@ -368,19 +371,21 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed to reach the STATUS register, ret=%d\n",
 			ret);
-		return ret;
+		goto calibrate_done;
 	}
 	reg_val = i2c_smbus_read_byte(chip->client);
 
 	if ((reg_val & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: STATUS - ADC not valid.\n");
-		return -ENODATA;
+		ret = -ENODATA;
+		goto calibrate_done;
 	}
 	lux_val = taos_get_lux(indio_dev);
 	if (lux_val < 0) {
 		dev_err(&chip->client->dev, "taos_als_calibrate failed to get lux\n");
-		return lux_val;
+		ret = lux_val;
+		goto calibrate_done;
 	}
 	gain_trim_val = (unsigned int)(((chip->taos_settings.als_cal_target)
 			* chip->taos_settings.als_gain_trim) / lux_val);
@@ -389,11 +394,15 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: trim_val of %d is out of range\n",
 			gain_trim_val);
-		return -ENODATA;
+		ret = -ENODATA;
+		goto calibrate_done;
 	}
 	chip->taos_settings.als_gain_trim = (int)gain_trim_val;
+	ret = gain_trim_val;
+
+calibrate_done:
+	return ret;
 
-	return (int)gain_trim_val;
 }
 
 /*
@@ -403,7 +412,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 static int taos_chip_on(struct iio_dev *indio_dev)
 {
 	int i;
-	int ret;
+	int ret = -EINVAL;
 	u8 *uP;
 	u8 utmp;
 	int als_count;
@@ -414,7 +423,7 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
 		/* if forcing a register update - turn off, then on */
 		dev_info(&chip->client->dev, "device is already enabled\n");
-		return -EINVAL;
+		goto chip_on_done;
 	}
 
 	/* determine als integration register */
@@ -442,7 +451,7 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 					TSL258X_CMD_REG | TSL258X_CNTRL, utmp);
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "taos_chip_on failed on CNTRL reg.\n");
-		return ret;
+		goto chip_on_done;
 	}
 
 	/*
@@ -456,7 +465,7 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 		if (ret < 0) {
 			dev_err(&chip->client->dev,
 				"taos_chip_on failed on reg %d.\n", i);
-			return ret;
+			goto chip_on_done;
 		}
 	}
 
@@ -471,10 +480,11 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 					utmp);
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "taos_chip_on failed on 2nd CTRL reg.\n");
-		return ret;
+		goto chip_on_done;
 	}
 	chip->taos_chip_status = TSL258X_CHIP_WORKING;
 
+chip_on_done:
 	return ret;
 }
 
@@ -549,10 +559,10 @@ static ssize_t taos_gain_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int value;
+	int value, ret = -EINVAL;
 
 	if (kstrtoint(buf, 0, &value))
-		return -EINVAL;
+		goto gain_store_done;
 
 	switch (value) {
 	case 1:
@@ -569,10 +579,12 @@ static ssize_t taos_gain_store(struct device *dev,
 		break;
 	default:
 		dev_err(dev, "Invalid Gain Index (must be 1,8,16,111)\n");
-		return -EINVAL;
+		goto gain_store_done;
 	}
+	ret = len;
 
-	return len;
+gain_store_done:
+	return ret;
 }
 
 static ssize_t taos_gain_available_show(struct device *dev,
@@ -597,20 +609,22 @@ static ssize_t taos_als_time_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int value;
+	int value, ret = -EINVAL;
 
 	if (kstrtoint(buf, 0, &value))
-		return -EINVAL;
+		goto als_time_store_done;
 
 	if ((value < 50) || (value > 650))
-		return -EINVAL;
+		goto als_time_store_done;
 
 	if (value % 50)
-		return -EINVAL;
+		goto als_time_store_done;
 
 	chip->taos_settings.als_time = value;
+	ret = len;
 
-	return len;
+als_time_store_done:
+	return ret;
 }
 
 static ssize_t taos_als_time_available_show(struct device *dev,
@@ -734,7 +748,7 @@ static ssize_t taos_luxtable_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int value[ARRAY_SIZE(taos_device_lux) * 3 + 1];
-	int n;
+	int n, ret = -EINVAL;
 
 	get_options(buf, ARRAY_SIZE(value), value);
 
@@ -746,11 +760,11 @@ static ssize_t taos_luxtable_store(struct device *dev,
 	n = value[0];
 	if ((n % 3) || n < 6 || n > ((ARRAY_SIZE(taos_device_lux) - 1) * 3)) {
 		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
-		return -EINVAL;
+		goto luxable_store_done;
 	}
 	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
 		dev_info(dev, "LUX TABLE INPUT ERROR 2 Value[0]=%d\n", n);
-		return -EINVAL;
+		goto luxable_store_done;
 	}
 
 	if (chip->taos_chip_status == TSL258X_CHIP_WORKING)
@@ -761,8 +775,10 @@ static ssize_t taos_luxtable_store(struct device *dev,
 	memcpy(taos_device_lux, &value[1], (value[0] * 4));
 
 	taos_chip_on(indio_dev);
+	ret = len;
 
-	return len;
+luxable_store_done:
+	return ret;
 }
 
 static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
@@ -833,12 +849,15 @@ static int taos_probe(struct i2c_client *clientp,
 	if (!i2c_check_functionality(clientp->adapter,
 				     I2C_FUNC_SMBUS_BYTE_DATA)) {
 		dev_err(&clientp->dev, "taos_probe() - i2c smbus byte data func unsupported\n");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto probe_done;
 	}
 
 	indio_dev = devm_iio_device_alloc(&clientp->dev, sizeof(*chip));
-	if (!indio_dev)
-		return -ENOMEM;
+	if (!indio_dev) {
+		ret = -ENOMEM;
+		goto probe_done;
+	}
 	chip = iio_priv(indio_dev);
 	chip->client = clientp;
 	i2c_set_clientdata(clientp, indio_dev);
@@ -854,14 +873,14 @@ static int taos_probe(struct i2c_client *clientp,
 			dev_err(&clientp->dev,
 				"i2c_smbus_write_byte to cmd reg failed in taos_probe(), err = %d\n",
 				ret);
-			return ret;
+			goto probe_done;
 		}
 		ret = i2c_smbus_read_byte(clientp);
 		if (ret < 0) {
 			dev_err(&clientp->dev,
 				"i2c_smbus_read_byte from reg failed in taos_probe(), err = %d\n",
 				ret);
-			return ret;
+			goto probe_done;
 		}
 		buf[i] = ret;
 	}
@@ -869,7 +888,8 @@ static int taos_probe(struct i2c_client *clientp,
 	if (!taos_tsl258x_device(buf)) {
 		dev_info(&clientp->dev,
 			 "i2c device found but does not match expected id in taos_probe()\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto probe_done;
 	}
 
 	ret = i2c_smbus_write_byte(clientp, (TSL258X_CMD_REG | TSL258X_CNTRL));
@@ -877,7 +897,7 @@ static int taos_probe(struct i2c_client *clientp,
 		dev_err(&clientp->dev,
 			"i2c_smbus_write_byte() to cmd reg failed in taos_probe(), err = %d\n",
 			ret);
-		return ret;
+		goto probe_done;
 	}
 
 	indio_dev->info = &tsl2583_info;
@@ -887,7 +907,7 @@ static int taos_probe(struct i2c_client *clientp,
 	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev, "iio registration failed\n");
-		return ret;
+		goto probe_done;
 	}
 
 	/* Load up the V2 defaults (these are hard coded defaults for now) */
@@ -897,7 +917,9 @@ static int taos_probe(struct i2c_client *clientp,
 	taos_chip_on(indio_dev);
 
 	dev_info(&clientp->dev, "Light sensor found.\n");
-	return 0;
+
+probe_done:
+	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.7.4
