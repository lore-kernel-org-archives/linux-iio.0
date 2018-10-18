Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from da1vs02.rockwellcollins.com ([205.175.227.29]:15753 "EHLO
        da1vs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbeJSCir (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 22:38:47 -0400
From: Matt Weber <matthew.weber@rockwellcollins.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>
Subject: [PATCH v3 2/2] iio:temperature:max31856:Add device tree bind info
Date: Thu, 18 Oct 2018 13:36:29 -0500
Message-Id: <1539887789-7562-2-git-send-email-matthew.weber@rockwellcollins.com>
In-Reply-To: <1539887789-7562-1-git-send-email-matthew.weber@rockwellcollins.com>
References: <1539887789-7562-1-git-send-email-matthew.weber@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

This patch added device tree binding info for MAX31856 driver.

Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
---
Changes
v1 -> v2
[Matt
 - Removed comment block and added possibilities of
   thermocouple type in device tree binding doc.

v2 -> v3
 - Rebased
---
 .../bindings/iio/temperature/max31856.txt          | 32 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
new file mode 100644
index 0000000..e1def9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
@@ -0,0 +1,32 @@
+Maxim MAX31856 thermocouple support
+
+https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
+
+Required properties:
+	- compatible: must be "max31856"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: As per datasheet max. supported freq is 5000000
+	- spi-cpha: must be defined for max31856 to enable SPI mode 1
+	- type: Type of thermocouple (By default is K-Type)
+		0x00 : TYPE_B
+		0x01 : TYPE_E
+		0x02 : TYPE_J
+		0x03 : TYPE_K (default)
+		0x04 : TYPE_N
+		0x05 : TYPE_R
+		0x06 : TYPE_S
+		0x07 : TYPE_T
+
+	Refer to spi/spi-bus.txt for generic SPI slave bindings.
+
+Optional properties:
+	- one-shot: Enable one-shot Conversion mode (By default mode is auto)
+
+ Example:
+	max31856@0 {
+		compatible = "max31856";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		spi-cpha;
+		type = <0x03>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3cfa518..44ec309 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7163,6 +7163,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/temperature/max31856.c
 F:	Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
+F:	Documentation/devicetree/bindings/iio/temperature/max31856.txt
 
 IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
-- 
1.9.1
