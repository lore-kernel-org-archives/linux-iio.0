Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35948 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935379AbdCLUtF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2017 16:49:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id j5so16883134pfb.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2017 13:48:36 -0700 (PDT)
From: Gargi Sharma <gs051095@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        Gargi Sharma <gs051095@gmail.com>
Subject: [PATCH] staging: iio: adc: Replace mlock with driver private lock
Date: Mon, 13 Mar 2017 02:15:46 +0530
Message-Id: <1489351546-21008-1-git-send-email-gs051095@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes.  Replace it with a lock in the devices global data.
This was done using Coccinelle Script.

@r1@
identifier xxx_state;
@@
struct xxx_state {
...
+ struct mutex          lock; /* protect sensor state */
};

@r2@
expression e;
@@
- mutex_lock(e);
+ mutex_lock(&st->lock);

@r3@
expression e;
@@
- mutex_unlock(e);
+ mutex_unlock(&st->lock);

Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index ee679ac..27a3ce3 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -136,6 +136,7 @@ struct ad7280_state {
 	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
 
 	__be32				buf[2] ____cacheline_aligned;
+	struct mutex			lock;  /* protect sensor state */
 };
 
 static void ad7280_crc8_build_table(unsigned char *crc_tab)
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
-- 
2.7.4

