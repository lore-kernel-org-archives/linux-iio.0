Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:39266 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab3IJMuB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:50:01 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so3867442ead.33
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:50:00 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 13/38] Documentation: dt: iio: Add binding for LSM303DLH
Date: Tue, 10 Sep 2013 13:49:14 +0100
Message-Id: <1378817379-8238-14-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

LSM303DLH is a Magnetometer Sensor

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/iio/magnetometer/lsm303dlh.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt b/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt
new file mode 100644
index 0000000..5938369
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Magnetometer Sensor
+
+Required properties:
+  - compatible: Should be "st,lsm303dlh_magn"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c@80128000 {
+	lsm303dlh_magn@1e {
+		compatible = "st,lsm303dlh_magn";
+		reg = <0x1e>;
+
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		vddio-supply = <&db8500_vsmps2_reg>;
+	};
+};
-- 
1.8.1.2

