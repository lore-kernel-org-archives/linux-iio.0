Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/17] iio:ad7266: Remove redundant call to iio_sw_preenable()
Date: Mon, 14 Oct 2013 18:49:16 +0200
Message-Id: <1381769370-17100-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7266.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index f5723cb..58e9455 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -61,17 +61,7 @@ static int ad7266_powerdown(struct ad7266_state *st)
 static int ad7266_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7266_state *st = iio_priv(indio_dev);
-	int ret;
-
-	ret = ad7266_wakeup(st);
-	if (ret)
-		return ret;
-
-	ret = iio_sw_buffer_preenable(indio_dev);
-	if (ret)
-		ad7266_powerdown(st);
-
-	return ret;
+	return ad7266_wakeup(st);
 }
 
 static int ad7266_postdisable(struct iio_dev *indio_dev)
-- 
1.8.0
