Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58811 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbdCOK4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 06:56:41 -0400
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
Subject: [PATCH v4 14/18] mfd: axp20x: add MFD cells for AXP20X and AXP22X battery driver
Date: Wed, 15 Mar 2017 11:55:33 +0100
Message-Id: <20170315105537.22349-15-quentin.schulz@free-electrons.com>
In-Reply-To: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.

This patch adds the AXP20X/AXP22X battery driver to the MFD cells of the
AXP209, AXP221 and AXP223 MFD.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---

v2:
 - changed DT node name from battery_power_supply to
 battery-power-supply,
 - removed io-channels and io-channel-names from DT (the IIO mapping is
 done in the IIO ADC driver now),

 drivers/mfd/axp20x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index b2b6b16..3111b47 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -593,6 +593,9 @@ static struct mfd_cell axp20x_cells[] = {
 	}, {
 		.name		= "axp20x-adc",
 	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp209-battery-power-supply",
+	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp202-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
@@ -620,6 +623,9 @@ static struct mfd_cell axp221_cells[] = {
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
 		.resources	= axp20x_ac_power_supply_resources,
 	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp221-battery-power-supply",
+	}, {
 		.name		= "axp20x-usb-power-supply",
 		.of_compatible	= "x-powers,axp221-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
@@ -635,6 +641,9 @@ static struct mfd_cell axp223_cells[] = {
 	}, {
 		.name		= "axp22x-adc",
 	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp221-battery-power-supply",
+	}, {
 		.name			= "axp20x-regulator",
 	}, {
 		.name		= "axp20x-ac-power-supply",
-- 
2.9.3

