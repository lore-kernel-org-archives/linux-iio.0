Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46380 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbdA0JBv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 04:01:51 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH v2 03/25] power: supply: axp20x_usb_power: use IIO channels when available
Date: Fri, 27 Jan 2017 09:54:36 +0100
Message-Id: <20170127085458.18270-4-quentin.schulz@free-electrons.com>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X PMIC exposes the current current and voltage
measures via an internal ADC.

This adds the possibility to read IIO channels directly for processed
values rather than reading the registers and computing the value.

For backward compatibility purpose, if the IIO driver is not compiled,
this driver will fall back on previous behaviour which is direct
register readings.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 drivers/power/supply/axp20x_usb_power.c | 70 +++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 1bcb025..d8b1dc6 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -22,6 +22,7 @@
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/iio/consumer.h>
 
 #define DRVNAME "axp20x-usb-power-supply"
 
@@ -49,6 +50,8 @@ struct axp20x_usb_power {
 	struct regmap *regmap;
 	struct power_supply *supply;
 	int axp20x_id;
+	struct iio_channel *vbus_v;
+	struct iio_channel *vbus_i;
 };
 
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
@@ -76,6 +79,20 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = AXP20X_VBUS_VHOLD_uV(v);
 		return 0;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
+			ret = iio_read_channel_processed(power->vbus_v,
+							 &val->intval);
+			if (ret)
+				return ret;
+
+			/*
+			 * IIO framework gives mV but Power Supply framework
+			 * gives uV.
+			 */
+			val->intval *= 1000;
+			return 0;
+		}
+
 		ret = axp20x_read_variable_width(power->regmap,
 						 AXP20X_VBUS_V_ADC_H, 12);
 		if (ret < 0)
@@ -107,6 +124,20 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		}
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
+			ret = iio_read_channel_processed(power->vbus_i,
+							 &val->intval);
+			if (ret)
+				return ret;
+
+			/*
+			 * IIO framework gives mA but Power Supply framework
+			 * gives uA.
+			 */
+			val->intval *= 1000;
+			return 0;
+		}
+
 		ret = axp20x_read_variable_width(power->regmap,
 						 AXP20X_VBUS_I_ADC_H, 12);
 		if (ret < 0)
@@ -269,6 +300,36 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
 	.set_property = axp20x_usb_power_set_property,
 };
 
+static int configure_iio_channels(struct platform_device *pdev,
+				  struct axp20x_usb_power *power)
+{
+	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
+	if (IS_ERR(power->vbus_v)) {
+		if (PTR_ERR(power->vbus_v) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(power->vbus_v);
+	}
+
+	power->vbus_i = devm_iio_channel_get(&pdev->dev, "vbus_i");
+	if (IS_ERR(power->vbus_i)) {
+		if (PTR_ERR(power->vbus_i) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(power->vbus_i);
+	}
+
+	return 0;
+}
+
+static int configure_adc_registers(struct axp20x_usb_power *power)
+{
+	/* Enable vbus voltage and current measurement */
+	return regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
+				  AXP20X_ADC_EN1_VBUS_CURR |
+				  AXP20X_ADC_EN1_VBUS_VOLT,
+				  AXP20X_ADC_EN1_VBUS_CURR |
+				  AXP20X_ADC_EN1_VBUS_VOLT);
+}
+
 static int axp20x_usb_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -307,10 +368,11 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		/* Enable vbus voltage and current measurement */
-		ret = regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
-			AXP20X_ADC_EN1_VBUS_CURR | AXP20X_ADC_EN1_VBUS_VOLT,
-			AXP20X_ADC_EN1_VBUS_CURR | AXP20X_ADC_EN1_VBUS_VOLT);
+		if (IS_ENABLED(CONFIG_AXP20X_ADC))
+			ret = configure_iio_channels(pdev, power);
+		else
+			ret = configure_adc_registers(power);
+
 		if (ret)
 			return ret;
 
-- 
2.9.3

