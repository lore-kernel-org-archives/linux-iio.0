Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33879 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdCMJYB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 05:24:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id b5so17536156pgg.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Mar 2017 02:24:00 -0700 (PDT)
Message-ID: <58c6652a.467d630a.1c92b.3bea@mx.google.com>
Date: Mon, 13 Mar 2017 14:53:49 +0530
From: Varsha Rao <rvarsha016@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com
Subject: [PATCH 1/2] staging: iio: adis16240: Replace mlock with driver
 private lock.
References: <cover.1489395260.git.rvarsha016@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1489395260.git.rvarsha016@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by the IIO
core only for protecting device operating mode changes. ie. Changes
between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state changes.
Replace it with a lock in the devices global data. Also declare and
initialize variable st which is pointer to struct adis, to access
txrx_lock.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 27d7f6a..c182b2d 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -229,11 +229,12 @@ static ssize_t adis16240_read_12bit_signed(struct device *dev,
 {
 	ssize_t ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adis *st = iio_priv(indio_dev);
 
 	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->txrx_lock);
 	ret =  adis16240_spi_read_signed(dev, attr, buf, 12);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->txrx_lock);
 
 	return ret;
 }
@@ -295,31 +296,31 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		bits = 10;
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->txrx_lock);
 		addr = adis16240_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&st->txrx_lock);
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->txrx_lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
 		bits = 10;
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->txrx_lock);
 		addr = adis16240_addresses[chan->scan_index][1];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&st->txrx_lock);
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->txrx_lock);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
2.9.3

