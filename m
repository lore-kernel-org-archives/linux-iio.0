Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16630 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbaFXMZP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jun 2014 08:25:15 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, kgene.kim@samsung.com,
	linux-arm-kernel@lists.infradead.org, cpgs@samsung.com,
	devicetree@vger.kernel.org, lars@metafoo.de,
	Doug Anderson <dianders@chromium.org>
Subject: [PATCH 4/4] ARM: DTS: Add NTC thermistor nodes as child nodes to ADC
Date: Tue, 24 Jun 2014 17:49:16 +0530
Message-id: <1403612356-23685-5-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Exynos5420 based Peach PIT and Exynos5800 based PI boards have
4 NTC thermistors to measure temperatures at various points on the
board.

IIO based ADC becomes the parent and NTC thermistors are the childs,
via the HWMON interface.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
---
This patch needs
1. MAX77802 PMIC device tree nodes (for ldo9)
   https://www.mail-archive.com/devicetree@vger.kernel.org/msg31430.html
2. Uses the DT documentation for NTC thermistors updated with vendor-prefix

 arch/arm/boot/dts/exynos5420-peach-pit.dts |   32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index b96a66a..852a220 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -751,4 +751,36 @@
 	timeout-sec = <32>;
 };
 
+&adc {
+	vdd-supply = <&ldo9_reg>;
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
 #include "cros-ec-keyboard.dtsi"
-- 
1.7.9.5

