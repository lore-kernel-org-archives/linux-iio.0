Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from secvs01.rockwellcollins.com ([205.175.225.240]:13453 "EHLO
        secvs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727439AbeJZC0F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Oct 2018 22:26:05 -0400
From: Matt Weber <matthew.weber@rockwellcollins.com>
To: linux-iio@vger.kernel.org
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>
Subject: [PATCH v4 2/2] iio:temperature:max31856:Add device tree bind info
Date: Thu, 25 Oct 2018 12:42:45 -0500
Message-Id: <1540489365-3464-2-git-send-email-matthew.weber@rockwellcollins.com>
In-Reply-To: <1540489365-3464-1-git-send-email-matthew.weber@rockwellcollins.com>
References: <1540489365-3464-1-git-send-email-matthew.weber@rockwellcollins.com>
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

v3 -> v4
 - Removed one-shot property related information.
 - Used standard name 'temp-sensor'
---
 .../bindings/iio/temperature/max31856.txt          | 29 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
new file mode 100644
index 0000000..eb3dc0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
@@ -0,0 +1,29 @@
+Maxim MAX31856 thermocouple support
+
+https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
+
+Required properties:
+	- compatible: must be "maxim,max31856"
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
+ Example:
+	temp-sensor@0 {
+		compatible = "maxim,max31856";
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
