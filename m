Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52616 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbaICO4f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Sep 2014 10:56:35 -0400
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <k.wrona@samsung.com>
Subject: [RFC/PATCH 3/6] sensorhub: Add sensorhub bindings
Date: Wed, 03 Sep 2014 16:55:47 +0200
Message-id: <1409756150-30889-4-git-send-email-k.wrona@samsung.com>
In-reply-to: <1409756150-30889-1-git-send-email-k.wrona@samsung.com>
References: <1409756150-30889-1-git-send-email-k.wrona@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add sensorhub bindings for sensorhub on Galaxy Gear 2.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/misc/sensorhub.txt         |   51 ++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sensorhub.txt

diff --git a/Documentation/devicetree/bindings/misc/sensorhub.txt b/Documentation/devicetree/bindings/misc/sensorhub.txt
new file mode 100644
index 0000000..b43c2b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sensorhub.txt
@@ -0,0 +1,50 @@
+Samsung Sensorhub driver
+
+Sensorhub is MCU which manages several sensors and also play the role
+of virtual sensor device.
+
+Required properties:
+- compatible: "samsung,sensorhub-rinato" or "samsung,sensorhub-thermostat"
+- spi-max-frequency: max SPI clock frequency
+- interrupt-parent
+- interrupts: communication interrupt
+- ap-mcu-int: [out] ap to sensorhub line - used during communication
+- mcu-ap-int: [in] sensorhub to ap - used during communication
+- mcu-reset: [out] sensorhub reset
+- mag-table: magnitude table
+
+Optional properties:
+- sensor's nodes:
+  compatible = "samsung,mpu6500-accel"
+  compatible = "samsung,mpu6500-gyro"
+  compatible = "samsung,adpd142"
+
+Sensor compatibles are used to match proper sensor driver to real sensor on
+the board. The firmware does not give such information, so it helps to specify
+some sensors properties. Sensors have "samsung" prefixes because frequently
+they will not have much in common with sensors used without sensorhub because
+it can do some data processing.
+
+Example:
+
+	shub_spi: shub {
+		compatible = "samsung,rinato-ssp-spi";
+		spi-max-frequency = <5000000>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <2 0>;
+		ap-mcu-int = <&gpx0 0 0>;
+		mcu-ap-int = <&gpx0 4 0>;
+		mcu-reset = <&gpx0 5 0>;
+		mag-table = /bits/ 8 <110 85 171 71 203 195 0 67
+				208 56 175 244 206 213 0 92 250 0
+				55 48 189 252 171 243 13 45 250>;
+		sensor@0 {
+			compatible = "samsung,mpu6500-accel";
+		};
+		sensor@1 {
+			compatible = "samsung,mpu6500-gyro";
+		};
+		sensor@2 {
+			compatible = "samsung,adpd142";
+		};
+	};
-- 
1.7.9.5

