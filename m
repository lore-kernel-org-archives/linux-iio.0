Return-Path: <SRS0=wWyX=JU=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <mchehab@kernel.org>, <davem@davemloft.net>,
	<gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
	<linus.walleij@linaro.org>, <rdunlap@infradead.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v5 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Date: Wed, 4 Jul 2018 17:32:53 +0300
Message-ID: <1530714773-18956-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v5:
	- used a dac@0 as a more generic node name instead of ad5758@0.
Changes in v4:
	- Nothing changed, just to follow the patch set version.
Changes in v3:
	- AD5758 can be both a current and voltage output DAC. The
	  decision is made based on the DT and the channel type is set
	  during probe.
	- range was replaced by range-microvolt and range-microamp
	- dc-dc-mode, range-microvolt and range-microamp are required
	  properties.
	- Introduced a slew-time-us property from which slew rate clock
	  and slew rate step are calculated using a best match algorithm.
	- Added units in the name of the properties.
	- Offered more explanation for the various modes of operation.

Changes in v2:
	- Nothing changed, just to follow the patch set version.

 .../devicetree/bindings/iio/dac/ad5758.txt         | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
new file mode 100644
index 0000000..90bc496
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
@@ -0,0 +1,73 @@
+Analog Devices AD5758 DAC device driver
+
+Required properties for the AD5758:
+	- compatible: Must be "adi,ad5758"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 50000000)
+	- spi-cpha: is the only mode that is supported
+
+Required properties:
+
+ - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
+ 		   Dynamic Power Control (DPC)
+		   In this mode, the AD5758 circuitry senses the output voltage and
+		   dynamically regulates the supply voltage, VDPC+, to meet compliance
+		   requirements plus an optimized headroom voltage for the output buffer.
+
+		   Programmable Power Control (PPC)
+		   In this mode, the VDPC+ voltage is user-programmable to a fixed level
+		   that needs to accommodate the maximum output load required.
+
+		   The output of the DAC core is either converted to a current or voltage
+		   output at the VIOUT pin. Only one mode can be enabled at any one time.
+
+		   The following values are currently supported:
+			* 1: DPC current mode
+			* 2: DPC voltage mode
+			* 3: PPC current mode
+
+ Depending on the selected output mode (voltage or current) one of the two properties must
+ be present:
+
+ - adi,range-microvolt: Voltage output range
+ 		The array of voltage output ranges must contain two fields:
+	      	* <0 5000000>: 0 V to 5 V voltage range
+		* <0 10000000>: 0 V to 10 V voltage range
+		* <(-5000000) 5000000>: ±5 V voltage range
+		* <(-10000000) 10000000>: ±10 V voltage range
+ - adi,range-microamp: Current output range
+ 		The array of current output ranges must contain two fields:
+		* <0 20000>: 0 mA to 20 mA current range
+		* <0 24000>: 0 mA to 24 mA current range
+		* <4 24000>: 4 mA to 20 mA current range
+		* <(-20000) 20000>: ±20 mA current range
+		* <(-24000) 24000>: ±24 mA current range
+		* <(-1000) 22000>: −1 mA to +22 mA current range
+
+Optional properties:
+
+ - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
+		   The following values are currently supported [uA]:
+		   	* 150000
+			* 200000
+			* 250000
+			* 300000
+			* 350000
+			* 400000
+
+ - adi,slew-time-us: The time it takes for the output to reach the full scale [uS]
+ 		     The supported range is between 133us up to 1023984375us
+
+AD5758 Example:
+
+	dac@0 {
+		compatible = "adi,ad5758";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpha;
+
+		adi,dc-dc-mode = <2>;
+		adi,range-microvolt = <0 10000000>;
+		adi,dc-dc-ilim-microamp = <200000>;
+		adi,slew-time-us = <125000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 12d102d..60b1028 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/dac/ad5758.c
+F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.7.4
