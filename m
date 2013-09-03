Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:46893 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759225Ab3ICAs1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2013 20:48:27 -0400
Received: by mail-qe0-f49.google.com with SMTP id da11so764032qeb.22
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2013 17:48:26 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@cam.ac.uk
Cc: marex@denx.de, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] iio: mxs-lradc: Add MODULE_ALIAS
Date: Mon,  2 Sep 2013 21:48:12 -0300
Message-Id: <1378169292-29899-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1378169292-29899-1-git-send-email-festevam@gmail.com>
References: <1378169292-29899-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add MODULE_ALIAS, so that auto module loading can work.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 75f5aac..f36cde5 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1038,3 +1038,4 @@ module_platform_driver(mxs_lradc_driver);
 MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
 MODULE_DESCRIPTION("Freescale i.MX28 LRADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.8.1.2

