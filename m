Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43115 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbdBNJlz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2017 04:41:55 -0500
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
Subject: [PATCH v3 14/18] mfd: axp20x: add MFD cells for AXP20X and AXP22X battery driver
Date: Tue, 14 Feb 2017 10:41:08 +0100
Message-Id: <20170214094112.27426-15-quentin.schulz@free-electrons.com>
In-Reply-To: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.

This patch adds the AXP20X/AXP22X battery driver to the MFD cells of the
AXP209, AXP221 and AXP223 MFD.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 86bc1d5..b75d5c5 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -585,6 +585,9 @@ static struct mfd_cell axp20x_cells[] = {
 	}, {
 		.name		= "axp20x-adc",
 	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp209-battery-power-supply",
+	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp202-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
@@ -612,6 +615,9 @@ static struct mfd_cell axp221_cells[] = {
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
 		.resources	= axp20x_ac_power_supply_resources,
 	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp221-battery-power-supply",
+	}, {
 		.name		= "axp20x-usb-power-supply",
 		.of_compatible	= "x-powers,axp221-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
@@ -627,6 +633,9 @@ static struct mfd_cell axp223_cells[] = {
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

