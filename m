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
Subject: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
Date: Thu, 30 Aug 2018 17:45:15 +0200
Message-Id: <20180830154518.29507-28-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The H3 SID is supported by the kernel so we can add a NVMEM Data cell,
that contains the calibration data.

On the H3 the eFuses are located at the offset 0x200. The thermal data
itself has an offset of 0x34 from the eFuse base. So we end on an offset
of 0x234.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 1866aec69ec1..0fc447f0c02a 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -106,8 +106,15 @@
 
 	soc {
 		sid: eeprom@1c14000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "allwinner,sun8i-h3-sid";
 			reg = <0x01c14000 0x400>;
+
+			/* Data cells */
+			thermal_calibration: calib@234 {
+				reg = <0x234 0x8>;
+			};
 		};
 	};
 
@@ -227,4 +234,6 @@
 &ths {
 	compatible = "allwinner,sun8i-h3-ths";
 	#thermal-sensor-cells = <0>;
+	nvmem-cells = <&thermal_calibration>;
+	nvmem-cell-names = "calibration";
 };
-- 
2.11.0
