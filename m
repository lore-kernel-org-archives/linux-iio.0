Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:36120 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab3H0L3s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2013 07:29:48 -0400
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com,
	Josh Wu <josh.wu@atmel.com>
Subject: [PATCH v3 1/6] iio: at91: fix adc_clk overflow
Date: Tue, 27 Aug 2013 19:28:47 +0800
Message-Id: <1377602932-1899-2-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The adc_clk variable is currently defined using a 32-bits unsigned integer,
which will overflow under some very valid range of operations.

Such overflow will occur if, for example, the parent clock is set to a
20MHz frequency and the ADC startup time is larger than 215ns.

To fix this, introduce an intermediate variable holding the clock rate
in kHz.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
v1 --> v2:
  refined the commit message.

 drivers/iio/adc/at91_adc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index b6db6a0..9cf8ab5 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -582,7 +582,7 @@ static const struct iio_info at91_adc_info = {
 
 static int at91_adc_probe(struct platform_device *pdev)
 {
-	unsigned int prsc, mstrclk, ticks, adc_clk, shtim;
+	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
 	int ret;
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
@@ -680,6 +680,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	 */
 	mstrclk = clk_get_rate(st->clk);
 	adc_clk = clk_get_rate(st->adc_clk);
+	adc_clk_khz = adc_clk / 1000;
 	prsc = (mstrclk / (2 * adc_clk)) - 1;
 
 	if (!st->startup_time) {
@@ -693,15 +694,15 @@ static int at91_adc_probe(struct platform_device *pdev)
 	 * defined in the electrical characteristics of the board, divided by 8.
 	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
 	 */
-	ticks = round_up((st->startup_time * adc_clk /
-			  1000000) - 1, 8) / 8;
+	ticks = round_up((st->startup_time * adc_clk_khz /
+			  1000) - 1, 8) / 8;
 	/*
 	 * a minimal Sample and Hold Time is necessary for the ADC to guarantee
 	 * the best converted final value between two channels selection
 	 * The formula thus is : Sample and Hold Time = (shtim + 1) / ADCClock
 	 */
-	shtim = round_up((st->sample_hold_time * adc_clk /
-			  1000000) - 1, 1);
+	shtim = round_up((st->sample_hold_time * adc_clk_khz /
+			  1000) - 1, 1);
 
 	reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
 	reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
-- 
1.7.10

