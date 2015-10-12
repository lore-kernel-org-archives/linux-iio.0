Return-Path: <Paul.Cercueil@analog.com>
From: Paul Cercueil <paul.cercueil@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald
	<pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Paul Cercueil <paul.cercueil@analog.com>
Subject: [PATCHv2 1/3] Documentation: ad5064: Added devicetree bindings documentation
Date: Mon, 12 Oct 2015 13:50:32 +0200
Message-ID: <1444650634-12025-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5064.txt         | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5064.txt

 v2: No change in this patch

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5064.txt b/Documentation/devicetree/bindings/iio/dac/ad5064.txt
new file mode 100644
index 0000000..fa2d328
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5064.txt
@@ -0,0 +1,48 @@
+Analog Devices AD5064 DAC device driver
+
+Required properties:
+	- compatible: Must be one of:
+		* "adi,ad5024"
+		* "adi,ad5025"
+		* "adi,ad5044"
+		* "adi,ad5045"
+		* "adi,ad5064"
+		* "adi,ad5064-1"
+		* "adi,ad5065"
+		* "adi,ad5628-1"
+		* "adi,ad5628-2"
+		* "adi,ad5648-1"
+		* "adi,ad5648-2"
+		* "adi,ad5666-1"
+		* "adi,ad5666-2"
+		* "adi,ad5668-1"
+		* "adi,ad5668-2"
+		* "adi,ad5668-3"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 30000000)
+	- vrefA-supply, vrefB-supply: phandles to external reference voltage
+	  supplies for channels 0 and 1 respectively.
+	  This property must be present for ad5024, ad5025, ad5044, ad5045,
+	  ad5064, ad5065.
+	- vrefC-supply, vrefD-supply: phandles to external reference voltage
+	  supplies for channels 2 and 3 respectively.
+	  This property must be present for ad5024, ad5044, ad5064.
+
+Optional properties:
+	- vref-supply: phandle to the external reference voltage supply.
+	  This should only be set if there is an external reference voltage
+	  connected to the vref or vref[A-D] pins.
+	  If the property is not set, the internal reference voltage supply
+	  is used if present.
+	  This property can be used with ad5064-1, ad5628-1, ad5628-2, ad5648-1,
+	  ad5648-2, ad5666-1, ad5666-2, ad5668-1, ad5668-2, ad5668-3.
+
+Example:
+
+		ad5668-2@4 {
+			compatible = "adi,ad5668-2";
+			reg = <4>;
+			spi-max-frequency = <10000000>;
+			adi,use-external-reference;
+			vref-supply = <&vref_supply>;
+		};
-- 
2.5.3
