Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42747 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933023AbdABQiA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 11:38:00 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH 02/22] mfd: axp20x: add ADC data regs to volatile regs for AXP22X
Date: Mon,  2 Jan 2017 17:37:02 +0100
Message-Id: <20170102163723.7939-3-quentin.schulz@free-electrons.com>
In-Reply-To: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AXP22X PMICs have multiple ADCs, each one exposing data from the
different power supplies connected to the PMIC.

This adds the different ADC data registers to the volatile registers of
the AXP22X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 619a83e..a33db5e 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -100,6 +100,7 @@ static const struct regmap_range axp22x_writeable_ranges[] = {
 static const struct regmap_range axp22x_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
 	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
+	regmap_reg_range(AXP22X_TEMP_ADC_H, AXP20X_BATT_DISCHRG_I_L),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
 	regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
-- 
2.9.3

