Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:46001 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbcCYWqU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 18:46:20 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/8] phy: Fix phy-omap-control dependencies
Date: Fri, 25 Mar 2016 23:40:50 +0100
Message-Id: <1458945655-5027-3-git-send-email-richard@nod.at>
In-Reply-To: <1458945655-5027-1-git-send-email-richard@nod.at>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not all archs have io memory.

Fixes the following build error:
ERROR: "devm_ioremap_resource" [drivers/phy/phy-omap-control.ko] undefined!

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 78d2981..7856e7d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -127,6 +127,7 @@ config PHY_RCAR_GEN3_USB2
 
 config OMAP_CONTROL_PHY
 	tristate "OMAP CONTROL PHY Driver"
+	depends on HAS_IOMEM
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  Enable this to add support for the PHY part present in the control
-- 
1.8.4.5

