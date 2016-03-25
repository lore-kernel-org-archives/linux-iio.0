Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:46000 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbcCYWqT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 18:46:19 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 2/8] mailbox: Fix rockchip dependencies
Date: Fri, 25 Mar 2016 23:40:49 +0100
Message-Id: <1458945655-5027-2-git-send-email-richard@nod.at>
In-Reply-To: <1458945655-5027-1-git-send-email-richard@nod.at>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver needs io memory but not all archs offer it.

Fixes the following build error:
drivers/built-in.o: In function `rockchip_mbox_probe':
rockchip-mailbox.c:(.text+0x4b19c): undefined reference to `devm_ioremap_resource'

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 5305923..5ee207c 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -45,6 +45,7 @@ config OMAP_MBOX_KFIFO_SIZE
 
 config ROCKCHIP_MBOX
 	bool "Rockchip Soc Intergrated Mailbox Support"
+	depends on HAS_IOMEM
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  This driver provides support for inter-processor communication
-- 
1.8.4.5

