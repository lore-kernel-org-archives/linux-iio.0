Return-Path: <SRS0=F73h=A7=gmail.com=himshijain.hj@kernel.org>
Date: Sun, 1 Oct 2017 01:35:21 +0530
From: Himanshi Jain <himshijain.hj@gmail.com>
To: outreachy-kernel@googlegroups.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	daniel.baluta@gmail.com, amsfield22@gmail.com,
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org
Subject: [PATCH] staging: iio: ade7753: expanding buffer lock to cover both
 buffer and state protection
Message-ID: <20170930200521.GA19705@himanshi-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Dropping the extra lock (used for protecting the write frequency) by
expanding the buffer lock to cover both buffer and state protection.

Doing this by introducing a new function (__ade7753_spi_write_reg_16)
making buffer changes without locking the state, to avoid nested locks
while making device frequency changes.

Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>
---
 drivers/staging/iio/meter/ade7753.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index b704b24..c44eb57 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -80,13 +80,11 @@
  * @us:         actual spi_device
  * @tx:         transmit buffer
  * @rx:         receive buffer
- * @buf_lock:       mutex to protect tx and rx
- * @lock:	protect sensor data
+ * @buf_lock:       mutex to protect tx, rx and write frequency
  **/
 struct ade7753_state {
 	struct spi_device   *us;
 	struct mutex        buf_lock;
-	struct mutex	    lock; /* protect sensor data */
 	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
 	u8          rx[ADE7753_MAX_RX];
 };
@@ -109,6 +107,19 @@ static int ade7753_spi_write_reg_8(struct device *dev,
 	return ret;
 }
 
+static int __ade7753_spi_write_reg_16(struct device *dev, u8 reg_address,
+				      u16 value)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ade7753_state *st = iio_priv(indio_dev);
+
+	st->tx[0] = ADE7753_WRITE_REG(reg_address);
+	st->tx[1] = (value >> 8) & 0xFF;
+	st->tx[2] = value & 0xFF;
+
+	return spi_write(st->us, st->tx, 3);
+}
+
 static int ade7753_spi_write_reg_16(struct device *dev, u8 reg_address,
 				    u16 value)
 {
@@ -117,10 +128,7 @@ static int ade7753_spi_write_reg_16(struct device *dev, u8 reg_address,
 	struct ade7753_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7753_WRITE_REG(reg_address);
-	st->tx[1] = (value >> 8) & 0xFF;
-	st->tx[2] = value & 0xFF;
-	ret = spi_write(st->us, st->tx, 3);
+	ret = __ade7753_spi_write_reg_16(dev, reg_address, value);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -485,7 +493,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	mutex_lock(&st->buf_lock);
 
 	t = 27900 / val;
 	if (t > 0)
@@ -503,10 +511,10 @@ static ssize_t ade7753_write_frequency(struct device *dev,
 	reg &= ~(3 << 11);
 	reg |= t << 11;
 
-	ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
+	ret = __ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
 
 out:
-	mutex_unlock(&st->lock);
+	mutex_unlock(&st->buf_lock);
 
 	return ret ? ret : len;
 }
@@ -581,7 +589,6 @@ static int ade7753_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	mutex_init(&st->lock);
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
-- 
1.9.1
