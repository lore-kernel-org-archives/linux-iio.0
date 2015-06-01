Return-Path: <vladimir.barinov@cogentembedded.com>
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] dt: Document Holt descrete ADC bindings
Date: Mon,  1 Jun 2015 15:20:52 +0300
Message-Id: <1433161252-22122-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com>
List-ID: <linux-iio@vger.kernel.org>

These bindings can be used to register Holt HI-8435/8436/8437 descrete ADC

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
 .../devicetree/bindings/iio/adc/hi-843x.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/hi-843x.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/hi-843x.txt b/Documentation/devicetree/bindings/iio/adc/hi-843x.txt
new file mode 100644
index 0000000..872e801
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/hi-843x.txt
@@ -0,0 +1,27 @@
+Holt Integrated Circuits HI-8435/8436/8437 discrete ADC bindings
+
+Required properties:
+ - compatible: Should be "holt,hi-8435" or "holt,hi-8436" or "holt,hi-8437"
+ - reg: spi chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+ - holt,mr-gpio: GPIO used for controlling the MR (chip reset) pin
+ - holt,debounce-soft: enable software debounce at startup
+ - holt,debounce-soft-delay: software debounce interval in milliseconds
+
+Example:
+adc@0 {
+	compatible = "holt,hi-8435";
+	reg = <0>;
+
+	holt,mr-gpio = <&gpio6 1 0>;
+
+	holt,debounce-soft;
+	holt,debounce-soft-delay = <100>;
+
+	spi-max-frequency = <1000000>;
+};
-- 
1.9.1
