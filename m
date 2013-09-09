Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:63521 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3IIKKf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2013 06:10:35 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so3091691eek.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2013 03:10:34 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/14] Documentation: dt: i2c: Add LPS001WP to the Trivial Devices list
Date: Mon,  9 Sep 2013 11:10:08 +0100
Message-Id: <1378721410-30937-13-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
References: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

LPS001WP is a Pressure and Temperature sensor.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/iio/pressure/lps001wp.txt   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/lps001wp.txt

diff --git a/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
new file mode 100644
index 0000000..45cb45c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Pressure Sensor
+
+Required properties:
+  - compatible: Should be "st,lps001wp"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c@80128000 {
+        lps001wp@5c {
+                compatible = "st,lps001wp";
+                reg = <0x5c>;
+
+                vdd-supply = <&ab8500_ldo_aux1_reg>;
+                vddio-supply = <&db8500_vsmps2_reg>;
+        };
+};
-- 
1.8.1.2

