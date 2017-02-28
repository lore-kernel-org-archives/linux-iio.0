Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33338 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdB1Chv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 21:37:51 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v5 1/4] dt-bindings: iio: accel: Document ADXL345 accelerometer binding
Date: Tue, 28 Feb 2017 10:37:16 +0800
Message-Id: <dec0c0561b579095dfc6d67fac4bf911a1b450f4.1488248485.git.eraretuya@gmail.com>
In-Reply-To: <cover.1488248485.git.eraretuya@gmail.com>
References: <cover.1488248485.git.eraretuya@gmail.com>
In-Reply-To: <cover.1488248485.git.eraretuya@gmail.com>
References: <cover.1488248485.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the device tree binding documentation for the ADXL345 3-axis digital
accelerometer.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
Changes from v4:
* Update subject-prefix 
* Update node name from "adxl345@unit-address" to "accelerometer@unit-address"

 .../devicetree/bindings/iio/accel/adxl345.txt      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl345.txt b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
new file mode 100644
index 0000000..e7111b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
@@ -0,0 +1,38 @@
+Analog Devices ADXL345 3-Axis, +/-(2g/4g/8g/16g) Digital Accelerometer
+
+http://www.analog.com/en/products/mems/accelerometers/adxl345.html
+
+Required properties:
+ - compatible : should be "adi,adxl345"
+ - reg : the I2C address or SPI chip select number of the sensor
+
+Required properties for SPI bus usage:
+ - spi-max-frequency : set maximum clock frequency, must be 5000000
+ - spi-cpol and spi-cpha : must be defined for adxl345 to enable SPI mode 3
+
+Optional properties:
+ - interrupt-parent : phandle to the parent interrupt controller as documented
+   in Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+ - interrupts: interrupt mapping for IRQ as documented in
+   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example for a I2C device node:
+
+	accelerometer@2a {
+		compatible = "adi,adxl345";
+		reg = <0x53>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+Example for a SPI device node:
+
+	accelerometer@0 {
+		compatible = "adi,adxl345";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		spi-cpol;
+		spi-cpha;
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
2.7.4

