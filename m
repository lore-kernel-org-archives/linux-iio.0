Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:32943 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbD3NQw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2015 09:16:52 -0400
Received: by lbbzk7 with SMTP id zk7so44315104lbb.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2015 06:16:51 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/10] ARM: ux500: add the sensors to the STUIB board
Date: Thu, 30 Apr 2015 15:15:55 +0200
Message-Id: <1430399755-26475-10-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the device tree data for the LIS331DL and the
AK8974 magnetometer to the STUIB board device tree include
file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Jonathan: This will be merged through the ARM SoC tree if
found OK. Do not merge to the IIO tree.
---
 arch/arm/boot/dts/ste-href-stuib.dtsi | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/ste-href-stuib.dtsi b/arch/arm/boot/dts/ste-href-stuib.dtsi
index 7d4f8184c522..78b75256c638 100644
--- a/arch/arm/boot/dts/ste-href-stuib.dtsi
+++ b/arch/arm/boot/dts/ste-href-stuib.dtsi
@@ -77,6 +77,34 @@
 			};
 		};
 
+		/* Sensors mounted on this board variant */
+		i2c@80128000 {
+			lis331dl@1c {
+				/* Accelerometer */
+				compatible = "st,lis331dl-accel";
+				st,drdy-int-pin = <1>;
+				reg = <0x1c>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&accel_stuib_mode>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <18 IRQ_TYPE_EDGE_RISING>,
+					     <19 IRQ_TYPE_EDGE_RISING>;
+			};
+			ak8974@0f {
+				/* Magnetometer */
+				compatible = "asahi-kasei,ak8974";
+				reg = <0x0f>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&magneto_stuib_mode>;
+				interrupt-parent = <&gpio1>;
+				interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
+
 		i2c@80110000 {
 			bu21013_tp@5c {
 				compatible = "rohm,bu21013_tp";
@@ -116,6 +144,28 @@
 					};
 				};
 			};
+			accelerometer {
+				accel_stuib_mode: accel_stuib {
+					/* Accelerometer interrupt lines 1 & 2 */
+					stuib_cfg {
+						pins = "GPIO82_C1", "GPIO83_D3";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+			magnetometer {
+				magneto_stuib_mode: magneto_stuib {
+					/* Magnetometer uses GPIO 31 and 32, pull these up/down respectively */
+					stuib_cfg1 {
+						pins = "GPIO31_V3";
+						ste,config = <&gpio_in_pu>;
+					};
+					stuib_cfg2 {
+						pins = "GPIO32_V2";
+						ste,config = <&gpio_in_pd>;
+					};
+				};
+			};
 		};
 	};
 };
-- 
1.9.3

