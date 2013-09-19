Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 22/24] staging:iio:mxs-lradc: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:59 +0200
Message-Id: <1379595601-26448-22-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 7401230..9da64bf 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -625,13 +625,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	if (iio->scan_timestamp) {
-		s64 *timestamp = (s64 *)((u8 *)lradc->buffer +
-					ALIGN(j, sizeof(s64)));
-		*timestamp = pf->timestamp;
-	}
-
-	iio_push_to_buffers(iio, lradc->buffer);
+	iio_push_to_buffers_with_timestamp(iio, lradc->buffer, pf->timestamp);
 
 	iio_trigger_notify_done(iio->trig);
 
-- 
1.8.0
