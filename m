Return-Path: <SRS0=gxlc=LZ=az8.co=afonsobordado@kernel.org>
From: Afonso Bordado <afonsobordado@az8.co>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 3/5] dt-bindings: fxas21002c: Document the fxas21002c I2C bindings
Date: Tue, 11 Sep 2018 16:00:09 +0100
Message-Id: <20180911150011.31964-3-afonsobordado@az8.co>
In-Reply-To: <20180911150011.31964-1-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
List-ID: <linux-iio@vger.kernel.org>

Add documentation for the fxas21002c I2C bindings.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
new file mode 100644
index 000000000000..9e5cdf0c0b69
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
@@ -0,0 +1,33 @@
+* Freescale FXAS21002C Digital Angular Rate Gyroscope
+
+Required properties:
+
+  - compatible: must be "fsl,fxas21002c"
+  - reg : the I2C address of the sensor
+
+Optional properties:
+
+  - interrupts		: The first interrupt listed must be the one
+			  connected to the INT1 pin, the second interrupt
+			  listed must be the one connected to the INT2 pin.
+			  The interrupts can be triggered on rising or falling
+			  edges alike.
+			  see interrupt-controller/interrupts.txt
+  - vdd-supply		: The main voltage regulator
+  - iovdd-supply	: The IO voltage regulator
+			  see regulator/regulator.txt
+  - reset-gpios		: GPIO used to reset the device.
+			  see gpio/gpio.txt.
+  - mount-matrix	: see iio/mount-matrix.txt
+
+Example:
+gyroscope@20 {
+	compatible = "fsl,fxas21002c";
+	reg = <0x20>;
+	reset-gpios = <&gpio0 2 0>;
+	vdd-supply = <&vref>;
+	iovdd-supply = <&vref2>;
+	interrupt-parent = <&foo>;
+	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
+		     <1 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)>;
+};
-- 
2.18.0
