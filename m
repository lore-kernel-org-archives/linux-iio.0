Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 70/99] staging:iio:adc:ad7606 Convert to new channel registration method Update Add missing call to iio_trigger_notify_done() Set pollfunc top and bottom half handler
Date: Wed,  4 May 2011 12:58:42 +0100
Message-Id: <1304510351-10922-71-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

V3: rebase fixup.

Backported to relevant merge point by Jonathan Cameron.
V2: IIO_CHAN macro usage update

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606.h      |    7 +-
 drivers/staging/iio/adc/ad7606_core.c |  185 +++++++++++++++++++--------------
 drivers/staging/iio/adc/ad7606_ring.c |   99 ++----------------
 3 files changed, 116 insertions(+), 175 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index b8563bf..2af1434 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -43,10 +43,9 @@ struct ad7606_platform_data {
 /**
  * struct ad7606_chip_info - chip specifc information
  * @name:		indentification string for chip
- * @bits:		accuracy of the adc in bits
- * @bits:		output coding [s]igned or [u]nsigned
  * @int_vref_mv:	the internal reference voltage
- * @num_channels:	number of physical inputs on chip
+ * @channels:		channel specification
+ * @num_channels:	number of channels
  */
 
 struct ad7606_chip_info {
@@ -54,6 +53,7 @@ struct ad7606_chip_info {
 	u8				bits;
 	char				sign;
 	u16				int_vref_mv;
+	struct iio_chan_spec		*channels;
 	unsigned			num_channels;
 };
 
@@ -69,7 +69,6 @@ struct ad7606_state {
 	struct regulator		*reg;
 	struct work_struct		poll_work;
 	wait_queue_head_t		wq_data_avail;
-	atomic_t			protect_ring;
 	size_t				d_size;
 	const struct ad7606_bus_ops	*bops;
 	int				irq;
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 27090b9..ee61009 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -78,62 +78,39 @@ error_ret:
 	return ret;
 }
 
-static ssize_t ad7606_scan(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+static int ad7606_read_raw(struct iio_dev *dev_info,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7606_state *st = dev_info->dev_data;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
-
-	mutex_lock(&dev_info->mlock);
-	if (iio_ring_enabled(dev_info))
-		ret = ad7606_scan_from_ring(st, this_attr->address);
-	else
-		ret = ad7606_scan_direct(st, this_attr->address);
-	mutex_unlock(&dev_info->mlock);
-
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", (short) ret);
-}
-
-static IIO_DEV_ATTR_IN_RAW(0, ad7606_scan, 0);
-static IIO_DEV_ATTR_IN_RAW(1, ad7606_scan, 1);
-static IIO_DEV_ATTR_IN_RAW(2, ad7606_scan, 2);
-static IIO_DEV_ATTR_IN_RAW(3, ad7606_scan, 3);
-static IIO_DEV_ATTR_IN_RAW(4, ad7606_scan, 4);
-static IIO_DEV_ATTR_IN_RAW(5, ad7606_scan, 5);
-static IIO_DEV_ATTR_IN_RAW(6, ad7606_scan, 6);
-static IIO_DEV_ATTR_IN_RAW(7, ad7606_scan, 7);
-
-static ssize_t ad7606_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	/* Driver currently only support internal vref */
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(dev_info);
-	unsigned int scale_uv = (st->range * 1000 * 2) >> st->chip_info->bits;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
-}
-static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7606_show_scale, NULL, 0);
-
-static ssize_t ad7606_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_dev_get_devdata(dev_info);
-
-	return sprintf(buf, "%s\n", st->chip_info->name);
+	struct ad7606_state *st = dev_info->dev_data;
+	unsigned int scale_uv;
+
+	switch (m) {
+	case 0:
+		mutex_lock(&dev_info->mlock);
+		if (iio_ring_enabled(dev_info))
+			ret = ad7606_scan_from_ring(st, chan->address);
+		else
+			ret = ad7606_scan_direct(st, chan->address);
+		mutex_unlock(&dev_info->mlock);
+
+		if (ret < 0)
+			return ret;
+		*val = (short) ret;
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		scale_uv = (st->range * 1000 * 2)
+			>> st->chip_info->channels[0].scan_type.realbits;
+		*val =  scale_uv / 1000;
+		*val2 = (scale_uv % 1000) * 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	return -EINVAL;
 }
 
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad7606_show_name, NULL, 0);
-
 static ssize_t ad7606_show_range(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -222,16 +199,6 @@ static IIO_DEVICE_ATTR(oversampling_ratio, S_IRUGO | S_IWUSR,
 static IIO_CONST_ATTR(oversampling_ratio_available, "0 2 4 8 16 32 64");
 
 static struct attribute *ad7606_attributes[] = {
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_dev_attr_in2_raw.dev_attr.attr,
-	&iio_dev_attr_in3_raw.dev_attr.attr,
-	&iio_dev_attr_in4_raw.dev_attr.attr,
-	&iio_dev_attr_in5_raw.dev_attr.attr,
-	&iio_dev_attr_in6_raw.dev_attr.attr,
-	&iio_dev_attr_in7_raw.dev_attr.attr,
-	&iio_dev_attr_in_scale.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	&iio_dev_attr_range.dev_attr.attr,
 	&iio_const_attr_range_available.dev_attr.attr,
 	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
@@ -248,15 +215,7 @@ static mode_t ad7606_attr_is_visible(struct kobject *kobj,
 
 	mode_t mode = attr->mode;
 
-	if (st->chip_info->num_channels <= 6 &&
-		(attr == &iio_dev_attr_in7_raw.dev_attr.attr ||
-		attr == &iio_dev_attr_in6_raw.dev_attr.attr))
-		mode = 0;
-	else if (st->chip_info->num_channels <= 4 &&
-		(attr == &iio_dev_attr_in5_raw.dev_attr.attr ||
-		attr == &iio_dev_attr_in4_raw.dev_attr.attr))
-		mode = 0;
-	else if (!st->have_os &&
+	if (!st->have_os &&
 		(attr == &iio_dev_attr_oversampling_ratio.dev_attr.attr ||
 		attr ==
 		&iio_const_attr_oversampling_ratio_available.dev_attr.attr))
@@ -274,29 +233,92 @@ static const struct attribute_group ad7606_attribute_group = {
 	.is_visible = ad7606_attr_is_visible,
 };
 
+static struct iio_chan_spec ad7606_8_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, 0, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 1, 1, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 2, 2, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 3, 3, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 4, 4, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 5, 5, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 6, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 6, 6, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 7, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 7, 7, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+};
+
+static struct iio_chan_spec ad7606_6_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, 0, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 1, 1, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 2, 2, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 3, 3, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 4, 4, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 5, 5, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(6),
+};
+
+static struct iio_chan_spec ad7606_4_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, 0, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 1, 1, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 2, 2, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 3, 3, IIO_ST('s', 16, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
 static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 	/*
 	 * More devices added in future
 	 */
 	[ID_AD7606_8] = {
 		.name = "ad7606",
-		.bits = 16,
-		.sign = IIO_SCAN_EL_TYPE_SIGNED,
 		.int_vref_mv = 2500,
+		.channels = ad7606_8_channels,
 		.num_channels = 8,
 	},
 	[ID_AD7606_6] = {
 		.name = "ad7606-6",
-		.bits = 16,
-		.sign = IIO_SCAN_EL_TYPE_SIGNED,
 		.int_vref_mv = 2500,
+		.channels = ad7606_6_channels,
 		.num_channels = 6,
 	},
 	[ID_AD7606_4] = {
 		.name = "ad7606-4",
-		.bits = 16,
-		.sign = IIO_SCAN_EL_TYPE_SIGNED,
 		.int_vref_mv = 2500,
+		.channels = ad7606_4_channels,
 		.num_channels = 4,
 	},
 };
@@ -445,8 +467,6 @@ struct ad7606_state *ad7606_probe(struct device *dev, int irq,
 	st->pdata = pdata;
 	st->chip_info = &ad7606_chip_info_tbl[id];
 
-	atomic_set(&st->protect_ring, 0);
-
 	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
@@ -459,6 +479,9 @@ struct ad7606_state *ad7606_probe(struct device *dev, int irq,
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 	st->indio_dev->name = st->chip_info->name;
+	st->indio_dev->channels = st->chip_info->channels;
+	st->indio_dev->num_channels = st->chip_info->num_channels;
+	st->indio_dev->read_raw = &ad7606_read_raw;
 
 	init_waitqueue_head(&st->wq_data_avail);
 
@@ -483,7 +506,9 @@ struct ad7606_state *ad7606_probe(struct device *dev, int irq,
 	if (ret)
 		goto error_free_irq;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  st->indio_dev->channels,
+					  st->indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 43caced..15531b6 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -21,87 +21,6 @@
 
 #include "ad7606.h"
 
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
-static ssize_t ad7606_show_type(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct ad7606_state *st = indio_dev->dev_data;
-
-	return sprintf(buf, "%c%d/%d\n", st->chip_info->sign,
-		       st->chip_info->bits, st->chip_info->bits);
-}
-static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad7606_show_type, NULL, 0);
-
-static struct attribute *ad7606_scan_el_attrs[] = {
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
-	&iio_dev_attr_in_type.dev_attr.attr,
-	NULL,
-};
-
-static mode_t ad7606_scan_el_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct ad7606_state *st = indio_dev->dev_data;
-
-	mode_t mode = attr->mode;
-
-	if (st->chip_info->num_channels <= 6 &&
-		(attr == &iio_scan_el_in7.dev_attr.attr ||
-		attr == &iio_const_attr_in7_index.dev_attr.attr ||
-		attr == &iio_scan_el_in6.dev_attr.attr ||
-		attr == &iio_const_attr_in6_index.dev_attr.attr))
-		mode = 0;
-	else if (st->chip_info->num_channels <= 4 &&
-		(attr == &iio_scan_el_in5.dev_attr.attr ||
-		attr == &iio_const_attr_in5_index.dev_attr.attr ||
-		attr == &iio_scan_el_in4.dev_attr.attr ||
-		attr == &iio_const_attr_in4_index.dev_attr.attr))
-		mode = 0;
-
-	return mode;
-}
-
-static struct attribute_group ad7606_scan_el_group = {
-	.name = "scan_elements",
-	.attrs = ad7606_scan_el_attrs,
-	.is_visible = ad7606_scan_el_attr_is_visible,
-};
-
 int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch)
 {
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
@@ -139,7 +58,7 @@ static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 	size_t d_size;
 
 	d_size = st->chip_info->num_channels *
-		 st->chip_info->bits / 8;
+		 st->chip_info->channels[0].scan_type.storagebits / 8;
 
 	if (ring->scan_timestamp) {
 		d_size += sizeof(s64);
@@ -157,14 +76,15 @@ static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 }
 
 /**
- * ad7606_trigger_handler_th() th of trigger launched polling to ring buffer
+ * ad7606_trigger_handler_th() th/bh of trigger launched polling to ring buffer
  *
  **/
-static irqreturn_t ad7606_trigger_handler_th(int irq, void *p)
+static irqreturn_t ad7606_trigger_handler_th_bh(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
 	struct ad7606_state *st = indio_dev->dev_data;
+
 	gpio_set_value(st->pdata->gpio_convst, 1);
 
 	return IRQ_HANDLED;
@@ -190,10 +110,6 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	__u8 *buf;
 	int ret;
 
-	/* Ensure only one copy of this function running at a time */
-	if (atomic_inc_return(&st->protect_ring) > 1)
-		return;
-
 	buf = kzalloc(st->d_size, GFP_KERNEL);
 	if (buf == NULL)
 		return;
@@ -231,8 +147,8 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	ring->access.store_to(&sw_ring->buf, buf, time_ns);
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(buf);
-	atomic_dec(&st->protect_ring);
 }
 
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
@@ -253,8 +169,10 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
+
 	indio_dev->pollfunc->private_data = indio_dev;
-	indio_dev->pollfunc->h = &ad7606_trigger_handler_th;
+	indio_dev->pollfunc->h = &ad7606_trigger_handler_th_bh;
+	indio_dev->pollfunc->thread = &ad7606_trigger_handler_th_bh;
 	indio_dev->pollfunc->name =
 		kasprintf(GFP_KERNEL, "%s_consumer%d", indio_dev->name,
 			  indio_dev->id);
@@ -267,7 +185,6 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->preenable = &ad7606_ring_preenable;
 	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
 	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
-	indio_dev->ring->scan_el_attrs = &ad7606_scan_el_group;
 	indio_dev->ring->scan_timestamp = true ;
 
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
-- 
1.7.3.4
