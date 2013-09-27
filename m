Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64644 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab3I0Qcb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:31 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 11/14] Documentation: Add st_magn binding documentation
Date: Fri, 27 Sep 2013 18:32:15 +0200
Message-id: <1380299538-22047-12-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the document for STMicroeletronics Magnetic Sensors driver under
Documentation/devicetree/bindings/iio/.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../bindings/iio/magnetometer/st_magnometer.txt    |   33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt b/Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt
new file mode 100644
index 0000000..fb4f473
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt
@@ -0,0 +1,33 @@
+STMicroelectronics Magnetic Sensors
+
+Required properties:
+
+  - compatible : value should be one of the following:
+	(a) "st,lsm303dlhc" for magnetometer in LSM330DLHC
+	(b) "st,lsm303dlm" for magnetometer in LIS3DH
+	(c) "st,lis3mdl" for magnetometer in LSM330
+
+  - reg : the I2C address of the magnetometer
+
+Optional properties:
+
+  - st,drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)
+
+  - interrupts : Interrupt numbers for the ST accelerometers, as an array
+	in case the magnetometer have more interrupt lines:
+	<DataReady irq>,
+	<Event irq>;
+
+  - interrupt-names : Array of strings associated with the interrupt numbers
+
+Example:
+
+lis3mdl@1c {
+	compatible = "st,lis3mdl";
+	reg = <0x1C>;
+
+	st,drdy-int-pin = /bits/ 8 <1>;
+	interrupt-parent = <&gpf0>;
+	interrupts = <5 0>, <6 0>;
+	interrupt-names = "drdy-int", "event-int";
+};
-- 
1.7.9.5

