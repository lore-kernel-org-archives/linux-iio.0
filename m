Return-Path: <josh.wu@atmel.com>
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
        nicolas.ferre@atmel.com, Josh Wu <josh.wu@atmel.com>
Subject: [PATCH 1/5] iio: at91: use adc_clk_khz to make the calculation not easy to large than u32.
Date: Sun, 14 Jul 2013 16:04:25 +0800
Message-Id: <1373789069-11604-2-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
List-ID: <linux-iio@vger.kernel.org>

for example, if adc_clk is 20Mhz and start-up time set as larger than 215us.
then the calculation "st->startup_time * adc_clk_khz" will out of u32.

In this patch, it will use khz unit for adc_clk, that avoids above problem.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/iio/adc/at91_adc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index e5b88d5..18bd54f 100644
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
