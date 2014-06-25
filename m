Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33636 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaFYGcm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jun 2014 02:32:42 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, kgene.kim@samsung.com,
	linux-arm-kernel@lists.infradead.org, cpgs@samsung.com,
	devicetree@vger.kernel.org, lars@metafoo.de,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/4 v2] hwmon: ntc_thermistor: Use the manufacturer name
 properly
Date: Wed, 25 Jun 2014 11:59:31 +0530
Message-id: <1403677773-21141-3-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Murata Manufacturing Co., Ltd is the vendor for
NTC (Negative Temperature coefficient) based Thermistors.
But, the driver extensively uses "NTC" as the vendor name.

This patch corrects the vendor name also updates the
compatibility strings according to the vendor-prefix.txt

Note: Drivers continue to support the previous compatible strings
but further addition of these compatible strings in device tree
is deprecated.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
Changes since v1:
1. Kept the old compatible string marked as <DEPRECATED> in code and
   in the Documentation.

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |    2 +-
 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |   20 ++++++++++++++------
 Documentation/hwmon/ntc_thermistor                 |    8 ++++----
 drivers/hwmon/Kconfig                              |    5 +++--
 drivers/hwmon/ntc_thermistor.c                     |   14 +++++++++++++-
 5 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
index 5d49f2b..832fe8c 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
@@ -48,7 +48,7 @@ adc@12D10000 {
 
 	/* NTC thermistor is a hwmon device */
 	ncp15wb473@0 {
-		compatible = "ntc,ncp15wb473";
+		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <47000>;
 		pulldown-ohm = <0>;
diff --git a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
index c6f6667..b117b2e 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
+++ b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
@@ -3,11 +3,19 @@ NTC Thermistor hwmon sensors
 
 Requires node properties:
 - "compatible" value : one of
-	"ntc,ncp15wb473"
-	"ntc,ncp18wb473"
-	"ntc,ncp21wb473"
-	"ntc,ncp03wb473"
-	"ntc,ncp15wl333"
+	"murata,ncp15wb473"
+	"murata,ncp18wb473"
+	"murata,ncp21wb473"
+	"murata,ncp03wb473"
+	"murata,ncp15wl333"
+
+/* Usage of vendor name "ntc" is deprecated */
+<DEPRECATED>	"ntc,ncp15wb473"
+<DEPRECATED>	"ntc,ncp18wb473"
+<DEPRECATED>	"ntc,ncp21wb473"
+<DEPRECATED>	"ntc,ncp03wb473"
+<DEPRECATED>	"ntc,ncp15wl333"
+
 - "pullup-uv"	Pull up voltage in micro volts
 - "pullup-ohm"	Pull up resistor value in ohms
 - "pulldown-ohm" Pull down resistor value in ohms
@@ -21,7 +29,7 @@ Read more about iio bindings at
 
 Example:
 	ncp15wb473@0 {
-		compatible = "ntc,ncp15wb473";
+		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <47000>;
 		pulldown-ohm = <0>;
diff --git a/Documentation/hwmon/ntc_thermistor b/Documentation/hwmon/ntc_thermistor
index 3bfda94..057b770 100644
--- a/Documentation/hwmon/ntc_thermistor
+++ b/Documentation/hwmon/ntc_thermistor
@@ -1,7 +1,7 @@
 Kernel driver ntc_thermistor
 =================
 
-Supported thermistors:
+Supported thermistors from Murata:
 * Murata NTC Thermistors NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, NCP15WL333
   Prefixes: 'ncp15wb473', 'ncp18wb473', 'ncp21wb473', 'ncp03wb473', 'ncp15wl333'
   Datasheet: Publicly available at Murata
@@ -15,9 +15,9 @@ Authors:
 Description
 -----------
 
-The NTC thermistor is a simple thermistor that requires users to provide the
-resistance and lookup the corresponding compensation table to get the
-temperature input.
+The NTC (Negative Temperature Coefficient) thermistor is a simple thermistor
+that requires users to provide the resistance and lookup the corresponding
+compensation table to get the temperature input.
 
 The NTC driver provides lookup tables with a linear approximation function
 and four circuit models with an option not to use any of the four models.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08531a1..154851b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1052,7 +1052,7 @@ config SENSORS_PC87427
 	  will be called pc87427.
 
 config SENSORS_NTC_THERMISTOR
-	tristate "NTC thermistor support"
+	tristate "NTC thermistor support from Murata"
 	depends on !OF || IIO=n || IIO
 	help
 	  This driver supports NTC thermistors sensor reading and its
@@ -1060,7 +1060,8 @@ config SENSORS_NTC_THERMISTOR
 	  send notifications about the temperature.
 
 	  Currently, this driver supports
-	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333.
+	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333
+	  from Murata.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ntc-thermistor.
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index e76feb86..bdfbe91 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -163,6 +163,18 @@ static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
 }
 
 static const struct of_device_id ntc_match[] = {
+	{ .compatible = "murata,ncp15wb473",
+		.data = &ntc_thermistor_id[0] },
+	{ .compatible = "murata,ncp18wb473",
+		.data = &ntc_thermistor_id[1] },
+	{ .compatible = "murata,ncp21wb473",
+		.data = &ntc_thermistor_id[2] },
+	{ .compatible = "murata,ncp03wb473",
+		.data = &ntc_thermistor_id[3] },
+	{ .compatible = "murata,ncp15wl333",
+		.data = &ntc_thermistor_id[4] },
+
+	/* Usage of vendor name "ntc" is deprecated */
 	{ .compatible = "ntc,ncp15wb473",
 		.data = &ntc_thermistor_id[0] },
 	{ .compatible = "ntc,ncp18wb473",
@@ -534,7 +546,7 @@ static struct platform_driver ntc_thermistor_driver = {
 
 module_platform_driver(ntc_thermistor_driver);
 
-MODULE_DESCRIPTION("NTC Thermistor Driver");
+MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:ntc-thermistor");
-- 
1.7.9.5

