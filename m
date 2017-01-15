Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33762 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdAOWml (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 17:42:41 -0500
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc: carlo@caione.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/4] ARM64: dts: meson: meson-gx: add the SAR ADC
Date: Sun, 15 Jan 2017 23:42:21 +0100
Message-Id: <20170115224221.15510-5-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
References: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
 <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the SAR ADC to meson-gxbb.dtsi and meson-gxl.dtsi. GXBB provides a
10-bit ADC while GXL (and GXM, which uses the same ADC as GXL) provides
a 12-bit ADC.
Some boards use resistor ladder buttons connected through one of the ADC
channels. On newer devices (GXL and GXM) some boards use pull-ups/downs
to change the resistance (and thus the ADC value) on of the ADC channels
to indicate the board revision.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   |  8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 10 ++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index cddad8c795ec..041e4f0ed7d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -237,6 +237,14 @@
 				status = "disabled";
 			};
 
+			saradc: adc@8680 {
+				compatible = "amlogic,meson-saradc";
+				#io-channel-cells = <1>;
+				status = "disabled";
+				reg = <0x0 0x8680 0x0 0x34>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
+			};
+
 			pwm_ef: pwm@86c0 {
 				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
 				reg = <0x0 0x086c0 0x0 0x10>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5d686334f692..114d7e1c9fc0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -429,6 +429,16 @@
 	clocks = <&clkc CLKID_I2C>;
 };
 
+&saradc {
+	compatible = "amlogic,meson-gxbb-saradc", "amlogic,meson-saradc";
+	clocks = <&xtal>,
+		 <&clkc CLKID_SAR_ADC>,
+		 <&clkc CLKID_SANA>,
+		 <&clkc CLKID_SAR_ADC_CLK>,
+		 <&clkc CLKID_SAR_ADC_SEL>;
+	clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
+};
+
 &sd_emmc_a {
 	clocks = <&clkc CLKID_SD_EMMC_A>,
 		 <&xtal>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index bb2842f8a08f..6b63296b6c60 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -273,6 +273,16 @@
 	clocks = <&clkc CLKID_I2C>;
 };
 
+&saradc {
+	compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
+	clocks = <&xtal>,
+		 <&clkc CLKID_SAR_ADC>,
+		 <&clkc CLKID_SANA>,
+		 <&clkc CLKID_SAR_ADC_CLK>,
+		 <&clkc CLKID_SAR_ADC_SEL>;
+	clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
+};
+
 &sd_emmc_a {
 	clocks = <&clkc CLKID_SD_EMMC_A>,
 		 <&xtal>,
-- 
2.11.0

