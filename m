Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/16] staging:iio:adc:ad7993 stop reading from buffer for sysfs raw read.
Date: Sun, 27 Nov 2011 13:33:40 +0000
Message-Id: <1322400825-29400-12-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No known usecase and makes in kernel interface work more complex.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7793.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 432f60e..f2f1081 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -316,25 +316,6 @@ out:
 	return ret;
 }
 
-static int ad7793_scan_from_ring(struct ad7793_state *st, unsigned ch, int *val)
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
 static int ad7793_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
@@ -650,8 +631,7 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		mutex_lock(&indio_dev->mlock);
 		if (iio_buffer_enabled(indio_dev))
-			ret = ad7793_scan_from_ring(st,
-					chan->scan_index, &smpl);
+			ret = -EBUSY;
 		else
 			ret = ad7793_read(st, chan->address,
 					chan->scan_type.realbits / 8, &smpl);
-- 
1.7.7.3
