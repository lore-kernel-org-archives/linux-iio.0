Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34868 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeENKbe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 May 2018 06:31:34 -0400
Message-ID: <1526293892.12966.21.camel@gmail.com>
Subject: [PATCH] iio: dac: Add regulator framework to LTC2632 device driver
From: Silvan Murer <silvan.murer@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 14 May 2018 12:31:32 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for external reference voltage through the regulator framework.
The patch add also the remove function to the device driver.

Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
---
 .../devicetree/bindings/iio/dac/ltc2632.txt        |  9 +++
 drivers/iio/dac/ltc2632.c                          | 86 +++++++++++++++++-----
 2 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
index eb911e5..d369a4b 100644
--- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
@@ -14,10 +14,19 @@ apply. In particular, "reg" and "spi-max-frequency" properties must be given.
 
 Example:
 
+	vref: regulator-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-ltc2632";
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1250000>;
+		regulator-always-on;
+	};
+
 	spi_master {
 		dac: ltc2632@0 {
 			compatible = "lltc,ltc2632-l12";
 			reg = <0>; /* CS0 */
 			spi-max-frequency = <1000000>;
+			vref-supply = <&vref>; /* optional */
 		};
 	};
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index ac5e05f..4a5c5bd 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -2,6 +2,7 @@
  * LTC2632 Digital to analog convertors spi driver
  *
  * Copyright 2017 Maxime Roussin-Bélanger
+ * expanded by Silvan Murer <silvan.murer@gmail.com>
  *
  * Licensed under the GPL-2.
  */
@@ -10,6 +11,7 @@
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 #include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
 
 #define LTC2632_DAC_CHANNELS                    2
 
@@ -28,7 +30,7 @@
 /**
  * struct ltc2632_chip_info - chip specific information
  * @channels:		channel spec for the DAC
- * @vref_mv:		reference voltage
+ * @vref_mv:		internal reference voltage
  */
 struct ltc2632_chip_info {
 	const struct iio_chan_spec *channels;
@@ -39,10 +41,14 @@ struct ltc2632_chip_info {
  * struct ltc2632_state - driver instance specific data
  * @spi_dev:			pointer to the spi_device struct
  * @powerdown_cache_mask	used to show current channel powerdown state
+ * @vref_mv			used reference voltage (internal or external)
+ * @vref_reg		regulator for the reference voltage
  */
 struct ltc2632_state {
 	struct spi_device *spi_dev;
 	unsigned int powerdown_cache_mask;
+	int vref_mv;
+	struct regulator *vref_reg;
 };
 
 enum ltc2632_supported_device_ids {
@@ -90,7 +96,7 @@ static int ltc2632_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-		*val = chip_info->vref_mv;
+		*val = st->vref_mv;
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -247,6 +253,41 @@ static int ltc2632_probe(struct spi_device *spi)
 	chip_info = (struct ltc2632_chip_info *)
 			spi_get_device_id(spi)->driver_data;
 
+	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(st->vref_reg)) {
+		/* use internal reference voltage */
+		st->vref_reg = NULL;
+		st->vref_mv = chip_info->vref_mv;
+
+		ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER,
+				0, 0, 0);
+		if (ret) {
+			dev_err(&spi->dev,
+				"Set internal reference command failed, %d\n",
+				ret);
+			return ret;
+		}
+	} else {
+		/* use external reference voltage */
+		ret = regulator_enable(st->vref_reg);
+		if (ret) {
+			dev_err(&spi->dev,
+				"enable reference regulator failed, %d\n",
+				ret);
+			return ret;
+		}
+		st->vref_mv = regulator_get_voltage(st->vref_reg)/1000;
+
+		ret = ltc2632_spi_write(spi, LTC2632_CMD_EXTERNAL_REFER,
+				0, 0, 0);
+		if (ret) {
+			dev_err(&spi->dev,
+				"Set external reference command failed, %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = dev_of_node(&spi->dev) ? dev_of_node(&spi->dev)->name
 						 : spi_get_device_id(spi)->name;
@@ -255,14 +296,23 @@ static int ltc2632_probe(struct spi_device *spi)
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = LTC2632_DAC_CHANNELS;
 
-	ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER, 0, 0, 0);
-	if (ret) {
-		dev_err(&spi->dev,
-			"Set internal reference command failed, %d\n", ret);
-		return ret;
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static int ltc2632_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ltc2632_state *st = iio_priv(indio_dev);
+
+	devm_iio_device_unregister(&spi->dev, indio_dev);
+
+	if (st->vref_reg != NULL) {
+		regulator_disable(st->vref_reg);
+		devm_regulator_put(st->vref_reg);
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	devm_iio_device_free(&spi->dev, indio_dev);
+	return 0;
 }
 
 static const struct spi_device_id ltc2632_id[] = {
@@ -276,15 +326,6 @@ static const struct spi_device_id ltc2632_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ltc2632_id);
 
-static struct spi_driver ltc2632_driver = {
-	.driver		= {
-		.name	= "ltc2632",
-	},
-	.probe		= ltc2632_probe,
-	.id_table	= ltc2632_id,
-};
-module_spi_driver(ltc2632_driver);
-
 static const struct of_device_id ltc2632_of_match[] = {
 	{
 		.compatible = "lltc,ltc2632-l12",
@@ -309,6 +350,17 @@ static const struct of_device_id ltc2632_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ltc2632_of_match);
 
+static struct spi_driver ltc2632_driver = {
+	.driver		= {
+		.name	= "ltc2632",
+		.of_match_table = of_match_ptr(ltc2632_of_match),
+	},
+	.probe		= ltc2632_probe,
+	.remove     = ltc2632_remove,
+	.id_table	= ltc2632_id,
+};
+module_spi_driver(ltc2632_driver);
+
 MODULE_AUTHOR("Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>");
 MODULE_DESCRIPTION("LTC2632 DAC SPI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4
