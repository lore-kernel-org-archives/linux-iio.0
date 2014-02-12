Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:52065
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751153AbaBLMDM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2014 07:03:12 -0500
From: Paul Cercueil <paul.cercueil@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	Paul Cercueil <paul.cercueil@analog.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 3/3] devicetree: ad5064: Added devicetree bindings documentation
Date: Wed, 12 Feb 2014 13:01:58 +0100
Message-ID: <1392206518-1457-3-git-send-email-paul.cercueil@analog.com>
In-Reply-To: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com>
References: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/iio/dac/ad5064.txt         |   49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5064.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5064.txt b/Documentation/devicetree/bindings/iio/dac/ad5064.txt
new file mode 100644
index 0000000..e5997b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5064.txt
@@ -0,0 +1,49 @@
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
+	- adi,use-external-reference: If set, the external reference voltage
+	  supply is used. This should only be set if there is an external
+	  reference voltage connected to the vref or vref[A-D] pins.
+	  If the property is not set, the internal reference voltage supply
+	  is used if present, or an error is issued by the driver.
+	- vref-supply: phandle to the external reference voltage supply.
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
1.7.10.4


