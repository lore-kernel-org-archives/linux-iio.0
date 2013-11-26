Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:3220
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756539Ab3KZLV3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Nov 2013 06:21:29 -0500
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>, <sachin.kamat@linaro.org>
CC: <devicetree@vger.kernel.org>, <shawn.guo@linaro.org>,
	<b20596@freescale.com>, <linux-iio@vger.kernel.org>
Subject: [PATCH v3 3/3] Documentation: add the binding file for Freescale vf610 ADC driver
Date: Tue, 26 Nov 2013 18:56:34 +0800
Message-ID: <1385463394-11157-4-git-send-email-B38611@freescale.com>
In-Reply-To: <1385463394-11157-1-git-send-email-B38611@freescale.com>
References: <1385463394-11157-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch adds the binding file for Freescale vf610 ADC driver.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   57 ++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
new file mode 100644
index 0000000..4101516
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
@@ -0,0 +1,57 @@
+Freescale vf610 Analog to Digital Converter bindings
+
+The devicetree bindings are for the new ADC driver written for
+vf610/i.MX6slx and upward SoCs from Freescale.
+
+Required properties:
+- compatible: Should be "fsl,vf610-adc"
+- reg: Offset and length of the register set for the device
+- interrupts: Should contain the interrupt for the device
+- clocks: The clocks needed by the ADC controller
+- clock-names: the name of the clocks
+
+Optional properties:
+- fsl,adc-io-pinctl: Enable field for the I/O port control of MCU pins used as analog inputs.
+- fsl,adc-vref: ADC refrence voltage value, unit is uV.
+- fsl,adc-clk-div: Current clock divider value, such as 1,2,4,8,16 and so on.
+- fsl,adc-res: ADC conversion mode selection, such as 8 for 8-bit, 10 for 10-bit, 12 for 12-bit mode.
+- fsl,adc-sam-time: ADC sample time duration, number of ADC clocks, such as 2, 4, 6, 8, 12, 16, 20, 24
+- fsl,adc-aver-sam-sel: Determines how many ADC conversions will be averaged to create the ADC average result.
+			The Optional value is 4, 8, 16, 32.
+- fsl,adc-hw-aver-en: Bool type to decide enable hardware average function.
+- fsl,adc-low-power-mode: Bool type to decide enable ADC low power mode.
+- fsl,adc-high-speed-conv: Bool type to decide enable ADC high speed mode.
+- vref: The regulator to support ADC refrence voltage.
+
+Example:
+adc0: adc@4003b000 {
+	compatible = "fsl,vf610-adc";
+	reg = <0x4003b000 0x1000>;
+	interrupts = <0 53 0x04>;
+	clocks = <&clks VF610_CLK_ADC0>;
+	clock-names = "adc";
+	status = "disabled";
+};
+
+adc1: adc@400bb000 {
+	compatible = "fsl,vf610-adc";
+	reg = <0x400bb000 0x1000>;
+	interrupts = <0 54 0x04>;
+	clocks = <&clks VF610_CLK_ADC1>;
+	clock-names = "adc";
+	status = "disabled";
+};
+
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_ad5>;
+	fsl,adc-io-pinctl = <0x20>;
+	fsl,adc-vref = <3300000>;
+	fsl,adc-clk-div = <2>;
+	fsl,adc-res = <12>;
+	fsl,adc-sam-time = <4>;
+	fsl,adc-aver-sam-sel = <4>;
+	fsl,adc-hw-aver-en;
+	fsl,adc-low-power-mode;
+	status = "okay";
+};
-- 
1.7.2.rc3


