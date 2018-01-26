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
Subject: [PATCH 16/16] arm: dts: sun8i: a83t: add thermal zone to A83T
Date: Fri, 26 Jan 2018 16:19:41 +0100
Message-Id: <20180126151941.12183-17-embed3d@gmail.com>
In-Reply-To: <20180126151941.12183-1-embed3d@gmail.com>
References: <20180126151941.12183-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds the thermal zones to the A83T. Sensor 0 is located in the
cpu cluster 0. Sensor 1 is located in cluster 1 and Sensor 3 is located
in the gpu.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 9e53ff5ac4ed..4259a8726031 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -747,4 +747,24 @@
 			#size-cells = <0>;
 		};
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 0>;
+		};
+
+		cpu1_thermal: cpu1-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 1>;
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
