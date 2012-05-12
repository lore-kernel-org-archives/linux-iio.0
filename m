Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/23] staging:iio:ade7758_spi_read_burst: Pass IIO device directly
Date: Sat, 12 May 2012 15:39:40 +0200
Message-Id: <1336829994-7857-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1336829994-7857-1-git-send-email-lars@metafoo.de>
References: <1336829994-7857-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

When calling ade7758_spi_read_burst we pass the device struct of embedded in the
IIO device only to look up the IIO device from the device struct again right
away. This patch changes the code to pass the IIO device directly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/meter/ade7758_ring.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 7b9be8a..92159f2 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -19,11 +19,10 @@
 
 /**
  * ade7758_spi_read_burst() - read data registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @indio_dev: the IIO device
  **/
-static int ade7758_spi_read_burst(struct device *dev)
+static int ade7758_spi_read_burst(struct iio_dev *indio_dev)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
@@ -68,7 +67,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 	u32 *dat32 = (u32 *)dat64;
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
-		if (ade7758_spi_read_burst(&indio_dev->dev) >= 0)
+		if (ade7758_spi_read_burst(indio_dev) >= 0)
 			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
 
 	/* Guaranteed to be aligned with 8 byte boundary */
-- 
1.7.10
