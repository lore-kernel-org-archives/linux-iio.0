Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:3913
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752190Ab3KYJ7L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 04:59:11 -0500
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>, <sachin.kamat@linaro.org>
CC: <shawn.guo@linaro.org>, <b20596@freescale.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v1 3/3] Documentation: add the binding file for Freescale (Vybrid/IMX) ADC driver
Date: Mon, 25 Nov 2013 17:34:31 +0800
Message-ID: <1385372071-5108-4-git-send-email-B38611@freescale.com>
In-Reply-To: <1385372071-5108-1-git-send-email-B38611@freescale.com>
References: <1385372071-5108-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch adds the binding file for Freescale (Vybrid/IMX) ADC driver.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   57 ++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
new file mode 100644
index 0000000..7a5b53e
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
+  (* the future expander for i.MX6slx, i.MX7 will be "fsl,imx-adc")
+- reg: Offset and length of the register set for the device
+- interrupts: Should contain the interrupt for the device
+- clocks: The clocks needed by the ADC controller
+- clock-names: the name of the clocks
+
+Optional properties:
+- imx,adc-io-pinctl: Enable field for the I/O port control of MCU pins used as analog inputs.
+- imx,adc-vref: ADC refrence voltage value, unit is uV.
+- imx,adc-clk-div: Current clock divider value, such as 1,2,4,8,16 and so on.
+- imx,adc-res: ADC conversion mode selection, such as 8 for 8-bit, 10 for 10-bit, 12 for 12-bit mode.
+- imx,adc-sam-time: ADC sample time duration, number of ADC clocks, such as 2, 4, 6, 8, 12, 16, 20, 24
+- imx,adc-aver-sam-sel: Determines how many ADC conversions will be averaged to create the ADC average result.
+			The Optional value is 4, 8, 16, 32.
+- imx,adc-hw-aver-en: Bool type to decide enable hardware average function.
+- imx,adc-low-power-mode: Bool type to decide enable ADC low power mode.
+- imx,adc-high-speed-conv: Bool type to decide enable ADC high speed mode.
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
+	imx,adc-io-pinctl = <0x20>;
+	imx,adc-vref = <3300000>;
+	imx,adc-clk-div = <2>;
+	imx,adc-res = <12>;
+	imx,adc-sam-time = <4>;
+	imx,adc-aver-sam-sel = <4>;
+	imx,adc-hw-aver-en;
+	imx,adc-low-power-mode;
+	status = "okay";
+};
-- 
1.7.2.rc3


