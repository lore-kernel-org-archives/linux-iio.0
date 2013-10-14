Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/17] staging:iio:ad5933: Remove redundant call to iio_sw_buffer_preenable()
Date: Mon, 14 Oct 2013 18:49:28 +0200
Message-Id: <1381769370-17100-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index f570115..0a4298b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -574,10 +574,6 @@ static int ad5933_ring_preenable(struct iio_dev *indio_dev)
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	ret = iio_sw_buffer_preenable(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	ret = ad5933_reset(st);
 	if (ret < 0)
 		return ret;
-- 
1.8.0
