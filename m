Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47002 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933276AbcKHKRE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:17:04 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 10/23] staging: iio: tsl2583: unify function and variable prefix to tsl2583_
Date: Tue,  8 Nov 2016 05:16:35 -0500
Message-Id: <1478600208-21153-11-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some functions and variables were prefixed with either taos, tsl258x or
tsl2583. Change everything to use the tsl2583 prefix since that is the
name of the .c file. The taos_settings member inside the taos_settings
struct was renamed to als_settings.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 208 ++++++++++++++++++------------------
 1 file changed, 104 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index c797ab0..d4cd143 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -28,35 +28,35 @@
 #include <linux/iio/sysfs.h>
 
 /* Device Registers and Masks */
-#define TSL258X_CNTRL			0x00
-#define TSL258X_ALS_TIME		0X01
-#define TSL258X_INTERRUPT		0x02
-#define TSL258X_GAIN			0x07
-#define TSL258X_REVID			0x11
-#define TSL258X_CHIPID			0x12
-#define TSL258X_ALS_CHAN0LO		0x14
-#define TSL258X_ALS_CHAN0HI		0x15
-#define TSL258X_ALS_CHAN1LO		0x16
-#define TSL258X_ALS_CHAN1HI		0x17
-#define TSL258X_TMR_LO			0x18
-#define TSL258X_TMR_HI			0x19
+#define TSL2583_CNTRL			0x00
+#define TSL2583_ALS_TIME		0X01
+#define TSL2583_INTERRUPT		0x02
+#define TSL2583_GAIN			0x07
+#define TSL2583_REVID			0x11
+#define TSL2583_CHIPID			0x12
+#define TSL2583_ALS_CHAN0LO		0x14
+#define TSL2583_ALS_CHAN0HI		0x15
+#define TSL2583_ALS_CHAN1LO		0x16
+#define TSL2583_ALS_CHAN1HI		0x17
+#define TSL2583_TMR_LO			0x18
+#define TSL2583_TMR_HI			0x19
 
 /* tsl2583 cmd reg masks */
-#define TSL258X_CMD_REG			0x80
-#define TSL258X_CMD_SPL_FN		0x60
-#define TSL258X_CMD_ALS_INT_CLR	0X01
+#define TSL2583_CMD_REG			0x80
+#define TSL2583_CMD_SPL_FN		0x60
+#define TSL2583_CMD_ALS_INT_CLR	0X01
 
 /* tsl2583 cntrl reg masks */
-#define TSL258X_CNTL_ADC_ENBL	0x02
-#define TSL258X_CNTL_PWR_OFF		0x00
-#define TSL258X_CNTL_PWR_ON		0x01
+#define TSL2583_CNTL_ADC_ENBL	0x02
+#define TSL2583_CNTL_PWR_OFF		0x00
+#define TSL2583_CNTL_PWR_ON		0x01
 
 /* tsl2583 status reg masks */
-#define TSL258X_STA_ADC_VALID	0x01
-#define TSL258X_STA_ADC_INTR	0x10
+#define TSL2583_STA_ADC_VALID	0x01
+#define TSL2583_STA_ADC_INTR	0x10
 
 /* Lux calculation constants */
-#define	TSL258X_LUX_CALC_OVER_FLOW		65535
+#define	TSL2583_LUX_CALC_OVER_FLOW		65535
 
 #define TSL2583_INTERRUPT_DISABLED	0x00
 
@@ -64,13 +64,13 @@
 #define TSL2583_CHIP_ID_MASK		0xf0
 
 /* Per-device data */
-struct taos_als_info {
+struct tsl2583_als_info {
 	u16 als_ch0;
 	u16 als_ch1;
 	u16 lux;
 };
 
-struct taos_settings {
+struct tsl2583_settings {
 	int als_time;
 	int als_gain;
 	int als_gain_trim;
@@ -80,14 +80,14 @@ struct taos_settings {
 struct tsl2583_chip {
 	struct mutex als_mutex;
 	struct i2c_client *client;
-	struct taos_als_info als_cur_info;
-	struct taos_settings taos_settings;
+	struct tsl2583_als_info als_cur_info;
+	struct tsl2583_settings als_settings;
 	int als_time_scale;
 	int als_saturation;
 	bool suspended;
 };
 
-struct taos_lux {
+struct tsl2583_lux {
 	unsigned int ratio;
 	unsigned int ch0;
 	unsigned int ch1;
@@ -96,7 +96,7 @@ struct taos_lux {
 /* This structure is intentionally large to accommodate updates via sysfs. */
 /* Sized to 11 = max 10 segments + 1 termination segment */
 /* Assumption is one and only one type of glass used  */
-static struct taos_lux taos_device_lux[11] = {
+static struct tsl2583_lux tsl2583_device_lux[11] = {
 	{  9830,  8520, 15729 },
 	{ 12452, 10807, 23344 },
 	{ 14746,  6383, 11705 },
@@ -121,25 +121,25 @@ static const struct gainadj gainadj[] = {
  * Provides initial operational parameter defaults.
  * These defaults may be changed through the device's sysfs files.
  */
-static void taos_defaults(struct tsl2583_chip *chip)
+static void tsl2583_defaults(struct tsl2583_chip *chip)
 {
 	/*
 	 * The integration time must be a multiple of 50ms and within the
 	 * range [50, 600] ms.
 	 */
-	chip->taos_settings.als_time = 100;
+	chip->als_settings.als_time = 100;
 
 	/*
 	 * This is an index into the gainadj table. Assume clear glass as the
 	 * default.
 	 */
-	chip->taos_settings.als_gain = 0;
+	chip->als_settings.als_gain = 0;
 
 	/* Default gain trim to account for aperture effects */
-	chip->taos_settings.als_gain_trim = 1000;
+	chip->als_settings.als_gain_trim = 1000;
 
 	/* Known external ALS reading used for calibration */
-	chip->taos_settings.als_cal_target = 130;
+	chip->als_settings.als_cal_target = 130;
 }
 
 /*
@@ -149,26 +149,26 @@ static void taos_defaults(struct tsl2583_chip *chip)
  * Time scale factor array values are adjusted based on the integration time.
  * The raw values are multiplied by a scale factor, and device gain is obtained
  * using gain index. Limit checks are done next, then the ratio of a multiple
- * of ch1 value, to the ch0 value, is calculated. The array taos_device_lux[]
+ * of ch1 value, to the ch0 value, is calculated. The array tsl2583_device_lux[]
  * declared above is then scanned to find the first ratio value that is just
  * above the ratio we just calculated. The ch0 and ch1 multiplier constants in
  * the array are then used along with the time scale factor array values, to
  * calculate the lux.
  */
-static int taos_get_lux(struct iio_dev *indio_dev)
+static int tsl2583_get_lux(struct iio_dev *indio_dev)
 {
 	u16 ch0, ch1; /* separated ch0/ch1 data from device */
 	u32 lux; /* raw lux calculated from device data */
 	u64 lux64;
 	u32 ratio;
 	u8 buf[5];
-	struct taos_lux *p;
+	struct tsl2583_lux *p;
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int i, ret;
 	u32 ch0lux = 0;
 	u32 ch1lux = 0;
 
-	ret = i2c_smbus_read_byte_data(chip->client, TSL258X_CMD_REG);
+	ret = i2c_smbus_read_byte_data(chip->client, TSL2583_CMD_REG);
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "%s failed to read CMD_REG register\n",
 			__func__);
@@ -176,7 +176,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 	}
 
 	/* is data new & valid */
-	if (!(ret & TSL258X_STA_ADC_INTR)) {
+	if (!(ret & TSL2583_STA_ADC_INTR)) {
 		dev_err(&chip->client->dev, "%s: data not valid; returning last value\n",
 			__func__);
 		ret = chip->als_cur_info.lux; /* return LAST VALUE */
@@ -184,7 +184,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 	}
 
 	for (i = 0; i < 4; i++) {
-		int reg = TSL258X_CMD_REG | (TSL258X_ALS_CHAN0LO + i);
+		int reg = TSL2583_CMD_REG | (TSL2583_ALS_CHAN0LO + i);
 
 		ret = i2c_smbus_read_byte_data(chip->client, reg);
 		if (ret < 0) {
@@ -200,8 +200,8 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 	 * we use the bit anyway - don't forget 0x80 - this is a command
 	 */
 	ret = i2c_smbus_write_byte(chip->client,
-				   (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
-				    TSL258X_CMD_ALS_INT_CLR));
+				   (TSL2583_CMD_REG | TSL2583_CMD_SPL_FN |
+				    TSL2583_CMD_ALS_INT_CLR));
 
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "%s failed to clear the interrupt bit\n",
@@ -228,7 +228,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 	/* calculate ratio */
 	ratio = (ch1 << 15) / ch0;
 	/* convert to unscaled lux using the pointer to the table */
-	for (p = (struct taos_lux *)taos_device_lux;
+	for (p = (struct tsl2583_lux *)tsl2583_device_lux;
 	     p->ratio != 0 && p->ratio < ratio; p++)
 		;
 
@@ -236,11 +236,11 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 		lux = 0;
 	} else {
 		ch0lux = ((ch0 * p->ch0) +
-			  (gainadj[chip->taos_settings.als_gain].ch0 >> 1))
-			 / gainadj[chip->taos_settings.als_gain].ch0;
+			  (gainadj[chip->als_settings.als_gain].ch0 >> 1))
+			 / gainadj[chip->als_settings.als_gain].ch0;
 		ch1lux = ((ch1 * p->ch1) +
-			  (gainadj[chip->taos_settings.als_gain].ch1 >> 1))
-			 / gainadj[chip->taos_settings.als_gain].ch1;
+			  (gainadj[chip->als_settings.als_gain].ch1 >> 1))
+			 / gainadj[chip->als_settings.als_gain].ch1;
 		lux = ch0lux - ch1lux;
 	}
 
@@ -261,7 +261,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 			chip->als_time_scale;
 
 	/* Adjust for active gain scale.
-	 * The taos_device_lux tables above have a factor of 8192 built in,
+	 * The tsl2583_device_lux tables above have a factor of 8192 built in,
 	 * so we need to shift right.
 	 * User-specified gain provides a multiplier.
 	 * Apply user-specified gain before shifting right to retain precision.
@@ -269,13 +269,13 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 	 * Then go back to 32 bits before division to avoid using div_u64().
 	 */
 	lux64 = lux;
-	lux64 = lux64 * chip->taos_settings.als_gain_trim;
+	lux64 = lux64 * chip->als_settings.als_gain_trim;
 	lux64 >>= 13;
 	lux = lux64;
 	lux = (lux + 500) / 1000;
-	if (lux > TSL258X_LUX_CALC_OVER_FLOW) { /* check for overflow */
+	if (lux > TSL2583_LUX_CALC_OVER_FLOW) { /* check for overflow */
 return_max:
-		lux = TSL258X_LUX_CALC_OVER_FLOW;
+		lux = TSL2583_LUX_CALC_OVER_FLOW;
 	}
 
 	/* Update the structure with the latest VALID lux. */
@@ -291,7 +291,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
  * to derive actual lux).
  * Return updated gain_trim value.
  */
-static int taos_als_calibrate(struct iio_dev *indio_dev)
+static int tsl2583_als_calibrate(struct iio_dev *indio_dev)
 {
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned int gain_trim_val;
@@ -299,7 +299,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 	int lux_val;
 
 	ret = i2c_smbus_read_byte_data(chip->client,
-				       TSL258X_CMD_REG | TSL258X_CNTRL);
+				       TSL2583_CMD_REG | TSL2583_CNTRL);
 	if (ret < 0) {
 		dev_err(&chip->client->dev,
 			"%s failed to read from the CNTRL register\n",
@@ -307,24 +307,24 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	if ((ret & (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON))
-			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
+	if ((ret & (TSL2583_CNTL_ADC_ENBL | TSL2583_CNTL_PWR_ON))
+			!= (TSL2583_CNTL_ADC_ENBL | TSL2583_CNTL_PWR_ON)) {
 		dev_err(&chip->client->dev,
 			"%s failed: device not powered on with ADC enabled\n",
 			__func__);
 		return -EINVAL;
-	} else if ((ret & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
+	} else if ((ret & TSL2583_STA_ADC_VALID) != TSL2583_STA_ADC_VALID) {
 		dev_err(&chip->client->dev,
 			"%s failed: STATUS - ADC not valid.\n", __func__);
 		return -ENODATA;
 	}
-	lux_val = taos_get_lux(indio_dev);
+	lux_val = tsl2583_get_lux(indio_dev);
 	if (lux_val < 0) {
 		dev_err(&chip->client->dev, "%s failed to get lux\n", __func__);
 		return lux_val;
 	}
-	gain_trim_val = (unsigned int)(((chip->taos_settings.als_cal_target)
-			* chip->taos_settings.als_gain_trim) / lux_val);
+	gain_trim_val = (unsigned int)(((chip->als_settings.als_cal_target)
+			* chip->als_settings.als_gain_trim) / lux_val);
 
 	if ((gain_trim_val < 250) || (gain_trim_val > 4000)) {
 		dev_err(&chip->client->dev,
@@ -332,7 +332,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 			__func__, gain_trim_val);
 		return -ENODATA;
 	}
-	chip->taos_settings.als_gain_trim = (int)gain_trim_val;
+	chip->als_settings.als_gain_trim = (int)gain_trim_val;
 
 	return (int)gain_trim_val;
 }
@@ -343,7 +343,7 @@ static int tsl2583_set_als_time(struct tsl2583_chip *chip)
 	u8 val;
 
 	/* determine als integration register */
-	als_count = (chip->taos_settings.als_time * 100 + 135) / 270;
+	als_count = (chip->als_settings.als_time * 100 + 135) / 270;
 	if (!als_count)
 		als_count = 1; /* ensure at least one cycle */
 
@@ -352,7 +352,7 @@ static int tsl2583_set_als_time(struct tsl2583_chip *chip)
 
 	val = 256 - als_count;
 	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_ALS_TIME,
+					TSL2583_CMD_REG | TSL2583_ALS_TIME,
 					val);
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "%s failed to set the als time to %d\n",
@@ -371,13 +371,13 @@ static int tsl2583_set_als_gain(struct tsl2583_chip *chip)
 {
 	int ret;
 
-	/* Set the gain based on taos_settings struct */
+	/* Set the gain based on als_settings struct */
 	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_GAIN,
-					chip->taos_settings.als_gain);
+					TSL2583_CMD_REG | TSL2583_GAIN,
+					chip->als_settings.als_gain);
 	if (ret < 0)
 		dev_err(&chip->client->dev, "%s failed to set the gain to %d\n",
-			__func__, chip->taos_settings.als_gain);
+			__func__, chip->als_settings.als_gain);
 
 	return ret;
 }
@@ -387,7 +387,7 @@ static int tsl2583_set_power_state(struct tsl2583_chip *chip, u8 state)
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_CNTRL, state);
+					TSL2583_CMD_REG | TSL2583_CNTRL, state);
 	if (ret < 0)
 		dev_err(&chip->client->dev, "%s failed to set the power state to %d\n",
 			__func__, state);
@@ -405,12 +405,12 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 	int ret;
 
 	/* Power on the device; ADC off. */
-	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_ON);
+	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON);
 	if (ret < 0)
 		return ret;
 
 	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_INTERRUPT,
+					TSL2583_CMD_REG | TSL2583_INTERRUPT,
 					TSL2583_INTERRUPT_DISABLED);
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "%s failed to disable interrupts\n",
@@ -428,8 +428,8 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 
 	usleep_range(3000, 3500);
 
-	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_ON |
-					    TSL258X_CNTL_ADC_ENBL);
+	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON |
+					    TSL2583_CNTL_ADC_ENBL);
 	if (ret < 0)
 		return ret;
 
@@ -449,7 +449,7 @@ static ssize_t in_illuminance_input_target_show(struct device *dev,
 	int ret;
 
 	mutex_lock(&chip->als_mutex);
-	ret = sprintf(buf, "%d\n", chip->taos_settings.als_cal_target);
+	ret = sprintf(buf, "%d\n", chip->als_settings.als_cal_target);
 	mutex_unlock(&chip->als_mutex);
 
 	return ret;
@@ -467,7 +467,7 @@ static ssize_t in_illuminance_input_target_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&chip->als_mutex);
-	chip->taos_settings.als_cal_target = value;
+	chip->als_settings.als_cal_target = value;
 	mutex_unlock(&chip->als_mutex);
 
 	return len;
@@ -491,7 +491,7 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
 		goto done;
 	}
 
-	ret = taos_als_calibrate(indio_dev);
+	ret = tsl2583_als_calibrate(indio_dev);
 	if (ret < 0)
 		goto done;
 
@@ -509,12 +509,12 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 	int i;
 	int offset = 0;
 
-	for (i = 0; i < ARRAY_SIZE(taos_device_lux); i++) {
+	for (i = 0; i < ARRAY_SIZE(tsl2583_device_lux); i++) {
 		offset += sprintf(buf + offset, "%u,%u,%u,",
-				  taos_device_lux[i].ratio,
-				  taos_device_lux[i].ch0,
-				  taos_device_lux[i].ch1);
-		if (taos_device_lux[i].ratio == 0) {
+				  tsl2583_device_lux[i].ratio,
+				  tsl2583_device_lux[i].ch0,
+				  tsl2583_device_lux[i].ch1);
+		if (tsl2583_device_lux[i].ratio == 0) {
 			/*
 			 * We just printed the first "0" entry.
 			 * Now get rid of the extra "," and break.
@@ -528,7 +528,7 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 	return offset;
 }
 
-#define TSL2583_MAX_LUX_INTS ((ARRAY_SIZE(taos_device_lux) - 1) * 3)
+#define TSL2583_MAX_LUX_INTS ((ARRAY_SIZE(tsl2583_device_lux) - 1) * 3)
 
 static ssize_t in_illuminance_lux_table_store(struct device *dev,
 					      struct device_attribute *attr,
@@ -536,7 +536,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int value[ARRAY_SIZE(taos_device_lux) * 3 + 1];
+	int value[ARRAY_SIZE(tsl2583_device_lux) * 3 + 1];
 	int n, ret = -EINVAL;
 
 	mutex_lock(&chip->als_mutex);
@@ -562,8 +562,8 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 	}
 
 	/* Zero out the table */
-	memset(taos_device_lux, 0, sizeof(taos_device_lux));
-	memcpy(taos_device_lux, &value[1], (value[0] * 4));
+	memset(tsl2583_device_lux, 0, sizeof(tsl2583_device_lux));
+	memcpy(tsl2583_device_lux, &value[1], (value[0] * 4));
 
 	ret = len;
 
@@ -632,7 +632,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (chan->type == IIO_LIGHT) {
-			ret = taos_get_lux(indio_dev);
+			ret = tsl2583_get_lux(indio_dev);
 			if (ret < 0)
 				goto read_done;
 
@@ -655,7 +655,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->type == IIO_LIGHT) {
-			ret = taos_get_lux(indio_dev);
+			ret = tsl2583_get_lux(indio_dev);
 			if (ret < 0)
 				goto read_done;
 
@@ -665,20 +665,20 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		if (chan->type == IIO_LIGHT) {
-			*val = chip->taos_settings.als_gain_trim;
+			*val = chip->als_settings.als_gain_trim;
 			ret = IIO_VAL_INT;
 		}
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		if (chan->type == IIO_LIGHT) {
-			*val = gainadj[chip->taos_settings.als_gain].mean;
+			*val = gainadj[chip->als_settings.als_gain].mean;
 			ret = IIO_VAL_INT;
 		}
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
 		if (chan->type == IIO_LIGHT) {
 			*val = 0;
-			*val2 = chip->taos_settings.als_time;
+			*val2 = chip->als_settings.als_time;
 			ret = IIO_VAL_INT_PLUS_MICRO;
 		}
 		break;
@@ -709,7 +709,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		if (chan->type == IIO_LIGHT) {
-			chip->taos_settings.als_gain_trim = val;
+			chip->als_settings.als_gain_trim = val;
 			ret = 0;
 		}
 		break;
@@ -719,7 +719,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 
 			for (i = 0; i < ARRAY_SIZE(gainadj); i++) {
 				if (gainadj[i].mean == val) {
-					chip->taos_settings.als_gain = i;
+					chip->als_settings.als_gain = i;
 					ret = tsl2583_set_als_gain(chip);
 					break;
 				}
@@ -729,7 +729,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		if (chan->type == IIO_LIGHT && !val && val2 >= 50 &&
 		    val2 <= 650 && !(val2 % 50)) {
-			chip->taos_settings.als_time = val2;
+			chip->als_settings.als_time = val2;
 			ret = tsl2583_set_als_time(chip);
 		}
 		break;
@@ -754,8 +754,8 @@ static const struct iio_info tsl2583_info = {
  * Client probe function - When a valid device is found, the driver's device
  * data structure is updated, and initialization completes successfully.
  */
-static int taos_probe(struct i2c_client *clientp,
-		      const struct i2c_device_id *idp)
+static int tsl2583_probe(struct i2c_client *clientp,
+			 const struct i2c_device_id *idp)
 {
 	int ret;
 	struct tsl2583_chip *chip;
@@ -779,7 +779,7 @@ static int taos_probe(struct i2c_client *clientp,
 	chip->suspended = true;
 
 	ret = i2c_smbus_read_byte_data(clientp,
-				       TSL258X_CMD_REG | TSL258X_CHIPID);
+				       TSL2583_CMD_REG | TSL2583_CHIPID);
 	if (ret < 0) {
 		dev_err(&clientp->dev,
 			"%s failed to read the chip ID register\n", __func__);
@@ -806,7 +806,7 @@ static int taos_probe(struct i2c_client *clientp,
 	}
 
 	/* Load up the V2 defaults (these are hard coded defaults for now) */
-	taos_defaults(chip);
+	tsl2583_defaults(chip);
 
 	/* Make sure the chip is on */
 	ret = tsl2583_chip_init_and_power_on(indio_dev);
@@ -818,7 +818,7 @@ static int taos_probe(struct i2c_client *clientp,
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int taos_suspend(struct device *dev)
+static int tsl2583_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
@@ -826,14 +826,14 @@ static int taos_suspend(struct device *dev)
 
 	mutex_lock(&chip->als_mutex);
 
-	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
+	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_OFF);
 	chip->suspended = true;
 
 	mutex_unlock(&chip->als_mutex);
 	return ret;
 }
 
-static int taos_resume(struct device *dev)
+static int tsl2583_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
@@ -847,19 +847,19 @@ static int taos_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
-#define TAOS_PM_OPS (&taos_pm_ops)
+static SIMPLE_DEV_PM_OPS(tsl2583_pm_ops, tsl2583_suspend, tsl2583_resume);
+#define TAOS_PM_OPS (&tsl2583_pm_ops)
 #else
 #define TAOS_PM_OPS NULL
 #endif
 
-static struct i2c_device_id taos_idtable[] = {
+static struct i2c_device_id tsl2583_idtable[] = {
 	{ "tsl2580", 0 },
 	{ "tsl2581", 1 },
 	{ "tsl2583", 2 },
 	{}
 };
-MODULE_DEVICE_TABLE(i2c, taos_idtable);
+MODULE_DEVICE_TABLE(i2c, tsl2583_idtable);
 
 #ifdef CONFIG_OF
 static const struct of_device_id taos2583_of_match[] = {
@@ -874,16 +874,16 @@ MODULE_DEVICE_TABLE(of, taos2583_of_match);
 #endif
 
 /* Driver definition */
-static struct i2c_driver taos_driver = {
+static struct i2c_driver tsl2583_driver = {
 	.driver = {
 		.name = "tsl2583",
 		.pm = TAOS_PM_OPS,
 		.of_match_table = taos2583_of_match,
 	},
-	.id_table = taos_idtable,
-	.probe = taos_probe,
+	.id_table = tsl2583_idtable,
+	.probe = tsl2583_probe,
 };
-module_i2c_driver(taos_driver);
+module_i2c_driver(tsl2583_driver);
 
 MODULE_AUTHOR("J. August Brenner<jbrenner@taosinc.com>");
 MODULE_DESCRIPTION("TAOS tsl2583 ambient light sensor driver");
-- 
2.7.4

