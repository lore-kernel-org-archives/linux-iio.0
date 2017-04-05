Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59848 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbdDEILU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 04:11:20 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, icenowy@aosc.xyz
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        liam@networkimprov.net, thomas.petazzoni@free-electrons.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v5 4/7] ARM: dtsi: axp209: add battery power supply subnode
Date: Wed,  5 Apr 2017 10:10:56 +0200
Message-Id: <20170405081059.1684-5-quentin.schulz@free-electrons.com>
In-Reply-To: <20170405081059.1684-1-quentin.schulz@free-electrons.com>
References: <20170405081059.1684-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP209 PMIC exposes battery supply various data such as
the battery status (charging, discharging, full, dead), current max
limit, current current, battery capacity (in percentage), voltage max
and min limits, current voltage, and battery capacity (in Ah).

This adds the battery power supply subnode for AXP20X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---

v2:
 - changed DT node name from battery_power_supply to
 battery-power-supply,
 - removed io-channels and io-channel-names from DT (the IIO mapping is
 done in the IIO ADC driver now),

 arch/arm/boot/dts/axp209.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 9677dd5..3c8fa26 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -64,6 +64,11 @@
 		#gpio-cells = <2>;
 	};
 
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp209-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <1500>;
-- 
2.9.3

