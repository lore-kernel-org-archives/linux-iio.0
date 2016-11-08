Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:46836 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932574AbcKHKQ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:16:59 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 01/23] staging: iio: tsl2583: split out functionality of taos_chip_on()
Date: Tue,  8 Nov 2016 05:16:26 -0500
Message-Id: <1478600208-21153-2-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

taos_chip_on() reads an eight member array called taos_config
that contains the desired state of the chip's registers. Only four
of the registers actually need to be written to. The four that do
not need to be written to are for the {low,high} byte of the lower
interrupt threshold and the {low,high} byte of the upper interrupt
threshold. Interrupts are currently not supported by this driver
so there is no need to write to these registers.

This patch removes the taos_config array and separates out the
i2c calls that write to the CONTROL, TIMING, INTERRUPT and ANALOG
registers. This is part of a larger refactor that was split up to
make the code review easier.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 122 +++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 7eab17f..f17f919 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -31,9 +31,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-/* Triton register offsets */
-#define	TSL258X_REG_MAX		8
-
 /* Device Registers and Masks */
 #define TSL258X_CNTRL			0x00
 #define TSL258X_ALS_TIME		0X01
@@ -55,6 +52,7 @@
 
 /* tsl2583 cntrl reg masks */
 #define TSL258X_CNTL_ADC_ENBL	0x02
+#define TSL258X_CNTL_PWR_OFF		0x00
 #define TSL258X_CNTL_PWR_ON		0x01
 
 /* tsl2583 status reg masks */
@@ -64,6 +62,8 @@
 /* Lux calculation constants */
 #define	TSL258X_LUX_CALC_OVER_FLOW		65535
 
+#define TSL2583_INTERRUPT_DISABLED	0x00
+
 #define TSL2583_CHIP_ID			0x90
 #define TSL2583_CHIP_ID_MASK		0xf0
 
@@ -95,18 +95,8 @@ struct tsl2583_chip {
 	int als_time_scale;
 	int als_saturation;
 	int taos_chip_status;
-	u8 taos_config[8];
 };
 
-/*
- * Initial values for device - this values can/will be changed by driver.
- * and applications as needed.
- * These values are dynamic.
- */
-static const u8 taos_config[8] = {
-		0x00, 0xee, 0x00, 0x03, 0x00, 0xFF, 0xFF, 0x00
-}; /*	cntrl atime intC  Athl0 Athl1 Athh0 Athh1 gain */
-
 struct taos_lux {
 	unsigned int ratio;
 	unsigned int ch0;
@@ -362,16 +352,26 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 	return (int)gain_trim_val;
 }
 
+static int tsl2583_set_power_state(struct tsl2583_chip *chip, u8 state)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_CNTRL, state);
+	if (ret < 0)
+		dev_err(&chip->client->dev, "%s failed to set the power state to %d\n",
+			__func__, state);
+
+	return ret;
+}
+
 /*
  * Turn the device on.
  * Configuration must be set before calling this function.
  */
-static int taos_chip_on(struct iio_dev *indio_dev)
+static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 {
-	int i;
-	int ret;
-	u8 *uP;
-	u8 utmp;
+	int ret, val;
 	int als_count;
 	int als_time;
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
@@ -383,6 +383,20 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
+	/* Power on the device; ADC off. */
+	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_ON);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_INTERRUPT,
+					TSL2583_INTERRUPT_DISABLED);
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "%s failed to disable interrupts\n",
+			__func__);
+		return ret;
+	}
+
 	/* determine als integration register */
 	als_count = (chip->taos_settings.als_time * 100 + 135) / 270;
 	if (!als_count)
@@ -390,62 +404,43 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 
 	/* convert back to time (encompasses overrides) */
 	als_time = (als_count * 27 + 5) / 10;
-	chip->taos_config[TSL258X_ALS_TIME] = 256 - als_count;
+
+	val = 256 - als_count;
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_ALS_TIME,
+					val);
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "%s failed to set the als time to %d\n",
+			__func__, val);
+		return ret;
+	}
 
 	/* Set the gain based on taos_settings struct */
-	chip->taos_config[TSL258X_GAIN] = chip->taos_settings.als_gain;
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_GAIN,
+					chip->taos_settings.als_gain);
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "%s failed to set the gain to %d\n",
+			__func__, chip->taos_settings.als_gain);
+		return ret;
+	}
 
 	/* set chip struct re scaling and saturation */
 	chip->als_saturation = als_count * 922; /* 90% of full scale */
 	chip->als_time_scale = (als_time + 25) / 50;
 
-	/* Power on the device; ADC off. */
-	chip->taos_config[TSL258X_CNTRL] = TSL258X_CNTL_PWR_ON;
-
-	/*
-	 * Use the following shadow copy for our delay before enabling ADC.
-	 * Write all the registers.
-	 */
-	for (i = 0, uP = chip->taos_config; i < TSL258X_REG_MAX; i++) {
-		ret = i2c_smbus_write_byte_data(chip->client,
-						TSL258X_CMD_REG + i,
-						*uP++);
-		if (ret < 0) {
-			dev_err(&chip->client->dev,
-				"taos_chip_on failed on reg %d.\n", i);
-			return ret;
-		}
-	}
-
 	usleep_range(3000, 3500);
-	/*
-	 * NOW enable the ADC
-	 * initialize the desired mode of operation
-	 */
-	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
-	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_CNTRL,
-					utmp);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "taos_chip_on failed on 2nd CTRL reg.\n");
+
+	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_ON |
+					    TSL258X_CNTL_ADC_ENBL);
+	if (ret < 0)
 		return ret;
-	}
+
 	chip->taos_chip_status = TSL258X_CHIP_WORKING;
 
 	return ret;
 }
 
-static int taos_chip_off(struct iio_dev *indio_dev)
-{
-	struct tsl2583_chip *chip = iio_priv(indio_dev);
-
-	/* turn device off */
-	chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
-	return i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_CNTRL,
-					0x00);
-}
-
 /* Sysfs Interface Functions */
 
 static ssize_t in_illuminance_input_target_show(struct device *dev,
@@ -768,7 +763,6 @@ static int taos_probe(struct i2c_client *clientp,
 
 	mutex_init(&chip->als_mutex);
 	chip->taos_chip_status = TSL258X_CHIP_UNKNOWN;
-	memcpy(chip->taos_config, taos_config, sizeof(chip->taos_config));
 
 	ret = i2c_smbus_read_byte_data(clientp,
 				       TSL258X_CMD_REG | TSL258X_CHIPID);
@@ -808,7 +802,7 @@ static int taos_probe(struct i2c_client *clientp,
 	taos_defaults(chip);
 
 	/* Make sure the chip is on */
-	ret = taos_chip_on(indio_dev);
+	ret = tsl2583_chip_init_and_power_on(indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -826,7 +820,7 @@ static int taos_suspend(struct device *dev)
 	mutex_lock(&chip->als_mutex);
 
 	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
-		ret = taos_chip_off(indio_dev);
+		ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
 		chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
 	}
 
@@ -843,7 +837,7 @@ static int taos_resume(struct device *dev)
 	mutex_lock(&chip->als_mutex);
 
 	if (chip->taos_chip_status == TSL258X_CHIP_SUSPENDED)
-		ret = taos_chip_on(indio_dev);
+		ret = tsl2583_chip_init_and_power_on(indio_dev);
 
 	mutex_unlock(&chip->als_mutex);
 	return ret;
-- 
2.7.4

