Return-Path: <SRS0=1Vn7=DD=samsung.com=m.purski@kernel.org>
From: Maciej Purski <m.purski@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, Stefan Bruens
	<stefan.bruens@rwth-aachen.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, Jean
	Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Marek
	Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz
	<b.zolnierkie@samsung.com>, Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2] iio: adc: ina2xx: Make calibration register value fixed
Date: Thu, 07 Dec 2017 13:02:47 +0100
Message-id: <1512648167-11482-1-git-send-email-m.purski@samsung.com>
References: <CGME20171207120340eucas1p24b145ba9b41768c1708ad574307c00c0@eucas1p2.samsung.com>
List-ID: <linux-iio@vger.kernel.org>

Calibration register is used for calculating current register in
hardware according to datasheet:
current = shunt_volt * calib_register / 2048 (ina 226)
current = shunt_volt * calib_register / 4096 (ina 219)

Fix calib_register value to 2048 for ina226 and 4096 for ina 219 in
order to avoid truncation error and provide best precision allowed
by shunt_voltage measurement. Make current scale value follow changes
of shunt_resistor from sysfs as calib_register value is now fixed.

Power_lsb value should also follow shunt_resistor changes as stated in
datasheet:
power_lsb = 25 * current_lsb (ina 226)
power_lsb = 20 * current_lsb (ina 219)

This is a part of the patchset: https://lkml.org/lkml/2017/11/22/394

Signed-off-by: Maciej Purski <m.purski@samsung.com>

---
Changes in v2:
- rebase on top of the latest next
- remove a redundant variable - power_lsb_uW
- fix comments
---
 drivers/iio/adc/ina2xx-adc.c | 58 +++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index ddf8781..3e4972f 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -124,11 +124,11 @@ enum ina2xx_ids { ina219, ina226 };
 
 struct ina2xx_config {
 	u16 config_default;
-	int calibration_factor;
+	int calibration_value;
 	int shunt_voltage_lsb;	/* nV */
 	int bus_voltage_shift;	/* position of lsb */
 	int bus_voltage_lsb;	/* uV */
-	int power_lsb;		/* uW */
+	int power_lsb_factor;
 	enum ina2xx_ids chip_id;
 };
 
@@ -138,6 +138,7 @@ struct ina2xx_chip_info {
 	const struct ina2xx_config *config;
 	struct mutex state_lock;
 	unsigned int shunt_resistor_uohm;
+	unsigned int current_lsb_uA;
 	int avg;
 	int int_time_vbus; /* Bus voltage integration time uS */
 	int int_time_vshunt; /* Shunt voltage integration time uS */
@@ -149,20 +150,20 @@ struct ina2xx_chip_info {
 static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
 		.config_default = INA219_CONFIG_DEFAULT,
-		.calibration_factor = 40960000,
+		.calibration_value = 4096,
 		.shunt_voltage_lsb = 10000,
 		.bus_voltage_shift = INA219_BUS_VOLTAGE_SHIFT,
 		.bus_voltage_lsb = 4000,
-		.power_lsb = 20000,
+		.power_lsb_factor = 20,
 		.chip_id = ina219,
 	},
 	[ina226] = {
 		.config_default = INA226_CONFIG_DEFAULT,
-		.calibration_factor = 5120000,
+		.calibration_value = 2048,
 		.shunt_voltage_lsb = 2500,
 		.bus_voltage_shift = 0,
 		.bus_voltage_lsb = 1250,
-		.power_lsb = 25000,
+		.power_lsb_factor = 25,
 		.chip_id = ina226,
 	},
 };
@@ -229,14 +230,16 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 
 		case INA2XX_POWER:
 			/* processed (mW) = raw*lsb (uW) / 1000 */
-			*val = chip->config->power_lsb;
+			*val = chip->config->power_lsb_factor *
+			       chip->current_lsb_uA;
 			*val2 = 1000;
 			return IIO_VAL_FRACTIONAL;
 
 		case INA2XX_CURRENT:
-			/* processed (mA) = raw (mA) */
-			*val = 1;
-			return IIO_VAL_INT;
+			/* processed (mA) = raw*lsb (uA) / 1000 */
+			*val = chip->current_lsb_uA;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
 		}
 
 	case IIO_CHAN_INFO_HARDWAREGAIN:
@@ -541,28 +544,34 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
 }
 
 /*
- * Set current LSB to 1mA, shunt is in uOhms
- * (equation 13 in datasheet). We hardcode a Current_LSB
- * of 1.0 x10-3. The only remaining parameter is RShunt.
- * There is no need to expose the CALIBRATION register
- * to the user for now. But we need to reset this register
- * if the user updates RShunt after driver init, e.g upon
- * reading an EEPROM/Probe-type value.
+ * Calibration register is set to the best value, which eliminates
+ * truncation errors on calculating current register in hardware.
+ * According to datasheet (INA 226: eq. 3, INA219: eq. 4) the best values
+ * are 2048 for ina226 and 4096 for ina219. They are hardcoded as
+ * calibration_value.
  */
 static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
 {
-	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
-				   chip->shunt_resistor_uohm);
-
-	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
+	return regmap_write(chip->regmap, INA2XX_CALIBRATION,
+			    chip->config->calibration_value);
 }
 
+/*
+ * In order to keep calibration register value fixed, the product
+ * of current_lsb and shunt_resistor should also be fixed and equal
+ * to shunt_voltage_lsb = 1 / shunt_div multiplied by 10^9 in order
+ * to keep the scale.
+ */
 static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
 {
-	if (val <= 0 || val > chip->config->calibration_factor)
+	unsigned int dividend = DIV_ROUND_CLOSEST(1000000000,
+						  chip->config->shunt_div);
+
+	if (val <= 0 || val > dividend)
 		return -EINVAL;
 
 	chip->shunt_resistor_uohm = val;
+	chip->current_lsb_uA = DIV_ROUND_CLOSEST(dividend, val);
 
 	return 0;
 }
@@ -592,11 +601,6 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	/* Update the Calibration register */
-	ret = ina2xx_set_calibration(chip);
-	if (ret)
-		return ret;
-
 	return len;
 }
 
-- 
2.7.4
