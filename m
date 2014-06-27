Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16990 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbaF0GL1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 02:11:27 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, cpgs@samsung.com
Subject: [PATCH v2 2/2] ARM: DTS: Add thermistor dts fragment used by exynos
 based Peach boards
Date: Fri, 27 Jun 2014 11:38:15 +0530
Message-id: <1403849295-29538-3-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403849295-29538-1-git-send-email-ch.naveen@samsung.com>
References: <1403849295-29538-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch creates a thermistor fragment carrying the NTC Thermistor
nodes as children of the IIO based ADC.

This fragment is included in exynos5420-peach-pit.dts and
exynos5800-peach-pi.dts.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
Changes since v1:
As per the comments https://lkml.org/lkml/2014/6/26/271
and discussion about fragments vs common dtsi
@ http://patchwork.ozlabs.org/patch/362633/.

Created a thermistors fragment instead of a common dtsi file

cat sysfs entries exported by hwmon for 4 thermistors
and verified the values on Peach pit and pi boards.

 arch/arm/boot/dts/cros-adc-thermistors.dtsi |   44 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts  |    6 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts   |    6 ++++
 3 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/cros-adc-thermistors.dtsi

diff --git a/arch/arm/boot/dts/cros-adc-thermistors.dtsi b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
new file mode 100644
index 0000000..17fce72
--- /dev/null
+++ b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
@@ -0,0 +1,44 @@
+/*
+ * Thermistor dts fragment for devices that use Thermistors as
+ * children of the IIO based ADC.
+ *
+ * Currently, used by Exynos5420 based Peach PIT and
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
index d124394..7c64009 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -101,6 +101,11 @@
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
@@ -775,3 +780,4 @@
 };
 
 #include "cros-ec-keyboard.dtsi"
+#include "cros-adc-thermistors.dtsi"
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index c36c9ce..4fd48b9 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -99,6 +99,11 @@
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
@@ -773,3 +778,4 @@
 };
 
 #include "cros-ec-keyboard.dtsi"
+#include "cros-adc-thermistors.dtsi"
-- 
1.7.9.5

