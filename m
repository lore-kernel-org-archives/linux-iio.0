Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>,
	linux-iio@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2 / 2] iio: ti_am335x_adc: adjust the closing bracket in tiadc_read_raw()
Date: Wed, 23 Oct 2013 19:00:24 +0200
Message-Id: <1382547624-15256-2-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1382547624-15256-1-git-send-email-bigeasy@linutronix.de>
References: <1382547624-15256-1-git-send-email-bigeasy@linutronix.de>
List-ID: <linux-iio@vger.kernel.org>

It somehow looks like the ending bracket belongs to the if statement but
it does belong to the while loop. This patch moves the bracket where it
belongs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index ef54d8a..c9b487f 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -338,7 +338,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	while (tiadc_readl(adc_dev, REG_ADCFSM) & SEQ_STATUS) {
 		if (time_after(jiffies, timeout))
 			return -EAGAIN;
-		}
+	}
 	map_val = chan->channel + TOTAL_CHANNELS;
 
 	/*
-- 
1.8.4.rc3
