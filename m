Return-Path: <jan@arkub.com>
From: Jan Kardell <jan.kardell@telliq.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH] iio: ti_am335x_adc: Use same step id at FIFOs both ends
Date: Wed, 11 Jun 2014 23:18:18 +0200
Message-Id: <1402521498-11535-1-git-send-email-jan.kardell@telliq.com>
List-ID: <linux-iio@vger.kernel.org>

Since AI lines could be selected at will (linux-3.11) the sending
and receiving ends of the FIFO does not agree about what step is used
for a line. It only works if the last lines are used, like 5,6,7,
and fails if ie 2,4,6 is selected in DT.

Signed-off-by: Jan Kardell <jan.kardell@telliq.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index a4db302..d5dc4c6 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -374,7 +374,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 			return -EAGAIN;
 		}
 	}
-	map_val = chan->channel + TOTAL_CHANNELS;
+	map_val = adc_dev->channel_step[chan->scan_index];
 
 	/*
 	 * We check the complete FIFO. We programmed just one entry but in case
-- 
1.8.4.5
