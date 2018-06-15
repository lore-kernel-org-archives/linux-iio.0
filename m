Return-Path: <SRS0=5rWN=JB=linaro.org=baolin.wang@kernel.org>
From: Baolin Wang <baolin.wang@linaro.org>
To: jic23@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: baolin.wang@linaro.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	freeman.liu@spreadtrum.com,
	broonie@kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: Add Spreadtrum SC27XX PMICs ADC controller documentation
Date: Fri, 15 Jun 2018 15:03:35 +0800
Message-Id: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This patch adds the binding documentation for Spreadtrum SC27XX series
PMICs ADC controller device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - No updates.
---
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
new file mode 100644
index 0000000..8aad960
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
@@ -0,0 +1,36 @@
+Spreadtrum SC27XX series PMICs ADC binding
+
+Required properties:
+- compatible: Should be one of the following.
+	"sprd,sc2720-adc"
+	"sprd,sc2721-adc"
+	"sprd,sc2723-adc"
+	"sprd,sc2730-adc"
+	"sprd,sc2731-adc"
+- reg: The address offset of ADC controller.
+- interrupt-parent: The interrupt controller.
+- interrupts: The interrupt number for the ADC device.
+- #io-channel-cells: Number of cells in an IIO specifier.
+- hwlocks: Reference to a phandle of a hwlock provider node.
+
+Example:
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmic_adc: adc@480 {
+			compatible = "sprd,sc2731-adc";
+			reg = <0x480>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			hwlocks = <&hwlock 4>;
+		};
+	};
-- 
1.7.9.5
