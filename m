Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35510 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdK3Pn7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Nov 2017 10:43:59 -0500
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        samuel@sortiz.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH 2/3] staging: irda: Handle return value of platform_get_irq
Date: Thu, 30 Nov 2017 21:13:35 +0530
Message-Id: <1512056616-21065-3-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/staging/irda/drivers/pxaficp_ir.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/irda/drivers/pxaficp_ir.c b/drivers/staging/irda/drivers/pxaficp_ir.c
index 1dba16b..a97ce04 100644
--- a/drivers/staging/irda/drivers/pxaficp_ir.c
+++ b/drivers/staging/irda/drivers/pxaficp_ir.c
@@ -960,7 +960,17 @@ static int pxa_irda_probe(struct platform_device *pdev)
 	si->irda_base = ficp;
 	si->stuart_base = stuart;
 	si->uart_irq = platform_get_irq(pdev, 0);
+	if (si->uart_irq < 0) {
+		err =  si->uart_irq;
+		goto err_mem_1;
+	}
+
 	si->icp_irq = platform_get_irq(pdev, 1);
+	if (si->icp_irq < 0) {
+		err =  si->icp_irq;
+		goto err_mem_1;
+	}
+
 
 	si->sir_clk = devm_clk_get(&pdev->dev, "UARTCLK");
 	si->fir_clk = devm_clk_get(&pdev->dev, "FICPCLK");
-- 
2.7.4

