Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45694 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933818AbdDFQNH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2017 12:13:07 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 1/5] dt-bindings: iio: stm32-dac: Add support for STM32 DAC
Date: Thu, 6 Apr 2017 18:11:52 +0200
Message-ID: <1491495116-7209-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
References: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Document STMicroelectronics STM32 DAC (digital-to-analog converter).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- use 'reg' instead of 'st,dac-channel' property
- remove alignment from description
---
 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
new file mode 100644
index 0000000..bcee71f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
@@ -0,0 +1,61 @@
+STMicroelectronics STM32 DAC
+
+The STM32 DAC is a 12-bit voltage output digital-to-analog converter. The DAC
+may be configured in 8 or 12-bit mode. It has two output channels, each with
+its own converter.
+It has built-in noise and triangle waveform generator and supports external
+triggers for conversions. The DAC's output buffer allows a high drive output
+current.
+
+Contents of a stm32 dac root node:
+-----------------------------------
+Required properties:
+- compatible: Must be "st,stm32h7-dac-core".
+- reg: Offset and length of the device's register set.
+- clocks: Must contain an entry for pclk (which feeds the peripheral bus
+  interface)
+- clock-names: Must be "pclk".
+- vref-supply: Phandle to the vref+ input analog reference supply.
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Optional properties:
+- resets: Must contain the phandle to the reset controller.
+- A pinctrl state named "default" for each DAC channel may be defined to set
+  DAC_OUTx pin in mode of operation for analog output on external pin.
+
+Contents of a stm32 dac child node:
+-----------------------------------
+DAC core node should contain at least one subnode, representing a
+DAC instance/channel available on the machine.
+
+Required properties:
+- compatible: Must be "st,stm32-dac".
+- reg: Must be either 1 or 2, to define (single) channel in use
+- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
+  Documentation/devicetree/bindings/iio/iio-bindings.txt
+
+Example:
+	dac: dac@40007400 {
+		compatible = "st,stm32h7-dac-core";
+		reg = <0x40007400 0x400>;
+		clocks = <&clk>;
+		clock-names = "pclk";
+		vref-supply = <&reg_vref>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dac_out1 &dac_out2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dac1: dac@1 {
+			compatible = "st,stm32-dac";
+			#io-channels-cells = <1>;
+			reg = <1>;
+		};
+
+		dac2: dac@2 {
+			compatible = "st,stm32-dac";
+			#io-channels-cells = <1>;
+			reg = <2>;
+		};
+	};
-- 
1.9.1

