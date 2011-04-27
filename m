Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 1/2] IIO-onwards: ADC: AD7780: Convert to new channel registration method
Date: Wed, 27 Apr 2011 09:45:24 +0200
Message-ID: <1303890325-3770-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Convert to new channel registration method

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7780.c |  113 +++++++++++++++++---------------------
 1 files changed, 51 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index f828e83..c000efc 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -36,9 +36,7 @@
 #define AD7780_PAT0	(1 << 0)
 
 struct ad7780_chip_info {
-	u8				bits;
-	u8				storagebits;
-	u8				res_shift;
+	struct iio_chan_spec		channel;
 };
 
 struct ad7780_state {
@@ -88,70 +86,59 @@ out:
 	return ret;
 }
 
-static ssize_t ad7780_scan(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+static int ad7780_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7780_state *st = dev_info->dev_data;
-	int ret, val, smpl;
-
-	mutex_lock(&dev_info->mlock);
-	ret = ad7780_read(st, &smpl);
-	mutex_unlock(&dev_info->mlock);
-
-	if (ret < 0)
-		return ret;
-
-	if ((smpl & AD7780_ERR) ||
-		!((smpl & AD7780_PAT0) && !(smpl & AD7780_PAT1)))
-		return -EIO;
-
-	val = (smpl >> st->chip_info->res_shift) &
-		((1 << (st->chip_info->bits)) - 1);
-	val -= (1 << (st->chip_info->bits - 1));
-
-	if (!(smpl & AD7780_GAIN))
-		val *= 128;
-
-	return sprintf(buf, "%d\n", val);
-}
-static IIO_DEV_ATTR_IN_RAW(0, ad7780_scan, 0);
-
-static ssize_t ad7780_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7780_state *st = iio_dev_get_devdata(dev_info);
-	/* Corresponds to Vref / 2^(bits-1) */
-	unsigned int scale = (st->int_vref_mv * 100000) >>
-		(st->chip_info->bits - 1);
-
-	return sprintf(buf, "%d.%05d\n", scale / 100000, scale % 100000);
+	int ret, smpl;
+	struct ad7780_state *st = indio_dev->dev_data;
+	unsigned int scale_uv;
+
+	switch (m) {
+	case 0:
+		mutex_lock(&indio_dev->mlock);
+		ret = ad7780_read(st, &smpl);
+		mutex_unlock(&indio_dev->mlock);
+
+		if (ret < 0)
+			return ret;
+
+		if ((smpl & AD7780_ERR) ||
+			!((smpl & AD7780_PAT0) && !(smpl & AD7780_PAT1)))
+			return -EIO;
+
+		*val = (smpl >> st->chip_info->channel.scan_type.shift) &
+			((1 << (st->chip_info->channel.scan_type.realbits))
+			- 1);
+		*val -= (1 << (st->chip_info->channel.scan_type.realbits
+			- 1));
+
+		if (!(smpl & AD7780_GAIN))
+			*val *= 128;
+
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		scale_uv = (st->int_vref_mv * 100000)
+			>> (st->chip_info->channel.scan_type.realbits - 1);
+		*val =  scale_uv / 100000;
+		*val2 = (scale_uv % 100000) * 10;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	return -EINVAL;
 }
-static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7780_show_scale, NULL, 0);
-
-static struct attribute *ad7780_attributes[] = {
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in_scale.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7780_attribute_group = {
-	.attrs = ad7780_attributes,
-};
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7780] = {
-		.bits = 24,
-		.storagebits = 32,
-		.res_shift = 8,
+		.channel = IIO_CHAN_EV(IIO_IN, 0,
+			(1 << IIO_CHAN_INFO_SCALE_SHARED),
+			0, 0, IIO_ST('s', 24, 32, 8), 0),
 	},
 	[ID_AD7781] = {
-		.bits = 20,
-		.storagebits = 32,
-		.res_shift = 12,
+		.channel = IIO_CHAN_EV(IIO_IN, 0,
+			(1 << IIO_CHAN_INFO_SCALE_SHARED),
+			0, 0, IIO_ST('s', 20, 32, 12), 0),
 	},
 };
 
@@ -218,17 +205,19 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 	/* Establish that the iio_dev is a child of the spi device */
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->attrs = &ad7780_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	st->indio_dev->channels = &st->chip_info->channel;
+	st->indio_dev->num_channels = 1;
+	st->indio_dev->read_raw = &ad7780_read_raw;
 
 	init_waitqueue_head(&st->wq_data_avail);
 
 	/* Setup default message */
 
 	st->xfer.rx_buf = &st->data;
-	st->xfer.len = st->chip_info->storagebits / 8;
+	st->xfer.len = st->chip_info->channel.scan_type.storagebits / 8;
 
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
-- 
1.6.0.2
