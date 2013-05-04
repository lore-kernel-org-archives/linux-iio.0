Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:34130 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758751Ab3EDN1n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 4 May 2013 09:27:43 -0400
Message-Id: <ba60ca91ef1d3061b454e518f6026a1157fae5d7.1367671597.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <6bb527db65fb20f60bb95814bff3abc513733a7c.1367671597.git.mirq-linux@rere.qmqm.pl>
References: <6bb527db65fb20f60bb95814bff3abc513733a7c.1367671597.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] staging/iio/mxs-lradc: fix preenable for multiple buffers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Date: Sat,  4 May 2013 15:19:35 +0200 (CEST)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This fixes 'preenable failed: -EINVAL' error when using this driver.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/staging/iio/adc/mxs-lradc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 03299ea..d92c97a 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -690,7 +690,6 @@ static void mxs_lradc_trigger_remove(struct iio_dev *iio)
 static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 {
 	struct mxs_lradc *lradc = iio_priv(iio);
-	struct iio_buffer *buffer = iio->buffer;
 	int ret = 0, chan, ofs = 0;
 	unsigned long enable = 0;
 	uint32_t ctrl4_set = 0;
@@ -698,7 +697,7 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 	uint32_t ctrl1_irq = 0;
 	const uint32_t chan_value = LRADC_CH_ACCUMULATE |
 		((LRADC_DELAY_TIMER_LOOP - 1) << LRADC_CH_NUM_SAMPLES_OFFSET);
-	const int len = bitmap_weight(buffer->scan_mask, LRADC_MAX_TOTAL_CHANS);
+	const int len = bitmap_weight(iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS);
 
 	if (!len)
 		return -EINVAL;
@@ -725,7 +724,7 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 
-	for_each_set_bit(chan, buffer->scan_mask, LRADC_MAX_TOTAL_CHANS) {
+	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
 		ctrl4_set |= chan << LRADC_CTRL4_LRADCSELECT_OFFSET(ofs);
 		ctrl4_clr |= LRADC_CTRL4_LRADCSELECT_MASK(ofs);
 		ctrl1_irq |= LRADC_CTRL1_LRADC_IRQ_EN(ofs);
-- 
1.7.10.4

