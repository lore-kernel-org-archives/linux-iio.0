Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 18/19] staging:iio:light:tsl2583 allocate chip state with iio_dev
Date: Fri, 12 Aug 2011 17:08:52 +0100
Message-Id: <1313165333-3951-19-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
References: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

There are some unusual corners in the probe function of this
driver, so may need another look.

V2: Now with the check for allocation success not inverted.
V3: Now with the i2c devdata calls actually being correctly cast.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Tested-by: Jon Brenner <jbrenner@TAOSinc.com>
---
 drivers/staging/iio/light/tsl2583.c |  216 ++++++++++++++++-------------------
 1 files changed, 101 insertions(+), 115 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 296d0ff..f75fe85 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -87,7 +87,6 @@ struct taos_settings {
 struct tsl2583_chip {
 	struct mutex als_mutex;
 	struct i2c_client *client;
-	struct iio_dev *iio_dev;
 	struct taos_als_info als_cur_info;
 	struct taos_settings taos_settings;
 	int als_time_scale;
@@ -159,8 +158,7 @@ static void taos_defaults(struct tsl2583_chip *chip)
 static int
 taos_i2c_read(struct i2c_client *client, u8 reg, u8 *val, unsigned int len)
 {
-	int ret;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < len; i++) {
 		/* select register to write */
@@ -191,47 +189,47 @@ taos_i2c_read(struct i2c_client *client, u8 reg, u8 *val, unsigned int len)
  * the array are then used along with the time scale factor array values, to
  * calculate the lux.
  */
-static int taos_get_lux(struct i2c_client *client)
+static int taos_get_lux(struct iio_dev *indio_dev)
 {
 	u16 ch0, ch1; /* separated ch0/ch1 data from device */
 	u32 lux; /* raw lux calculated from device data */
 	u32 ratio;
 	u8 buf[5];
 	struct taos_lux *p;
-	struct tsl2583_chip *chip = i2c_get_clientdata(client);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int i, ret;
 	u32 ch0lux = 0;
 	u32 ch1lux = 0;
 
 	if (mutex_trylock(&chip->als_mutex) == 0) {
-		dev_info(&client->dev, "taos_get_lux device is busy\n");
+		dev_info(&chip->client->dev, "taos_get_lux device is busy\n");
 		return chip->als_cur_info.lux; /* busy, so return LAST VALUE */
 	}
 
 	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
 		/* device is not enabled */
-		dev_err(&client->dev, "taos_get_lux device is not enabled\n");
+		dev_err(&chip->client->dev, "taos_get_lux device is not enabled\n");
 		ret = -EBUSY ;
 		goto out_unlock;
 	}
 
-	ret = taos_i2c_read(client, (TSL258X_CMD_REG), &buf[0], 1);
+	ret = taos_i2c_read(chip->client, (TSL258X_CMD_REG), &buf[0], 1);
 	if (ret < 0) {
-		dev_err(&client->dev, "taos_get_lux failed to read CMD_REG\n");
+		dev_err(&chip->client->dev, "taos_get_lux failed to read CMD_REG\n");
 		goto out_unlock;
 	}
 	/* is data new & valid */
 	if (!(buf[0] & TSL258X_STA_ADC_INTR)) {
-		dev_err(&client->dev, "taos_get_lux data not valid\n");
+		dev_err(&chip->client->dev, "taos_get_lux data not valid\n");
 		ret = chip->als_cur_info.lux; /* return LAST VALUE */
 		goto out_unlock;
 	}
 
 	for (i = 0; i < 4; i++) {
 		int reg = TSL258X_CMD_REG | (TSL258X_ALS_CHAN0LO + i);
-		ret = taos_i2c_read(client, reg, &buf[i], 1);
+		ret = taos_i2c_read(chip->client, reg, &buf[i], 1);
 		if (ret < 0) {
-			dev_err(&client->dev, "taos_get_lux failed to read"
+			dev_err(&chip->client->dev, "taos_get_lux failed to read"
 				" register %x\n", reg);
 			goto out_unlock;
 		}
@@ -239,11 +237,12 @@ static int taos_get_lux(struct i2c_client *client)
 
 	/* clear status, really interrupt status (interrupts are off), but
 	 * we use the bit anyway - don't forget 0x80 - this is a command*/
-	ret = i2c_smbus_write_byte(client,
-	(TSL258X_CMD_REG | TSL258X_CMD_SPL_FN | TSL258X_CMD_ALS_INT_CLR));
+	ret = i2c_smbus_write_byte(chip->client,
+				   (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
+				    TSL258X_CMD_ALS_INT_CLR));
 
 	if (ret < 0) {
-		dev_err(&client->dev,
+		dev_err(&chip->client->dev,
 			"taos_i2c_write_command failed in taos_get_lux, err = %d\n",
 			ret);
 		goto out_unlock; /* have no data, so return failure */
@@ -285,7 +284,7 @@ static int taos_get_lux(struct i2c_client *client)
 
 	/* note: lux is 31 bit max at this point */
 	if (ch1lux > ch0lux) {
-		dev_dbg(&client->dev, "No Data - Return last value\n");
+		dev_dbg(&chip->client->dev, "No Data - Return last value\n");
 		ret = chip->als_cur_info.lux = 0;
 		goto out_unlock;
 	}
@@ -319,54 +318,56 @@ out_unlock:
  * to derive actual lux).
  * Return updated gain_trim value.
  */
-int taos_als_calibrate(struct i2c_client *client)
+static int taos_als_calibrate(struct iio_dev *indio_dev)
 {
-	struct tsl2583_chip *chip = i2c_get_clientdata(client);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	u8 reg_val;
 	unsigned int gain_trim_val;
 	int ret;
 	int lux_val;
 
-	ret = i2c_smbus_write_byte(client, (TSL258X_CMD_REG | TSL258X_CNTRL));
+	ret = i2c_smbus_write_byte(chip->client,
+				   (TSL258X_CMD_REG | TSL258X_CNTRL));
 	if (ret < 0) {
-		dev_err(&client->dev,
+		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed to reach the CNTRL register, ret=%d\n",
 			ret);
 		return ret;
 	}
 
-	reg_val = i2c_smbus_read_byte(client);
+	reg_val = i2c_smbus_read_byte(chip->client);
 	if ((reg_val & (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON))
 			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
-		dev_err(&client->dev,
+		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
 		return -1;
 	}
 
-	ret = i2c_smbus_write_byte(client, (TSL258X_CMD_REG | TSL258X_CNTRL));
+	ret = i2c_smbus_write_byte(chip->client,
+				   (TSL258X_CMD_REG | TSL258X_CNTRL));
 	if (ret < 0) {
-		dev_err(&client->dev,
+		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed to reach the STATUS register, ret=%d\n",
 			ret);
 		return ret;
 	}
-	reg_val = i2c_smbus_read_byte(client);
+	reg_val = i2c_smbus_read_byte(chip->client);
 
 	if ((reg_val & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
-		dev_err(&client->dev,
+		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: STATUS - ADC not valid.\n");
 		return -ENODATA;
 	}
-	lux_val = taos_get_lux(client);
+	lux_val = taos_get_lux(indio_dev);
 	if (lux_val < 0) {
-		dev_err(&client->dev, "taos_als_calibrate failed to get lux\n");
+		dev_err(&chip->client->dev, "taos_als_calibrate failed to get lux\n");
 		return lux_val;
 	}
 	gain_trim_val = (unsigned int) (((chip->taos_settings.als_cal_target)
 			* chip->taos_settings.als_gain_trim) / lux_val);
 
 	if ((gain_trim_val < 250) || (gain_trim_val > 4000)) {
-		dev_err(&client->dev,
+		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: trim_val of %d is out of range\n",
 			gain_trim_val);
 		return -ENODATA;
@@ -380,21 +381,21 @@ int taos_als_calibrate(struct i2c_client *client)
  * Turn the device on.
  * Configuration must be set before calling this function.
  */
-static int taos_chip_on(struct i2c_client *client)
+static int taos_chip_on(struct iio_dev *indio_dev)
 {
 	int i;
-	int ret = 0;
+	int ret;
 	u8 *uP;
 	u8 utmp;
 	int als_count;
 	int als_time;
-	struct tsl2583_chip *chip = i2c_get_clientdata(client);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	/* and make sure we're not already on */
 	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
 		/* if forcing a register update - turn off, then on */
-		dev_info(&client->dev, "device is already enabled\n");
-		return   -EINVAL;
+		dev_info(&chip->client->dev, "device is already enabled\n");
+		return -EINVAL;
 	}
 
 	/* determine als integration regster */
@@ -416,20 +417,21 @@ static int taos_chip_on(struct i2c_client *client)
 	/* TSL258x Specific power-on / adc enable sequence
 	 * Power on the device 1st. */
 	utmp = TSL258X_CNTL_PWR_ON;
-	ret = i2c_smbus_write_byte_data(client,
-		TSL258X_CMD_REG | TSL258X_CNTRL, utmp);
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_CNTRL, utmp);
 	if (ret < 0) {
-		dev_err(&client->dev, "taos_chip_on failed on CNTRL reg.\n");
+		dev_err(&chip->client->dev, "taos_chip_on failed on CNTRL reg.\n");
 		return -1;
 	}
 
 	/* Use the following shadow copy for our delay before enabling ADC.
 	 * Write all the registers. */
 	for (i = 0, uP = chip->taos_config; i < TSL258X_REG_MAX; i++) {
-		ret = i2c_smbus_write_byte_data(client, TSL258X_CMD_REG + i,
+		ret = i2c_smbus_write_byte_data(chip->client,
+						TSL258X_CMD_REG + i,
 						*uP++);
 		if (ret < 0) {
-			dev_err(&client->dev,
+			dev_err(&chip->client->dev,
 				"taos_chip_on failed on reg %d.\n", i);
 			return -1;
 		}
@@ -439,10 +441,11 @@ static int taos_chip_on(struct i2c_client *client)
 	/* NOW enable the ADC
 	 * initialize the desired mode of operation */
 	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
-	ret = i2c_smbus_write_byte_data(client, TSL258X_CMD_REG | TSL258X_CNTRL,
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_CNTRL,
 					utmp);
 	if (ret < 0) {
-		dev_err(&client->dev, "taos_chip_on failed on 2nd CTRL reg.\n");
+		dev_err(&chip->client->dev, "taos_chip_on failed on 2nd CTRL reg.\n");
 		return -1;
 	}
 	chip->taos_chip_status = TSL258X_CHIP_WORKING;
@@ -450,33 +453,26 @@ static int taos_chip_on(struct i2c_client *client)
 	return ret;
 }
 
-static int taos_chip_off(struct i2c_client *client)
+static int taos_chip_off(struct iio_dev *indio_dev)
 {
-	struct tsl2583_chip *chip = i2c_get_clientdata(client);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int ret;
 
 	/* turn device off */
 	chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
-	ret = i2c_smbus_write_byte_data(client, TSL258X_CMD_REG | TSL258X_CNTRL,
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_CNTRL,
 					0x00);
 	return ret;
 }
 
 /* Sysfs Interface Functions */
-static ssize_t taos_device_id(struct device *dev,
-struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
-
-	return sprintf(buf, "%s\n", chip->client->name);
-}
 
 static ssize_t taos_power_state_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->taos_chip_status);
 }
@@ -485,16 +481,15 @@ static ssize_t taos_power_state_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
 		return -EINVAL;
 
 	if (value == 0)
-		taos_chip_off(chip->client);
+		taos_chip_off(indio_dev);
 	else
-		taos_chip_on(chip->client);
+		taos_chip_on(indio_dev);
 
 	return len;
 }
@@ -503,7 +498,7 @@ static ssize_t taos_gain_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	char gain[4] = {0};
 
 	switch (chip->taos_settings.als_gain) {
@@ -528,7 +523,7 @@ static ssize_t taos_gain_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -565,7 +560,7 @@ static ssize_t taos_als_time_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->taos_settings.als_time);
 }
@@ -574,7 +569,7 @@ static ssize_t taos_als_time_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -586,7 +581,7 @@ static ssize_t taos_als_time_store(struct device *dev,
 	if (value % 50)
 		return -EINVAL;
 
-	 chip->taos_settings.als_time = value;
+	chip->taos_settings.als_time = value;
 
 	return len;
 }
@@ -602,7 +597,7 @@ static ssize_t taos_als_trim_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->taos_settings.als_gain_trim);
 }
@@ -611,7 +606,7 @@ static ssize_t taos_als_trim_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -627,7 +622,7 @@ static ssize_t taos_als_cal_target_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->taos_settings.als_cal_target);
 }
@@ -636,7 +631,7 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -651,27 +646,26 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
 static ssize_t taos_lux_show(struct device *dev, struct device_attribute *attr,
 	char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
-	int lux;
+	int ret;
 
-	lux = taos_get_lux(chip->client);
+	ret = taos_get_lux(dev_get_drvdata(dev));
+	if (ret < 0)
+		return ret;
 
-	return sprintf(buf, "%d\n", lux);
+	return sprintf(buf, "%d\n", ret);
 }
 
 static ssize_t taos_do_calibrate(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
 		return -EINVAL;
 
 	if (value == 1)
-		taos_als_calibrate(chip->client);
+		taos_als_calibrate(indio_dev);
 
 	return len;
 }
@@ -703,8 +697,8 @@ static ssize_t taos_luxtable_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
-	int value[ARRAY_SIZE(taos_device_lux)];
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
+	int value[ARRAY_SIZE(taos_device_lux)*3 + 1];
 	int n;
 
 	get_options(buf, ARRAY_SIZE(value), value);
@@ -725,18 +719,17 @@ static ssize_t taos_luxtable_store(struct device *dev,
 	}
 
 	if (chip->taos_chip_status == TSL258X_CHIP_WORKING)
-		taos_chip_off(chip->client);
+		taos_chip_off(indio_dev);
 
 	/* Zero out the table */
 	memset(taos_device_lux, 0, sizeof(taos_device_lux));
 	memcpy(taos_device_lux, &value[1], (value[0] * 4));
 
-	taos_chip_on(chip->client);
+	taos_chip_on(indio_dev);
 
 	return len;
 }
 
-static DEVICE_ATTR(name, S_IRUGO, taos_device_id, NULL);
 static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
 		taos_power_state_show, taos_power_state_store);
 
@@ -762,7 +755,6 @@ static DEVICE_ATTR(illuminance0_lux_table, S_IRUGO | S_IWUSR,
 		taos_luxtable_show, taos_luxtable_store);
 
 static struct attribute *sysfs_attrs_ctrl[] = {
-	&dev_attr_name.attr,
 	&dev_attr_power_state.attr,
 	&dev_attr_illuminance0_calibscale.attr,			/* Gain  */
 	&dev_attr_illuminance0_calibscale_available.attr,
@@ -798,9 +790,10 @@ static const struct iio_info tsl2583_info = {
 static int __devinit taos_probe(struct i2c_client *clientp,
 		      const struct i2c_device_id *idp)
 {
-	int i, ret = 0;
+	int i, ret;
 	unsigned char buf[TSL258X_MAX_DEVICE_REGS];
-	static struct tsl2583_chip *chip;
+	struct tsl2583_chip *chip;
+	struct iio_dev *indio_dev;
 
 	if (!i2c_check_functionality(clientp->adapter,
 		I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -810,12 +803,15 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 		return -EOPNOTSUPP;
 	}
 
-	chip = kzalloc(sizeof(struct tsl2583_chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		dev_err(&clientp->dev, "iio allocation failed\n");
+		goto fail1;
+	}
+	chip = iio_priv(indio_dev);
 	chip->client = clientp;
-	i2c_set_clientdata(clientp, chip);
+	i2c_set_clientdata(clientp, indio_dev);
 
 	mutex_init(&chip->als_mutex);
 	chip->taos_chip_status = TSL258X_CHIP_UNKNOWN;
@@ -827,14 +823,14 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 		if (ret < 0) {
 			dev_err(&clientp->dev, "i2c_smbus_write_bytes() to cmd "
 				"reg failed in taos_probe(), err = %d\n", ret);
-			goto fail1;
+			goto fail2;
 		}
 		ret = i2c_smbus_read_byte(clientp);
 		if (ret < 0) {
 			dev_err(&clientp->dev, "i2c_smbus_read_byte from "
 				"reg failed in taos_probe(), err = %d\n", ret);
 
-			goto fail1;
+			goto fail2;
 		}
 		buf[i] = ret;
 	}
@@ -842,58 +838,50 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 	if (!taos_tsl258x_device(buf)) {
 		dev_info(&clientp->dev, "i2c device found but does not match "
 			"expected id in taos_probe()\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	ret = i2c_smbus_write_byte(clientp, (TSL258X_CMD_REG | TSL258X_CNTRL));
 	if (ret < 0) {
 		dev_err(&clientp->dev, "i2c_smbus_write_byte() to cmd reg "
 			"failed in taos_probe(), err = %d\n", ret);
-		goto fail1;
+		goto fail2;
 	}
 
-	chip->iio_dev = iio_allocate_device(0);
-	if (!chip->iio_dev) {
-		ret = -ENOMEM;
-		dev_err(&clientp->dev, "iio allocation failed\n");
-		goto fail1;
-	}
-
-	chip->iio_dev->info = &tsl2583_info;
-	chip->iio_dev->dev.parent = &clientp->dev;
-	chip->iio_dev->dev_data = (void *)(chip);
-	chip->iio_dev->modes = INDIO_DIRECT_MODE;
-	ret = iio_device_register(chip->iio_dev);
+	indio_dev->info = &tsl2583_info;
+	indio_dev->dev.parent = &clientp->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = chip->client->name;
+	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev, "iio registration failed\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	/* Load up the V2 defaults (these are hard coded defaults for now) */
 	taos_defaults(chip);
 
 	/* Make sure the chip is on */
-	taos_chip_on(clientp);
+	taos_chip_on(indio_dev);
 
 	dev_info(&clientp->dev, "Light sensor found.\n");
-
 	return 0;
-
 fail1:
-	kfree(chip);
-
+	iio_free_device(indio_dev);
+fail2:
 	return ret;
 }
 
 static int taos_suspend(struct i2c_client *client, pm_message_t state)
 {
-	struct tsl2583_chip *chip = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
 
 	mutex_lock(&chip->als_mutex);
 
 	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
-		ret = taos_chip_off(client);
+		ret = taos_chip_off(indio_dev);
 		chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
 	}
 
@@ -903,13 +891,14 @@ static int taos_suspend(struct i2c_client *client, pm_message_t state)
 
 static int taos_resume(struct i2c_client *client)
 {
-	struct tsl2583_chip *chip = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
 
 	mutex_lock(&chip->als_mutex);
 
 	if (chip->taos_chip_status == TSL258X_CHIP_SUSPENDED)
-		ret = taos_chip_on(client);
+		ret = taos_chip_on(indio_dev);
 
 	mutex_unlock(&chip->als_mutex);
 	return ret;
@@ -918,11 +907,8 @@ static int taos_resume(struct i2c_client *client)
 
 static int __devexit taos_remove(struct i2c_client *client)
 {
-	struct tsl2583_chip *chip = i2c_get_clientdata(client);
-
-	iio_device_unregister(chip->iio_dev);
+	iio_device_unregister(i2c_get_clientdata(client));
 
-	kfree(chip);
 	return 0;
 }
 
-- 
1.7.3.4
