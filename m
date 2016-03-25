Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:46003 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbcCYWqU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 18:46:20 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 5/8] nvmem: Fix io memory dependencies
Date: Fri, 25 Mar 2016 23:40:52 +0100
Message-Id: <1458945655-5027-5-git-send-email-richard@nod.at>
In-Reply-To: <1458945655-5027-1-git-send-email-richard@nod.at>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not all archs have io memory.

Fixes the following build error:
ERROR: "devm_ioremap_resource" [drivers/nvmem/nvmem_mtk-efuse.ko] undefined!
ERROR: "devm_ioremap_resource" [drivers/nvmem/nvmem_lpc18xx_eeprom.ko] undefined!

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/nvmem/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ca52952..3766da3 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -27,6 +27,7 @@ config NVMEM_IMX_OCOTP
 
 config NVMEM_LPC18XX_EEPROM
 	tristate "NXP LPC18XX EEPROM Memory Support"
+	depends on HAS_IOMEM
 	depends on ARCH_LPC18XX || COMPILE_TEST
 	help
 	  Say Y here to include support for NXP LPC18xx EEPROM memory found in
@@ -48,6 +49,7 @@ config NVMEM_MXS_OCOTP
 
 config MTK_EFUSE
 	tristate "Mediatek SoCs EFUSE support"
+	depends on HAS_IOMEM
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select REGMAP_MMIO
 	help
-- 
1.8.4.5

