Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35718 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992692AbdD2Htc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Apr 2017 03:49:32 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: iio: accel: adxl345: Add optional interrupt-names support
Date: Sat, 29 Apr 2017 15:48:58 +0800
Message-Id: <bebc6b7e800964a70ee6812f20ae2fac581bea43.1493450577.git.eraretuya@gmail.com>
In-Reply-To: <cover.1493450577.git.eraretuya@gmail.com>
References: <cover.1493450577.git.eraretuya@gmail.com>
In-Reply-To: <cover.1493450577.git.eraretuya@gmail.com>
References: <cover.1493450577.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add interrupt-names property in order to specify interrupt pin in use.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Change in v2:
* Add Rob's Acked-by tag

 Documentation/devicetree/bindings/iio/accel/adxl345.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl345.txt b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
index e7111b0..a7c9022 100644
--- a/Documentation/devicetree/bindings/iio/accel/adxl345.txt
+++ b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
@@ -15,6 +15,8 @@ Optional properties:
    in Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
  - interrupts: interrupt mapping for IRQ as documented in
    Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+ - interrupt-names: specify INTx pin in use. Should be "INT1" for INT1 pin or
+   "INT2" for INT2 pin.
 
 Example for a I2C device node:
 
@@ -23,6 +25,7 @@ Example for a I2C device node:
 		reg = <0x53>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "INT1";
 	};
 
 Example for a SPI device node:
@@ -35,4 +38,5 @@ Example for a SPI device node:
 		spi-cpha;
 		interrupt-parent = <&gpio1>;
 		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "INT1";
 	};
-- 
2.7.4

