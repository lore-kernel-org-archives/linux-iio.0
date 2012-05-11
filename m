Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/24] staging:iio:adis16209_read_ring_data: Pass IIO device directly
Date: Fri, 11 May 2012 14:58:28 +0200
Message-Id: <1336741127-29552-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-1-git-send-email-lars@metafoo.de>
References: <1336741127-29552-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

When calling adis16209_read_ring_data we pass the device struct of embedded in
the IIO device only to look up the IIO device from the device struct again right
away. This patch changes the code to pass the IIO device directly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16209_ring.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index f7ed989..8b485a4 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -12,13 +12,12 @@
 
 /**
  * adis16209_read_ring_data() read data registers which will be placed into ring
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: The IIO device
  * @rx: somewhere to pass back the value read
  **/
-static int adis16209_read_ring_data(struct device *dev, u8 *rx)
+static int adis16209_read_ring_data(struct iio_dev *indio_dev, u8 *rx)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16209_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[ADIS16209_OUTPUTS + 1];
 	int ret;
@@ -71,7 +70,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
-	    adis16209_read_ring_data(&indio_dev->dev, st->rx) >= 0)
+	    adis16209_read_ring_data(indio_dev, st->rx) >= 0)
 		for (; i < bitmap_weight(indio_dev->active_scan_mask,
 					 indio_dev->masklength); i++)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
-- 
1.7.10
