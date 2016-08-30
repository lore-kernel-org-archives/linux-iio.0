Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from exsmtp03.microchip.com ([198.175.253.49]:42564 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758132AbcH3M03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2016 08:26:29 -0400
From: Nicolas Ferre <nicolas.ferre@atmel.com>
To: Cristian Birsan <cristian.birsan@microchip.com>,
        Ludovic Desroches <ludovic.desroches@atmel.com>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] iio: adc: at91: Add support for Touchscreen Switches Closure Time
Date: Tue, 30 Aug 2016 14:27:01 +0200
Message-ID: <20160830122701.19385-1-nicolas.ferre@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On newer components compatible with the at91sam9x5, the Touchscreen
Switches Closure Time or TSSCTIM value of the Touchscreen Mode Register is
not filled at all.
On some hardware, having no time indicated for it may lead to incoherent
values and jitter.
We fix this time to 10us as it is usually difficult to retrieve impedance
values from LCD manufacturers.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/iio/adc/at91_adc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0438c68015e8..bbdac07f4aaa 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -113,6 +113,7 @@
 #define		AT91_ADC_TSMR_TSAV	(3 << 4)	/* Averages samples */
 #define			AT91_ADC_TSMR_TSAV_(x)		((x) << 4)
 #define		AT91_ADC_TSMR_SCTIM	(0x0f << 16)	/* Switch closure time */
+#define			AT91_ADC_TSMR_SCTIM_(x)		((x) << 16)
 #define		AT91_ADC_TSMR_PENDBC	(0x0f << 28)	/* Pen Debounce time */
 #define			AT91_ADC_TSMR_PENDBC_(x)	((x) << 28)
 #define		AT91_ADC_TSMR_NOTSDMA	(1 << 22)	/* No Touchscreen DMA */
@@ -150,6 +151,7 @@
 #define MAX_RLPOS_BITS         10
 #define TOUCH_SAMPLE_PERIOD_US_RL      10000   /* 10ms, the SoC can't keep up with 2ms */
 #define TOUCH_SHTIM                    0xa
+#define TOUCH_SCTIM_US		10		/* 10us for the Touchscreen Switches Closure Time */
 
 /**
  * struct at91_adc_reg_desc - Various informations relative to registers
@@ -1001,7 +1003,9 @@ static void atmel_ts_close(struct input_dev *dev)
 
 static int at91_ts_hw_init(struct at91_adc_state *st, u32 adc_clk_khz)
 {
+	struct iio_dev *idev = iio_priv_to_dev(st);
 	u32 reg = 0;
+	u32 tssctim = 0;
 	int i = 0;
 
 	/* a Pen Detect Debounce Time is necessary for the ADC Touch to avoid
@@ -1034,11 +1038,20 @@ static int at91_ts_hw_init(struct at91_adc_state *st, u32 adc_clk_khz)
 		return 0;
 	}
 
+	/* Touchscreen Switches Closure time needed for allowing the value to
+	 * stabilize.
+	 * Switch Closure Time = (TSSCTIM * 4) ADCClock periods
+	 */
+	tssctim = DIV_ROUND_UP(TOUCH_SCTIM_US * adc_clk_khz / 1000, 4);
+	dev_dbg(&idev->dev, "adc_clk at: %d KHz, tssctim at: %d\n",
+		adc_clk_khz, tssctim);
+
 	if (st->touchscreen_type == ATMEL_ADC_TOUCHSCREEN_4WIRE)
 		reg = AT91_ADC_TSMR_TSMODE_4WIRE_PRESS;
 	else
 		reg = AT91_ADC_TSMR_TSMODE_5WIRE;
 
+	reg |= AT91_ADC_TSMR_SCTIM_(tssctim) & AT91_ADC_TSMR_SCTIM;
 	reg |= AT91_ADC_TSMR_TSAV_(st->caps->ts_filter_average)
 	       & AT91_ADC_TSMR_TSAV;
 	reg |= AT91_ADC_TSMR_PENDBC_(st->ts_pendbc) & AT91_ADC_TSMR_PENDBC;
-- 
2.9.0

