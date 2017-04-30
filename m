Return-Path: <SRS0=B/yk=4G=axis.com=marten.lindahl@kernel.org>
From: =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	devicetree@vger.kernel.org,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>
Subject: [PATCHv2 1/2] dt-bindings: iio: adc: add driver for the ti-adc084s021 chip
Date: Sun, 30 Apr 2017 14:53:41 +0200
Message-Id: <1493556822-2601-2-git-send-email-marten.lindahl@axis.com>
In-Reply-To: <1493556822-2601-1-git-send-email-marten.lindahl@axis.com>
References: <1493556822-2601-1-git-send-email-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

From: Mårten Lindahl <martenli@axis.com>

This adds support for the Texas Instruments ADC084S021 ADC chip.

Signed-off-by: Mårten Lindahl <martenli@axis.com>
---
Changes in v2:
- Updated the 'Required properties' section
- Removed the 'Optional properties' section

 .../devicetree/bindings/iio/adc/ti-adc084s021.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
new file mode 100644
index 0000000..4259e50
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
@@ -0,0 +1,19 @@
+* Texas Instruments' ADC084S021
+
+Required properties:
+ - compatible        : Must be "ti,adc084s021"
+ - reg               : SPI chip select number for the device
+ - vref-supply       : The regulator supply for ADC reference voltage
+ - spi-cpol          : Per spi-bus bindings
+ - spi-cpha          : Per spi-bus bindings
+ - spi-max-frequency : Per spi-bus bindings
+
+Example:
+adc@0 {
+	compatible = "ti,adc084s021";
+	reg = <0>;
+	vref-supply = <&adc_vref>;
+	spi-cpol;
+	spi-cpha;
+	spi-max-frequency = <16000000>;
+};
-- 
2.1.4
