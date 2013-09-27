Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64647 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab3I0Qcb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:31 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 12/14] Documentation: Add st_gyro binding documentation
Date: Fri, 27 Sep 2013 18:32:16 +0200
Message-id: <1380299538-22047-13-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the document for STMicroeletronics Angular Velocity Sensors
driver under Documentation/devicetree/bindings/iio/.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../bindings/iio/gyroscope/st_gyroscope.txt        |   38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt b/Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt
new file mode 100644
index 0000000..8a6a9be
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt
@@ -0,0 +1,38 @@
+STMicroelectronics Angular Velocity  Sensors
+
+Required properties:
+
+  - compatible : value should be one of the following:
+	(a) "st,l3g4200d" for gyroscope in L3G4200D
+	(b) "st,lsm330d-gyro" for gyroscope in LSM330D
+	(c) "st,lsm330dl-gyro" for gyroscope in LSM330DL
+	(d) "st,lsm330dlc-gyro" for gyroscope in LSM330DLC
+	(e) "st,l3gd20" for gyroscope in L3GD20
+	(f) "st,l3gd20h" for gyroscope in L3GD20H
+	(g) "st,l3g4is-ui" for gyroscope in L3G4IS
+	(h) "st,lsm330-gyro" for gyroscope in LSM330
+
+  - reg : the I2C address of the gyroscope
+
+Optional properties:
+
+  - st,drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)
+
+  - interrupts : Interrupt numbers for the ST gyroscopes, as an array
+	in case the gyroscope have more interrupt lines:
+	<DataReady irq>,
+	<Event irq>;
+
+  - interrupt-names : Array of strings associated with the interrupt numbers
+
+Example:
+
+lsm330dlc_gyro@6b {
+	compatible = "st,lsm330dlc-gyro";
+	reg = <0x6b>;
+
+	st,drdy-int-pin = /bits/ 8 <2>;
+	interrupt-parent = <&gpf0>;
+	interrupts = <3 0>, <4 0>;
+	interrupt-names = "drdy-int", "event-int";
+};
-- 
1.7.9.5

