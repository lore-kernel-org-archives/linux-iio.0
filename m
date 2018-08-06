Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr730084.outbound.protection.outlook.com ([40.107.73.84]:43328
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731324AbeHFOOs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Aug 2018 10:14:48 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <broonie@kernel.org>
CC: Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Date: Mon, 6 Aug 2018 15:04:43 +0300
Message-ID: <1533557087-10401-3-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the device tree binding documentation for the ADXL372 3-axis digital
accelerometer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/accel/adxl372.txt      | 22 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
new file mode 100644
index 0000000..9409984
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -0,0 +1,22 @@
+Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
+
+http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
+
+Required properties:
+ - compatible : should be "adi,adxl372"
+ - reg: SPI chip select number for the device
+ - spi-max-frequency: Max SPI frequency to use
+
+Optional properties:
+ - interrupts: interrupt mapping for IRQ as documented in
+   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+	accelerometer@0 {
+		compatible = "adi,adxl372";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ba47bb..c8dd09c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
+F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
 
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.7.4

