Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:12756 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab3H0L3z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2013 07:29:55 -0400
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com,
	Josh Wu <josh.wu@atmel.com>
Subject: [PATCH v3 4/6] iio: at91: ADC start-up time calculation changed since at91sam9x5
Date: Tue, 27 Aug 2013 19:28:50 +0800
Message-Id: <1377602932-1899-5-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since in at91sam9x5, sama5d3x chip. the start up time calucation is changed.
This patch can choose different start up time calculation formula for different
chips.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
v2 --> v3:
 use function pointer for the startup time calculation.

 drivers/iio/adc/at91_adc.c |   53 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index bccc407..f32a69d 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -40,6 +40,9 @@
 	(writel_relaxed(val, st->reg_base + reg))
 
 struct at91_adc_caps {
+	/* startup time calculate function */
+	u32 (*calc_startup_ticks)(u8 startup_time, u32 adc_clk_khz);
+
 	struct at91_adc_reg_desc registers;
 };
 
@@ -434,6 +437,45 @@ ret:
 	return ret;
 }
 
+static u32 calc_startup_ticks_9260(u8 startup_time, u32 adc_clk_khz)
+{
+	/*
+	 * Number of ticks needed to cover the startup time of the ADC
+	 * as defined in the electrical characteristics of the board,
+	 * divided by 8. The formula thus is :
+	 *   Startup Time = (ticks + 1) * 8 / ADC Clock
+	 */
+	return round_up((startup_time * adc_clk_khz / 1000) - 1, 8) / 8;
+}
+
+static u32 calc_startup_ticks_9x5(u8 startup_time, u32 adc_clk_khz)
+{
+	/*
+	 * For sama5d3x and at91sam9x5, the formula changes to:
+	 * Startup Time = <lookup_table_value> / ADC Clock
+	 */
+	const int startup_lookup[] = {
+		0  , 8  , 16 , 24 ,
+		64 , 80 , 96 , 112,
+		512, 576, 640, 704,
+		768, 832, 896, 960
+		};
+	int i, size = ARRAY_SIZE(startup_lookup);
+	unsigned int ticks;
+
+	ticks = startup_time * adc_clk_khz / 1000;
+	for (i = 0; i < size; i++)
+		if (ticks < startup_lookup[i])
+			break;
+
+	ticks = i;
+	if (ticks == size)
+		/* Reach the end of lookup table */
+		ticks = size - 1;
+
+	return ticks;
+}
+
 static const struct of_device_id at91_adc_dt_ids[];
 
 static int at91_adc_probe_dt(struct at91_adc_state *st,
@@ -662,15 +704,9 @@ static int at91_adc_probe(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto error_disable_adc_clk;
 	}
+	ticks = (*st->caps->calc_startup_ticks)(st->startup_time, adc_clk_khz);
 
 	/*
-	 * Number of ticks needed to cover the startup time of the ADC as
-	 * defined in the electrical characteristics of the board, divided by 8.
-	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
-	 */
-	ticks = round_up((st->startup_time * adc_clk_khz /
-			  1000) - 1, 8) / 8;
-	/*
 	 * a minimal Sample and Hold Time is necessary for the ADC to guarantee
 	 * the best converted final value between two channels selection
 	 * The formula thus is : Sample and Hold Time = (shtim + 1) / ADCClock
@@ -751,6 +787,7 @@ static int at91_adc_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static struct at91_adc_caps at91sam9260_caps = {
+	.calc_startup_ticks = calc_startup_ticks_9260,
 	.registers = {
 		.channel_base = AT91_ADC_CHR(0),
 		.drdy_mask = AT91_ADC_DRDY,
@@ -762,6 +799,7 @@ static struct at91_adc_caps at91sam9260_caps = {
 };
 
 static struct at91_adc_caps at91sam9g45_caps = {
+	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
 	.registers = {
 		.channel_base = AT91_ADC_CHR(0),
 		.drdy_mask = AT91_ADC_DRDY,
@@ -773,6 +811,7 @@ static struct at91_adc_caps at91sam9g45_caps = {
 };
 
 static struct at91_adc_caps at91sam9x5_caps = {
+	.calc_startup_ticks = calc_startup_ticks_9x5,
 	.registers = {
 		.channel_base = AT91_ADC_CDR0_9X5,
 		.drdy_mask = AT91_ADC_SR_DRDY_9X5,
-- 
1.7.10

