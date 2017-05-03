Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:55828 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751789AbdECMCT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 May 2017 08:02:19 -0400
From: =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: add driver for the ti-adc084s021 chip
Date: Wed,  3 May 2017 14:01:44 +0200
Message-Id: <1493812905-28904-2-git-send-email-marten.lindahl@axis.com>
In-Reply-To: <1493812905-28904-1-git-send-email-marten.lindahl@axis.com>
References: <1493812905-28904-1-git-send-email-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Mårten Lindahl <martenli@axis.com>

This adds support for the Texas Instruments ADC084S021 ADC chip.

Signed-off-by: Mårten Lindahl <martenli@axis.com>
---
Changes in v3:
- No updates since v2

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

