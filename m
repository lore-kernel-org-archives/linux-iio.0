Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:32960 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab3IPQCr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 12:02:47 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so2136497eak.15
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2013 09:02:46 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 10/20] Documentation: dt: iio: Add binding for LSM303DLH - Magn
Date: Mon, 16 Sep 2013 17:02:16 +0100
Message-Id: <1379347346-823-11-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

LSM303DLH is a Magnetometer Sensor

Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/iio/magnetometer/lsm303dlhc.txt        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt b/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt
new file mode 100644
index 0000000..2ad49c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Magnetometer Sensor
+
+Required properties:
+  - compatible: Should be "st,lsm303dlhc_magn"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c@80128000 {
+	lsm303dlhc_magn@1e {
+		compatible = "st,lsm303dlhc_magn";
+		reg = <0x1e>;
+
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		vddio-supply = <&db8500_vsmps2_reg>;
+	};
+};
-- 
1.8.1.2

