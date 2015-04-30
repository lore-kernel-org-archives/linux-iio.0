Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:36182 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbD3NQo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2015 09:16:44 -0400
Received: by lagv1 with SMTP id v1so43862659lag.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2015 06:16:43 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/10] ARM: ux500: fix lsm303dlh magnetometer compat string
Date: Thu, 30 Apr 2015 15:15:53 +0200
Message-Id: <1430399755-26475-8-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The magnetometer found on the Ux500 TVK and Snowball boards
is a LSM303DLH not a LSM303DLM, small differences but still
different. Put in the right compatible strings and things start
working smoothly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Jonathan: This will be merged through the ARM SoC tree if
found OK. Do not merge to the IIO tree.
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 4 ++--
 arch/arm/boot/dts/ste-snowball.dts         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 062c6aae3afa..0eeb4d4b5202 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -100,9 +100,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&accel_tvk_mode>;
 			};
-			lsm303dlm@1e {
+			lsm303dlh@1e {
 				/* Magnetometer */
-				compatible = "st,lsm303dlm-magn";
+				compatible = "st,lsm303dlh-magn";
 				reg = <0x1e>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 1bc84ebdccaa..e2a7417777f9 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -263,9 +263,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&accel_snowball_mode>;
 			};
-			lsm303dlm@1e {
+			lsm303dlh@1e {
 				/* Magnetometer */
-				compatible = "st,lsm303dlm-magn";
+				compatible = "st,lsm303dlh-magn";
 				reg = <0x1e>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
-- 
1.9.3

