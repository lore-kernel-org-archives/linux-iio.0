Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36100 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdCMRwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 13:52:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id j5so19717185pfb.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Mar 2017 10:52:43 -0700 (PDT)
Date: Mon, 13 Mar 2017 23:22:14 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 1/2] staging: iio: ad9834: Use private driver lock instead
 of mlock
Message-ID: <b8be73b2cd73e64684c56c8214140571ae65f012.1489424208.git.karniksayli1995@gmail.com>
References: <cover.1489424208.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1489424208.git.karniksayli1995@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_dev->mlock should be used by the IIO core only for protecting
device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
INDIO_BUFFER_* modes.
Replace mlock with a lock in the device's global data to protect
hardware state changes.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
v4:
Initialised the lock with mutex_init() and sent as a patchset
v2:
Fixed mistake by changing mutex_lock() to mutex_unlock()

 drivers/staging/iio/frequency/ad9834.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index f92ff7f..2dffe48 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -63,6 +63,7 @@
  * @msg:		default spi message
  * @freq_xfer:		tuning word spi transfer
  * @freq_msg:		tuning word spi message
+ * @lock:		protect sensor state
  * @data:		spi transmit buffer
  * @freq_data:		tuning word spi transmit buffer
  */
@@ -77,6 +78,7 @@ struct ad9834_state {
 	struct spi_message		msg;
 	struct spi_transfer		freq_xfer[2];
 	struct spi_message		freq_msg;
+	struct mutex                    lock;   /* protect sensor state */
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -149,7 +151,7 @@ static ssize_t ad9834_write(struct device *dev,
 	if (ret)
 		goto error_ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9834_REG_FREQ0:
 	case AD9834_REG_FREQ1:
@@ -207,7 +209,7 @@ static ssize_t ad9834_write(struct device *dev,
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 error_ret:
 	return ret ? ret : len;
@@ -224,7 +226,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 	int ret = 0;
 	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	switch ((u32)this_attr->address) {
 	case 0:
@@ -267,7 +269,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
 		ret = spi_sync(st->spi, &st->msg);
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -418,6 +420,7 @@ static int ad9834_probe(struct spi_device *spi)
 	}
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
 	st->mclk = pdata->mclk;
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
-- 
2.7.4

