Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60547 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758023AbdCUPgk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 11:36:40 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz
Subject: [PATCH v3 09/11] ARM: dtsi: sun8i: a33: add CPU thermal throttling
Date: Tue, 21 Mar 2017 16:36:09 +0100
Message-Id: <20170321153611.16228-10-quentin.schulz@free-electrons.com>
In-Reply-To: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds CPU thermal throttling for the Allwinner A33. It uses the
thermal sensor present in the SoC's GPADC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v3:
  - switched to new phandle because of modified DT node name for the GPADC
  (named THS),
  - got rid of cooling-min-level and cooling-max-level as it's not used in any
  code in the kernel,

v2:
  - updated cooling-max-level to reflect newly added OPPs,

 arch/arm/boot/dts/sun8i-a33.dtsi | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index f391f71..73552bb 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -43,6 +43,7 @@
  */
 
 #include "sun8i-a23-a33.dtsi"
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	cpu0_opp_table: opp_table0 {
@@ -127,6 +128,7 @@
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
@@ -170,6 +172,49 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_alert1: cpu_alert1 {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_crit: cpu_crit {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	memory {
 		reg = <0x40000000 0x80000000>;
 	};
-- 
2.9.3

