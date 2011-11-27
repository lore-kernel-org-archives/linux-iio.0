Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 13/16] staging:iio:adc:ad799x stop reading from buffer for sysfs accesses
Date: Sun, 27 Nov 2011 13:33:42 +0000
Message-Id: <1322400825-29400-14-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No known use case and makes in kernel interface work more complex.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad799x.h      |    6 ------
 drivers/staging/iio/adc/ad799x_core.c |    3 +--
 drivers/staging/iio/adc/ad799x_ring.c |   30 ------------------------------
 3 files changed, 1 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index eda01d5..356f690 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -124,15 +124,9 @@ struct ad799x_platform_data {
 int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask);
 
 #ifdef CONFIG_AD799X_RING_BUFFER
-int ad799x_single_channel_from_ring(struct iio_dev *indio_dev, int channum);
 int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad799x_ring_cleanup(struct iio_dev *indio_dev);
 #else /* CONFIG_AD799X_RING_BUFFER */
-int ad799x_single_channel_from_ring(struct iio_dev *indio_dev, int channum)
-{
-	return -EINVAL;
-}
-
 
 static inline int
 ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 5bedb19..815e6b9 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -151,8 +151,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		mutex_lock(&indio_dev->mlock);
 		if (iio_buffer_enabled(indio_dev))
-			ret = ad799x_single_channel_from_ring(indio_dev,
-							      chan->scan_index);
+			ret = -EBUSY;
 		else
 			ret = ad799x_scan_direct(st, chan->scan_index);
 		mutex_unlock(&indio_dev->mlock);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 5841c3c..5dded9e 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -23,36 +23,6 @@
 
 #include "ad799x.h"
 
-int ad799x_single_channel_from_ring(struct iio_dev *indio_dev, int channum)
-{
-	struct iio_buffer *ring = indio_dev->buffer;
-	int count = 0, ret;
-	u16 *ring_data;
-
-	if (!(test_bit(channum, ring->scan_mask))) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
-
-	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
-			    GFP_KERNEL);
-	if (ring_data == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	ret = ring->access->read_last(ring, (u8 *) ring_data);
-	if (ret)
-		goto error_free_ring_data;
-	/* Need a count of channels prior to this one */
-	count = bitmap_weight(ring->scan_mask, channum);
-	ret = be16_to_cpu(ring_data[count]);
-
-error_free_ring_data:
-	kfree(ring_data);
-error_ret:
-	return ret;
-}
-
 /**
  * ad799x_ring_preenable() setup the parameters of the ring before enabling
  *
-- 
1.7.7.3
