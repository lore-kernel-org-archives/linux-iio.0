Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35960 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdCMPgT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 11:36:19 -0400
Date: Mon, 13 Mar 2017 21:08:11 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v2] staging: adis16060_core: Use private driver lock instead
 of mlock
Message-ID: <20170313153811.GA11378@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes.  Replace it with a lock in the devices global data.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 
 v2:
   -Fixed compilation error

 drivers/staging/iio/gyro/adis16060_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index c9d46e7..0f1bc8a 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -29,11 +29,13 @@
  * @us_r:		actual spi_device to read back data
  * @buf:		transmit or receive buffer
  * @buf_lock:		mutex to protect tx and rx
+ * @lock:		protect sensor state
  **/
 struct adis16060_state {
 	struct spi_device		*us_w;
 	struct spi_device		*us_r;
 	struct mutex			buf_lock;
+	struct mutex			lock;	 /* protect sensor state */
 
 	u8 buf[3] ____cacheline_aligned;
 };
@@ -83,11 +85,12 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 {
 	u16 tval = 0;
 	int ret;
+	struct adis16060_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		/* Take the iio_dev status lock */
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = adis16060_spi_write(indio_dev, chan->address);
 		if (ret < 0)
 			goto out_unlock;
@@ -96,7 +99,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			goto out_unlock;
 
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 		*val = tval;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
@@ -112,7 +115,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 
 out_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
-- 
2.7.4

