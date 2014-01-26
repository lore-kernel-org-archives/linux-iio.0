Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:23707
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751012AbaAZGRe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jan 2014 01:17:34 -0500
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>
CC: <shawn.guo@linaro.org>, <sachin.kamat@linaro.org>,
	<pmeerw@pmeerw.net>, <lars@metafoo.de>, <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
Date: Sun, 26 Jan 2014 13:39:31 +0800
Message-ID: <1390714773-23066-2-git-send-email-B38611@freescale.com>
In-Reply-To: <1390714773-23066-1-git-send-email-B38611@freescale.com>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
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
 arch/arm/boot/dts/vf610-twr.dts |   21 +++++++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi    |   26 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index c8047ca..d867be3 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -34,6 +34,27 @@
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
+
+};
+
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_ad5>;
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
 };
 
 &dspi0 {
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index d31ce1b..b5b21ea 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -152,6 +152,15 @@
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
@@ -178,6 +187,14 @@
 
 				/* functions and groups pins */
 
+				adc0 {
+					pinctrl_adc0_ad5: adc0_ad5 {
+						fsl,pins = <
+						VF610_PAD_PTC30__ADC0_SE5	0xa1
+						>;
+					};
+				};
+
 				dcu0 {
 					pinctrl_dcu0_1: dcu0grp_1 {
 						fsl,pins = <
@@ -450,6 +467,15 @@
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


