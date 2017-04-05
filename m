Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33041 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932669AbdDEJHI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 05:07:08 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v4 7/8] ARM: sun8i: a33: Add devfreq-based GPU cooling
Date: Wed,  5 Apr 2017 11:06:33 +0200
Message-Id: <20170405090634.4649-8-quentin.schulz@free-electrons.com>
In-Reply-To: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

This adds GPU thermal throttling for the Allwinner A33.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v3:
  - got rid of cooling-min-level and cooling-max-level as it's not used in any
  code in the kernel,

added in v2
 arch/arm/boot/dts/sun8i-a23-a33.dtsi |  1 +
 arch/arm/boot/dts/sun8i-a33.dtsi     | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 5e8725d..6d81a6d 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -495,6 +495,7 @@
 
 			assigned-clocks = <&ccu CLK_GPU>;
 			assigned-clock-rates = <384000000>;
+			#cooling-cells = <2>;
 		};
 
 		gic: interrupt-controller@01c81000 {
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index b88c107..541ca45 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -188,6 +188,16 @@
 					trip = <&cpu_alert1>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+
+				map2 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&mali 1 THERMAL_NO_LIMIT>;
+				};
+
+				map3 {
+					trip = <&gpu_alert1>;
+					cooling-device = <&mali 2 THERMAL_NO_LIMIT>;
+				};
 			};
 
 			trips {
@@ -198,6 +208,13 @@
 					type = "passive";
 				};
 
+				gpu_alert0: gpu_alert0 {
+					/* milliCelsius */
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_alert1: cpu_alert1 {
 					/* milliCelsius */
 					temperature = <90000>;
@@ -205,6 +222,13 @@
 					type = "hot";
 				};
 
+				gpu_alert1: gpu_alert1 {
+					/* milliCelsius */
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
 				cpu_crit: cpu_crit {
 					/* milliCelsius */
 					temperature = <110000>;
-- 
2.9.3

