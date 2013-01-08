Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ye0-f176.google.com ([209.85.213.176]:52000 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3AHBbQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jan 2013 20:31:16 -0500
Received: by mail-ye0-f176.google.com with SMTP id m1so3143064yen.35
        for <linux-iio@vger.kernel.org>; Mon, 07 Jan 2013 17:31:15 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@cam.ac.uk
Cc: marex@denx.de, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] iio: mxs-lradc: indexes are unsigned
Date: Mon,  7 Jan 2013 23:05:17 -0200
Message-Id: <1357607117-5868-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following warning when building with W=1 option:

drivers/staging/iio/adc/mxs-lradc.c: In function 'mxs_lradc_trigger_handler':
drivers/staging/iio/adc/mxs-lradc.c:244:2: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/iio/adc/mxs-lradc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index fb31b45..6cf3af8 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -239,7 +239,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
 	struct mxs_lradc *lradc = iio_priv(iio);
 	const uint32_t chan_value = LRADC_CH_ACCUMULATE |
 		((LRADC_DELAY_TIMER_LOOP - 1) << LRADC_CH_NUM_SAMPLES_OFFSET);
-	int i, j = 0;
+	u32 i, j = 0;
 
 	for_each_set_bit(i, iio->active_scan_mask, iio->masklength) {
 		lradc->buffer[j] = readl(lradc->base + LRADC_CH(j));
-- 
1.7.9.5

