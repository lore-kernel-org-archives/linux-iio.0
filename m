Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/17] staging:iio:ade7758: Remove redundant call to iio_sw_buffer_preenable()
Date: Mon, 14 Oct 2013 18:49:29 +0200
Message-Id: <1381769370-17100-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7758_ring.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 7a448ff..c0accf8 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -87,15 +87,10 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ade7758_state *st = iio_priv(indio_dev);
 	unsigned channel;
-	int ret;
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	ret = iio_sw_buffer_preenable(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 
-- 
1.8.0
