Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:63544 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaFYGcr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jun 2014 02:32:47 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, kgene.kim@samsung.com,
	linux-arm-kernel@lists.infradead.org, cpgs@samsung.com,
	devicetree@vger.kernel.org, lars@metafoo.de,
	Doug Anderson <dianders@chromium.org>
Subject: [PATCH 4/4 v2] ARM: DTS: Add NTC thermistor nodes to Exynos5420 based
 Peach_PIT
Date: Wed, 25 Jun 2014 11:59:33 +0530
Message-id: <1403677773-21141-5-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Exynos5420 based Peach PIT board has 4 NTC thermistors to measure
temperatures at various points on the board.

IIO based ADC becomes the parent and NTC thermistors are the childs,
via the HWMON interface.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
---
Changes since v1:
1. Arranged the ADC node alphabetical
2. Added "status = "okay"" to the ADC node

This patch needs
1. MAX77802 PMIC device tree nodes (for ldo9)
   https://www.mail-archive.com/devicetree@vger.kernel.org/msg31430.html
2. Uses the DT documentation for NTC thermistors updated with vendor-prefix

This patch set is tested
1. On Peach PIT board via sysfs entry exposed by hwmon
localhost ~ # cat /sys/class/hwmon/hwmon*/device/temp1_input                                                                                                                                          
37436
36449
38560
38059

2. Backward compatibility is tested by replacing "murata" with "ntc"
   in the dts nodes and running the above test.

 arch/arm/boot/dts/exynos5420-peach-pit.dts |   34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index b96a66a..19d733d 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -101,6 +101,40 @@
 	};
 };
 
+&adc {
+	status = "okay";
+	vdd-supply = <&ldo9_reg>;
+
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
+
 &dp {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.7.9.5

