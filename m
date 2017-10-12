Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48506 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753350AbdJLNSS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2017 09:18:18 -0400
From: Maciej Purski <m.purski@samsung.com>
To: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 1/4] iio: adc: ina2xx: Make max expected current
 configurable
Date: Thu, 12 Oct 2017 15:17:59 +0200
Message-id: <1507814282-1486-2-git-send-email-m.purski@samsung.com>
In-reply-to: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
References: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
        <CGME20171012131814eucas1p172faad38314e077e3395befaceef77af@eucas1p1.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Max expected current is used for calculating calibration register value,
Current LSB and Power LSB according to equations found in ina datasheet:
current_lsb = max_expected_current / 2^15
calibration_register = 0.00512 / (current_lsb * r_shunt)
power_lsb = 25 * current_lsb (for ina231, 230, 226)
power_lsb = 20 * current_lsb (for older ones)

Max expected current is now implicitly set to default value,
which is 2^15, thanks to which Current LSB is equal to 1 mA and
Power LSB is equal to 20000 uW or 25000 uW depending on ina model, but
users have no impact on the precision of the device.

Make max expected current configurable from device tree or platform_data.
Allow changing current_lsb from sysfs. It is exposed in sysfs as
scale attribute for IIO current channel. Update calibration register and
power_lsb value on each scale change.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/iio/adc/ina2xx-adc.c         | 96 ++++++++++++++++++++++++++----------
 include/linux/platform_data/ina2xx.h |  2 +
 2 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a16f8c6..be26dfc 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -56,6 +56,7 @@
 #define INA226_DEFAULT_IT		1110
 
 #define INA2XX_RSHUNT_DEFAULT           10000
+#define INA2XX_MAX_EXPECTED_MA_DEFAULT	BIT(15)	/* current_lsb = 1 mA */
 
 /*
  * bit masks for reading the settings in the configuration register
@@ -114,7 +115,7 @@ struct ina2xx_config {
 	int shunt_div;
 	int bus_voltage_shift;
 	int bus_voltage_lsb;	/* uV */
-	int power_lsb;		/* uW */
+	int power_lsb_factor;
 	enum ina2xx_ids chip_id;
 };
 
@@ -123,7 +124,9 @@ struct ina2xx_chip_info {
 	struct task_struct *task;
 	const struct ina2xx_config *config;
 	struct mutex state_lock;
-	unsigned int shunt_resistor;
+	unsigned int shunt_resistor;		/* uOhms */
+	int current_lsb;			/* uA */
+	int power_lsb;				/* uW */
 	int avg;
 	int int_time_vbus; /* Bus voltage integration time uS */
 	int int_time_vshunt; /* Shunt voltage integration time uS */
@@ -137,7 +140,7 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.shunt_div = 100,
 		.bus_voltage_shift = 3,
 		.bus_voltage_lsb = 4000,
-		.power_lsb = 20000,
+		.power_lsb_factor = 20,
 		.chip_id = ina219,
 	},
 	[ina226] = {
@@ -146,7 +149,7 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.shunt_div = 400,
 		.bus_voltage_shift = 0,
 		.bus_voltage_lsb = 1250,
-		.power_lsb = 25000,
+		.power_lsb_factor = 25,
 		.chip_id = ina226,
 	},
 };
@@ -210,14 +213,15 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 
 		case INA2XX_POWER:
 			/* processed (mW) = raw*lsb (uW) / 1000 */
-			*val = chip->config->power_lsb;
+			*val = chip->power_lsb;
 			*val2 = 1000;
 			return IIO_VAL_FRACTIONAL;
 
 		case INA2XX_CURRENT:
-			/* processed (mA) = raw (mA) */
-			*val = 1;
-			return IIO_VAL_INT;
+			/* processed (mA) = raw*lsb (uA) / 1000 */
+			*val = chip->current_lsb;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
 		}
 	}
 
@@ -353,6 +357,36 @@ static int ina219_set_int_time_vshunt(struct ina2xx_chip_info *chip,
 	return 0;
 }
 
+/*
+ * Calculate calibration value according to equation 1 in ina226 datasheet
+ * http://www.ti.com/lit/ds/symlink/ina226.pdf.
+ * Current LSB is in uA and RShunt is in uOhms, so RShunt should be
+ * converted to mOhms in order to keep the scale.
+ * There is no need to expose the CALIBRATION register
+ * to the user for now. But we need to reset this register
+ * if the user updates RShunt or max expected current after driver
+ * init, e.g upon reading an EEPROM/Probe-type value.
+ */
+static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
+{
+	unsigned int rshunt = DIV_ROUND_CLOSEST(chip->shunt_resistor, 1000);
+	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
+				     chip->current_lsb * rshunt);
+
+	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
+}
+
+static int ina2xx_set_scale(struct ina2xx_chip_info *chip, unsigned int val)
+{
+	if (val <= 0 || val > chip->config->calibration_factor)
+		return -EINVAL;
+
+	chip->current_lsb = val;
+	chip->power_lsb = chip->current_lsb * chip->config->power_lsb_factor;
+
+	return 0;
+}
+
 static int ina2xx_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
@@ -394,7 +428,18 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
 							       &tmp);
 		}
 		break;
-
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_CURRENT:
+			val = val * 1000 + DIV_ROUND_CLOSEST(val2, 1000);
+			ret = ina2xx_set_scale(chip, val);
+			if (!ret)
+				ret = ina2xx_set_calibration(chip);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -433,22 +478,6 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
 	return len;
 }
 
-/*
- * Set current LSB to 1mA, shunt is in uOhms
- * (equation 13 in datasheet). We hardcode a Current_LSB
- * of 1.0 x10-6. The only remaining parameter is RShunt.
- * There is no need to expose the CALIBRATION register
- * to the user for now. But we need to reset this register
- * if the user updates RShunt after driver init, e.g upon
- * reading an EEPROM/Probe-type value.
- */
-static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
-{
-	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
-				   chip->shunt_resistor);
-
-	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
-}
 
 static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
 {
@@ -849,6 +878,23 @@ static int ina2xx_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	if (of_property_read_u32(client->dev.of_node,
+				"ti-max-expected-current-milliamp", &val) < 0) {
+		struct ina2xx_platform_data *pdata =
+		    dev_get_platdata(&client->dev);
+
+		if (pdata && pdata->max_mA != 0)
+			val = pdata->max_mA;
+		else
+			val = INA2XX_MAX_EXPECTED_MA_DEFAULT;
+	}
+
+	/* Calculate current_lsb: max-expected-current / 2^15 */
+	val = DIV_ROUND_CLOSEST(val * 1000, (1 << 15));
+	ret = ina2xx_set_scale(chip, val);
+	if (ret)
+		return ret;
+
 	/* Patch the current config register with default. */
 	val = chip->config->config_default;
 
diff --git a/include/linux/platform_data/ina2xx.h b/include/linux/platform_data/ina2xx.h
index 9abc0ca..f02b1d8 100644
--- a/include/linux/platform_data/ina2xx.h
+++ b/include/linux/platform_data/ina2xx.h
@@ -13,7 +13,9 @@
 /**
  * struct ina2xx_platform_data - ina2xx info
  * @shunt_uohms		shunt resistance in microohms
+ * @max_mA		max expected current in mA
  */
 struct ina2xx_platform_data {
 	long shunt_uohms;
+	int max_mA;
 };
-- 
2.7.4

