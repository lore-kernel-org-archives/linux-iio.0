Return-Path: <SRS0=zW5g=EX=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	davem@davemloft.net,
	hans.verkuil@cisco.com,
	mchehab@kernel.org,
	rask@formelder.dk,
	clabbe.montjoie@gmail.com,
	sean@mess.org,
	krzk@kernel.org,
	quentin.schulz@free-electrons.com,
	icenowy@aosc.io,
	edu.molinas@gmail.com,
	singhalsimran0@gmail.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v2 14/16] arm: dts: sun8i: h3: enable H3 sid controller
Date: Mon, 29 Jan 2018 00:29:17 +0100
Message-Id: <20180128232919.12639-15-embed3d@gmail.com>
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch enables the the sid controller in the H3. It can be used
for thermal calibration data.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 3f83f6a27c74..9bb5cc29fec5 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -72,6 +72,13 @@
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
