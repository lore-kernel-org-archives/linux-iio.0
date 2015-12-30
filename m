Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36228 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbL3Fo6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Dec 2015 00:44:58 -0500
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, robh@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2] iio: health: max30100: add config for LED current
Date: Tue, 29 Dec 2015 21:44:48 -0800
Message-Id: <1451454288-9945-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow the current for both RED and IR LEDs to be set via an device tree
property setting.

This is an optional setting that is useful for applications that have a
known glass attenuation factor.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
Changes from v2:
* change to use microamp property name from LED class
* updated documentation for new format
* added allowed current index map

.../devicetree/bindings/iio/health/max30100.txt    |  8 +++
 drivers/iio/health/max30100.c                      | 81 ++++++++++++++++++++--
 2 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/health/max30100.txt b/Documentation/devicetree/bindings/iio/health/max30100.txt
index f6fbac6..4eef96e 100644
--- a/Documentation/devicetree/bindings/iio/health/max30100.txt
+++ b/Documentation/devicetree/bindings/iio/health/max30100.txt
@@ -11,11 +11,19 @@ Required properties:
   Refer to interrupt-controller/interrupts.txt for generic
   interrupt client node bindings.
 
+Optional properties:
+  - maxim,led-current-microamp: configuration for LED current in microamperes
+    while the engine is running. First indexed value is the configuration for
+    the RED LED, and second value is for the IR LED.
+
+    Refer to the datasheet for the allowed current values.
+
 Example:
 
 max30100@057 {
 	compatible = "maxim,max30100";
 	reg = <57>;
+	maxim,led-current-microamp = <24000 50000>;
 	interrupt-parent = <&gpio1>;
 	interrupts = <16 2>;
 };
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 9d1c81f..09db893 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -13,7 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
- * TODO: allow LED current and pulse length controls via device tree properties
+ * TODO: enable pulse length controls via device tree properties
  */
 
 #include <linux/module.h>
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -65,6 +66,7 @@
 #define MAX30100_REG_SPO2_CONFIG_1600US		0x3
 
 #define MAX30100_REG_LED_CONFIG			0x09
+#define MAX30100_REG_LED_CONFIG_LED_MASK	0x0f
 #define MAX30100_REG_LED_CONFIG_RED_LED_SHIFT	4
 
 #define MAX30100_REG_LED_CONFIG_24MA		0x07
@@ -111,6 +113,12 @@ static const struct regmap_config max30100_regmap_config = {
 	.volatile_reg = max30100_is_volatile_reg,
 };
 
+static const unsigned int max30100_led_current_mapping[] = {
+	4400, 7600, 11000, 14200, 17400,
+	20800, 24000, 27100, 30600, 33800,
+	37000, 40200, 43600, 46800, 50000
+};
+
 static const unsigned long max30100_scan_masks[] = {0x3, 0};
 
 static const struct iio_chan_spec max30100_channels[] = {
@@ -243,15 +251,76 @@ static irqreturn_t max30100_interrupt_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static int max30100_get_current_idx(unsigned int val, int *reg)
+{
+	int idx;
+
+	/* LED turned off */
+	if (val == 0) {
+		*reg = 0;
+		return 0;
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(max30100_led_current_mapping); idx++) {
+		if (max30100_led_current_mapping[idx] == val) {
+			*reg = idx + 1;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int max30100_led_init(struct max30100_data *data)
+{
+	struct device *dev = &data->client->dev;
+	struct device_node *np = dev->of_node;
+	unsigned int val[2];
+	int reg, ret;
+
+	ret = of_property_read_u32_array(np, "maxim,led-current-microamp",
+					(unsigned int *) &val, 2);
+	if (ret) {
+		/* Default to 24 mA RED LED, 50 mA IR LED */
+		reg = (MAX30100_REG_LED_CONFIG_24MA <<
+			MAX30100_REG_LED_CONFIG_RED_LED_SHIFT) |
+			MAX30100_REG_LED_CONFIG_50MA;
+		dev_warn(dev, "no led-current-microamp set");
+
+		return regmap_write(data->regmap, MAX30100_REG_LED_CONFIG, reg);
+	}
+
+	/* RED LED current */
+	ret = max30100_get_current_idx(val[0], &reg);
+	if (ret) {
+		dev_err(dev, "invalid RED current setting %d", val[0]);
+		return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, MAX30100_REG_LED_CONFIG,
+		MAX30100_REG_LED_CONFIG_LED_MASK <<
+		MAX30100_REG_LED_CONFIG_RED_LED_SHIFT,
+		reg << MAX30100_REG_LED_CONFIG_RED_LED_SHIFT);
+	if (ret)
+		return ret;
+
+	/* IR LED current */
+	ret = max30100_get_current_idx(val[1], &reg);
+	if (ret) {
+		dev_err(dev, "invalid IR current setting %d", val[1]);
+		return ret;
+	}
+
+	return regmap_update_bits(data->regmap, MAX30100_REG_LED_CONFIG,
+		MAX30100_REG_LED_CONFIG_LED_MASK, reg);
+}
+
 static int max30100_chip_init(struct max30100_data *data)
 {
 	int ret;
 
-	/* RED IR LED = 24mA, IR LED = 50mA */
-	ret = regmap_write(data->regmap, MAX30100_REG_LED_CONFIG,
-				(MAX30100_REG_LED_CONFIG_24MA <<
-				 MAX30100_REG_LED_CONFIG_RED_LED_SHIFT) |
-				 MAX30100_REG_LED_CONFIG_50MA);
+	/* setup LED current settings */
+	ret = max30100_led_init(data);
 	if (ret)
 		return ret;
 
-- 
2.6.4

