Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:56059 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932825AbdHVNe7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2017 09:34:59 -0400
Message-Id: <87644503b0397248c06fbe0058f292955dd10f79.1503407738.git.lukas@wunner.de>
In-Reply-To: <cover.1503407738.git.lukas@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 22 Aug 2017 15:33:00 +0200
Subject: [PATCH 5/6] dt-bindings: iio: adc: mcp320x: Update for mcp3550/1/3
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All chips supported by this driver clock data out on the falling edge
and latch data in on the rising edge, hence SPI mode (0,0) or (1,1)
must be used.

Furthermore, none of the chips has an internal reference voltage
regulator, so an external supply is always required and needs to be
specified in the device tree lest the IIO "scale" in sysfs cannot be
calculated.

Document these requirements in the device tree binding, together with
the new "microchip,continuous-conversion" property added specifically
for the mcp3550/1/3.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 .../devicetree/bindings/iio/adc/mcp320x.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
index bcd3ac8e6e0c..cf28af9ec0ac 100644
--- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
@@ -29,15 +29,38 @@ Required properties:
 				"microchip,mcp3204"
 				"microchip,mcp3208"
 				"microchip,mcp3301"
+				"microchip,mcp3550-50"
+				"microchip,mcp3550-60"
+				"microchip,mcp3551"
+				"microchip,mcp3553"
 
 			NOTE: The use of the compatibles with no vendor prefix
 			is deprecated and only listed because old DT use them.
 
+	- spi-cpha, spi-cpol (boolean):
+			Either SPI mode (0,0) or (1,1) must be used, so specify
+			none or both of spi-cpha, spi-cpol.  The MCP3550/1/3
+			is more efficient in mode (1,1) as only 3 instead of
+			4 bytes need to be read from the ADC, but not all SPI
+			masters support it.
+
+	- vref-supply:	Phandle to the external reference voltage supply.
+
+Optional properties:
+	- microchip,continuous-conversion (boolean):
+			Only applicable to MCP3550/1/3:  These ADCs have long
+			conversion times and therefore support "continuous
+			conversion mode" to allow retrieval of conversions
+			at any time without observing a delay.  The mode is
+			enabled by permanently driving CS low, e.g. by wiring
+			it to ground.
+
 Examples:
 spi_controller {
 	mcp3x0x@0 {
 		compatible = "mcp3002";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
+		vref-supply = <&vref_reg>;
 	};
 };
-- 
2.11.0

