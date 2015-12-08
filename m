Return-Path: <Haibo.Chen@freescale.com>
From: Haibo Chen <haibo.chen@freescale.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <shawnguo@kernel.org>, <kernel@pengutronix.de>
CC: <haibo.chen@freescale.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/4] Documentation: add the binding file for Freescale imx7d ADC driver
Date: Tue, 8 Dec 2015 18:26:21 +0800
Message-ID: <1449570383-25716-3-git-send-email-haibo.chen@freescale.com>
In-Reply-To: <1449570383-25716-1-git-send-email-haibo.chen@freescale.com>
References: <1449570383-25716-1-git-send-email-haibo.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The patch adds the binding file for Freescale imx7d ADC driver.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/imx7d-adc.txt      | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
new file mode 100644
index 0000000..5c184b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
@@ -0,0 +1,22 @@
+Freescale imx7d ADC bindings
+
+The devicetree bindings are for the ADC driver written for
+imx7d SoC.
+
+Required properties:
+- compatible: Should be "fsl,imx7d-adc"
+- reg: Offset and length of the register set for the ADC device
+- interrupts: The interrupt number for the ADC device
+- clocks: The root clock of the ADC controller
+- clock-names: Must contain "adc", matching entry in the clocks property
+- vref-supply: The regulator supply ADC reference voltage
+
+Example:
+adc1: adc@30610000 {
+	compatible = "fsl,imx7d-adc";
+	reg = <0x30610000 0x10000>;
+	interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
+	clock-names = "adc";
+	vref-supply = <&reg_vcc_3v3_mcu>;
+};
-- 
1.9.1
