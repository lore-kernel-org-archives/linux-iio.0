Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:34849 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdIEJ1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2017 05:27:05 -0400
Message-Id: <cceeb1a985343d36dc90d2708371f3e1a73264f6.1504602350.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 5 Sep 2017 11:27:00 +0200
Subject: [PATCH 1/2] dt-bindings: iio: dac: ti-dac082s085: Document new driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        "Andrew F. Davis" <afd@ti.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree bindings for Texas Instruments 8/10/12-bit 2/4-channel
DAC driver.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 .../devicetree/bindings/iio/dac/ti-dac082s085.txt  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt b/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
new file mode 100644
index 000000000000..9cb0e10df704
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
@@ -0,0 +1,34 @@
+Texas Instruments 8/10/12-bit 2/4-channel DAC driver
+
+Required properties:
+ - compatible:		Must be one of:
+			"ti,dac082s085"
+			"ti,dac102s085"
+			"ti,dac122s085"
+			"ti,dac084s085"
+			"ti,dac104s085"
+			"ti,dac124s085"
+ - reg: 		Chip select number.
+ - spi-cpha, spi-cpol:	SPI mode (0,1) or (1,0) must be used, so specify
+			either spi-cpha or spi-cpol (but not both).
+ - vref-supply: 	Phandle to the external reference voltage supply.
+
+For other required and optional properties of SPI slave nodes please refer to
+../../spi/spi-bus.txt.
+
+Example:
+	vref_2v5_reg: regulator-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
+
+	dac@0 {
+		compatible = "ti,dac082s085";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		spi-cpol;
+		vref-supply = <&vref_2v5_reg>;
+	};
-- 
2.11.0

