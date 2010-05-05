Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/6] staging:iio:adis16400 clean out some unused code
Date: Wed,  5 May 2010 23:25:45 +0100
Message-Id: <1273098346-4184-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
References: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400.h      |    9 -----
 drivers/staging/iio/imu/adis16400_core.c |   49 ------------------------------
 2 files changed, 0 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index a8062f6..5a69a7a 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -147,21 +147,12 @@ struct adis16400_state {
 	struct mutex			buf_lock;
 };
 
-int adis16400_spi_write_reg_8(struct device *dev,
-			      u8 reg_address,
-			      u8 val);
-
 int adis16400_spi_read_burst(struct device *dev, u8 *rx);
 
-int adis16400_spi_read_sequence(struct device *dev,
-				      u8 *tx, u8 *rx, int num);
-
 int adis16400_set_irq(struct device *dev, bool enable);
 
 int adis16400_reset(struct device *dev);
 
-int adis16400_stop_device(struct device *dev);
-
 int adis16400_check_status(struct device *dev);
 
 #ifdef CONFIG_IIO_RING_BUFFER
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 868c526..2c10072 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -209,55 +209,6 @@ int adis16400_spi_read_burst(struct device *dev, u8 *rx)
 	return ret;
 }
 
-/**
- * adis16400_spi_read_sequence() - read a sequence of 16-bit registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @tx: register addresses in bytes 0,2,4,6... (min size is 2*num bytes)
- * @rx: somewhere to pass back the value read (min size is 2*num bytes)
- **/
-int adis16400_spi_read_sequence(struct device *dev,
-		u8 *tx, u8 *rx, int num)
-{
-	struct spi_message msg;
-	struct spi_transfer *xfers;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	int ret, i;
-
-	xfers = kzalloc(num + 1, GFP_KERNEL);
-	if (xfers == NULL) {
-		dev_err(&st->us->dev, "memory alloc failed");
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	/* tx: |add1|addr2|addr3|...|addrN |zero|
-	 * rx: |zero|res1 |res2 |...|resN-1|resN| */
-	spi_message_init(&msg);
-	for (i = 0; i < num + 1; i++) {
-		if (i > 0)
-			xfers[i].rx_buf = st->rx + 2*(i - 1);
-		if (i < num)
-			xfers[i].tx_buf = st->tx + 2*i;
-		xfers[i].bits_per_word = 8;
-		xfers[i].len = 2;
-		xfers[i].cs_change = 1;
-		spi_message_add_tail(&xfers[i], &msg);
-	}
-
-	mutex_lock(&st->buf_lock);
-
-	ret = spi_sync(st->us, &msg);
-	if (ret)
-		dev_err(&st->us->dev, "problem when reading sequence");
-
-	mutex_unlock(&st->buf_lock);
-	kfree(xfers);
-
-error_ret:
-	return ret;
-}
-
 static ssize_t adis16400_spi_read_signed(struct device *dev,
 		struct device_attribute *attr,
 		char *buf,
-- 
1.7.0.4
