Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:17177
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751635Ab3KZCHh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 21:07:37 -0500
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>, <sachin.kamat@linaro.org>
CC: <shawn.guo@linaro.org>, <b20596@freescale.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v2 1/3] ARM: dts: vf610-twr: Add ADC support
Date: Tue, 26 Nov 2013 09:42:50 +0800
Message-ID: <1385430172-16642-2-git-send-email-B38611@freescale.com>
In-Reply-To: <1385430172-16642-1-git-send-email-B38611@freescale.com>
References: <1385430172-16642-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

vf610 have two ADC controllers, and vf610-twr board ADC0_SE5 pin connect
to sliding rheostat for ADC test, other ADC pins connect to connectors for
future use.

Add support for ADC0_SE5.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts |   14 ++++++++++++++
 arch/arm/boot/dts/vf610.dtsi    |   26 ++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index c8047ca..db069ef 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -36,6 +36,20 @@
 
 };
 
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_ad5>;
+	vf610,adc-io-pinctl = <0x20>;
+	vf610,adc-vref = <3300000>;
+	vf610,adc-clk-div = <2>;
+	vf610,adc-res = <12>;
+	vf610,adc-sam-time = <4>;
+	vf610,adc-aver-sam-sel = <4>;
+	vf610,adc-hw-aver-en;
+	vf610,adc-low-power-mode;
+	status = "okay";
+};
+
 &dspi0 {
 	bus-num = <0>;
 	pinctrl-names = "default";
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


