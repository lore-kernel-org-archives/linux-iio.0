Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34625 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbcLTK2W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 05:28:22 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, linux@armlinux.org.uk,
        stefan.mavrodiev@gmail.com
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@free-electrons.com
Subject: [PATCH 7/7] ARM: dtsi: sun8i-a33: add CPU thermal throttling
Date: Tue, 20 Dec 2016 11:27:09 +0100
Message-Id: <20161220102709.9504-8-quentin.schulz@free-electrons.com>
In-Reply-To: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds CPU thermal throttling for the Allwinner A33. It uses the
thermal sensor present in the SoC's GPADC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 1fcae81..735ebea 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -43,6 +43,7 @@
  */
 
 #include "sun8i-a23-a33.dtsi"
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	cpu0_opp_table: opp_table0 {
@@ -79,6 +80,9 @@
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <3>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@2 {
@@ -100,6 +104,49 @@
 		status = "disabled";
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&rtp>;
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

