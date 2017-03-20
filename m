Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38673 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbdCTIRu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 04:17:50 -0400
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
Subject: [RESEND PATCH v4 9/9] mfd: axp20x: add CHRG_CTRL1/2/3 to writeable regs for AXP20X/AXP22X
Date: Mon, 20 Mar 2017 09:16:53 +0100
Message-Id: <20170320081653.8884-10-quentin.schulz@free-electrons.com>
In-Reply-To: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The CHRG_CTRL1 and CHRG_CTRL2 registers are made for controlling
different battery charging settings such as the constant current charge
value.

The AXP22X also have a third register CHRG_CTRL3 which has settings for
battery charging too.

This adds the CHRG_CTRL1, CHRG_CTRL2 and CHRG_CTRL3 registers to the
list of writeable registers for AXP20X and AXP22X PMICs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

v2:
 - added AXP20X_CHRG_CTRL2 and AXP20X_CHRG_CTRL3 to the writeable
 registers table,
 - removed added reg range for ADC data in volatile regs range,

 drivers/mfd/axp20x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 37643b1..5ba3b04 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -68,6 +68,7 @@ static const struct regmap_access_table axp152_volatile_table = {
 
 static const struct regmap_range axp20x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
 	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
 };
@@ -94,6 +95,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
 /* AXP22x ranges are shared with the AXP809, as they cover the same range */
 static const struct regmap_range axp22x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP22X_CHRG_CTRL3),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
 };
 
-- 
2.9.3

