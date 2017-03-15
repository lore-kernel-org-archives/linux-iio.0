Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58734 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbdCOK4e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 06:56:34 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: icenowy@aosc.xyz, bonbons@linux-vserver.org, sre@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        liam@networkimprov.net, thomas.petazzoni@free-electrons.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v4 07/18] ARM: dtsi: axp209: add AC power supply subnode
Date: Wed, 15 Mar 2017 11:55:26 +0100
Message-Id: <20170315105537.22349-8-quentin.schulz@free-electrons.com>
In-Reply-To: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X PMIC exposes the status of AC power supply, the
current current and voltage supplied to the board by the AC power
supply.

This adds the AC power supply subnode for AXP20X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

v2:
 - changed DT node name from ac_power_supply to ac-power-supply,
 - removed io-channels and io-channel-names from DT (the IIO mapping is
 done in the IIO ADC driver now),

 arch/arm/boot/dts/axp209.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 675bb0f..9677dd5 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -53,6 +53,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp202-ac-power-supply";
+		status = "disabled";
+	};
+
 	axp_gpio: gpio {
 		compatible = "x-powers,axp209-gpio";
 		gpio-controller;
-- 
2.9.3

