Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:55437 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3JUJ2a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 05:28:30 -0400
Received: by mail-pb0-f51.google.com with SMTP id wz7so2197357pbc.38
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2013 02:28:30 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 2/2] iio: adc: ti_am335x_adc: Remove redundant of_match_ptr
Date: Mon, 21 Oct 2013 14:57:29 +0530
Message-Id: <1382347649-3382-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382347649-3382-1-git-send-email-sachin.kamat@linaro.org>
References: <1382347649-3382-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ti_adc_dt_ids is always compiled in. Hence of_match_ptr is not
needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/ti_am335x_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 8fb5429..ef553d0 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -515,7 +515,7 @@ static struct platform_driver tiadc_driver = {
 		.name   = "TI-am335x-adc",
 		.owner	= THIS_MODULE,
 		.pm	= TIADC_PM_OPS,
-		.of_match_table = of_match_ptr(ti_adc_dt_ids),
+		.of_match_table = ti_adc_dt_ids,
 	},
 	.probe	= tiadc_probe,
 	.remove	= tiadc_remove,
-- 
1.7.9.5

