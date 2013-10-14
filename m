Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/17] iio:ad_sigma_delta: Remove redundant call to iio_sw_buffer_preenable().
Date: Mon, 14 Oct 2013 18:49:18 +0200
Message-Id: <1381769370-17100-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad_sigma_delta.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 2b59112..e6fbd3e 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -397,7 +397,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 }
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
-	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &ad_sd_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad_sd_buffer_postdisable,
-- 
1.8.0
