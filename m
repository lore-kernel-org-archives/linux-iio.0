Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] IIO-onwards: ADC: AD7298: Convert to new channel registration method
Date: Tue, 19 Apr 2011 13:56:09 +0200
Message-ID: <1303214170-10379-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Convert to new channel registration method Update
Add missing call to iio_trigger_notify_done()

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7298.h      |    5 +-
 drivers/staging/iio/adc/ad7298_core.c |  171 +++++++++++++++++++--------------
 drivers/staging/iio/adc/ad7298_ring.c |   69 +++----------
 3 files changed, 114 insertions(+), 131 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
index 8d149c8..718e56a 100644
--- a/drivers/staging/iio/adc/ad7298.h
+++ b/drivers/staging/iio/adc/ad7298.h
@@ -17,14 +17,13 @@
 #define AD7298_TAVG	(1 << 1) /* temperature sensor averaging enable */
 #define AD7298_PDD	(1 << 0) /* partial power down enable */
 
-#define AD7298_CH_MASK	(AD7298_CH0 | AD7298_CH1 | AD7298_CH2 | AD7298_CH3 | \
-			AD7298_CH4 | AD7298_CH5 | AD7298_CH6 | AD7298_CH7)
-
 #define AD7298_MAX_CHAN		8
 #define AD7298_BITS		12
 #define AD7298_STORAGE_BITS	16
 #define AD7298_INTREF_mV	2500
 
+#define AD7298_CH_TEMP		9
+
 #define RES_MASK(bits)	((1 << (bits)) - 1)
 
 /*
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 5fe0dff..ef670cf 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -23,6 +23,37 @@
 
 #include "ad7298.h"
 
+static struct iio_chan_spec ad7298_channels[] = {
+	IIO_CHAN_EV(IIO_TEMP, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		9, AD7298_CH_TEMP, IIO_ST('s', 32, 32, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		0, 0, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 1,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		1, 1, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 2,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		2, 2, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 3,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		3, 3, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 4,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		4, 4, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 5,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		5, 5, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 6,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		6, 6, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_EV(IIO_IN, 7,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		7, 7, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+};
+
 static int ad7298_scan_direct(struct ad7298_state *st, unsigned ch)
 {
 	int ret;
@@ -36,55 +67,28 @@ static int ad7298_scan_direct(struct ad7298_state *st, unsigned ch)
 	return be16_to_cpu(st->rx_buf[0]);
 }
 
-static ssize_t ad7298_scan(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+static int ad7298_scan_temp(struct ad7298_state *st, int *val)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7298_state *st = dev_info->dev_data;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret;
+	int tmp, ret;
 
-	mutex_lock(&dev_info->mlock);
-	if (iio_ring_enabled(dev_info))
-		ret = ad7298_scan_from_ring(st, this_attr->address);
-	else
-		ret = ad7298_scan_direct(st, this_attr->address);
-	mutex_unlock(&dev_info->mlock);
+	tmp = cpu_to_be16(AD7298_WRITE | AD7298_TSENSE |
+			  AD7298_TAVG | st->ext_ref);
 
-	if (ret < 0)
+	ret = spi_write(st->spi, (u8 *)&tmp, 2);
+	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", ret & RES_MASK(AD7298_BITS));
-}
-
-static IIO_DEV_ATTR_IN_RAW(0, ad7298_scan, 0);
-static IIO_DEV_ATTR_IN_RAW(1, ad7298_scan, 1);
-static IIO_DEV_ATTR_IN_RAW(2, ad7298_scan, 2);
-static IIO_DEV_ATTR_IN_RAW(3, ad7298_scan, 3);
-static IIO_DEV_ATTR_IN_RAW(4, ad7298_scan, 4);
-static IIO_DEV_ATTR_IN_RAW(5, ad7298_scan, 5);
-static IIO_DEV_ATTR_IN_RAW(6, ad7298_scan, 6);
-static IIO_DEV_ATTR_IN_RAW(7, ad7298_scan, 7);
-
-static ssize_t ad7298_show_temp(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7298_state *st = iio_dev_get_devdata(dev_info);
-	int tmp;
+	tmp = 0;
 
-	tmp = cpu_to_be16(AD7298_WRITE | AD7298_TSENSE |
-			  AD7298_TAVG | st->ext_ref);
+	ret = spi_write(st->spi, (u8 *)&tmp, 2);
+	if (ret)
+		return ret;
 
-	mutex_lock(&dev_info->mlock);
-	spi_write(st->spi, (u8 *)&tmp, 2);
-	tmp = 0;
-	spi_write(st->spi, (u8 *)&tmp, 2);
 	usleep_range(101, 1000); /* sleep > 100us */
-	spi_read(st->spi, (u8 *)&tmp, 2);
-	mutex_unlock(&dev_info->mlock);
+
+	ret = spi_read(st->spi, (u8 *)&tmp, 2);
+	if (ret)
+		return ret;
 
 	tmp = be16_to_cpu(tmp) & RES_MASK(AD7298_BITS);
 
@@ -101,41 +105,56 @@ static ssize_t ad7298_show_temp(struct device *dev,
 		tmp *= 250; /* temperature in milli degrees Celsius */
 	}
 
-	return sprintf(buf, "%d\n", tmp);
-}
+	*val = tmp;
 
-static IIO_DEVICE_ATTR(temp0_input, S_IRUGO, ad7298_show_temp, NULL, 0);
+	return 0;
+}
 
-static ssize_t ad7298_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int ad7298_read_raw(struct iio_dev *dev_info,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7298_state *st = iio_dev_get_devdata(dev_info);
-	/* Corresponds to Vref / 2^(bits) */
-	unsigned int scale_uv = (st->int_vref_mv * 1000) >> AD7298_BITS;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
+	int ret;
+	struct ad7298_state *st = dev_info->dev_data;
+	unsigned int scale_uv;
+
+	switch (m) {
+	case 0:
+		mutex_lock(&dev_info->mlock);
+		if (iio_ring_enabled(dev_info)) {
+			if (chan->address == AD7298_CH_TEMP)
+				ret = -ENODEV;
+			else
+				ret = ad7298_scan_from_ring(st, chan->address);
+		} else {
+			if (chan->address == AD7298_CH_TEMP)
+				ret = ad7298_scan_temp(st, val);
+			else
+				ret = ad7298_scan_direct(st, chan->address);
+		}
+		mutex_unlock(&dev_info->mlock);
+
+		if (ret < 0)
+			return ret;
+
+		if (chan->address != AD7298_CH_TEMP)
+			*val = ret & RES_MASK(AD7298_BITS);
+
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		scale_uv = (st->int_vref_mv * 1000) >> AD7298_BITS;
+		*val =  scale_uv / 1000;
+		*val2 = (scale_uv % 1000) * 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		*val =  1;
+		*val2 = 0;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	return -EINVAL;
 }
-static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7298_show_scale, NULL, 0);
-
-static struct attribute *ad7298_attributes[] = {
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_dev_attr_in2_raw.dev_attr.attr,
-	&iio_dev_attr_in3_raw.dev_attr.attr,
-	&iio_dev_attr_in4_raw.dev_attr.attr,
-	&iio_dev_attr_in5_raw.dev_attr.attr,
-	&iio_dev_attr_in6_raw.dev_attr.attr,
-	&iio_dev_attr_in7_raw.dev_attr.attr,
-	&iio_dev_attr_in_scale.dev_attr.attr,
-	&iio_dev_attr_temp0_input.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7298_attribute_group = {
-	.attrs = ad7298_attributes,
-};
 
 static int __devinit ad7298_probe(struct spi_device *spi)
 {
@@ -168,10 +187,12 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 
 	st->indio_dev->name = spi_get_device_id(spi)->name;
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &ad7298_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	st->indio_dev->channels = ad7298_channels;
+	st->indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
+	st->indio_dev->read_raw = &ad7298_read_raw;
 
 	/* Setup default message */
 
@@ -204,7 +225,9 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_device;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  &ad7298_channels[1], /* skip temp0 */
+					  ARRAY_SIZE(ad7298_channels) - 1);
 	if (ret)
 		goto error_cleanup_ring;
 	return 0;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 1b9752c..19e6916 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -21,49 +21,6 @@
 
 #include "ad7298.h"
 
-static IIO_SCAN_EL_C(in0, 0, 0, NULL);
-static IIO_SCAN_EL_C(in1, 1, 0, NULL);
-static IIO_SCAN_EL_C(in2, 2, 0, NULL);
-static IIO_SCAN_EL_C(in3, 3, 0, NULL);
-static IIO_SCAN_EL_C(in4, 4, 0, NULL);
-static IIO_SCAN_EL_C(in5, 5, 0, NULL);
-static IIO_SCAN_EL_C(in6, 6, 0, NULL);
-static IIO_SCAN_EL_C(in7, 7, 0, NULL);
-
-static IIO_SCAN_EL_TIMESTAMP(8);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static IIO_CONST_ATTR(in_type, "u12/16") ;
-
-static struct attribute *ad7298_scan_el_attrs[] = {
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_scan_el_in1.dev_attr.attr,
-	&iio_const_attr_in1_index.dev_attr.attr,
-	&iio_scan_el_in2.dev_attr.attr,
-	&iio_const_attr_in2_index.dev_attr.attr,
-	&iio_scan_el_in3.dev_attr.attr,
-	&iio_const_attr_in3_index.dev_attr.attr,
-	&iio_scan_el_in4.dev_attr.attr,
-	&iio_const_attr_in4_index.dev_attr.attr,
-	&iio_scan_el_in5.dev_attr.attr,
-	&iio_const_attr_in5_index.dev_attr.attr,
-	&iio_scan_el_in6.dev_attr.attr,
-	&iio_const_attr_in6_index.dev_attr.attr,
-	&iio_scan_el_in7.dev_attr.attr,
-	&iio_const_attr_in7_index.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	&iio_const_attr_in_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group ad7298_scan_el_group = {
-	.name = "scan_elements",
-	.attrs = ad7298_scan_el_attrs,
-};
-
 int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
 {
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
@@ -75,12 +32,13 @@ int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
 		goto error_ret;
 	}
 
-	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
+	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
+			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = ring->access.read_last(ring, (u8 *) ring_data);
+	ret = ring->access->read_last(ring, (u8 *) ring_data);
 	if (ret)
 		goto error_free_ring_data;
 
@@ -116,8 +74,8 @@ static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
 	}
 
-	if (ring->access.set_bytes_per_datum)
-		ring->access.set_bytes_per_datum(ring, d_size);
+	if (ring->access->set_bytes_per_datum)
+		ring->access->set_bytes_per_datum(ring, d_size);
 
 	st->d_size = d_size;
 
@@ -182,11 +140,18 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	for (i = 0; i < ring->scan_count; i++)
 		buf[i] = be16_to_cpu(st->rx_buf[i]);
 
-	indio_dev->ring->access.store_to(ring, (u8 *)buf, time_ns);
+	indio_dev->ring->access->store_to(ring, (u8 *)buf, time_ns);
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
 
+static struct iio_ring_setup_ops ad7298_ring_setup_ops = {
+	.preenable = &ad7298_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+};
+
 int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -197,7 +162,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	indio_dev->ring->access = &ring_sw_access_funcs;
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
@@ -214,11 +179,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_free_poll_func;
 	}
 	/* Ring buffer functions - here trigger setup related */
-
-	indio_dev->ring->preenable = &ad7298_ring_preenable;
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
-	indio_dev->ring->scan_el_attrs = &ad7298_scan_el_group;
+	indio_dev->ring->setup_ops = &ad7298_ring_setup_ops;
 	indio_dev->ring->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
-- 
1.6.0.2
