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
Subject: [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP tables and CPUfreq
Date: Thu, 30 Aug 2018 17:45:18 +0200
Message-Id: <20180830154518.29507-31-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Since we have now thermal trotteling enabeled we can now add the full
range of the OPP table.

The operating points were found in Allwinner BSP and fex files.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 78aa448e869f..ddcf404f9c80 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -250,6 +250,22 @@
 			opp-microvolt = <840000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <920000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1800000000 { /* BOOT FREQ */
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <1080000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
 	};
 
 	cpu1_opp_table: opp_table1 {
@@ -303,6 +319,22 @@
 			opp-microvolt = <840000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <920000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1800000000 { /* BOOT FREQ */
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <1080000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
 	};
 
 	soc {
-- 
2.11.0
