Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34334 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbD3NQr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2015 09:16:47 -0400
Received: by lbcga7 with SMTP id ga7so44265110lbc.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2015 06:16:46 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/10] ARM: ux500: assign the sensor trigger IRQs
Date: Thu, 30 Apr 2015 15:15:54 +0200
Message-Id: <1430399755-26475-9-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ST sensors on the Ux500 boards were not utilizing the IRQs
for data ready sample triggers. Enable this by assigning the
right GPIO lines and interrupt lines (when the GPIO lines are
used for IRQs) to the accelerometer, gyro and magnetometer
sensors.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Jonathan: This will be merged through the ARM SoC tree if
found OK. Do not merge to the IIO tree.
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi |  3 +++
 arch/arm/boot/dts/ste-snowball.dts         | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 0eeb4d4b5202..0e1c96943d47 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -99,6 +99,9 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&accel_tvk_mode>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <18 IRQ_TYPE_EDGE_RISING>,
+					     <19 IRQ_TYPE_EDGE_RISING>;
 			};
 			lsm303dlh@1e {
 				/* Magnetometer */
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index e2a7417777f9..9edadc37719f 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -262,6 +262,9 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&accel_snowball_mode>;
+				interrupt-parent = <&gpio5>;
+				interrupts = <3 IRQ_TYPE_EDGE_RISING>, /* INT1 */
+					     <4 IRQ_TYPE_EDGE_RISING>; /* INT2 */
 			};
 			lsm303dlh@1e {
 				/* Magnetometer */
@@ -271,6 +274,7 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&magneto_snowball_mode>;
+				gpios = <&gpio5 5 0x4>; /* DRDY line */
 			};
 			l3g4200d@68 {
 				/* Gyroscope */
@@ -279,6 +283,11 @@
 				reg = <0x68>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&gyro_snowball_mode>;
+				gpios = <&gpio5 6 0x4>; /* DRDY line */
+				interrupt-parent = <&gpio5>;
+				interrupts = <9 IRQ_TYPE_EDGE_RISING>; /* INT1 */
 			};
 			lsp001wm@5c {
 				/* Barometer/pressure sensor */
@@ -489,6 +498,16 @@
 					};
 				};
 			};
+			gyro {
+				gyro_snowball_mode: gyro_snowball {
+					snowball_cfg1 {
+						pins =
+						"GPIO166_A22", /* DRDY */
+						"GPIO169_D22"; /* INT */
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 			magnetometer {
 				magneto_snowball_mode: magneto_snowball {
 					snowball_cfg1 {
-- 
1.9.3

