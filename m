Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:treewide use byteswapped smbus read word
Date: Tue, 11 Oct 2011 17:39:24 +0100
Message-Id: <1318351164-11211-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Relies on swapped variants of smbus word read and write functions.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
Depends on the patch that introduces these fucntions which is queued
up in Jean's i2c tree for the next merge window.

Straight forward boilerplate removal.

Jonathan

 drivers/staging/iio/adc/ad7150.c           |   14 ++--
 drivers/staging/iio/adc/ad7152.c           |   16 ++--
 drivers/staging/iio/adc/ad7291.c           |   94 +++++++++------------
 drivers/staging/iio/adc/ad7746.c           |   16 ++--
 drivers/staging/iio/adc/ad799x_core.c      |  126 +++++++---------------------
 drivers/staging/iio/magnetometer/hmc5843.c |    4 +-
 6 files changed, 99 insertions(+), 171 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 2a1d9c0..a015459 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -105,18 +105,18 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case 0:
-		ret = i2c_smbus_read_word_data(chip->client,
+		ret = i2c_smbus_read_word_swapped(chip->client,
 					ad7150_addresses[chan->channel][0]);
 		if (ret < 0)
 			return ret;
-		*val = swab16(ret);
+		*val = ret;
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE):
-		ret = i2c_smbus_read_word_data(chip->client,
+		ret = i2c_smbus_read_word_swapped(chip->client,
 					ad7150_addresses[chan->channel][1]);
 		if (ret < 0)
 			return ret;
-		*val = swab16(ret);
+		*val = ret;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -178,9 +178,9 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev, u64 event_code)
 		/* Note completely different from the adaptive versions */
 	case IIO_EV_TYPE_THRESH:
 		value = chip->threshold[rising][chan];
-		ret = i2c_smbus_write_word_data(chip->client,
-						ad7150_addresses[chan][3],
-						swab16(value));
+		ret = i2c_smbus_write_word_swapped(chip->client,
+						   ad7150_addresses[chan][3],
+						   value);
 		if (ret < 0)
 			return ret;
 		return 0;
diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 662584d..a1f916d 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -267,9 +267,9 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 
 		val = (val2 * 1024) / 15625;
 
-		ret = i2c_smbus_write_word_data(chip->client,
+		ret = i2c_smbus_write_word_swapped(chip->client,
 				ad7152_addresses[chan->channel][AD7152_GAIN],
-				swab16(val));
+				val);
 		if (ret < 0)
 			goto out;
 
@@ -281,9 +281,9 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = i2c_smbus_write_word_data(chip->client,
+		ret = i2c_smbus_write_word_swapped(chip->client,
 				ad7152_addresses[chan->channel][AD7152_OFFS],
-				swab16(val));
+				val);
 		if (ret < 0)
 			goto out;
 
@@ -361,11 +361,11 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 
 		msleep(ad7152_filter_rate_table[chip->filter_rate_setup][1]);
 		/* Now read the actual register */
-		ret = i2c_smbus_read_word_data(chip->client,
+		ret = i2c_smbus_read_word_swapped(chip->client,
 				ad7152_addresses[chan->channel][AD7152_DATA]);
 		if (ret < 0)
 			goto out;
-		*val = swab16(ret);
+		*val = ret;
 
 		if (chan->differential)
 			*val -= 0x8000;
@@ -380,7 +380,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 			goto out;
 		/* 1 + gain_val / 2^16 */
 		*val = 1;
-		*val2 = (15625 * swab16(ret)) / 1024;
+		*val2 = (15625 * ret) / 1024;
 
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
@@ -389,7 +389,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 				ad7152_addresses[chan->channel][AD7152_OFFS]);
 		if (ret < 0)
 			goto out;
-		*val = swab16(ret);
+		*val = ret;
 
 		ret = IIO_VAL_INT;
 		break;
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 10e79e8..88e7297 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -105,27 +105,6 @@ struct ad7291_chip_info {
 	struct mutex		state_lock;
 };
 
-static int ad7291_i2c_read(struct ad7291_chip_info *chip, u8 reg, u16 *data)
-{
-	struct i2c_client *client = chip->client;
-	int ret = 0;
-
-	ret = i2c_smbus_read_word_data(client, reg);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C read error\n");
-		return ret;
-	}
-
-	*data = swab16((u16)ret);
-
-	return 0;
-}
-
-static int ad7291_i2c_write(struct ad7291_chip_info *chip, u8 reg, u16 data)
-{
-	return i2c_smbus_write_word_data(chip->client, reg, swab16(data));
-}
-
 static ssize_t ad7291_store_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -134,8 +113,8 @@ static ssize_t ad7291_store_reset(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 
-	return ad7291_i2c_write(chip, AD7291_COMMAND,
-				chip->command | AD7291_RESET);
+	return i2c_smbus_write_word_swapped(chip->client, AD7291_COMMAND,
+					    chip->command | AD7291_RESET);
 }
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, ad7291_store_reset, 0);
@@ -153,25 +132,29 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct ad7291_chip_info *chip = iio_priv(private);
-	u16 t_status, v_status;
-	u16 command;
-	int i;
+	int t_status, v_status, i;
 	s64 timestamp = iio_get_time_ns();
 
-	if (ad7291_i2c_read(chip, AD7291_T_ALERT_STATUS, &t_status))
+	t_status = i2c_smbus_read_word_swapped(chip->client,
+					       AD7291_T_ALERT_STATUS);
+	if (t_status < 0)
 		return IRQ_HANDLED;
 
-	if (ad7291_i2c_read(chip, AD7291_VOLTAGE_ALERT_STATUS, &v_status))
+	v_status = i2c_smbus_read_word_swapped(chip->client,
+					       AD7291_VOLTAGE_ALERT_STATUS);
+	if (v_status < 0)
 		return IRQ_HANDLED;
 
 	if (!(t_status || v_status))
 		return IRQ_HANDLED;
 
-	command = chip->command | AD7291_ALERT_CLEAR;
-	ad7291_i2c_write(chip, AD7291_COMMAND, command);
+	i2c_smbus_write_word_swapped(chip->client,
+				     AD7291_COMMAND,
+				     chip->command | AD7291_ALERT_CLEAR);
 
-	command = chip->command & ~AD7291_ALERT_CLEAR;
-	ad7291_i2c_write(chip, AD7291_COMMAND, command);
+	i2c_smbus_write_word_swapped(chip->client,
+				     AD7291_COMMAND,
+				     chip->command & ~AD7291_ALERT_CLEAR);
 
 	/* For now treat t_sense and t_sense_average the same */
 	if ((t_status & (1 << 0)) || (t_status & (1 << 2)))
@@ -216,14 +199,13 @@ static inline ssize_t ad7291_show_hyst(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u16 data;
 	int ret;
 
-	ret = ad7291_i2c_read(chip, this_attr->address, &data);
+	ret = i2c_smbus_read_word_swapped(chip->client, this_attr->address);
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", data & AD7291_VALUE_MASK);
+	return sprintf(buf, "%d\n", ret & AD7291_VALUE_MASK);
 }
 
 static inline ssize_t ad7291_set_hyst(struct device *dev,
@@ -244,7 +226,8 @@ static inline ssize_t ad7291_set_hyst(struct device *dev,
 	if (data > AD7291_VALUE_MASK)
 		return -EINVAL;
 
-	ret = ad7291_i2c_write(chip, this_attr->address, data);
+	ret = i2c_smbus_write_word_swapped(chip->client,
+					   this_attr->address, data);
 	if (ret < 0)
 		return ret;
 
@@ -315,7 +298,6 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 
 	int ret;
 	u8 reg;
-	u16 uval;
 	s16 signval;
 
 	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
@@ -324,10 +306,10 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_RISING)];
 
-		ret = ad7291_i2c_read(chip, reg, &uval);
+		ret = i2c_smbus_read_word_swapped(chip->client, reg);
 		if (ret < 0)
 			return ret;
-		*val = uval & AD7291_VALUE_MASK;
+		*val = ret & AD7291_VALUE_MASK;
 		return 0;
 
 	case IIO_TEMP:
@@ -335,10 +317,11 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_RISING)];
 
-		ret = ad7291_i2c_read(chip, reg, &signval);
+		ret = i2c_smbus_read_word_swapped(chip->client, reg);
 		if (ret < 0)
 			return ret;
-		signval = (s16)((signval & AD7291_VALUE_MASK) << 4) >> 4;
+		signval =
+			(s16)((*(int *)&signval & AD7291_VALUE_MASK) << 4) >> 4;
 		*val = signval;
 		return 0;
 	default:
@@ -361,7 +344,7 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
 		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
 			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_RISING)];
-		return ad7291_i2c_write(chip, reg, val);
+		return i2c_smbus_write_word_swapped(chip->client, reg, val);
 	case IIO_TEMP:
 		if (val > 2047 || val < -2048)
 			return -EINVAL;
@@ -369,7 +352,8 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
 			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_RISING)];
 		signval = val;
-		return ad7291_i2c_write(chip, reg, *(u16 *)&signval);
+		return i2c_smbus_write_word_swapped(chip->client, reg,
+						    *(u16 *)&signval);
 	default:
 		return -EINVAL;
 	};
@@ -432,7 +416,9 @@ static int ad7291_write_event_config(struct iio_dev *indio_dev,
 		if (chip->c_mask) /* Enable autocycle? */
 			regval |= AD7291_AUTOCYCLE;
 
-		ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
+		ret = i2c_smbus_write_word_swapped(chip->client,
+						   AD7291_COMMAND,
+						   regval);
 		if (ret < 0)
 			goto error_ret;
 
@@ -472,7 +458,9 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 			/* Enable this channel alone */
 			regval = chip->command & (~AD7291_VOLTAGE_MASK);
 			regval |= 1 << (15 - chan->channel);
-			ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
+			ret = i2c_smbus_write_word_swapped(chip->client,
+							   AD7291_COMMAND,
+							   regval);
 			if (ret < 0) {
 				mutex_unlock(&chip->state_lock);
 				return ret;
@@ -484,7 +472,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 				mutex_unlock(&chip->state_lock);
 				return ret;
 			}
-			*val = swab16((u16)ret) & AD7291_VALUE_MASK;
+			*val = ret & AD7291_VALUE_MASK;
 			mutex_unlock(&chip->state_lock);
 			return IIO_VAL_INT;
 		case IIO_TEMP:
@@ -493,8 +481,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 						       AD7291_T_SENSE);
 			if (ret < 0)
 				return ret;
-			signval = (s16)((swab16((u16)ret) &
-				AD7291_VALUE_MASK) << 4) >> 4;
+			signval = (s16)((ret & AD7291_VALUE_MASK) << 4) >> 4;
 			*val = signval;
 			return IIO_VAL_INT;
 		default:
@@ -505,8 +492,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 					       AD7291_T_AVERAGE);
 			if (ret < 0)
 				return ret;
-			signval = (s16)((swab16((u16)ret) &
-				AD7291_VALUE_MASK) << 4) >> 4;
+			signval = (s16)((ret & AD7291_VALUE_MASK) << 4) >> 4;
 			*val = signval;
 			return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
@@ -618,13 +604,17 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	indio_dev->info = &ad7291_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ad7291_i2c_write(chip, AD7291_COMMAND, AD7291_RESET);
+	ret = i2c_smbus_write_word_swapped(chip->client,
+					   AD7291_COMMAND,
+					   AD7291_RESET);
 	if (ret) {
 		ret = -EIO;
 		goto error_disable_reg;
 	}
 
-	ret = ad7291_i2c_write(chip, AD7291_COMMAND, chip->command);
+	ret = i2c_smbus_write_word_swapped(chip->client,
+					   AD7291_COMMAND,
+					   chip->command);
 	if (ret) {
 		ret = -EIO;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/adc/ad7746.c b/drivers/staging/iio/adc/ad7746.c
index 2867943..10ef1c6 100644
--- a/drivers/staging/iio/adc/ad7746.c
+++ b/drivers/staging/iio/adc/ad7746.c
@@ -497,7 +497,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		ret = i2c_smbus_write_word_data(chip->client, reg, swab16(val));
+		ret = i2c_smbus_write_word_swapped(chip->client, reg, val);
 		if (ret < 0)
 			goto out;
 
@@ -508,8 +508,8 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = i2c_smbus_write_word_data(chip->client,
-				AD7746_REG_CAP_OFFH, swab16(val));
+		ret = i2c_smbus_write_word_swapped(chip->client,
+						   AD7746_REG_CAP_OFFH, val);
 		if (ret < 0)
 			goto out;
 
@@ -625,21 +625,21 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		ret = i2c_smbus_read_word_data(chip->client, reg);
+		ret = i2c_smbus_read_word_swapped(chip->client, reg);
 		if (ret < 0)
 			goto out;
 		/* 1 + gain_val / 2^16 */
 		*val = 1;
-		*val2 = (15625 * swab16(ret)) / 1024;
+		*val2 = (15625 * ret) / 1024;
 
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case (1 << IIO_CHAN_INFO_CALIBBIAS_SHARED):
-		ret = i2c_smbus_read_word_data(chip->client,
-					       AD7746_REG_CAP_OFFH);
+		ret = i2c_smbus_read_word_swapped(chip->client,
+						  AD7746_REG_CAP_OFFH);
 		if (ret < 0)
 			goto out;
-		*val = swab16(ret);
+		*val = ret;
 
 		ret = IIO_VAL_INT;
 		break;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index ee6cd79..d64fbf9 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -39,76 +39,16 @@
 
 #include "ad799x.h"
 
-/*
- * ad799x register access by I2C
- */
-static int ad799x_i2c_read16(struct ad799x_state *st, u8 reg, u16 *data)
-{
-	struct i2c_client *client = st->client;
-	int ret = 0;
-
-	ret = i2c_smbus_read_word_data(client, reg);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C read error\n");
-		return ret;
-	}
-
-	*data = swab16((u16)ret);
-
-	return 0;
-}
-
-static int ad799x_i2c_read8(struct ad799x_state *st, u8 reg, u8 *data)
-{
-	struct i2c_client *client = st->client;
-	int ret = 0;
-
-	ret = i2c_smbus_read_byte_data(client, reg);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C read error\n");
-		return ret;
-	}
-
-	*data = (u8)ret;
-
-	return 0;
-}
-
-static int ad799x_i2c_write16(struct ad799x_state *st, u8 reg, u16 data)
-{
-	struct i2c_client *client = st->client;
-	int ret = 0;
-
-	ret = i2c_smbus_write_word_data(client, reg, swab16(data));
-	if (ret < 0)
-		dev_err(&client->dev, "I2C write error\n");
-
-	return ret;
-}
-
-static int ad799x_i2c_write8(struct ad799x_state *st, u8 reg, u8 data)
-{
-	struct i2c_client *client = st->client;
-	int ret = 0;
-
-	ret = i2c_smbus_write_byte_data(client, reg, data);
-	if (ret < 0)
-		dev_err(&client->dev, "I2C write error\n");
-
-	return ret;
-}
-
 int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask)
 {
-	return ad799x_i2c_write16(st, AD7998_CONF_REG,
-		st->config | (mask << AD799X_CHANNEL_SHIFT));
+	return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
+					    st->config |
+					    (mask << AD799X_CHANNEL_SHIFT));
 }
 
 static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
 {
-	u16 rxbuf;
 	u8 cmd;
-	int ret;
 
 	switch (st->id) {
 	case ad7991:
@@ -129,11 +69,7 @@ static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
 		return -EINVAL;
 	}
 
-	ret = ad799x_i2c_read16(st, cmd, &rxbuf);
-	if (ret < 0)
-		return ret;
-
-	return rxbuf;
+	return i2c_smbus_read_word_swapped(st->client, cmd);
 }
 
 static int ad799x_read_raw(struct iio_dev *indio_dev,
@@ -187,11 +123,12 @@ static ssize_t ad799x_read_frequency(struct device *dev,
 
 	int ret;
 	u8 val;
-	ret = ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &val);
-	if (ret)
+
+	ret = i2c_smbus_read_byte_data(st->client, AD7998_CYCLE_TMR_REG);
+	if (ret < 0)
 		return ret;
 
-	val &= AD7998_CYC_MASK;
+	val = ret & AD7998_CYC_MASK;
 
 	return sprintf(buf, "%u\n", ad7998_frequencies[val]);
 }
@@ -213,11 +150,11 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &t);
-	if (ret)
+	ret = i2c_smbus_read_byte_data(st->client, AD7998_CYCLE_TMR_REG);
+	if (ret < 0)
 		goto error_ret_mutex;
 	/* Wipe the bits clean */
-	t &= ~AD7998_CYC_MASK;
+	t = ret & ~AD7998_CYC_MASK;
 
 	for (i = 0; i < ARRAY_SIZE(ad7998_frequencies); i++)
 		if (val == ad7998_frequencies[i])
@@ -227,7 +164,7 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 		goto error_ret_mutex;
 	}
 	t |= i;
-	ret = ad799x_i2c_write8(st, AD7998_CYCLE_TMR_REG, t);
+	ret = i2c_smbus_write_byte_data(st->client, AD7998_CYCLE_TMR_REG, t);
 
 error_ret_mutex:
 	mutex_unlock(&indio_dev->mlock);
@@ -257,11 +194,10 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 	int direction = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_FALLING);
 	int number = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	u8 address = ad799x_threshold_addresses[number][direction];
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_write16(st,
-				 ad799x_threshold_addresses[number][direction],
-				 val);
+	ret = i2c_smbus_write_word_swapped(st->client, address, val);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
@@ -276,16 +212,14 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 	int direction = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
 			   IIO_EV_DIR_FALLING);
 	int number = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
-	u16 valin;
+	u8 address = ad799x_threshold_addresses[number][direction];
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_read16(st,
-				ad799x_threshold_addresses[number][direction],
-				&valin);
+	ret = i2c_smbus_read_word_swapped(st->client, address);
 	mutex_unlock(&indio_dev->mlock);
 	if (ret < 0)
 		return ret;
-	*val = valin;
+	*val = ret;
 
 	return 0;
 }
@@ -297,14 +231,14 @@ static ssize_t ad799x_read_channel_config(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad799x_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
 	int ret;
-	u16 val;
-	ret = ad799x_i2c_read16(st, this_attr->address, &val);
-	if (ret)
+
+	ret = i2c_smbus_read_word_swapped(st->client,
+					  this_attr->address);
+	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", val);
+	return sprintf(buf, "%d\n", ret);
 }
 
 static ssize_t ad799x_write_channel_config(struct device *dev,
@@ -324,7 +258,8 @@ static ssize_t ad799x_write_channel_config(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_write16(st, this_attr->address, val);
+	ret = i2c_smbus_write_word_swapped(st->client,
+					   this_attr->address, val);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
@@ -337,14 +272,17 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 	u8 status;
 	int i, ret;
 
-	ret = ad799x_i2c_read8(st, AD7998_ALERT_STAT_REG, &status);
-	if (ret)
+	ret = i2c_smbus_read_byte_data(st->client, AD7998_ALERT_STAT_REG);
+	if (ret < 0)
 		return ret;
 
-	if (!status)
+	if (ret == 0)
 		return -EIO;
-
-	ad799x_i2c_write8(st, AD7998_ALERT_STAT_REG, AD7998_ALERT_STAT_CLEAR);
+	status = ret;
+	ret = i2c_smbus_write_byte_data(st->client, AD7998_ALERT_STAT_REG,
+					AD7998_ALERT_STAT_CLEAR);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i))
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index fc9ee97..bd20848 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -156,12 +156,12 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
 	while (!(result & DATA_READY))
 		result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
 
-	result = i2c_smbus_read_word_data(client, address);
+	result = i2c_smbus_read_word_swapped(client, address);
 	mutex_unlock(&data->lock);
 	if (result < 0)
 		return -EINVAL;
 
-	*val	= (s16)swab16((u16)result);
+	*val	= (s16)result;
 	return IIO_VAL_INT;
 }
 
-- 
1.7.3.4
