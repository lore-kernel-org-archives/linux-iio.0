Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:20608
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbeIDSjt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Sep 2018 14:39:49 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <mark.rutland@arm.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 3/3] dt-bindings: adxl372: Document the adxl372 I2C bindings
Date: Tue, 4 Sep 2018 17:13:14 +0300
Message-ID: <1536070394-5679-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The adxl372 is designed to communicate in either SPI or I2C protocol.
This patch adds the documentation of device tree bindings for adxl372
I2C.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 Documentation/devicetree/bindings/iio/accel/adxl372.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
index 9409984..a289964 100644
--- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -4,14 +4,25 @@ http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
 
 Required properties:
  - compatible : should be "adi,adxl372"
- - reg: SPI chip select number for the device
+ - reg: the I2C address or SPI chip select number for the device
+
+Required properties for SPI bus usage:
  - spi-max-frequency: Max SPI frequency to use
 
 Optional properties:
  - interrupts: interrupt mapping for IRQ as documented in
    Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
-Example:
+Example for a I2C device node:
+
+	accelerometer@53 {
+		compatible = "adi,adxl372";
+		reg = <0x53>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+Example for a SPI device node:
 
 	accelerometer@0 {
 		compatible = "adi,adxl372";
-- 
2.7.4
