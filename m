Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>,
	george.mccollister@gmail.com
Subject: [PATCH 2/3] iio: proximity: as3935: remove triggered buffer processing
Date: Sat, 21 May 2016 20:01:02 -0700
Message-Id: <1463886063-20004-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1463886063-20004-1-git-send-email-mranostay@gmail.com>
References: <1463886063-20004-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Triggered buffers shouldn't return processed data, and the respective
conversion was overflowing the defined .realbits for the channel.

Cc: george.mccollister@gmail.com
Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/as3935.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index f0a0def..6aed024 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -213,7 +213,6 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
 	if (ret)
 		goto err_read;
 	val &= AS3935_DATA_MASK;
-	val *= 1000;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &val, pf->timestamp);
 err_read:
-- 
2.7.4
