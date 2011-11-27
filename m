Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/16] staging:iio:adc:ad7606 remove buffer access to data from sysfs read.
Date: Sun, 27 Nov 2011 13:33:39 +0000
Message-Id: <1322400825-29400-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No known use case and complicates in kernel interface work.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7606.h      |    1 -
 drivers/staging/iio/adc/ad7606_core.c |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c |   24 ------------------------
 3 files changed, 1 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 35018c3..10f5989 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -99,7 +99,6 @@ enum ad7606_supported_device_ids {
 	ID_AD7606_4
 };
 
-int ad7606_scan_from_ring(struct iio_dev *indio_dev, unsigned ch);
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7606_ring_cleanup(struct iio_dev *indio_dev);
 #endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index a8596b8..da25846 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -91,7 +91,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		mutex_lock(&indio_dev->mlock);
 		if (iio_buffer_enabled(indio_dev))
-			ret = ad7606_scan_from_ring(indio_dev, chan->address);
+			ret = -EBUSY;
 		else
 			ret = ad7606_scan_direct(indio_dev, chan->address);
 		mutex_unlock(&indio_dev->mlock);
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index f682af6..e8f94a1 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -18,30 +18,6 @@
 
 #include "ad7606.h"
 
-int ad7606_scan_from_ring(struct iio_dev *indio_dev, unsigned ch)
-{
-	struct iio_buffer *ring = indio_dev->buffer;
-	int ret;
-	u16 *ring_data;
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
-	ret = ring_data[ch];
-
-error_free_ring_data:
-	kfree(ring_data);
-error_ret:
-	return ret;
-}
-
 /**
  * ad7606_trigger_handler_th() th/bh of trigger launched polling to ring buffer
  *
-- 
1.7.7.3
