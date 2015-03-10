Return-Path: <san@rosetechnology.dk>
Message-ID: <1426022097.5476.39.camel@sanws1.rosetechnology.dk>
Subject: [patch 2/2] dt-bindings Help for MCP ADCs
From: =?ISO-8859-1?Q?S=F8ren?= Andersen <san@rosetechnology.dk>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 10 Mar 2015 22:14:57 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
Documentation/devicetree/bindings/iio/adc/mcp320x.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
new file mode 100644
index 0000000..b851843
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
@@ -0,0 +1,30 @@
+* Microchip Analog to Digital Converter (ADC)
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in
+
+        Documentation/devicetree/bindings/spi/spi-bus.txt
+
+must be specified.
+
+Required properties:
+	- compatible:  	Must be one of the following, depending on the
+			model:
+				"mcp3001"
+				"mcp3002"
+				"mcp3004"
+				"mcp3008"
+				"mcp3201"
+				"mcp3202"
+				"mcp3204"
+				"mcp3208"
+
+
+Examples:
+spi_controller {
+	mcp3x0x@0 {
+		compatible = "mcp3002";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
