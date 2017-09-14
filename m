Return-Path: <SRS0=lOB+=AP=aosc.io=icenowy@kernel.org>
From: Icenowy Zheng <icenowy@aosc.io>
To: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 1/6] dt-bindings: update the Allwinner GPADC device tree binding for H3
Date: Thu, 14 Sep 2017 22:52:46 +0800
Message-Id: <20170914145251.21784-2-icenowy@aosc.io>
In-Reply-To: <20170914145251.21784-1-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
List-ID: <linux-iio@vger.kernel.org>

Allwinner H3 features a thermal sensor like the one in A33, but has its
register re-arranged, the clock divider moved to CCU (originally the
clock divider is in ADC) and added a pair of bus clock and reset.

Update the binding document to cover H3.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v4:
- Add nvmem calibration data (not yet used by the driver)
Changes in v3:
- Clock name changes.
- Example node name changes.
- Add interupts (not yet used by the driver).

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 30 ++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
index badff3611a98..6c470d584bf9 100644
--- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
+++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
@@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can also act as a thermal sensor
 and sometimes as a touchscreen controller.
 
 Required properties:
-  - compatible: "allwinner,sun8i-a33-ths",
+  - compatible: must contain one of the following compatibles:
+		- "allwinner,sun8i-a33-ths"
+		- "allwinner,sun8i-h3-ths"
   - reg: mmio address range of the chip,
   - #thermal-sensor-cells: shall be 0,
   - #io-channel-cells: shall be 0,
 
-Example:
+Optional properties:
+  - nvmem-cells: A phandle to the calibration data provided by a nvmem device.
+                 If unspecified default values shall be used.
+  - nvmem-cell-names: Should be "calibration-data"
+
+Required properties for the following compatibles:
+		- "allwinner,sun8i-h3-ths"
+  - clocks: the bus clock and the input clock of the ADC,
+  - clock-names: should be "bus" and "mod",
+  - resets: the bus reset of the ADC,
+  - interrupts: the sampling interrupt of the ADC,
+
+Example for A33:
 	ths: ths@01c25000 {
 		compatible = "allwinner,sun8i-a33-ths";
 		reg = <0x01c25000 0x100>;
@@ -17,6 +31,18 @@ Example:
 		#io-channel-cells = <0>;
 	};
 
+Example for H3:
+	ths: thermal-sensor@1c25000 {
+		compatible = "allwinner,sun8i-h3-ths";
+		reg = <0x01c25000 0x400>;
+		clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+		clock-names = "bus", "mod";
+		resets = <&ccu RST_BUS_THS>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		#thermal-sensor-cells = <0>;
+		#io-channel-cells = <0>;
+	};
+
 sun4i, sun5i and sun6i SoCs are also supported via the older binding:
 
 sun4i resistive touchscreen controller
-- 
2.13.5
