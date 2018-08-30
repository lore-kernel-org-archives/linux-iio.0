Return-Path: <SRS0=HpEw=LN=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@bootlin.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	eugen.hristev@microchip.com,
	rdunlap@infradead.org,
	vilhelm.gray@gmail.com,
	clabbe.montjoie@gmail.com,
	quentin.schulz@bootlin.com,
	geert+renesas@glider.be,
	lukas@wunner.de,
	icenowy@aosc.io,
	arnd@arndb.de,
	broonie@kernel.org,
	arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v3 25/30] ARM: dts: sun8i: h3: add thermal zone to H3
Date: Thu, 30 Aug 2018 17:45:13 +0200
Message-Id: <20180830154518.29507-26-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds the thermal zones to the H3. We have only one sensor and
that is placed in the cpu.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi    | 31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi |  1 +
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 5b7994cb1471..954848d5df50 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -78,6 +78,8 @@
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
 		};
 
 		cpu@1 {
@@ -102,6 +104,35 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths>;
+
+			trips {
+				cpu_hot_trip: cpu-warm {
+					temperature = <65000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_very_hot_trip: cpu-very-hot {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-warm-limit {
+					trip = <&cpu_hot_trip>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 3520e4ad6042..2c83f4893757 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-h3-ccu.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
-- 
2.11.0
