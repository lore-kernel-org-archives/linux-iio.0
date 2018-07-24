Return-Path: <SRS0=XfvJ=KI=gmail.com=marcus.folkesson@kernel.org>
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Date: Tue, 24 Jul 2018 20:30:03 +0200
Message-Id: <20180724183004.20279-2-marcus.folkesson@gmail.com>
In-Reply-To: <20180724183004.20279-1-marcus.folkesson@gmail.com>
References: <20180724183004.20279-1-marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

MCP3911 is a dual channel Analog Front End (AFE) containing two
synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
---

Notes:
    v2:
    	- drop channel width
    	- drop `external_vref`
    	- replace `external-clock` with proper clock bindings

 .../devicetree/bindings/iio/adc/mcp3911.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
new file mode 100644
index 000000000000..af5472f51a84
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
@@ -0,0 +1,28 @@
+* Microchip MCP3911 Dual channel analog front end (ADC)
+
+Required properties:
+ - compatible: Should be "microchip,mcp3911"
+ - reg: SPI chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+	 Documentation/devicetree/bindings/spi/spi-bus.txt.
+	 Max frequency for this chip is 20MHz.
+
+Optional properties:
+ - device-addr: Device address when multiple MCP3911 chips are present on the
+	same SPI bus. Valid values are 0-3. Defaults to 0.
+ - vref-supply: Phandle to the external reference voltage supply.
+ - clocks: Phandle and clock identifier (see clock-names)
+ - clock-names: "adc_clk" for the ADC (sampling) clock
+
+Example:
+adc@0 {
+	compatible = "microchip,mcp3911";
+	reg = <0>;
+	spi-max-frequency = <20000000>;
+	device-addr = <0>;
+	vref-supply = <&vref_reg>;
+	clocks = <&xtal>;
+	clock-names = "adc_clk";
+};
-- 
2.11.0.rc2
