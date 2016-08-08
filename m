Return-Path: <anders@chargestorm.se>
From: Anders Darander <anders@chargestorm.se>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	alexandre.belloni@free-electrons.com
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Anders Darander <anders@chargestorm.se>
Subject: [PATCH] iio: adc: at91: unbreak channel adc channel 3
Date: Mon,  8 Aug 2016 14:42:16 +0200
Message-Id: <1470660136-12524-1-git-send-email-anders@chargestorm.se>
List-ID: <linux-iio@vger.kernel.org>

The driver always assumes that an input device has been created when
reading channel 3. This causes a kernel panic when dereferencing
st->ts_input.

The change was introduced in
commit 84882b060301 ("iio: adc: at91_adc: Add support for touchscreens
without TSMR"). Earlier versions only entered that part of the if-else
statement if only the following flags are set:

AT91_ADC_IER_XRDY | AT91_ADC_IER_YRDY | AT91_ADC_IER_PRDY

Signed-off-by: Anders Darander <anders@chargestorm.se>
---
 drivers/iio/adc/at91_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 52430ba..0438c68 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -381,8 +381,8 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
 		st->ts_bufferedmeasure = false;
 		input_report_key(st->ts_input, BTN_TOUCH, 0);
 		input_sync(st->ts_input);
-	} else if (status & AT91_ADC_EOC(3)) {
-		/* Conversion finished */
+	} else if (status & AT91_ADC_EOC(3) && st->ts_input) {
+		/* Conversion finished and we've a touchscreen */
 		if (st->ts_bufferedmeasure) {
 			/*
 			 * Last measurement is always discarded, since it can
-- 
2.8.1
