Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:56377 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbaDMTJt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Apr 2014 15:09:49 -0400
Received: by mail-we0-f182.google.com with SMTP id p61so7389616wes.27
        for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2014 12:09:47 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/6] ARM: ux500: add misc sensors to the device trees
Date: Sun, 13 Apr 2014 21:09:03 +0200
Message-Id: <1397416143-4396-7-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the STMicroelectonics MEMS sensor devices to the Ux500
family device trees:

- Accelerometer
- Magnetometer
- Gyroscope
- Pressure (barometer)

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi        | 30 +++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi | 15 ++++++++++++--
 arch/arm/boot/dts/ste-snowball.dts     | 38 +++++++++++++++++++++++++++++++---
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 6cb9b68e2188..fe64c472931c 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -103,6 +103,36 @@
 				compatible = "rohm,bh1780gli";
 				reg = <0x29>;
 			};
+			lsm303dlh@18 {
+				/* Accelerometer */
+				compatible = "st,lsm303dlh-accel";
+				st,drdy-int-pin = <1>;
+				reg = <0x18>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+			lsm303dlm@1e {
+				/* Magnetometer */
+				compatible = "st,lsm303dlm-magn";
+				reg = <0x1e>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+			l3g4200d@68 {
+				/* Gyroscope */
+				compatible = "st,l3g4200d-gyro";
+				st,drdy-int-pin = <2>;
+				reg = <0x68>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+			lsp001wm@5c {
+				/* Barometer/pressure sensor */
+				compatible = "st,lps001wp-press";
+				reg = <0x5c>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
 		};
 
 		i2c@80110000 {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index c2341061b943..e912d422b99e 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -35,8 +35,6 @@
 			 */
 			pinctrl-names = "default";
 			pinctrl-0 = <&ipgpio_hrefv60_mode>,
-				  <&accel_hrefv60_mode>,
-				  <&magneto_hrefv60_mode>,
 				  <&etm_hrefv60_mode>,
 				  <&nahj_hrefv60_mode>,
 				  <&nfc_hrefv60_mode>,
@@ -238,5 +236,18 @@
 				};
 			};
 		};
+
+		i2c@80128000 {
+			lsm303dlh@18 {
+				/* Pins for the accelerometer */
+				pinctrl-names = "default";
+				pinctrl-0 = <&accel_hrefv60_mode>;
+			};
+			lsm303dlm@1e {
+				/* Pins for the magnetometer */
+				pinctrl-names = "default";
+				pinctrl-0 = <&magneto_hrefv60_mode>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index a2f632d0be2a..cc1abc063b4b 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -241,6 +241,40 @@
 			pinctrl-names = "default","sleep";
 			pinctrl-0 = <&i2c2_default_mode>;
 			pinctrl-1 = <&i2c2_sleep_mode>;
+			lsm303dlh@18 {
+				/* Accelerometer */
+				compatible = "st,lsm303dlh-accel";
+				st,drdy-int-pin = <1>;
+				reg = <0x18>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&accel_snowball_mode>;
+			};
+			lsm303dlm@1e {
+				/* Magnetometer */
+				compatible = "st,lsm303dlm-magn";
+				reg = <0x1e>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&magneto_snowball_mode>;
+			};
+			l3g4200d@68 {
+				/* Gyroscope */
+				compatible = "st,l3g4200d-gyro";
+				st,drdy-int-pin = <2>;
+				reg = <0x68>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+			lsp001wm@5c {
+				/* Barometer/pressure sensor */
+				compatible = "st,lps001wp-press";
+				reg = <0x5c>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
 		};
 
 		i2c@80110000 {
@@ -361,9 +395,7 @@
 			 * can be moved over to being controlled by respective device.
 			 */
 			pinctrl-names = "default";
-			pinctrl-0 = <&accel_snowball_mode>,
-				  <&magneto_snowball_mode>,
-				  <&gbf_snowball_mode>,
+			pinctrl-0 = <&gbf_snowball_mode>,
 				  <&wlan_snowball_mode>;
 
 			ethernet {
-- 
1.9.0

