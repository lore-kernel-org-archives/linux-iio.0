Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49454 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbaFZMXY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jun 2014 08:23:24 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, cpgs@samsung.com
Subject: [PATCH 3/3] ARM: DTS: Add common dts file for Peach PIT and PI along
 with ADC nodes
Date: Thu, 26 Jun 2014 17:49:08 +0530
Message-id: <1403785148-20792-4-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403785148-20792-1-git-send-email-ch.naveen@samsung.com>
References: <1403785148-20792-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

DTS files exynos5420-peach-pit.dts and exynos5800-peach-pi.dts
have lots of device tree nodes in common.

This patch creates a cros-exynos-peach.dts file, which can carry the
device tree nodes common across exynos5420-peach-pit.dts and
exynos5800-peach-pi.dts. Starting with ADC based Thermistor nodes.

Also, enables ADC based thermistors for peach_pi and peach_pit.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
This patchset needs
"[PATCH v4 00/14] Add Maxim 77802 PMIC support" by "Javier Martinez Canillas"
Posted  https://lkml.org/lkml/2014/6/25/668

Intention is to slowly move the common DT nodes across exynos5420-peach-pit.dts
and exynos5800-peach-pi.dts into cros-exynos-peach.dts

I'm unsure of the naming conventions for dts files
   Named it "cros-exynos-peach.dts" as below.
   used for "cros" + based on "exynos" + boards named "peach" in common.

cat sysfs entries exported by hwmon for 4 thermistors
and verified the values on peach pit.

 arch/arm/boot/dts/cros-exynos-peach.dtsi   |   41 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts |    6 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |    6 ++++
 3 files changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/cros-exynos-peach.dtsi

diff --git a/arch/arm/boot/dts/cros-exynos-peach.dtsi b/arch/arm/boot/dts/cros-exynos-peach.dtsi
new file mode 100644
index 0000000..86135bd
--- /dev/null
+++ b/arch/arm/boot/dts/cros-exynos-peach.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Common device tree include for Exynos5420 based Peach PIT and
+ * Exynos5800 based Peach PI.
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+&adc {
+	ncp15wb473@3 {
+		compatible = "murata,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 3>;
+	};
+	ncp15wb473@4 {
+		compatible = "murata,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 4>;
+	};
+	ncp15wb473@5 {
+		compatible = "murata,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 5>;
+	};
+	ncp15wb473@6 {
+		compatible = "murata,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 6>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index d124394..682b9c2 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "exynos5420.dtsi"
+#include "cros-exynos-peach.dtsi"
 
 / {
 	model = "Google Peach Pit Rev 6+";
@@ -101,6 +102,11 @@
 	};
 };
 
+&adc {
+	status = "okay";
+	vdd-supply = <&ldo9_reg>;
+};
+
 &dp {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index c36c9ce..7552173 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "exynos5800.dtsi"
+#include "cros-exynos-peach.dtsi"
 
 / {
 	model = "Google Peach Pi Rev 10+";
@@ -99,6 +100,11 @@
 	};
 };
 
+&adc {
+	status = "okay";
+	vdd-supply = <&ldo9_reg>;
+};
+
 &dp {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.7.9.5

