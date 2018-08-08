Return-Path: <SRS0=k49u=KX=gmail.com=marcus.folkesson@kernel.org>
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Date: Wed,  8 Aug 2018 10:09:16 +0200
Message-Id: <20180808080917.2427-2-marcus.folkesson@gmail.com>
In-Reply-To: <20180808080917.2427-1-marcus.folkesson@gmail.com>
References: <20180808080917.2427-1-marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

MCP3911 is a dual channel Analog Front End (AFE) containing two
synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).

Co-Developed-by: Kent Gustavsson <kent@minoris.se>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v4:
    	- remove reference to Documentation/.../interrupts.txt
    	- add Kent as co-developer
    v3:
    	- add bindings for interrupt
    	- prefix device-addr with `microchip`
    	- drop `clock-names`
    v2:
    	- drop channel width
    	- drop `external_vref`
    	- replace `external-clock` with proper clock bindings

 .../devicetree/bindings/iio/adc/mcp3911.txt        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
new file mode 100644
index 000000000000..3071f48fb30b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
@@ -0,0 +1,30 @@
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
+ - clocks: Phandle and clock identifier for sampling clock
+ - interrupt-parent: Phandle to the parent interrupt controller
+ - interrupts: IRQ line for the ADC
+ - microchip,device-addr: Device address when multiple MCP3911 chips are present on the
+	same SPI bus. Valid values are 0-3. Defaults to 0.
+ - vref-supply: Phandle to the external reference voltage supply.
+
+Example:
+adc@0 {
+	compatible = "microchip,mcp3911";
+	reg = <0>;
+	interrupt-parent = <&gpio5>;
+	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+	spi-max-frequency = <20000000>;
+	microchip,device-addr = <0>;
+	vref-supply = <&vref_reg>;
+	clocks = <&xtal>;
+};
-- 
2.11.0.rc2
