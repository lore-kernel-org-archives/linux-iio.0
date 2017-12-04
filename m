Return-Path: <SRS0=JY12=DA=free-electrons.com=quentin.schulz@kernel.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: sre@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	maxime.ripard@free-electrons.com,
	jic23@kernel.org,
	lee.jones@linaro.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	icenowy@aosc.io,
	linux-sunxi@googlegroups.com,
	thomas.petazzoni@free-electrons.com,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 8/8] ARM: dtsi: sun8i: a711: enable battery power supply subnode
Date: Mon,  4 Dec 2017 15:12:54 +0100
Message-Id: <2af471ef9bee675a2cf411b9d2dd602eb4aa448b.1512396054.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

The TBS A711 has an AXP813 PMIC and a soldered battery, thus, we enable
the battery power supply subnode in its Device Tree.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 9871553..806cb17 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -181,6 +181,10 @@
 
 #include "axp81x.dtsi"
 
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
git-series 0.9.1
