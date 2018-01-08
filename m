Return-Path: <SRS0=omKU=ED=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 2/4] iio: humidity: hts221: remove trailing whitespace from a comment
Date: Mon,  8 Jan 2018 23:12:29 +0100
Message-Id: <20180108221231.13283-3-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/humidity/hts221_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index e971ea425268..f9522ee62170 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -61,7 +61,7 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
 	if (err < 0)
 		return IRQ_HANDLED;
 
-	/* 
+	/*
 	 * H_DA bit (humidity data available) is routed to DRDY line.
 	 * Humidity sample is computed after temperature one.
 	 * Here we can assume data channels are both available if H_DA bit
-- 
2.15.1
