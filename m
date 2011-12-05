Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/19] staging:iio:adc:ad7192 scrap read from buffer for sysfs access.
Date: Mon,  5 Dec 2011 22:18:18 +0000
Message-Id: <1323123510-21388-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1323123510-21388-1-git-send-email-jic23@kernel.org>
References: <1323123510-21388-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No known use case and complicates in kernel interface work.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7192.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 1b6ecc8..66cc507 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -453,25 +453,6 @@ out:
 	return ret;
 }
 
-static int ad7192_scan_from_ring(struct ad7192_state *st, unsigned ch, int *val)
-{
-	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
-	int ret;
-	s64 dat64[2];
-	u32 *dat32 = (u32 *)dat64;
-
-	if (!(test_bit(ch, ring->scan_mask)))
-		return  -EBUSY;
-
-	ret = ring->access->read_last(ring, (u8 *) &dat64);
-	if (ret)
-		return ret;
-
-	*val = *dat32;
-
-	return 0;
-}
-
 static int ad7192_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
@@ -875,8 +856,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		mutex_lock(&indio_dev->mlock);
 		if (iio_buffer_enabled(indio_dev))
-			ret = ad7192_scan_from_ring(st,
-					chan->scan_index, &smpl);
+			ret = -EBUSY;
 		else
 			ret = ad7192_read(st, chan->address,
 					chan->scan_type.realbits / 8, &smpl);
-- 
1.7.7.4
