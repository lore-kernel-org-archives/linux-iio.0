Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35370 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbL0Eik (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Dec 2015 23:38:40 -0500
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: health: max30100: add config for LED current
Date: Sat, 26 Dec 2015 20:38:24 -0800
Message-Id: <1451191104-1281-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow the current for both RED and IR LEDs to be set via an device tree
property setting.

This is an optional setting that is useful for applications that have a
known glass attenuation factor.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 .../devicetree/bindings/iio/health/max30100.txt     |  7 +++++++
 drivers/iio/health/max30100.c                       | 21 +++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/health/max30100.txt b/Documentation/devicetree/bindings/iio/health/max30100.txt
index f6fbac6..009314c 100644
--- a/Documentation/devicetree/bindings/iio/health/max30100.txt
+++ b/Documentation/devicetree/bindings/iio/health/max30100.txt
@@ -11,11 +11,18 @@ Required properties:
   Refer to interrupt-controller/interrupts.txt for generic
   interrupt client node bindings.
 
+Optional properties:
+  - max30100,led-current: configuration for LED current (in mA) while the engine
+    is running. Upper nibble is for the RED LED, and lower nibble the IR LED.
+
+    Refer to the datasheet for the current mapping values.
+
 Example:
 
 max30100@057 {
 	compatible = "maxim,max30100";
 	reg = <57>;
+	max30100,led-current = <0x7f>;
 	interrupt-parent = <&gpio1>;
 	interrupts = <16 2>;
 };
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 9d1c81f..37e8d7e 100644
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
@@ -245,13 +246,21 @@ static irqreturn_t max30100_interrupt_handler(int irq, void *private)
 
 static int max30100_chip_init(struct max30100_data *data)
 {
+	struct device *dev = &data->client->dev;
+	struct device_node *np = dev->of_node;
 	int ret;
+	u32 val;
 
-	/* RED IR LED = 24mA, IR LED = 50mA */
-	ret = regmap_write(data->regmap, MAX30100_REG_LED_CONFIG,
-				(MAX30100_REG_LED_CONFIG_24MA <<
-				 MAX30100_REG_LED_CONFIG_RED_LED_SHIFT) |
-				 MAX30100_REG_LED_CONFIG_50MA);
+	ret = of_property_read_u32(np, "max30100,led-current", &val);
+	if (ret) {
+		/* Default to 24 mA RED LED, 50 mA IR LED */
+		val = (MAX30100_REG_LED_CONFIG_24MA <<
+			MAX30100_REG_LED_CONFIG_RED_LED_SHIFT) |
+			MAX30100_REG_LED_CONFIG_50MA;
+		dev_warn(dev, "no led-current set, defaulting to %d", val);
+	}
+
+	ret = regmap_write(data->regmap, MAX30100_REG_LED_CONFIG, val & 0xFF);
 	if (ret)
 		return ret;
 
-- 
2.6.4

