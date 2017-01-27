Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46013 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbdA0I6C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 03:58:02 -0500
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
Subject: [PATCH v2 18/25] mfd: axp20x: add V_OFF to writeable regs for AXP20X and AXP22X
Date: Fri, 27 Jan 2017 09:54:51 +0100
Message-Id: <20170127085458.18270-19-quentin.schulz@free-electrons.com>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The V_OFF register has its first 3 read-write bits for the minimal
voltage (Voff) of the battery before the system is automatically shut
down due to the power being too low.

This adds V_OFF register to the writeable registers of AXP20X and AXP22X
PMICs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8210623..223dffe 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -65,7 +65,7 @@ static const struct regmap_access_table axp152_volatile_table = {
 
 static const struct regmap_range axp20x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
-	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
+	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_V_OFF),
 	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
 	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
@@ -94,7 +94,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
 /* AXP22x ranges are shared with the AXP809, as they cover the same range */
 static const struct regmap_range axp22x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
-	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
+	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_V_OFF),
 	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP22X_CHRG_CTRL3),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
 };
-- 
2.9.3

