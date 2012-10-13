Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: use iio_push_to_buffer() in at91 driver
Date: Sat, 13 Oct 2012 10:06:33 +0200
Message-Id: <1350115595-7107-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net>
References: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/at91_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index b3ba8af..2e2c9a8 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -81,7 +81,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 		*timestamp = pf->timestamp;
 	}
 
-	buffer->access->store_to(buffer, (u8 *)st->buffer);
+	iio_push_to_buffer(buffer, st->buffer);
 
 	iio_trigger_notify_done(idev->trig);
 
-- 
1.7.9.5
