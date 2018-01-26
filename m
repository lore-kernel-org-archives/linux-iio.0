Return-Path: <SRS0=NR6Q=EV=gmail.com=embed3d@kernel.org>
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
Subject: [PATCH 11/16] arm: dts: sunxi-h3-h5: add support for the thermal sensor in H3 and H5
Date: Fri, 26 Jan 2018 16:19:36 +0100
Message-Id: <20180126151941.12183-12-embed3d@gmail.com>
In-Reply-To: <20180126151941.12183-1-embed3d@gmail.com>
References: <20180126151941.12183-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

As we have gained the support for the thermal sensor in H3 and H5,
we can now add its device nodes to the device tree. The H3 and H5 share
most of its compatible. The compatible and the thermal sensor cells
will be added in an additional patch per device.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 7a83b15225c7..413c789b588d 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -426,6 +426,15 @@
 			};
 		};
 
+		ths: thermal-sensor@1c25000 {
+			reg = <0x01c25000 0x100>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_THS>;
+			#io-channel-cells = <0>;
+		};
+
 		timer@1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
-- 
2.11.0
