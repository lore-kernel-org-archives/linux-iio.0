Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2on0056.outbound.protection.outlook.com ([65.55.169.56]:48960
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752076AbbJMJxi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 13 Oct 2015 05:53:38 -0400
From: Paul Cercueil <paul.cercueil@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antonio Fiol <antonio@fiol.es>,
	"Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Ian Campbell" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>,
	Paul Cercueil <paul.cercueil@analog.com>
Subject: [PATCHv2 1/2] Documentation: ad5592r: Added devicetree bindings documentation
Date: Tue, 13 Oct 2015 11:37:59 +0200
Message-ID: <1444729080-9937-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5592r.txt        | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5592r.txt

 v2: Fix indentation issue

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5592r.txt b/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
new file mode 100644
index 0000000..12b8d0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
@@ -0,0 +1,43 @@
+Analog Devices AD5592R/AD5593R DAC/ADC device driver
+
+Required properties for the AD5592R:
+	- compatible: Must be "adi,ad5592r"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 30000000)
+	- spi-cpol: The AD5592R requires inverse clock polarity (CPOL) mode
+
+Required properties for the AD5593R:
+	- compatible: Must be "adi,ad5593r"
+	- reg: I2C address of the device
+
+Required properties for all supported chips:
+	- channel-modes: An array of eight 8-bit values (one per channel)
+	  describing the mode of each channel. Macros specifying the valid values
+	  can be found in <dt-bindings/iio/adi,ad5592r.h>.
+	  The following values are currently supported:
+		* CH_MODE_UNUSED (the pin is pulled down)
+		* CH_MODE_DAC
+		* CH_MODE_ADC
+		* CH_MODE_GPIO_TRISTATE
+
+Example:
+
+	#include <dt-bindings/iio/adi,ad5592r.h>
+
+	ad5592r@0 {
+		compatible = "adi,ad5592r";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+
+		channel-modes = /bits/ 8 <
+			CH_MODE_DAC
+			CH_MODE_ADC
+			CH_MODE_ADC
+			CH_MODE_UNUSED
+			CH_MODE_UNUSED
+			CH_MODE_UNUSED
+			CH_MODE_UNUSED
+			CH_MODE_UNUSED
+		>;
+	};
-- 
2.6.1

