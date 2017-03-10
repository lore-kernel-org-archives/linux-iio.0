Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34694 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935356AbdCJKj5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 05:39:57 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, stefan.mavrodiev@gmail.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 11/11] ARM: sun8i: a33: Add devfreq-based GPU cooling
Date: Fri, 10 Mar 2017 11:39:21 +0100
Message-Id: <20170310103921.19469-12-quentin.schulz@free-electrons.com>
In-Reply-To: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

This adds GPU thermal throttling for the Allwinner A33.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 arch/arm/boot/dts/sun8i-a23-a33.dtsi |  3 +++
 arch/arm/boot/dts/sun8i-a33.dtsi     | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 5e8725d..dc4e942 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -495,6 +495,9 @@
 
 			assigned-clocks = <&ccu CLK_GPU>;
 			assigned-clock-rates = <384000000>;
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
+			#cooling-cells = <2>;
 		};
 
 		gic: interrupt-controller@01c81000 {
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index df6e77f..6552762 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -202,6 +202,16 @@
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
@@ -212,6 +222,13 @@
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
@@ -219,6 +236,13 @@
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

