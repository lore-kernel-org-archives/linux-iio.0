Return-Path: <SRS0=5EMa=NZ=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
	<gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stefan.popa@analog.com>
Subject: [PATCH v5 4/4] dt-bindings: iio: adc: Add docs for ad7124
Date: Tue, 13 Nov 2018 13:22:18 +0200
Message-ID: <1542108138-3711-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Add support for Analog Devices AD7124 4-channels and 8-channels ADC.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Nothing changed.
Changes in v3:
	- Removed the "adi,channels" property.
	- Used the "reg" property to get the channel number and "adi,diff-channels"
	  for the differential pins. The "adi,channel-number" property was removed.
	- adi,bipolar is of boolean type.
Changes in v4:
	- Used the bipolar and diff-channels properties defined in the new adc.txt doc.
Changes in v5:
	- Removed the gain and odr properties from the example.

 .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 75 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
new file mode 100644
index 0000000..416273d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
@@ -0,0 +1,75 @@
+Analog Devices AD7124 ADC device driver
+
+Required properties for the AD7124:
+	- compatible: Must be one of "adi,ad7124-4" or "adi,ad7124-8"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use
+		see: Documentation/devicetree/bindings/spi/spi-bus.txt
+	- clocks: phandle to the master clock (mclk)
+		see: Documentation/devicetree/bindings/clock/clock-bindings.txt
+	- clock-names: Must be "mclk".
+	- interrupts: IRQ line for the ADC
+		see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+	  Required properties:
+		* #address-cells: Must be 1.
+		* #size-cells: Must be 0.
+
+	  Subnode(s) represent the external channels which are connected to the ADC.
+	  Each subnode represents one channel and has the following properties:
+		Required properties:
+			* reg: The channel number. It can have up to 4 channels on ad7124-4
+			  and 8 channels on ad7124-8, numbered from 0 to 15.
+			* diff-channels: see: Documentation/devicetree/bindings/iio/adc/adc.txt
+
+		Optional properties:
+			* bipolar: see: Documentation/devicetree/bindings/iio/adc/adc.txt
+			* adi,reference-select: Select the reference source to use when
+			  converting on the the specific channel. Valid values are:
+			  0: REFIN1(+)/REFIN1(−).
+			  1: REFIN2(+)/REFIN2(−).
+			  3: AVDD
+			  If this field is left empty, internal reference is selected.
+
+Optional properties:
+	- refin1-supply: refin1 supply can be used as reference for conversion.
+	- refin2-supply: refin2 supply can be used as reference for conversion.
+	- avdd-supply: avdd supply can be used as reference for conversion.
+
+Example:
+	adc@0 {
+		compatible = "adi,ad7124-4";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		interrupts = <25 2>;
+		interrupt-parent = <&gpio>;
+		refin1-supply = <&adc_vref>;
+		clocks = <&ad7124_mclk>;
+		clock-names = "mclk";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 {
+			reg = <0>;
+			diff-channels = <0 1>;
+			adi,reference-select = <0>;
+		};
+
+		channel@1 {
+			reg = <1>;
+			bipolar;
+			diff-channels = <2 3>;
+			adi,reference-select = <0>;
+		};
+
+		channel@2 {
+			reg = <2>;
+			diff-channels = <4 5>;
+		};
+
+		channel@3 {
+			reg = <3>;
+			diff-channels = <6 7>;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a1bfcb..f2fa508 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7124.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4
