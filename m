Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55369 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab3IIGKn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2013 02:10:43 -0400
Message-id: <522D6661.8030000@samsung.com>
Date: Mon, 09 Sep 2013 15:10:41 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@cam.ac.uk,
	rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	warren@wwwdotorg.org, ian.campbell@citrix.com,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 2/2] DT: Add binding documentation for CM36651 proximity/light
 sensor
Content-type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add device tree binding documentation for CM36651
proximity/light sensor.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 .../devicetree/bindings/iio/light/cm36651.txt      |   24
++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt

diff --git a/Documentation/devicetree/bindings/iio/light/cm36651.txt
b/Documentation/devicetree/bindings/iio/light/cm36651.txt
new file mode 100644
index 0000000..3a6ba38
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/cm36651.txt
@@ -0,0 +1,24 @@
+* Capella CM36651 I2C Proximity and Color Light sensor
+
+Required properties:
+- compatible: must be "capella,cm36651"
+- reg: the I2C address of the device
+- interrupts: interrupt to which the chip is connected
+- vled-supply: regulator for the sensor device, as covered
+	       in ../../regulator/regulator.txt
+
+Example:
+
+	i2c_cm36651: i2c-gpio {
+		/* ... */
+
+		cm36651@18 {
+			compatible = "capella,cm36651";
+			reg = <0x18>;
+			interrupt-parent = <&gpx0>;
+			interrupts = <2 0>;
+			vled-supply = <&ps_als_reg>;
+		};
+
+		/* ... */
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ec4d713..044796d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -17,6 +17,7 @@ brcm	Broadcom Corporation
 cavium	Cavium, Inc.
 chrp	Common Hardware Reference Platform
 cirrus	Cirrus Logic, Inc.
+capella	Capella Microsystems, Inc
 cortina	Cortina Systems, Inc.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
-- 
1.7.9.5

-- 
Beomho Seo, Assistant Engineer
System S/W Lab., S/W Platform Team, Software Center
Samsung Electronics
