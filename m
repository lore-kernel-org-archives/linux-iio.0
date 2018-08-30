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
Subject: [PATCH v3 26/30] ARM: dts: sun8i: h3: enable H3 sid controller
Date: Thu, 30 Aug 2018 17:45:14 +0200
Message-Id: <20180830154518.29507-27-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch enables the the sid controller in the H3. It can be used
for thermal calibration data.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 954848d5df50..1866aec69ec1 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -104,6 +104,13 @@
 		};
 	};
 
+	soc {
+		sid: eeprom@1c14000 {
+			compatible = "allwinner,sun8i-h3-sid";
+			reg = <0x01c14000 0x400>;
+		};
+	};
+
 	thermal-zones {
 		cpu-thermal {
 			/* milliseconds */
-- 
2.11.0
