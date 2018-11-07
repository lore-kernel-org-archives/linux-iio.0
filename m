Return-Path: <SRS0=Zge2=NS=denx.de=pn@kernel.org>
From: Parthiban Nallathambi <pn@denx.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	andy.shevchenko@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	devicetree@vger.kernel.org,
	matthias.bgg@gmail.com,
	Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v7 2/2] iio: light: Add device tree binding for vishay vcnl4035
Date: Wed,  7 Nov 2018 18:08:21 +0100
Message-Id: <20181107170821.1171886-2-pn@denx.de>
In-Reply-To: <20181107170821.1171886-1-pn@denx.de>
References: <20181107170821.1171886-1-pn@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Adding device tree binding for vcnl4035 and vendor
prefix for Vishay Intertechnology

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changelog in v4:
    - commit message fix
    - same indexing/space in binding
    
    Changelog in v3:
    - removed interrupt-parent property reference in documentation
    - renamed vcnl4035 to light-sensor

 .../devicetree/bindings/iio/light/vcnl4035.txt | 18 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt    |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
new file mode 100644
index 000000000000..c07c7f052556
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
@@ -0,0 +1,18 @@
+VISHAY VCNL4035 -  Ambient Light and proximity sensor
+
+Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
+
+Required properties:
+
+	-compatible: should be "vishay,vcnl4035"
+	-reg: I2C address of the sensor, should be 0x60
+	-interrupts: interrupt mapping for GPIO IRQ (level active low)
+
+Example:
+
+light-sensor@60 {
+	compatible = "vishay,vcnl4035";
+	reg = <0x60>;
+	interrupt-parent = <&gpio4>;
+	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..3c5e0c6f6cee 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -415,6 +415,7 @@ vamrs	Vamrs Ltd.
 variscite	Variscite Ltd.
 via	VIA Technologies, Inc.
 virtio	Virtual I/O Device Specification, developed by the OASIS consortium
+vishay	Vishay Intertechnology, Inc
 vitesse	Vitesse Semiconductor Corporation
 vivante	Vivante Corporation
 vocore VoCore Studio
-- 
2.17.2
