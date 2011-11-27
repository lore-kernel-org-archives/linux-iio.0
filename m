Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 12/16] staging:iio:adc:ad7887 stop reading from buffer for sysfs access.
Date: Sun, 27 Nov 2011 13:33:41 +0000
Message-Id: <1322400825-29400-13-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No known use case and complicates in kernel interface work.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7887.h      |    5 ----
 drivers/staging/iio/adc/ad7887_core.c |    2 +-
 drivers/staging/iio/adc/ad7887_ring.c |   34 ---------------------------------
 3 files changed, 1 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index 3452d18..bc53b65 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -83,14 +83,9 @@ enum ad7887_supported_device_ids {
 };
 
 #ifdef CONFIG_IIO_BUFFER
-int ad7887_scan_from_ring(struct ad7887_state *st, int channum);
 int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7887_ring_cleanup(struct iio_dev *indio_dev);
 #else /* CONFIG_IIO_BUFFER */
-static inline int ad7887_scan_from_ring(struct ad7887_state *st, int channum)
-{
-	return 0;
-}
 
 static inline int
 ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 8f48659..ffed20e 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -45,7 +45,7 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		mutex_lock(&indio_dev->mlock);
 		if (iio_buffer_enabled(indio_dev))
-			ret = ad7887_scan_from_ring(st, 1 << chan->address);
+			ret = -EBUSY;
 		else
 			ret = ad7887_scan_direct(st, chan->address);
 		mutex_unlock(&indio_dev->mlock);
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index f53a663..85076cd 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -19,40 +19,6 @@
 
 #include "ad7887.h"
 
-int ad7887_scan_from_ring(struct ad7887_state *st, int channum)
-{
-	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
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
-
-	/* for single channel scan the result is stored with zero offset */
-	if ((test_bit(1, ring->scan_mask) || test_bit(0, ring->scan_mask)) &&
-	    (channum == 1))
-		count = 1;
-
-	ret = be16_to_cpu(ring_data[count]);
-
-error_free_ring_data:
-	kfree(ring_data);
-error_ret:
-	return ret;
-}
-
 /**
  * ad7887_ring_preenable() setup the parameters of the ring before enabling
  *
-- 
1.7.7.3
