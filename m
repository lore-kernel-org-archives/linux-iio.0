Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45041 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdLQJH5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Dec 2017 04:07:57 -0500
Received: by mail-pl0-f66.google.com with SMTP id n13so3025793plp.11
        for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2017 01:07:57 -0800 (PST)
From: venkat.prashanth2498@gmail.com
To: lars@metafoo.de, Michael.Hennerich@analog.com
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org,
        Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [PATCH] Drivers: iio:adc: fix brace coding style issue in at91_adc.c
Date: Sun, 17 Dec 2017 14:37:48 +0530
Message-Id: <1513501668-13227-1-git-send-email-venkat.prashanth2498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

This is a patch to the at91_adc.c file that fixes up a brace
warning found by the checkpatch.pl tool

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 7b40925..a4767d6 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1165,9 +1165,9 @@ static int at91_adc_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

 	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(st->reg_base)) {
+	if (IS_ERR(st->reg_base))
 		return PTR_ERR(st->reg_base);
-	}
+

 	/*
 	 * Disable all IRQs before setting up the handler
--
1.9.1

