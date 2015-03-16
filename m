Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:14387 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933750AbbCPVhN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2015 17:37:13 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org,
	jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
	knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de,
	daniel.lezcano@linaro.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/6] clocksource/sh_mtu2.c: Fix !HAS_IOMEM build
Date: Mon, 16 Mar 2015 22:27:06 +0100
Message-Id: <1426541230-928-2-git-send-email-richard@nod.at>
In-Reply-To: <1426541230-928-1-git-send-email-richard@nod.at>
References: <1426541230-928-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes:
drivers/clocksource/sh_mtu2.c: In function ‘sh_mtu2_map_memory’:
drivers/clocksource/sh_mtu2.c:391:2: error: implicit declaration of function ‘ioremap_nocache’ [-Werror=implicit-function-declaration]
  mtu->mapbase = ioremap_nocache(res->start, resource_size(res));
  ^
drivers/clocksource/sh_mtu2.c:391:15: warning: assignment makes pointer from integer without a cast [enabled by default]
  mtu->mapbase = ioremap_nocache(res->start, resource_size(res));
               ^
drivers/clocksource/sh_mtu2.c: In function ‘sh_mtu2_setup’:
drivers/clocksource/sh_mtu2.c:448:2: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
  iounmap(mtu->mapbase);

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c948f4e..c4063a6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -202,6 +202,7 @@ config SH_TIMER_CMT
 config SH_TIMER_MTU2
 	bool "Renesas MTU2 timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	default SYS_SUPPORTS_SH_MTU2
 	help
 	  This enables build of a clockevent driver for the Multi-Function
-- 
1.8.4.5

