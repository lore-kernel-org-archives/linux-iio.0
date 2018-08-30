Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42692 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeH3Tsi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:38 -0400
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 29/30] ARM: dts: sun8i: a83t: add thermal zone to A83T
Date: Thu, 30 Aug 2018 17:45:17 +0200
Message-Id: <20180830154518.29507-30-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the thermal zones to the A83T. Sensor 0 is located
besides the cpu cluster 0. Sensor 1 is located besides cluster 1 and
sensor 2 is located besides in the gpu.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 103 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index f2f745930b08..78aa448e869f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -50,6 +50,7 @@
 #include <dt-bindings/reset/sun8i-a83t-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -69,6 +70,9 @@
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
 		};
 
 		cpu@1 {
@@ -107,6 +111,9 @@
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x100>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
 		};
 
 		cpu@101 {
@@ -1035,4 +1042,100 @@
 			#size-cells = <0>;
 		};
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu0_warm: cpu_warm {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_hot: cpu_hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_very_hot: cpu_very_hot {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_crit: cpu_crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu_warm_limit_cpu {
+					trip = <&cpu0_warm>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT 4>;
+				};
+				cpu_hot_limit_cpu {
+					trip = <&cpu0_hot>;
+					cooling-device = <&cpu0 5 5>;
+				};
+				cpu_very_hot_limit_cpu {
+					trip = <&cpu0_very_hot>;
+					cooling-device = <&cpu0 7 THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu1_thermal: cpu1-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 1>;
+
+			trips {
+				cpu1_warm: cpu_warm {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu1_hot: cpu_hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu1_very_hot: cpu_very_hot {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu1_crit: cpu_crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu_warm_limit_cpu {
+					trip = <&cpu1_warm>;
+					cooling-device = <&cpu100 THERMAL_NO_LIMIT 4>;
+				};
+				cpu_hot_limit_cpu {
+					trip = <&cpu1_hot>;
+					cooling-device = <&cpu100 5 5>;
+				};
+				cpu_very_hot_limit_cpu {
+					trip = <&cpu1_very_hot>;
+					cooling-device = <&cpu100 7 THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 2>;
+		};
+	};
 };
-- 
2.11.0
