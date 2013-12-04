Return-Path: <fugang.duan@freescale.com>
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>
CC: <shawn.guo@linaro.org>, <b20596@freescale.com>, <mark.rutland@arm.com>,
	<otavio@ossystems.com.br>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v4 3/3] Documentation: add the binding file for Freescale vf610 ADC driver
Date: Wed, 4 Dec 2013 18:00:03 +0800
Message-ID: <1386151203-29728-4-git-send-email-B38611@freescale.com>
In-Reply-To: <1386151203-29728-1-git-send-email-B38611@freescale.com>
References: <1386151203-29728-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The patch adds the binding file for Freescale vf610 ADC driver.

CC: Shawn Guo <shawn.guo@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Otavio Salvador <otavio@ossystems.com.br>
CC: Peter Meerwald <pmeerw@pmeerw.net>
CC: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   42 ++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
new file mode 100644
index 0000000..32ae3bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
@@ -0,0 +1,42 @@
+Freescale vf610 Analog to Digital Converter bindings
+
+The devicetree bindings are for the new ADC driver written for
+vf610/i.MX6slx and upward SoCs from Freescale.
+
+Required properties:
+- compatible: Should contain "fsl,vf610-adc"
+- reg: Offset and length of the register set for the device
+- interrupts: Should contain the interrupt for the device
+- clocks: The clock is needed by the ADC controller, ADC clock source is ipg clock.
+- vref-supply: The regulator supply ADC refrence voltage.
+
+Optional properties:
+- fsl,adc-io-pinctl: Enable field for the I/O port control of MCU pins used as analog inputs.
+		     Bit[23:0] correspond to 23 I/O ports, set the relative bit for pointed port.
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
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
+};
-- 
1.7.2.rc3
