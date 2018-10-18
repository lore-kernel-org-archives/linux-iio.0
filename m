Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr710045.outbound.protection.outlook.com ([40.107.71.45]:56224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbeJRTGn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Oct 2018 15:06:43 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: adc: Add docs for ad7124
Date: Thu, 18 Oct 2018 14:05:39 +0300
Message-ID: <1539860739-3416-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for Analog Devices AD7124 4-channels and 8-channels ADC.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 96 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
new file mode 100644
index 0000000..77a7b92
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
@@ -0,0 +1,96 @@
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
+	- adi,channels: List of external channels connected to the ADC:
+	  Required properties:
+		* #address-cells: Must be 2.
+		* #size-cells: Must be 0.
+
+	  The child nodes of this node represent the external channels which are
+	  connected to the ADC.
+
+	  Each child node represents one channel and has the following
+	  properties:
+		Required properties:
+			* reg: Pins the channel is connected to. The first value specifies
+			  the positive input pin, the second value the negative input pin.
+			* adi,channel-number: It can have up to 4 channels on ad7124-4 and
+			  8 channels on ad7124-8, numbered from 0 to 15.
+
+		Optional properties:
+			* adi,bipolar: If set the channel is used in bipolar mode.
+			* adi,reference-select: Select the reference source to use when
+			  converting on the the specific channel. Valid values are:
+			  0: REFIN1(+)/REFIN1(−).
+			  1: REFIN2(+)/REFIN2(−).
+			  3: AVDD
+			  If this field is left empty, internal reference is selected.
+			* adi,gain: Select the gain when converting on the specific channel.
+			  Valid values are: 1, 2, 4, 8, 16, 32, 64, 128.
+			  If this field is left empty, gain of 1 is selected.
+			* adi,odr-hz: The output data rate can be programmed from:
+			  9 to 19200 for full power mode (when the master clock is 614.4 kHz)
+			  2 to 4800 for mid power mode (when the master clock is 153.6 kHz)
+			  1 to 2400 for low power mode (when the master clock is 76.8 kHz)
+			  If this field is left empty, odr of 9 is selected.
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
+		adi,channels {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			channel@0 {
+				reg = <0 1>;
+				adi,channel-number = <0>;
+				adi,reference-select = <0>;
+				adi,gain = <2>;
+				adi,odr-hz = <10>;
+			};
+
+			channel@1 {
+				reg = <2 3>;
+				adi,bipolar;
+				adi,channel-number = <1>;
+				adi,reference-select = <0>;
+				adi,gain = <4>;
+				adi,odr-hz = <50>;
+			};
+
+			channel@2 {
+				reg = <4 5>;
+				adi,channel-number = <2>;
+				adi,gain = <128>;
+				adi,odr-hz = <19200>;
+			};
+
+			channel@3 {
+				reg = <6 7>;
+				adi,channel-number = <3>;
+			};
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
