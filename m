Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0044.outbound.protection.outlook.com ([104.47.40.44]:47327
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751590AbeFENxm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jun 2018 09:53:42 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Date: Tue, 5 Jun 2018 16:53:18 +0300
Message-ID: <1528206798-14095-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5758.txt         | 84 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
new file mode 100644
index 0000000..75fff6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
@@ -0,0 +1,84 @@
+Analog Devices AD5758 DAC device driver
+
+Required properties for the AD5758:
+	- compatible: Must be "adi,ad5758"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 50000000)
+	- spi-cpha: is the only mode that is supported
+
+Optional properties:
+
+ - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
+		   The following values are currently supported:
+		   	* 0: DC-to-DC converter powered off
+			* 1: DPC current mode
+			* 2: DPC voltage mode
+			* 3: PPC current mode
+
+ - adi,dc-dc-ilim: The dc-to-dc converter current limit
+		   The following values are currently supported [mA]:
+		   	* 150
+			* 200
+			* 250
+			* 300
+			* 350
+			* 400
+
+ - adi,slew: Array of slewrate settings should contain 3 fields:
+	1: Should be either 0 or 1 in order to enable or disable slewrate.
+	2: Slew rate clock:
+		Valid values for the slew rate update frequency [Hz]:
+		* 240000
+		* 200000
+		* 150000
+		* 128000
+		* 64000
+		* 32000
+		* 16000
+		* 8000
+		* 4000
+		* 2000
+		* 1000
+		* 512
+		* 256
+		* 128
+		* 64
+		* 16
+	3: Slew rate step:
+		Defines by how much the output value changes at each update.
+		Valid values for the step size LSBs:
+		* 4
+		* 12
+		* 64
+		* 120
+		* 256
+		* 500
+		* 1820
+		* 2048
+
+ - adi,range: The output range
+	      The following values are currently supported:
+	      	* 0: 0 V to 5 V voltage range
+		* 1: 0 V to 10 V voltage range
+		* 2: ±5 V voltage range
+		* 3: ±10 V voltage range
+		* 8: 0 mA to 20 mA current range
+		* 9: 0 mA to 24 mA current range
+		* 10: 4 mA to 20 mA current range
+		* 11: ±20 mA current range
+		* 12: ±24 mA current range
+		* 13: −1 mA to +22 mA current range
+
+AD5758 Example:
+
+	ad5758@0 {
+		compatible = "adi,ad5758";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpha;
+
+		adi,dc-dc-mode = <2>;
+		adi,dc-dc-ilim = <200>;
+		adi,slew = <1 200000 12>;
+		adi,range = <1>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1993779..f640146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -808,6 +808,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/dac/ad5758.c
+F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

