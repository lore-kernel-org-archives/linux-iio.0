Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:39072
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753824AbeGEMee (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Jul 2018 08:34:34 -0400
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>
CC: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH V3] iio: ad9523: replace core mlock with local lock
Date: Thu, 5 Jul 2018 15:34:22 +0300
Message-ID: <20180705123422.18786-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

This is also part of a long term effort to make the use of mlock opaque and
single purpose.

This lock is required for accessing device registers. The device may be
accessed by multiple processes at the same time, and this can result in
inconsistent data, where one device reads data before the other one has
finished writing.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

V2 -> V3:
* added description about the impact of the change

 drivers/iio/frequency/ad9523.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index ddb6a334ae68..8fb4e5890713 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -274,6 +274,14 @@ struct ad9523_state {
 	unsigned long		vco_out_freq[AD9523_NUM_CLK_SRC];
 	unsigned char		vco_out_map[AD9523_NUM_CHAN_ALT_CLK_SRC];
 
+	/*
+	 * Lock for accessing device registers. The device may be accessed by
+	 * multiple processes at the same time, and this can result in
+	 * inconsistent data, where one device reads data before the other one
+	 * has finished writing.
+	 */
+	struct mutex		lock;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -500,6 +508,7 @@ static ssize_t ad9523_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct ad9523_state *st = iio_priv(indio_dev);
 	bool state;
 	int ret;
 
@@ -510,7 +519,7 @@ static ssize_t ad9523_store(struct device *dev,
 	if (!state)
 		return 0;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9523_SYNC:
 		ret = ad9523_sync(indio_dev);
@@ -521,7 +530,7 @@ static ssize_t ad9523_store(struct device *dev,
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -532,15 +541,16 @@ static ssize_t ad9523_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct ad9523_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad9523_read(indio_dev, AD9523_READBACK_0);
 	if (ret >= 0) {
 		ret = sprintf(buf, "%d\n", !!(ret & (1 <<
 			(u32)this_attr->address)));
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -623,9 +633,9 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
 	unsigned int code;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad9523_read(indio_dev, AD9523_CHANNEL_CLOCK_DIST(chan->channel));
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	if (ret < 0)
 		return ret;
@@ -659,7 +669,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
 	unsigned int reg;
 	int ret, tmp, code;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad9523_read(indio_dev, AD9523_CHANNEL_CLOCK_DIST(chan->channel));
 	if (ret < 0)
 		goto out;
@@ -705,7 +715,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
 
 	ad9523_io_update(indio_dev);
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -713,9 +723,10 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
 			      unsigned int reg, unsigned int writeval,
 			      unsigned int *readval)
 {
+	struct ad9523_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	if (readval == NULL) {
 		ret = ad9523_write(indio_dev, reg | AD9523_R1B, writeval);
 		ad9523_io_update(indio_dev);
@@ -728,7 +739,7 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
 	}
 
 out_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -967,6 +978,8 @@ static int ad9523_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	mutex_init(&st->lock);
+
 	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
-- 
2.17.1

