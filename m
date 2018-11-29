Return-Path: <SRS0=zbk+=OJ=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Date: Thu, 29 Nov 2018 18:57:43 +0200
Message-ID: <1543510663-14921-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Document support for AD7606 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- fixed indentation issues.
	- used gpios instead of gpio.
	- added vendor prefix for conversion-start-gpios, first-data-gpios,
	and range-gpios.
Changes in v3:
	- Added adi,oversampling-ratio-gpios.

 .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
new file mode 100644
index 0000000..02fae23
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
@@ -0,0 +1,54 @@
+Analog Devices AD7606 Simultaneous Sampling ADC
+
+Required properties for the AD7606:
+
+- compatible: Must be one of
+	* "adi,ad7605-4"
+	* "adi,ad7606-8"
+	* "adi,ad7606-6"
+	* "adi,ad7606-4"
+- reg: SPI chip select number for the device
+- spi-max-frequency: Max SPI frequency to use
+	see: Documentation/devicetree/bindings/spi/spi-bus.txt
+- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
+- avcc-supply: phandle to the Avcc power supply
+- interrupts: IRQ line for the ADC
+	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+- adi,conversion-start-gpios: must be the device tree identifier of the CONVST pin.
+		  This logic input is used to initiate conversions on the analog
+		  input channels.
+
+Optional properties:
+
+- reset-gpios: must be the device tree identifier of the RESET pin. If specified,
+	       it will be asserted during driver probe.
+- standby-gpios: must be the device tree identifier of the STBY pin. This pin is used
+		to place the AD7606 into one of two power-down modes, Standby mode or
+		Shutdown mode.
+- adi,first-data-gpios: must be the device tree identifier of the FRSTDATA pin.
+		    The FRSTDATA output indicates when the first channel, V1, is
+		    being read back on either the parallel, byte or serial interface.
+- adi,range-gpios: must be the device tree identifier of the RANGE pin. The polarity on
+	      this pin determines the input range of the analog input channels. If
+	      this pin is tied to a logic high, the analog input range is ±10V for
+	      all channels. If this pin is tied to a logic low, the analog input range
+	      is ±5V for all channels.
+
+Example:
+
+	adc@0 {
+		compatible = "adi,ad7606-8";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+
+		avcc-supply = <&adc_vref>;
+
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpio>;
+
+		adi,conversion-start-gpios = <&gpio 17 0>;
+		reset-gpios = <&gpio 27 0>;
+		adi,first-data-gpios = <&gpio 22 0>;
+		standby-gpios = <&gpio 24 0>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 843545d..6d63db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
+F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4
