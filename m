Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57509 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbcLMOdp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2016 09:33:45 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        wens@csie.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com
Subject: [PATCH v9 2/3] mfd: Kconfig: MFD_SUN4I_GPADC depends on !TOUCHSCREN_SUN4I_GPADC
Date: Tue, 13 Dec 2016 15:33:31 +0100
Message-Id: <20161213143332.24988-3-quentin.schulz@free-electrons.com>
In-Reply-To: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

MFD_SUN4I_GPADC and TOUCHSCREEN_SUN4I are incompatible (both are drivers
for Allwinner SoCs' ADC). This makes sure TOUCHSCREEN_SUN4I isn't
enabled while MFD_SUN4I_GPADC is enabled.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v8. I wrongly put the XOR dependance for SUN4I_GPADC and
TOUCHSCREEN_SUN4I instead of for MFD_SUN4I_GPADC and TOUCHSCREEN_SUN4I.

 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 443ee50..e803884 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -45,6 +45,7 @@ config MFD_SUN4I_GPADC
 	select MFD_CORE
 	select REGMAP_MMIO
 	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on !TOUCHSCREEN_SUN4I
 	help
 	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
 	  This driver will only map the hardware interrupt and registers, you
-- 
2.9.3

