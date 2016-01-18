Return-Path: <ludovic.desroches@atmel.com>
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>, <nicolas.ferre@atmel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Ludovic Desroches
	<ludovic.desroches@atmel.com>
Subject: [PATCH 1/2] iio:adc:at91-sama5d2: fix vref_uv type
Date: Mon, 18 Jan 2016 09:41:55 +0100
Message-ID: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

vref_uv has to be an int.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ecb2d90..f2d8bd5 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -171,7 +171,7 @@ struct at91_adc_state {
 	struct clk			*per_clk;
 	struct regulator		*reg;
 	struct regulator		*vref;
-	u32				vref_uv;
+	int				vref_uv;
 	const struct iio_chan_spec	*chan;
 	bool				conversion_done;
 	u32				conversion_value;
-- 
2.5.0
