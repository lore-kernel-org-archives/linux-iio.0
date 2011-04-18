Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] IIO-onwards: ADC: AD7887: Convert to new channel registration method.
Date: Mon, 18 Apr 2011 15:03:50 +0200
Message-ID: <1303131831-4010-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Convert to new channel registration method
Update / change license copyright header
Add missing call to iio_trigger_notify_done()

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7887.h      |   14 ++--
 drivers/staging/iio/adc/ad7887_core.c |  123 ++++++++++++++-------------------
 drivers/staging/iio/adc/ad7887_ring.c |   71 +++-----------------
 3 files changed, 69 insertions(+), 139 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index ffff403..a0c3742 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -48,12 +48,15 @@ struct ad7887_platform_data {
 	bool				use_onchip_ref;
 };
 
+/**
+ * struct ad7887_chip_info - chip specifc information
+ * @int_vref_mv:	the internal reference voltage
+ * @channel:		channel specification
+ */
+
 struct ad7887_chip_info {
-	u8				bits;		/* number of ADC bits */
-	u8				storagebits;	/* number of bits read from the ADC */
-	u8				left_shift;	/* number of bits the sample must be shifted */
-	char				sign;		/* [s]igned or [u]nsigned */
-	u16				int_vref_mv;	/* internal reference voltage */
+	u16				int_vref_mv;
+	struct iio_chan_spec		channel[3];
 };
 
 struct ad7887_state {
@@ -63,7 +66,6 @@ struct ad7887_state {
 	struct regulator		*reg;
 	size_t				d_size;
 	u16				int_vref_mv;
-	bool				en_dual;
 	struct spi_transfer		xfer[4];
 	struct spi_message		msg[3];
 	struct spi_message		*ring_msg;
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 27adff4..68301de 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -1,9 +1,9 @@
 /*
  * AD7887 SPI ADC driver
  *
- * Copyright 2010 Analog Devices Inc.
+ * Copyright 2010-2011 Analog Devices Inc.
  *
- * Licensed under the GPL-2 or later.
+ * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
@@ -33,81 +33,55 @@ static int ad7887_scan_direct(struct ad7887_state *st, unsigned ch)
 	return (st->data[(ch * 2)] << 8) | st->data[(ch * 2) + 1];
 }
 
-static ssize_t ad7887_scan(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+static int ad7887_read_raw(struct iio_dev *dev_info,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7887_state *st = dev_info->dev_data;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
+	struct ad7887_state *st = dev_info->dev_data;
+	unsigned int scale_uv;
 
-	mutex_lock(&dev_info->mlock);
-	if (iio_ring_enabled(dev_info))
-		ret = ad7887_scan_from_ring(st, 1 << this_attr->address);
-	else
-		ret = ad7887_scan_direct(st, this_attr->address);
-	mutex_unlock(&dev_info->mlock);
-
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", (ret >> st->chip_info->left_shift) &
-		       RES_MASK(st->chip_info->bits));
-}
-static IIO_DEV_ATTR_IN_RAW(0, ad7887_scan, 0);
-static IIO_DEV_ATTR_IN_RAW(1, ad7887_scan, 1);
-
-static ssize_t ad7887_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	/* Driver currently only support internal vref */
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7887_state *st = iio_dev_get_devdata(dev_info);
-	/* Corresponds to Vref / 2^(bits) */
-	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
-}
-static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7887_show_scale, NULL, 0);
-
-static struct attribute *ad7887_attributes[] = {
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_dev_attr_in_scale.dev_attr.attr,
-	NULL,
-};
-
-static mode_t ad7887_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7887_state *st = iio_dev_get_devdata(dev_info);
-
-	mode_t mode = attr->mode;
-
-	if ((attr == &iio_dev_attr_in1_raw.dev_attr.attr) && !st->en_dual)
-			mode = 0;
-
-	return mode;
+	switch (m) {
+	case 0:
+		mutex_lock(&dev_info->mlock);
+		if (iio_ring_enabled(dev_info))
+			ret = ad7887_scan_from_ring(st, 1 << chan->address);
+		else
+			ret = ad7887_scan_direct(st, chan->address);
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
 
-static const struct attribute_group ad7887_attribute_group = {
-	.attrs = ad7887_attributes,
-	.is_visible = ad7887_attr_is_visible,
-};
 
 static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 	/*
 	 * More devices added in future
 	 */
 	[ID_AD7887] = {
-		.bits = 12,
-		.storagebits = 16,
-		.left_shift = 0,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN_EV(IIO_IN, 1,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  1, 1, IIO_ST('u', 12, 16, 0), 0),
+
+		.channel[1] = IIO_CHAN_EV(IIO_IN, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  0, 0, IIO_ST('u', 12, 16, 0), 0),
+
+		.channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
 		.int_vref_mv = 2500,
 	},
 };
@@ -149,8 +123,11 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	/* Estabilish that the iio_dev is a child of the spi device */
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->attrs = &ad7887_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->channels = st->chip_info->channel;
+	st->indio_dev->num_channels = 3;
+	st->indio_dev->read_raw = &ad7887_read_raw;
+
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -196,8 +173,6 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 		spi_message_init(&st->msg[AD7887_CH1]);
 		spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
 
-		st->en_dual = true;
-
 		if (pdata && pdata->vref_mv)
 			st->int_vref_mv = pdata->vref_mv;
 		else if (voltage_uv)
@@ -205,6 +180,8 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 		else
 			dev_warn(&spi->dev, "reference voltage unspecified\n");
 
+		st->indio_dev->channels = st->chip_info->channel;
+		st->indio_dev->num_channels = 3;
 	} else {
 		if (pdata && pdata->vref_mv)
 			st->int_vref_mv = pdata->vref_mv;
@@ -212,8 +189,10 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 			st->int_vref_mv = st->chip_info->int_vref_mv;
 		else
 			dev_warn(&spi->dev, "reference voltage unspecified\n");
-	}
 
+		st->indio_dev->channels = &st->chip_info->channel[1];
+		st->indio_dev->num_channels = 2;
+	}
 
 	ret = ad7887_register_ring_funcs_and_init(st->indio_dev);
 	if (ret)
@@ -223,7 +202,9 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_device;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  st->indio_dev->channels,
+					  st->indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 	return 0;
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 8e3653c..e4fe03d 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -1,8 +1,8 @@
 /*
- * Copyright 2010 Analog Devices Inc.
+ * Copyright 2010-2011 Analog Devices Inc.
  * Copyright (C) 2008 Jonathan Cameron
  *
- * Licensed under the GPL-2 or later.
+ * Licensed under the GPL-2.
  *
  * ad7887_ring.c
  */
@@ -25,61 +25,6 @@
 
 #include "ad7887.h"
 
-static IIO_SCAN_EL_C(in0, 0, 0, NULL);
-static IIO_SCAN_EL_C(in1, 1, 0, NULL);
-static IIO_SCAN_EL_TIMESTAMP(2);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static ssize_t ad7887_show_type(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct ad7887_state *st = indio_dev->dev_data;
-
-	return sprintf(buf, "%c%d/%d>>%d\n", st->chip_info->sign,
-		       st->chip_info->bits, st->chip_info->storagebits,
-		       st->chip_info->left_shift);
-}
-static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad7887_show_type, NULL, 0);
-
-static struct attribute *ad7887_scan_el_attrs[] = {
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_scan_el_in1.dev_attr.attr,
-	&iio_const_attr_in1_index.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	&iio_dev_attr_in_type.dev_attr.attr,
-	NULL,
-};
-
-static mode_t ad7887_scan_el_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct ad7887_state *st = indio_dev->dev_data;
-
-	mode_t mode = attr->mode;
-
-	if ((attr == &iio_scan_el_in1.dev_attr.attr) ||
-		(attr == &iio_const_attr_in1_index.dev_attr.attr))
-		if (!st->en_dual)
-			mode = 0;
-
-	return mode;
-}
-
-static struct attribute_group ad7887_scan_el_group = {
-	.name = "scan_elements",
-	.attrs = ad7887_scan_el_attrs,
-	.is_visible = ad7887_scan_el_attr_is_visible,
-};
-
 int ad7887_scan_from_ring(struct ad7887_state *st, long mask)
 {
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
@@ -124,7 +69,8 @@ static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 	struct ad7887_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
-	st->d_size = ring->scan_count * st->chip_info->storagebits / 8;
+	st->d_size = ring->scan_count *
+		st->chip_info->channel[0].scan_type.storagebits / 8;
 
 	if (ring->scan_timestamp) {
 		st->d_size += sizeof(s64);
@@ -179,7 +125,8 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	__u8 *buf;
 	int b_sent;
 
-	unsigned int bytes = ring->scan_count * st->chip_info->storagebits / 8;
+	unsigned int bytes = ring->scan_count *
+		st->chip_info->channel[0].scan_type.storagebits / 8;
 
 	buf = kzalloc(st->d_size, GFP_KERNEL);
 	if (buf == NULL)
@@ -193,11 +140,13 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 
 	memcpy(buf, st->data, bytes);
 	if (ring->scan_timestamp)
-		memcpy(buf + st->d_size - sizeof(s64), &time_ns, sizeof(time_ns));
+		memcpy(buf + st->d_size - sizeof(s64),
+			&time_ns, sizeof(time_ns));
 
 	indio_dev->ring->access.store_to(&sw_ring->buf, buf, time_ns);
 done:
 	kfree(buf);
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
@@ -235,8 +184,6 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
 	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
 	indio_dev->ring->postdisable = &ad7887_ring_postdisable;
-	indio_dev->ring->scan_el_attrs = &ad7887_scan_el_group;
-	indio_dev->ring->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
-- 
1.6.0.2
