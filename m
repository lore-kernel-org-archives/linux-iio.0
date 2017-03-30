Return-Path: <SRS0=z67z=3H=gmail.com=gs051095@kernel.org>
From: Gargi Sharma <gs051095@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Gargi Sharma <gs051095@gmail.com>
Subject: [RFC v2] staging: iio: update locking method during frequency writes
Date: Thu, 30 Mar 2017 12:09:13 +0530
Message-Id: <1490855953-27552-1-git-send-email-gs051095@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The driver needs to insure atomicity during frequency
changes of bus and device. The iiodev->mlock as used
was not doing that. Replace it with the drivers existing
buffer lock and introduce an auxiliary spi_write() that does
not hold the lock.

Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
Changes in v2:
        - Added auxiliary function.
        - Updated the buf_lock comment appropriately.
---
 drivers/staging/iio/meter/ade7754.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index c8d2d4c..f371030 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -97,7 +97,7 @@
 /**
  * struct ade7754_state - device instance specific data
  * @us:			actual spi_device
- * @buf_lock:		mutex to protect tx and rx
+ * @buf_lock:		mutex to protect tx, rx and write frequency
  * @tx:			transmit buffer
  * @rx:			receive buffer
  **/
@@ -108,17 +108,29 @@ struct ade7754_state {
 	u8			rx[ADE7754_MAX_RX];
 };
 
-static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
+/* Unlocked version of ade7754_spi_write_reg_8 function */
+static int __ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7754_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7754_WRITE_REG(reg_address);
 	st->tx[1] = val;
 
 	ret = spi_write(st->us, st->tx, 2);
+
+	return ret;
+}
+
+static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ade7754_state *st = iio_priv(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	ret = __ade7754_spi_write_reg_8(dev, reg_address, val);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -513,7 +525,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->buf_lock);
 
 	t = 26000 / val;
 	if (t > 0)
@@ -531,10 +543,10 @@ static ssize_t ade7754_write_frequency(struct device *dev,
 	reg &= ~(3 << 3);
 	reg |= t << 3;
 
-	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
+	ret = __ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->buf_lock);
 
 	return ret ? ret : len;
 }
-- 
2.7.4
