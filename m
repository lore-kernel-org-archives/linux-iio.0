Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:45998 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbcCYWqT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 18:46:19 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4/8] phy: Fix phy-bcm-cygnus-pcie dependencies
Date: Fri, 25 Mar 2016 23:40:51 +0100
Message-Id: <1458945655-5027-4-git-send-email-richard@nod.at>
In-Reply-To: <1458945655-5027-1-git-send-email-richard@nod.at>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not all archs have io memory.

Fixes the following build error:
ERROR: "devm_ioremap_resource" [drivers/phy/phy-bcm-cygnus-pcie.ko] undefined!

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 7856e7d..d209eb1 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -416,6 +416,7 @@ config PHY_BRCMSTB_SATA
 
 config PHY_CYGNUS_PCIE
 	tristate "Broadcom Cygnus PCIe PHY driver"
+	depends on HAS_IOMEM
 	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
 	select GENERIC_PHY
 	default ARCH_BCM_CYGNUS
-- 
1.8.4.5

