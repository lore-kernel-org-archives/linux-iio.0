Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:14389 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933749AbbCPVhN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2015 17:37:13 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org,
	jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
	knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de,
	daniel.lezcano@linaro.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/6] clocksource/sh_cmt.c: Fix !HAS_IOMEM build
Date: Mon, 16 Mar 2015 22:27:05 +0100
Message-Id: <1426541230-928-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes:
drivers/clocksource/sh_cmt.c: In function ‘sh_cmt_map_memory’:
drivers/clocksource/sh_cmt.c:920:2: error: implicit declaration of function ‘ioremap_nocache’ [-Werror=implicit-function-declaration]
  cmt->mapbase = ioremap_nocache(mem->start, resource_size(mem));
  ^
drivers/clocksource/sh_cmt.c:920:15: warning: assignment makes pointer from integer without a cast [enabled by default]
  cmt->mapbase = ioremap_nocache(mem->start, resource_size(mem));
               ^
drivers/clocksource/sh_cmt.c: In function ‘sh_cmt_setup’:
drivers/clocksource/sh_cmt.c:1034:2: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
  iounmap(cmt->mapbase);

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 68161f7..c948f4e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -192,6 +192,7 @@ config SYS_SUPPORTS_EM_STI
 config SH_TIMER_CMT
 	bool "Renesas CMT timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	default SYS_SUPPORTS_SH_CMT
 	help
 	  This enables build of a clocksource and clockevent driver for
-- 
1.8.4.5

