Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36011 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbbLKQtc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2015 11:49:32 -0500
Received: by mail-wm0-f46.google.com with SMTP id n186so38197058wmn.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2015 08:49:31 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH 3/3] iio: ina2xx: add support for CHAN_INFO_SCALE
Date: Fri, 11 Dec 2015 17:49:17 +0100
Message-Id: <1449852557-3138-3-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1449852557-3138-1-git-send-email-mtitinger@baylibre.com>
References: <1449852557-3138-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Provide client apps with the scales to apply to the register values
read from the software buffer.

Follow the ABI documentation so that values are in milli-unit after scales
are applied.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/iio/adc/ina2xx-adc.c | 85 +++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 99afa6e..98939ba 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -82,6 +82,11 @@ static bool ina2xx_is_volatile_reg(struct device *dev, unsigned int reg)
 	return (reg != INA2XX_CONFIG);
 }
 
+static inline bool is_signed_reg(unsigned int reg)
+{
+	return (reg == INA2XX_SHUNT_VOLTAGE) || (reg == INA2XX_CURRENT);
+}
+
 static const struct regmap_config ina2xx_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -133,43 +138,6 @@ static const struct ina2xx_config ina2xx_config[] = {
 		    },
 };
 
-static int ina2xx_get_value(struct ina2xx_chip_info *chip, u8 reg,
-			    unsigned int regval, int *val, int *uval)
-{
-	*val = 0;
-
-	switch (reg) {
-	case INA2XX_SHUNT_VOLTAGE:
-		/* signed register */
-		*uval = DIV_ROUND_CLOSEST((s16) regval,
-					  chip->config->shunt_div);
-		return IIO_VAL_INT_PLUS_MICRO;
-
-	case INA2XX_BUS_VOLTAGE:
-		*uval = (regval >> chip->config->bus_voltage_shift)
-			* chip->config->bus_voltage_lsb;
-		*val = *uval / 1000000;
-		*uval = *uval % 1000000;
-		return IIO_VAL_INT_PLUS_MICRO;
-
-	case INA2XX_POWER:
-		*uval = regval * chip->config->power_lsb;
-		*val = *uval / 1000000;
-		*uval = *uval % 1000000;
-		return IIO_VAL_INT_PLUS_MICRO;
-
-	case INA2XX_CURRENT:
-		/* signed register, LSB=1mA (selected), in mA */
-		*uval = (s16) regval * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
-
-	default:
-		/* programmer goofed */
-		WARN_ON_ONCE(1);
-	}
-	return -EINVAL;
-}
-
 static int ina2xx_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -184,7 +152,12 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		return ina2xx_get_value(chip, chan->address, regval, val, val2);
+		if (is_signed_reg(chan->address))
+			*val = (s16) regval;
+		else
+			*val  = regval;
+
+		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = chip->avg;
@@ -208,11 +181,34 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 
-	default:
-		return -EINVAL;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+		case INA2XX_SHUNT_VOLTAGE:
+			/* processed (mV) = raw*1000/shunt_div */
+			*val2 = chip->config->shunt_div;
+			*val = 1000;
+			return IIO_VAL_FRACTIONAL;
+
+		case INA2XX_BUS_VOLTAGE:
+			/* processed (mV) = raw*lsb (uV) / (1000 << shift) */
+			*val = chip->config->bus_voltage_lsb;
+			*val2 = 1000 << chip->config->bus_voltage_shift;
+			return IIO_VAL_FRACTIONAL;
+
+		case INA2XX_POWER:
+			/* processed (mW) = raw*lsb (uW) / 1000 */
+			*val = chip->config->power_lsb;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+
+		case INA2XX_CURRENT:
+			/* processed (mA) = raw (mA) */
+			*val = 1;
+			return IIO_VAL_INT;
+		}
 	}
 
-	return 0;
+	return -EINVAL;
 }
 
 /*
@@ -395,7 +391,7 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
 	.address = (_address), \
 	.indexed = 1, \
 	.channel = (_index), \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)|BIT(IIO_CHAN_INFO_SCALE), \
 	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
 				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
 	.scan_index = (_index), \
@@ -403,7 +399,7 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
 		.sign = 'u', \
 		.realbits = 16, \
 		.storagebits = 16, \
-		.endianness = IIO_BE, \
+		.endianness = IIO_LE, \
 	} \
 }
 
@@ -417,13 +413,14 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
 	.indexed = 1, \
 	.channel = (_index), \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_INT_TIME), \
 	.scan_index = (_index), \
 	.scan_type = { \
 		.sign = 'u', \
 		.realbits = 16, \
 		.storagebits = 16, \
-		.endianness = IIO_BE, \
+		.endianness = IIO_LE, \
 	} \
 }
 
-- 
1.9.1

