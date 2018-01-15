Return-Path: <SRS0=dCX1=EK=free-electrons.com=quentin.schulz@kernel.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	wens@csie.org,
	sre@kernel.org,
	linux@armlinux.org.uk,
	maxime.ripard@free-electrons.com,
	lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	linux-sunxi@googlegroups.com,
	julian.calaby@gmail.com,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 14/16] ARM: dtsi: axp81x: add battery power supply subnode
Date: Mon, 15 Jan 2018 11:33:48 +0100
Message-Id: <9c045de8dcee9a71803978855762e272efdc41d3.1516012352.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

The X-Powers AXP81X PMIC exposes battery supply various data such as
the battery status (charging, discharging, full, dead), current max
limit, current current, battery capacity (in percentage), voltage max
and min limits, current voltage, and battery capacity (in Ah).

This adds the battery power supply subnode for AXP81X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 6b5e7bc..1b05c7f 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -69,6 +69,11 @@
 		};
 	};
 
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp813-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
git-series 0.9.1
