Return-Path: <SRS0=iv4G=JL=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>
Subject: [PATCH] iio: ad9523: replace core mlock with local lock
Date: Mon, 25 Jun 2018 10:28:08 +0300
Message-ID: <20180625072808.8796-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

This is part of a long term effort to make the use of mlock opaque and
single purpose.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/frequency/ad9523.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index ddb6a334ae68..1b70e8a13338 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -274,6 +274,8 @@ struct ad9523_state {
 	unsigned long		vco_out_freq[AD9523_NUM_CLK_SRC];
 	unsigned char		vco_out_map[AD9523_NUM_CHAN_ALT_CLK_SRC];
 
+	struct mutex		lock;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -500,6 +502,7 @@ static ssize_t ad9523_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct ad9523_state *st = iio_priv(indio_dev);
 	bool state;
 	int ret;
 
@@ -510,7 +513,7 @@ static ssize_t ad9523_store(struct device *dev,
 	if (!state)
 		return 0;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9523_SYNC:
 		ret = ad9523_sync(indio_dev);
@@ -521,7 +524,7 @@ static ssize_t ad9523_store(struct device *dev,
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -532,15 +535,16 @@ static ssize_t ad9523_show(struct device *dev,
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
@@ -623,9 +627,9 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
 	unsigned int code;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad9523_read(indio_dev, AD9523_CHANNEL_CLOCK_DIST(chan->channel));
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	if (ret < 0)
 		return ret;
@@ -659,7 +663,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
 	unsigned int reg;
 	int ret, tmp, code;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad9523_read(indio_dev, AD9523_CHANNEL_CLOCK_DIST(chan->channel));
 	if (ret < 0)
 		goto out;
@@ -705,7 +709,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
 
 	ad9523_io_update(indio_dev);
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -713,9 +717,10 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
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
@@ -728,7 +733,7 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
 	}
 
 out_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -967,6 +972,8 @@ static int ad9523_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	mutex_init(&st->lock);
+
 	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
-- 
2.17.1
