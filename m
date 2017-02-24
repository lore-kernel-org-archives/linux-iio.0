Return-Path: <SRS0=fWxU=2F=jmondi.org=jacopo+renesas@kernel.org>
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com,
	magnus.damm@gmail.com,
	laurent.pinchart@ideasonboard.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	meerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/4] Documentation: dt-bindings: iio: Add max961x
Date: Fri, 24 Feb 2017 16:05:53 +0100
Message-Id: <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
List-ID: <linux-iio@vger.kernel.org>

Add device tree bindings documentation for Maxim max961x current sense
amplifier.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../devicetree/bindings/iio/adc/max961x.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max961x.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/max961x.txt b/Documentation/devicetree/bindings/iio/adc/max961x.txt
new file mode 100644
index 0000000..abbc6c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/max961x.txt
@@ -0,0 +1,27 @@
+* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
+
+Maxim max9611/max9612 is an high-side current sense amplifier with integrated
+12-bits ADC communicating over I2c bus.
+The device node for this driver shall be a child of a I2c controller.
+
+Required properties
+  - compatible: Should be "maxim,max961x"
+  - reg: The 7-bits long I2c address of the device
+  - shunt-resistor: Resistor value, in uOhm, of the current sense shunt
+		    resistor.
+
+Example:
+
+&i2c4 {
+	csa: max9611@7c {
+		compatible = "maxim,max961x";
+		reg = <0x7c>;
+
+		shunt-resistor = <5000>;
+	};
+};
+
+This device node describes a current sense amplifier sitting on I2c4 bus
+with address 0x7c (read address is 0xf9, write address is 0xf8).
+A sense resistor with 0,005 Ohm is installed between RS+ and RS-
+current-sensing inputs.
-- 
2.7.4
