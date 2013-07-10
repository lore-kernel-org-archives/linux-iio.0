Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ye0-f180.google.com ([209.85.213.180]:45103 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab3GJCgY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2013 22:36:24 -0400
Received: by mail-ye0-f180.google.com with SMTP id r11so2217425yen.39
        for <linux-iio@vger.kernel.org>; Tue, 09 Jul 2013 19:36:22 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@cam.ac.uk
Cc: marex@denx.de, shawn.guo@linaro.org, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] iio: mxs-lradc: Check the return value from stmp_reset_block()
Date: Tue,  9 Jul 2013 23:36:15 -0300
Message-Id: <1373423775-11053-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

stmp_reset_block() may fail, so let's check its return value and propagate it in
the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d92c97a..327914e 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -845,14 +845,16 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
 	MXS_ADC_CHAN(15, IIO_VOLTAGE),	/* VDD5V */
 };
 
-static void mxs_lradc_hw_init(struct mxs_lradc *lradc)
+static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
 {
 	/* The ADC always uses DELAY CHANNEL 0. */
 	const uint32_t adc_cfg =
 		(1 << (LRADC_DELAY_TRIGGER_DELAYS_OFFSET + 0)) |
 		(LRADC_DELAY_TIMER_PER << LRADC_DELAY_DELAY_OFFSET);
 
-	stmp_reset_block(lradc->base);
+	int ret = stmp_reset_block(lradc->base);
+	if (ret)
+		return ret;
 
 	/* Configure DELAY CHANNEL 0 for generic ADC sampling. */
 	writel(adc_cfg, lradc->base + LRADC_DELAY(0));
@@ -873,6 +875,8 @@ static void mxs_lradc_hw_init(struct mxs_lradc *lradc)
 
 	/* Start internal temperature sensing. */
 	writel(0, lradc->base + LRADC_CTRL2);
+
+	return 0;
 }
 
 static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
@@ -980,7 +984,9 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 		goto err_trig;
 
 	/* Configure the hardware. */
-	mxs_lradc_hw_init(lradc);
+	ret = mxs_lradc_hw_init(lradc);
+	if (ret)
+		goto err_dev;
 
 	/* Register the touchscreen input device. */
 	ret = mxs_lradc_ts_register(lradc);
-- 
1.8.1.2

