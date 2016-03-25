Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:45999 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbcCYWqT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 18:46:19 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/8] phy: Fix phy-hi6220-usb dependencies
Date: Fri, 25 Mar 2016 23:40:48 +0100
Message-Id: <1458945655-5027-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver needs io memory.

Fixes the following Kconfig warning:
warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)

And this build error:
drivers/mfd/syscon.c: In function ‘of_syscon_register’:
drivers/mfd/syscon.c:67:2: error: implicit declaration of function ‘ioremap’ [-Werror=implicit-function-declaration]
  base = ioremap(res.start, resource_size(&res));
  ^
drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer without a cast [enabled by default]
  base = ioremap(res.start, resource_size(&res));
       ^
drivers/mfd/syscon.c:109:2: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
  iounmap(base);

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: d896910f3 ("phy: Restrict phy-hi6220-usb to HiSilicon arm64")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 26566db..78d2981 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -224,6 +224,7 @@ config PHY_MT65XX_USB3
 
 config PHY_HI6220_USB
 	tristate "hi6220 USB PHY support"
+	depends on HAS_IOMEM
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
 	select GENERIC_PHY
 	select MFD_SYSCON
-- 
1.8.4.5

