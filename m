Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:58564 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab3IJMuA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:50:00 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so3833200eak.32
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:49:59 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/38] Documentation: dt: iio: Add binding for L3G4200D
Date: Tue, 10 Sep 2013 13:49:13 +0100
Message-Id: <1378817379-8238-13-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

L3G4200D is a Gyroscope Sensor

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/iio/gyro/l3g4200d.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt

diff --git a/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt b/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
new file mode 100644
index 0000000..29baf9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Gyroscope Sensor
+
+Required properties:
+  - compatible: Should be "st,l3g4200d_gyro"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c@80128000 {
+	l3g4200d_gyro@68 {
+		compatible = "st,l3g4200d_gyro";
+		reg = <0x68>;
+
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		vddio-supply = <&db8500_vsmps2_reg>;
+	};
+};
-- 
1.8.1.2

