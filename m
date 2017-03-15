Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58725 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbdCOK4d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 06:56:33 -0400
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
Subject: [PATCH v4 06/18] mfd: axp20x: add AC power supply cells for AXP22X PMICs
Date: Wed, 15 Mar 2017 11:55:25 +0100
Message-Id: <20170315105537.22349-7-quentin.schulz@free-electrons.com>
In-Reply-To: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
supply.

This adds the AC power supply driver to the MFD cells of the AXP22X
PMICs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0b6361e..a58326e 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -613,6 +613,11 @@ static struct mfd_cell axp221_cells[] = {
 	}, {
 		.name		= "axp22x-adc"
 	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp221-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
+	}, {
 		.name		= "axp20x-usb-power-supply",
 		.of_compatible	= "x-powers,axp221-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
@@ -630,6 +635,11 @@ static struct mfd_cell axp223_cells[] = {
 	}, {
 		.name			= "axp20x-regulator",
 	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp221-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
+	}, {
 		.name		= "axp20x-usb-power-supply",
 		.of_compatible	= "x-powers,axp223-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
-- 
2.9.3

