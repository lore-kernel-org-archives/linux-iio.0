Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51174 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab3EWFkO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2013 01:40:14 -0400
Received: by mail-pd0-f174.google.com with SMTP id 3so683907pdj.5
        for <linux-iio@vger.kernel.org>; Wed, 22 May 2013 22:40:13 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/1] iio: at91_adc: Add missing CONFIG_OF macro
Date: Thu, 23 May 2013 10:56:27 +0530
Message-Id: <1369286787-8448-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The data structure is required only when DT is enabled.
Hence compile it conditionally.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/at91_adc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index e5b88d5..b6db6a0 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -774,11 +774,13 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id at91_adc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9260-adc" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
+#endif
 
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
-- 
1.7.9.5

