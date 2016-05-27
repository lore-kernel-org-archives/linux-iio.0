Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34344 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbcE0WJg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 May 2016 18:09:36 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	sfr@canb.auug.org.au, linux@roeck-us.net,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH v5 4/4] watchdog: ebc-c384_wdt: Allow build for X86_64
Date: Fri, 27 May 2016 18:09:27 -0400
Message-Id: <383c17191c8261b578f057a969277fbbe918ef01.1464380034.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1464380034.git.vilhelm.gray@gmail.com>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

With the introduction of the ISA_BUS_API Kconfig option, ISA-style
drivers may be built for X86_64 architectures. This patch changes the
ISA Kconfig option dependency of the WinSystems EBC-C384 watchdog timer
driver to ISA_BUS_API, thus allowing it to build for X86_64 as it is
expected to.

Cc: Wim Van Sebroeck <wim@iguana.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b54f26c..b4b3e25 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -746,7 +746,7 @@ config ALIM7101_WDT
 
 config EBC_C384_WDT
 	tristate "WinSystems EBC-C384 Watchdog Timer"
-	depends on X86 && ISA
+	depends on X86 && ISA_BUS_API
 	select WATCHDOG_CORE
 	help
 	  Enables watchdog timer support for the watchdog timer on the
-- 
2.7.3

