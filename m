Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:54505 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab3IPQCq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 12:02:46 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so2144947eek.11
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2013 09:02:45 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 09/20] Documentation: dt: iio: Add binding for L3G4200D
Date: Mon, 16 Sep 2013 17:02:15 +0100
Message-Id: <1379347346-823-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

L3G4200D is a Gyroscope Sensor

Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/iio/gyro/l3g4200d.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt

diff --git a/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt b/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
new file mode 100644
index 0000000..3ca2b9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Gyroscope Sensor
+
+Required properties:
+  - compatible: Should be "st,l3g4200d"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c@80128000 {
+	l3g4200d@68 {
+		compatible = "st,l3g4200d";
+		reg = <0x68>;
+
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		vddio-supply = <&db8500_vsmps2_reg>;
+	};
+};
-- 
1.8.1.2

