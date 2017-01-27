Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48805 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932421AbdA0Jvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 04:51:53 -0500
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
Subject: [PATCH v2 11/25] mfd: axp20x: add AC power supply cells for AXP22X PMICs
Date: Fri, 27 Jan 2017 09:54:44 +0100
Message-Id: <20170127085458.18270-12-quentin.schulz@free-electrons.com>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
supply.

This adds the AC power supply driver to the MFD cells of the AXP22X
PMICs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index cdc729d..7607c30 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -607,6 +607,11 @@ static struct mfd_cell axp221_cells[] = {
 		.name		= "axp20x-adc",
 		.of_compatible	= "x-powers,axp221-adc"
 	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp221-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
+	}, {
 		.name		= "axp20x-usb-power-supply",
 		.of_compatible	= "x-powers,axp221-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
@@ -625,6 +630,11 @@ static struct mfd_cell axp223_cells[] = {
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

