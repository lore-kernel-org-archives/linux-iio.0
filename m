Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33223 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbcCNKUs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Mar 2016 06:20:48 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so95124108wml.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2016 03:20:47 -0700 (PDT)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: afd@ti.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH-vs-togreg v2 1/2] iio: ina2xx-adc: update the CALIB. register when RShunt changes
Date: Mon, 14 Mar 2016 11:20:44 +0100
Message-Id: <1457950844-7261-1-git-send-email-marc.titinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The user (or an init script) may setup RShunt via sysfs after the
driver was initialized, for instance based on the EEPROM contents
of a modular probe. The calibration register must be set accordingly.

Signed-off-by: Marc Titinger <marc.titinger@baylibre.com>
---
 v2 of http://www.spinics.net/lists/linux-iio/msg23402.html:

	- remove unnecessary line insertions
	- cleanup leftover unused variable (build warning)
	- patch 2/2 is unchanged (see v1)
---
 drivers/iio/adc/ina2xx-adc.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 65909d5..4e56fe3 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -350,6 +350,23 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
 	return len;
 }
 
+/*
+ * Set current LSB to 1mA, shunt is in uOhms
+ * (equation 13 in datasheet). We hardcode a Current_LSB
+ * of 1.0 x10-6. The only remaining parameter is RShunt.
+ * There is no need to expose the CALIBRATION register
+ * to the user for now. But we need to reset this register
+ * if the user updates RShunt after driver init, e.g upon
+ * reading an EEPROM/Probe-type value.
+ */
+static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
+{
+	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
+				   chip->shunt_resistor);
+
+	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
+}
+
 static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
 {
 	if (val <= 0 || val > chip->config->calibration_factor)
@@ -385,6 +402,11 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	/* Update the Calibration register */
+	ret = ina2xx_set_calibration(chip);
+	if (ret)
+		return ret;
+
 	return len;
 }
 
@@ -602,24 +624,11 @@ static const struct iio_info ina2xx_info = {
 /* Initialize the configuration and calibration registers. */
 static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
 {
-	u16 regval;
-	int ret;
-
-	ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
+	int ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
 	if (ret)
 		return ret;
 
-	/*
-	 * Set current LSB to 1mA, shunt is in uOhms
-	 * (equation 13 in datasheet). We hardcode a Current_LSB
-	 * of 1.0 x10-6. The only remaining parameter is RShunt.
-	 * There is no need to expose the CALIBRATION register
-	 * to the user for now.
-	 */
-	regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
-				   chip->shunt_resistor);
-
-	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
+	return ina2xx_set_calibration(chip);
 }
 
 static int ina2xx_probe(struct i2c_client *client,
-- 
2.5.0

