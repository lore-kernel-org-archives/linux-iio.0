Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/23] staging:iio:adis16204_read_ring_data: Pass IIO device directly
Date: Sat, 12 May 2012 15:39:35 +0200
Message-Id: <1336829994-7857-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1336829994-7857-1-git-send-email-lars@metafoo.de>
References: <1336829994-7857-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

When calling adis16204_read_ring_data we pass the device struct of embedded in
the IIO device only to look up the IIO device from the device struct again right
away. This patch changes the code to pass the IIO device directly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16204_ring.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 0a8b125..f73518b 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -12,13 +12,12 @@
 
 /**
  * adis16204_read_ring_data() read data registers which will be placed into ring
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: the IIO device
  * @rx: somewhere to pass back the value read
  **/
-static int adis16204_read_ring_data(struct device *dev, u8 *rx)
+static int adis16204_read_ring_data(struct iio_dev *indio_dev, u8 *rx)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16204_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[ADIS16204_OUTPUTS + 1];
 	int ret;
@@ -71,7 +70,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
-	    adis16204_read_ring_data(&indio_dev->dev, st->rx) >= 0)
+	    adis16204_read_ring_data(indio_dev, st->rx) >= 0)
 		for (; i < bitmap_weight(indio_dev->active_scan_mask,
 					 indio_dev->masklength); i++)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
-- 
1.7.10
