Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: remove useless irq_enabled variable in at91
Date: Sat, 13 Oct 2012 10:06:32 +0200
Message-Id: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

irq_enabled is only set, but never read

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/at91_adc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 3ed94bf..b3ba8af 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -46,7 +46,6 @@ struct at91_adc_state {
 	struct clk		*clk;
 	bool			done;
 	int			irq;
-	bool			irq_enabled;
 	u16			last_value;
 	struct mutex		lock;
 	u8			num_channels;
@@ -85,7 +84,6 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 	buffer->access->store_to(buffer, (u8 *)st->buffer);
 
 	iio_trigger_notify_done(idev->trig);
-	st->irq_enabled = true;
 
 	/* Needed to ACK the DRDY interruption */
 	at91_adc_readl(st, AT91_ADC_LCDR);
@@ -106,7 +104,6 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
 
 	if (iio_buffer_enabled(idev)) {
 		disable_irq_nosync(irq);
-		st->irq_enabled = false;
 		iio_trigger_poll(idev->trig, iio_get_time_ns());
 	} else {
 		st->last_value = at91_adc_readl(st, AT91_ADC_LCDR);
-- 
1.7.9.5
