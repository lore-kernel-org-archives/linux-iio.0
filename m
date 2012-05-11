Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/24] staging:iio:adis16400_ring: Pass IIO device directly
Date: Fri, 11 May 2012 14:58:33 +0200
Message-Id: <1336741127-29552-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-1-git-send-email-lars@metafoo.de>
References: <1336741127-29552-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

When calling adis16350_spi_read_all and adis16400_spi_read_burst we pass the
device struct of embedded in the IIO device only to look up the IIO device from
the device struct again right away. This patch changes the code to pass the IIO
device directly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_ring.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index e43c0e2..b7c39a4 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -13,13 +13,12 @@
 
 /**
  * adis16400_spi_read_burst() - read all data registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
+ * @dev: The IIO device
  * @rx: somewhere to pass back the value read (min size is 24 bytes)
  **/
-static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
+static int adis16400_spi_read_burst(struct iio_dev *indio_dev, u8 *rx)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16400_state *st = iio_priv(indio_dev);
 	u32 old_speed_hz = st->us->max_speed_hz;
 	int ret;
@@ -71,9 +70,8 @@ static const u16 read_all_tx_array[] = {
 	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_AUX_ADC)),
 };
 
-static int adis16350_spi_read_all(struct device *dev, u8 *rx)
+static int adis16350_spi_read_all(struct iio_dev *indio_dev, u8 *rx)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16400_state *st = iio_priv(indio_dev);
 
 	struct spi_message msg;
@@ -132,13 +130,13 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 
 	if (scan_count) {
 		if (st->variant->flags & ADIS16400_NO_BURST) {
-			ret = adis16350_spi_read_all(&indio_dev->dev, st->rx);
+			ret = adis16350_spi_read_all(indio_dev, st->rx);
 			if (ret < 0)
 				goto err;
 			for (; i < scan_count; i++)
 				data[i]	= *(s16 *)(st->rx + i*2);
 		} else {
-			ret = adis16400_spi_read_burst(&indio_dev->dev, st->rx);
+			ret = adis16400_spi_read_burst(indio_dev, st->rx);
 			if (ret < 0)
 				goto err;
 			for (; i < scan_count; i++) {
-- 
1.7.10
