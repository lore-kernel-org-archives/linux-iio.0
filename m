Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34976 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdIRWwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 18:52:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id i23so747772pfi.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Sep 2017 15:52:43 -0700 (PDT)
Date: Mon, 18 Sep 2017 15:52:40 -0700
From: Katie Dunne <kdunne@mail.ccsf.edu>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org, pmeerw@pmeerw.net, 21cnbao@gmail.com
Subject: [PATCH] Staging: iio: meter: ade7759: update locking method for
 write frequency
Message-ID: <20170918225240.GA3085@katie-Inspiron-5748>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_dev->mlock is to be used only by the IIO core for protecting
device mode changes between INDIO_DIRECT and INDIO_BUFFER.

This patch replaces the use of mlock with the already established
buf_lock mutex.

Introducing an 'unlocked' spi_write_reg_16 function to be used by
ade7759_write_frequency avoids nested locks and maintains atomicity
between bus and device frequency changes.

Based on the solution found in ade7754 patch here:
https://marc.info/?l=linux-iio&m=149086659008991&w=2

Signed-off-by: Katie Dunne <kdunne@mail.ccsf.edu>
---
 drivers/staging/iio/meter/ade7759.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 1691760..b52d4d7 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -60,7 +60,7 @@
 /**
  * struct ade7759_state - device instance specific data
  * @us:			actual spi_device
- * @buf_lock:		mutex to protect tx and rx
+ * @buf_lock:		mutex to protect tx and rx and write frequency
  * @tx:			transmit buffer
  * @rx:			receive buffer
  **/
@@ -89,19 +89,30 @@ static int ade7759_spi_write_reg_8(struct device *dev,
 	return ret;
 }
 
-static int ade7759_spi_write_reg_16(struct device *dev,
+/*Unlocked version of ade7759_spi_write_reg_16 function */
+static int __ade7759_spi_write_reg_16(struct device *dev,
 		u8 reg_address,
 		u16 value)
 {
-	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7759_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7759_WRITE_REG(reg_address);
 	st->tx[1] = (value >> 8) & 0xFF;
 	st->tx[2] = value & 0xFF;
-	ret = spi_write(st->us, st->tx, 3);
+	return spi_write(st->us, st->tx, 3);
+}
+
+static int ade7759_spi_write_reg_16(struct device *dev,
+		u8 reg_address,
+		u16 value)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ade7759_state *st = iio_priv(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	ret = __ade7759_spi_write_reg_16(dev, reg_address, value);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -429,7 +440,7 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->buf_lock);
 
 	t = 27900 / val;
 	if (t > 0)
@@ -447,10 +458,10 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 	reg &= ~(3 << 13);
 	reg |= t << 13;
 
-	ret = ade7759_spi_write_reg_16(dev, ADE7759_MODE, reg);
+	ret = __ade7759_spi_write_reg_16(dev, ADE7759_MODE, reg);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->buf_lock);
 
 	return ret ? ret : len;
 }
-- 
2.7.4

