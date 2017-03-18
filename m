Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34771 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdCRSoe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2017 14:44:34 -0400
Date: Sun, 19 Mar 2017 00:14:29 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v4] staging: Use buf_lock instead of mlock and Refactor code
Message-ID: <20170318184428.GA12858@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes. Replace it with buf_lock in the devices global data.

As buf_lock protects both the adis16060_spi_write() and
adis16060_spi_read() functions and both are always called in
pair. First write, then read. Thus, refactor the code to have
one single function adis16060_spi_write_than_read() which is
protected by the existing buf_lock.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---

 v4:
   -Refactored code 
   -change commit subject
   -change commit message

 drivers/staging/iio/gyro/adis16060_core.c | 37 ++++++++++++-------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index c9d46e7..39ddd55 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -40,7 +40,7 @@ struct adis16060_state {
 
 static struct iio_dev *adis16060_iio_dev;
 
-static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
+static int adis16060_spi_write_than_read(struct iio_dev *indio_dev, u8 val, u16 *val2)
 {
 	int ret;
 	struct adis16060_state *st = iio_priv(indio_dev);
@@ -48,17 +48,11 @@ static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
 	mutex_lock(&st->buf_lock);
 	st->buf[2] = val; /* The last 8 bits clocked in are latched */
 	ret = spi_write(st->us_w, st->buf, 3);
-	mutex_unlock(&st->buf_lock);
 
-	return ret;
-}
-
-static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
-{
-	int ret;
-	struct adis16060_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
+	if (ret < 0) {
+		mutex_unlock(&st->buf_lock);
+		return ret;
+	}
 
 	ret = spi_read(st->us_r, st->buf, 3);
 
@@ -67,10 +61,10 @@ static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
 	 * starts to place data MSB first on the DOUT line at
 	 * the 6th falling edge of SCLK
 	 */
-	if (!ret)
-		*val = ((st->buf[0] & 0x3) << 12) |
-			(st->buf[1] << 4) |
-			((st->buf[2] >> 4) & 0xF);
+        if (!ret)
+		*val2 = ((st->buf[0] & 0x3) << 12) |
+			 (st->buf[1] << 4) |
+			 ((st->buf[2] >> 4) & 0xF);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -83,20 +77,17 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 {
 	u16 tval = 0;
 	int ret;
+	struct adis16060_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		/* Take the iio_dev status lock */
-		mutex_lock(&indio_dev->mlock);
-		ret = adis16060_spi_write(indio_dev, chan->address);
+		mutex_lock(&st->buf_lock);
+		ret = adis16060_spi_write_than_read(indio_dev, chan->address, &tval);
 		if (ret < 0)
 			goto out_unlock;
 
-		ret = adis16060_spi_read(indio_dev, &tval);
-		if (ret < 0)
-			goto out_unlock;
-
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->buf_lock);
 		*val = tval;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
@@ -112,7 +103,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 
 out_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
-- 
2.7.4

