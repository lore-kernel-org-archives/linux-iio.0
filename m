Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>
Subject: [PATCH 06/17] iio:ti_am335x: Remove redundant call to iio_sw_buffer_preenable()
Date: Mon, 14 Oct 2013 18:49:19 +0200
Message-Id: <1381769370-17100-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer
core, so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 8fb5429..ef54d8a 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -166,7 +166,7 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 	for (i = 0; i < fifo1count; i++)
 		read = tiadc_readl(adc_dev, REG_FIFO1);
 
-	return iio_sw_buffer_preenable(indio_dev);
+	return 0;
 }
 
 static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
-- 
1.8.0
