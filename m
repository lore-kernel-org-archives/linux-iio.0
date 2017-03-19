Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36841 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbdCSVAk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 17:00:40 -0400
Date: Mon, 20 Mar 2017 01:36:21 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v6] staging: Use buf_lock instead of mlock and Refactor code
Message-ID: <20170319200621.GA21295@singhal-Inspiron-5558>
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

Removed nested locks as the function adis16060_read_raw call
a lock on &st->buf_lock and then calls the function
adis16060_spi_write which again tries to get hold
of the same lock.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---

 v6:
   -Change commit message
   -Remove nested lock

 drivers/staging/iio/gyro/adis16060_core.c | 40 ++++++++++---------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index c9d46e7..1c6de46 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -40,25 +40,17 @@ struct adis16060_state {
 
 static struct iio_dev *adis16060_iio_dev;
 
-static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
+static int adis16060_spi_write_than_read(struct iio_dev *indio_dev,
+					 u8 conf, u16 *val)
 {
 	int ret;
 	struct adis16060_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->buf_lock);
-	st->buf[2] = val; /* The last 8 bits clocked in are latched */
+	st->buf[2] = conf; /* The last 8 bits clocked in are latched */
 	ret = spi_write(st->us_w, st->buf, 3);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
-{
-	int ret;
-	struct adis16060_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->buf_lock);
+	if (ret < 0)
+		return ret;
 
 	ret = spi_read(st->us_r, st->buf, 3);
 
@@ -69,8 +61,8 @@ static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
 	 */
 	if (!ret)
 		*val = ((st->buf[0] & 0x3) << 12) |
-			(st->buf[1] << 4) |
-			((st->buf[2] >> 4) & 0xF);
+			 (st->buf[1] << 4) |
+			 ((st->buf[2] >> 4) & 0xF);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -83,20 +75,18 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
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
+		ret = adis16060_spi_write_than_read(indio_dev,
+						    chan->address, &tval);
+		mutex_unlock(&st->buf_lock);
 		if (ret < 0)
-			goto out_unlock;
+			return ret;
 
-		ret = adis16060_spi_read(indio_dev, &tval);
-		if (ret < 0)
-			goto out_unlock;
-
-		mutex_unlock(&indio_dev->mlock);
 		*val = tval;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
@@ -110,10 +100,6 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 	}
 
 	return -EINVAL;
-
-out_unlock:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
 }
 
 static const struct iio_info adis16060_info = {
-- 
2.7.4

