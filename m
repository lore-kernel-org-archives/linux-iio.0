Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46904 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754744AbdA0JIC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 04:08:02 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH v2 05/25] mfd: axp20x: add ADC cells for AXP20X and AXP22X PMICs
Date: Fri, 27 Jan 2017 09:54:38 +0100
Message-Id: <20170127085458.18270-6-quentin.schulz@free-electrons.com>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
AXP221 and AXP223 MFD.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 9c2fd37..cdc729d 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -581,6 +581,9 @@ static struct mfd_cell axp20x_cells[] = {
 	}, {
 		.name		= "axp20x-regulator",
 	}, {
+		.name		= "axp20x-adc",
+		.of_compatible	= "x-powers,axp209-adc",
+	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp202-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
@@ -601,6 +604,9 @@ static struct mfd_cell axp221_cells[] = {
 	}, {
 		.name		= "axp20x-regulator",
 	}, {
+		.name		= "axp20x-adc",
+		.of_compatible	= "x-powers,axp221-adc"
+	}, {
 		.name		= "axp20x-usb-power-supply",
 		.of_compatible	= "x-powers,axp221-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
@@ -614,6 +620,9 @@ static struct mfd_cell axp223_cells[] = {
 		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
 		.resources		= axp22x_pek_resources,
 	}, {
+		.name		= "axp20x-adc",
+		.of_compatible	= "x-powers,axp221-adc"
+	}, {
 		.name			= "axp20x-regulator",
 	}, {
 		.name		= "axp20x-usb-power-supply",
-- 
2.9.3

