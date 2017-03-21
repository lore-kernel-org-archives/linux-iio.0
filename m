Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33766 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933081AbdCUQNh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 12:13:37 -0400
Received: by mail-pg0-f68.google.com with SMTP id 79so17271457pgf.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 09:13:36 -0700 (PDT)
From: Gargi Sharma <gs051095@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Gargi Sharma <gs051095@gmail.com>
Subject: [RESEND PATCH v3] staging: iio: ad7280: Replace mlock with driver private lock
Date: Tue, 21 Mar 2017 21:31:09 +0530
Message-Id: <1490112069-30133-1-git-send-email-gs051095@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes.  Replace it with a lock in the devices global data.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
Changes in v3:
	- Added mutex_init(&st->lock) inside probe function.
	- Added driver name in subject line.
Changes in v2:
        - Made the commit log clearer.
---
 drivers/staging/iio/adc/ad7280a.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index ee679ac..6a85e28 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -134,6 +134,7 @@ struct ad7280_state {
 	unsigned char			aux_threshhigh;
 	unsigned char			aux_threshlow;
 	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
+	struct mutex			lock; /* protect sensor state */
 
 	__be32				buf[2] ____cacheline_aligned;
 };
@@ -410,7 +411,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
 	devaddr = this_attr->address >> 8;
 	ch = this_attr->address & 0xFF;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	if (readin)
 		st->cb_mask[devaddr] |= 1 << (ch + 2);
 	else
@@ -418,7 +419,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
 
 	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE,
 			   0, st->cb_mask[devaddr]);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -433,10 +434,10 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
 	int ret;
 	unsigned int msecs;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad7280_read(st, this_attr->address >> 8,
 			  this_attr->address & 0xFF);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	if (ret < 0)
 		return ret;
@@ -466,11 +467,11 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
 	if (val > 31)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad7280_write(st, this_attr->address >> 8,
 			   this_attr->address & 0xFF,
 			   0, (val & 0x1F) << 3);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -655,7 +656,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 
 	val = clamp(val, 0L, 0xFFL);
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD7280A_CELL_OVERVOLTAGE:
 		st->cell_threshhigh = val;
@@ -674,7 +675,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
 			   this_attr->address, 1, val);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -792,13 +793,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		if (chan->address == AD7280A_ALL_CELLS)
 			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
 		else
 			ret = ad7280_read_channel(st, chan->address >> 8,
 						  chan->address & 0xFF);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 
 		if (ret < 0)
 			return ret;
@@ -847,6 +848,7 @@ static int ad7280_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
+	mutex_init(&st->lock);
 
 	if (!pdata)
 		pdata = &ad7793_default_pdata;
-- 
2.7.4

