Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34044 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932931AbdCUQP5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 12:15:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so22680817pfb.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 09:15:57 -0700 (PDT)
Date: Tue, 21 Mar 2017 21:45:36 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2] staging: iio: meter: ade7758_core: Replace mlock with
 driver's private lock
Message-ID: <20170321161535.GA11483@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_dev->mlock should be used by the IIO core only for protecting
device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
INDIO_BUFFER_* modes.
Replace mlock with a lock in the device's global data to protect
hardware state changes. Declare a new lock to avoid deadlocks due to
nested mutex locks.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
Changes in v2:
Declared a new lock for raw reads/writes

 drivers/staging/iio/meter/ade7758.h      |  4 +++-
 drivers/staging/iio/meter/ade7758_core.c | 12 +++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index 6ae78d8..e45887e 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -112,13 +112,15 @@
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
+ * @lock:		mutex to protect raw reads and writes
  **/
 struct ade7758_state {
 	struct spi_device	*us;
 	struct iio_trigger	*trig;
 	u8			*tx;
 	u8			*rx;
-	struct mutex		buf_lock;
+	struct mutex		buf_lock; /* protect buffer reads/writes */
+	struct mutex		lock;	/* protect raw reads/writes */
 	struct spi_transfer	ring_xfer[4];
 	struct spi_message	ring_msg;
 	/*
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 99c89e6..0996d74 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -522,13 +522,14 @@ static int ade7758_read_raw(struct iio_dev *indio_dev,
 			    int *val2,
 			    long mask)
 {
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = ade7758_read_samp_freq(&indio_dev->dev, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 		return ret;
 	default:
 		return -EINVAL;
@@ -541,15 +542,16 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->buf_lock);
 		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->buf_lock);
 		return ret;
 	default:
 		return -EINVAL;
@@ -855,7 +857,7 @@ static int ade7758_probe(struct spi_device *spi)
 	}
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-
+	mutex_init(&st->lock);
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ade7758_info;
-- 
2.7.4

