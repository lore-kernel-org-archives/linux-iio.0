Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54206 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdLDOPM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 09:15:12 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, jic23@kernel.org,
        lee.jones@linaro.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, icenowy@aosc.io,
        linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 7/8] ARM: dtsi: axp81x: add battery power supply subnode
Date: Mon,  4 Dec 2017 15:12:53 +0100
Message-Id: <2c07b03783932463186237ed8487d664d4743ee8.1512396054.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
index 73b761f..f7401c3 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -48,6 +48,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
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
