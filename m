Return-Path: <SRS0=hNPF=AV=aosc.io=icenowy@kernel.org>
From: Icenowy Zheng <icenowy@aosc.io>
To: Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 6/7] arm64: allwinner: a64: add power supply nodes in AXP803 DTSI
Date: Wed, 20 Sep 2017 23:18:13 +0800
Message-Id: <20170920151814.22461-7-icenowy@aosc.io>
In-Reply-To: <20170920151814.22461-1-icenowy@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io>
List-ID: <linux-iio@vger.kernel.org>

AXP803 PMIC features AC/USB/Battery power supplies.

As we have now the device tree bindings for them, add device tree
nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index ff8af52743ff..3a8615231b7c 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,16 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp221-ac-power-supply";
+		status = "disabled";
+	};
+
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp803-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
@@ -147,4 +157,9 @@
 			regulator-name = "rtc-ldo";
 		};
 	};
+
+	usb_power_supply: usb_power_supply {
+		compatible = "x-powers,axp803-usb-power-supply";
+		status = "disabled";
+	};
 };
-- 
2.13.5
