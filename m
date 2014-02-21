Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:37554
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751010AbaBUGHu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2014 01:07:50 -0500
From: Fugang Duan <B38611@freescale.com>
To: <shawn.guo@linaro.org>
CC: <linux-iio@vger.kernel.org>
Subject: [PATCH v6 1/1] ARM: dts: vf610-twr: Add ADC support
Date: Fri, 21 Feb 2014 13:24:16 +0800
Message-ID: <1392960256-23561-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

vf610 has two ADC controllers, and vf610-twr board ADC0_SE5 pin connect
to sliding rheostat for ADC test, other ADC pins connect to connectors for
future use.

Add support for ADC0_SE5.

CC: Shawn Guo <shawn.guo@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Otavio Salvador <otavio@ossystems.com.br>
CC: Peter Meerwald <pmeerw@pmeerw.net>
CC: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi    |   18 ++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index e3a3805..38898f7 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -34,6 +34,26 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_vcc_3v3_mcu: regulator@0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vcc_3v3_mcu";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_ad5>;
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
 };
 
 &dspi0 {
@@ -76,6 +96,12 @@
 
 &iomuxc {
 	vf610-twr {
+		pinctrl_adc0_ad5: adc0_ad5 {
+			fsl,pins = <
+				VF610_PAD_PTC30__ADC0_SE5		0xa1
+			>;
+		};
+
 		pinctrl_dspi0: dspi0grp {
 			fsl,pins = <
 				VF610_PAD_PTB19__DSPI0_CS0		0x1182
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 91a7757..b0e5351 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -180,6 +180,15 @@
 				clock-names = "pit";
 			};
 
+			adc0: adc@4003b000 {
+				compatible = "fsl,vf610-adc";
+				reg = <0x4003b000 0x1000>;
+				interrupts = <0 53 0x04>;
+				clocks = <&clks VF610_CLK_ADC0>;
+				clock-names = "adc";
+				status = "disabled";
+			};
+
 			wdog@4003e000 {
 				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
@@ -323,6 +332,15 @@
 				status = "disabled";
 			};
 
+			adc1: adc@400bb000 {
+				compatible = "fsl,vf610-adc";
+				reg = <0x400bb000 0x1000>;
+				interrupts = <0 54 0x04>;
+				clocks = <&clks VF610_CLK_ADC1>;
+				clock-names = "adc";
+				status = "disabled";
+			};
+
 			fec0: ethernet@400d0000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d0000 0x1000>;
-- 
1.7.2.rc3


