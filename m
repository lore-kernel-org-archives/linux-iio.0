Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 34/99] staging:iio:ad7476 use channel_spec
Date: Wed,  4 May 2011 12:58:06 +0100
Message-Id: <1304510351-10922-35-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

V3: Trivial rebase fixup.
V2: Move to new single IIO_CHAN macro.

Done without hardware.

Fix from Michael Hennerich incorporated to use
iio_ring_buffer_register_ex instead of
iio_ring_buffer_register and thus actually make it work.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7476.h      |    5 +-
 drivers/staging/iio/adc/ad7476_core.c |  139 ++++++++++++++++-----------------
 drivers/staging/iio/adc/ad7476_ring.c |   40 +---------
 3 files changed, 74 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
index f917e9c..17febd2 100644
--- a/drivers/staging/iio/adc/ad7476.h
+++ b/drivers/staging/iio/adc/ad7476.h
@@ -19,11 +19,8 @@ struct ad7476_platform_data {
 };
 
 struct ad7476_chip_info {
-	u8				bits;
-	u8				storagebits;
-	u8				res_shift;
-	char				sign;
 	u16				int_vref_mv;
+	struct iio_chan_spec		channel[2];
 };
 
 struct ad7476_state {
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index b16744c..0438923 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -35,42 +35,39 @@ static int ad7476_scan_direct(struct ad7476_state *st)
 	return (st->data[0] << 8) | st->data[1];
 }
 
-static ssize_t ad7476_scan(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+static int ad7476_read_raw(struct iio_dev *dev_info,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7476_state *st = dev_info->dev_data;
 	int ret;
-
-	mutex_lock(&dev_info->mlock);
-	if (iio_ring_enabled(dev_info))
-		ret = ad7476_scan_from_ring(st);
-	else
-		ret = ad7476_scan_direct(st);
-	mutex_unlock(&dev_info->mlock);
-
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", (ret >> st->chip_info->res_shift) &
-		       RES_MASK(st->chip_info->bits));
-}
-static IIO_DEV_ATTR_IN_RAW(0, ad7476_scan, 0);
-
-static ssize_t ad7476_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	/* Driver currently only support internal vref */
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7476_state *st = iio_dev_get_devdata(dev_info);
-	/* Corresponds to Vref / 2^(bits) */
-	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
+	struct ad7476_state *st = dev_info->dev_data;
+	unsigned int scale_uv;
+
+	switch (m) {
+	case 0:
+		mutex_lock(&dev_info->mlock);
+		if (iio_ring_enabled(dev_info))
+			ret = ad7476_scan_from_ring(st);
+		else
+			ret = ad7476_scan_direct(st);
+		mutex_unlock(&dev_info->mlock);
+
+		if (ret < 0)
+			return ret;
+		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
+			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		scale_uv = (st->int_vref_mv * 1000)
+			>> st->chip_info->channel[0].scan_type.realbits;
+		*val =  scale_uv/1000;
+		*val2 = (scale_uv%1000)*1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	return -EINVAL;
 }
-static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7476_show_scale, NULL, 0);
 
 static ssize_t ad7476_show_name(struct device *dev,
 				 struct device_attribute *attr,
@@ -84,8 +81,6 @@ static ssize_t ad7476_show_name(struct device *dev,
 static IIO_DEVICE_ATTR(name, S_IRUGO, ad7476_show_name, NULL, 0);
 
 static struct attribute *ad7476_attributes[] = {
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in_scale.dev_attr.attr,
 	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
@@ -96,53 +91,53 @@ static const struct attribute_group ad7476_attribute_group = {
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7466] = {
-		.bits = 12,
-		.storagebits = 16,
-		.res_shift = 0,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7467] = {
-		.bits = 10,
-		.storagebits = 16,
-		.res_shift = 2,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 10, 16, 2), 0),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7468] = {
-		.bits = 8,
-		.storagebits = 16,
-		.res_shift = 4,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1 , 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 8, 16, 4), 0),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7475] = {
-		.bits = 12,
-		.storagebits = 16,
-		.res_shift = 0,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7476] = {
-		.bits = 12,
-		.storagebits = 16,
-		.res_shift = 0,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7477] = {
-		.bits = 10,
-		.storagebits = 16,
-		.res_shift = 2,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 10, 16, 2), 0),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7478] = {
-		.bits = 8,
-		.storagebits = 16,
-		.res_shift = 4,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 8, 16, 4), 0),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7495] = {
-		.bits = 12,
-		.storagebits = 16,
-		.res_shift = 0,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 		.int_vref_mv = 2500,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
 	},
 };
 
@@ -196,11 +191,13 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
-
+	st->indio_dev->channels = st->chip_info->channel;
+	st->indio_dev->num_channels = 2;
+	st->indio_dev->read_raw = &ad7476_read_raw;
 	/* Setup default message */
 
 	st->xfer.rx_buf = &st->data;
-	st->xfer.len = st->chip_info->storagebits / 8;
+	st->xfer.len = st->chip_info->channel[0].scan_type.storagebits / 8;
 
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
@@ -213,7 +210,9 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_device;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  st->chip_info->channel,
+					  ARRAY_SIZE(st->chip_info->channel));
 	if (ret)
 		goto error_cleanup_ring;
 	return 0;
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 92d9378..8f00d6c 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -25,39 +25,6 @@
 
 #include "ad7476.h"
 
-static IIO_SCAN_EL_C(in0, 0, 0, NULL);
-static IIO_SCAN_EL_TIMESTAMP(1);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static ssize_t ad7476_show_type(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct ad7476_state *st = indio_dev->dev_data;
-
-	return sprintf(buf, "%c%d/%d>>%d\n", st->chip_info->sign,
-		       st->chip_info->bits, st->chip_info->storagebits,
-		       st->chip_info->res_shift);
-}
-static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad7476_show_type, NULL, 0);
-
-static struct attribute *ad7476_scan_el_attrs[] = {
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	&iio_dev_attr_in_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group ad7476_scan_el_group = {
-	.name = "scan_elements",
-	.attrs = ad7476_scan_el_attrs,
-};
-
 int ad7476_scan_from_ring(struct ad7476_state *st)
 {
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
@@ -93,7 +60,8 @@ static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 	struct ad7476_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
-	st->d_size = ring->scan_count * st->chip_info->storagebits / 8;
+	st->d_size = ring->scan_count *
+		st->chip_info->channel[0].scan_type.storagebits / 8;
 
 	if (ring->scan_timestamp) {
 		st->d_size += sizeof(s64);
@@ -150,7 +118,8 @@ static void ad7476_poll_bh_to_ring(struct work_struct *work_s)
 	if (rxbuf == NULL)
 		return;
 
-	b_sent = spi_read(st->spi, rxbuf, st->chip_info->storagebits / 8);
+	b_sent = spi_read(st->spi, rxbuf,
+			  st->chip_info->channel[0].scan_type.storagebits / 8);
 	if (b_sent < 0)
 		goto done;
 
@@ -187,7 +156,6 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->preenable = &ad7476_ring_preenable;
 	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
 	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
-	indio_dev->ring->scan_el_attrs = &ad7476_scan_el_group;
 	indio_dev->ring->scan_timestamp = true;
 
 	INIT_WORK(&st->poll_work, &ad7476_poll_bh_to_ring);
-- 
1.7.3.4
