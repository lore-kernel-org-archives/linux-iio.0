Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64647 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab3I0Qcc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:32 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 14/14] Documentation: Add st_accel binding documentation
Date: Fri, 27 Sep 2013 18:32:18 +0200
Message-id: <1380299538-22047-15-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the document for STMicroeletronics Acceleration Sensors
driver under Documentation/devicetree/bindings/iio/.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../iio/accelerometer/st_accelerometer.txt         |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accelerometer/st_accelerometer.txt

diff --git a/Documentation/devicetree/bindings/iio/accelerometer/st_accelerometer.txt b/Documentation/devicetree/bindings/iio/accelerometer/st_accelerometer.txt
new file mode 100644
index 0000000..af70f29
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accelerometer/st_accelerometer.txt
@@ -0,0 +1,40 @@
+STMicroelectronics Acceleration Sensors
+
+Required properties:
+
+  - compatible : value should be one of the following:
+	(a) "st,lsm330dlhc-accel" for accelerometer in LSM330DLHC
+	(b) "st,lis3dh" for accelerometer in LIS3DH
+	(c) "st,lsm330d-accel" for accelerometer in LSM330
+	(d) "st,lsm330dl-accel" for accelerometer in LSM330DL
+	(e) "st,lsm330dlc-accel" for accelerometer in LSM330DLC
+	(f) "st,lsm331dlh" for accelerometer in LSM331DLH
+	(g) "st,lsm303dl-accel" for accelerometer in LSM303DL
+	(h) "st,lsm303dlh-accel" for accelerometer in LSM303DLH
+	(i) "st,lsm303dlm-accel" for accelerometer in LSM303DLM
+	(j) "st,lsm330-accel" for accelerometer in LMS330
+
+  - reg : the I2C address of the accelerometer
+
+Optional properties:
+
+  - st,drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)
+
+  - interrupts : Interrupt numbers for the ST accelerometers, as an array
+	in case the accelerometer have more interrupt lines:
+	<DataReady irq>,
+	<Event irq>;
+
+  - interrupt-names : Array of strings associated with the interrupt numbers
+
+Example:
+
+lsm330dlc_accel@19 {
+	compatible = "st,lsm330dlc-accel";
+	reg = <0x19>;
+
+	st,drdy-int-pin = /bits/ 8 <1>;
+	interrupt-parent = <&gpx0>;
+	interrupts= <0 0>, <1 0>;
+	interrupt-names = "event-int". "drdy-int";\
+};
-- 
1.7.9.5

