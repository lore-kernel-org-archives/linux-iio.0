Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57699 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab1EDL4z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 07:56:55 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Michael.Hennerich@analog.com,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 62/99] IIO-onwards: ADC: AD799x: Convert to new channel registration method.
Date: Wed,  4 May 2011 12:58:34 +0100
Message-Id: <1304510351-10922-63-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Convert to new channel registration method
Update copyright header
Add missing call to iio_trigger_notify_done()

V2: IIO_CHAN macro updates

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x.h      |   25 +-
 drivers/staging/iio/adc/ad799x_core.c |  491 +++++++++++++--------------------
 drivers/staging/iio/adc/ad799x_ring.c |    9 +-
 3 files changed, 206 insertions(+), 319 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 331435a..2e1506b 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010 Michael Hennerich, Analog Devices Inc.
+ * Copyright (C) 2010-2011 Michael Hennerich, Analog Devices Inc.
  * Copyright (C) 2008-2010 Jonathan Cameron
  *
  * This program is free software; you can redistribute it and/or modify
@@ -68,6 +68,8 @@
 #define AD7997_8_READ_SINGLE			0x80
 #define AD7997_8_READ_SEQUENCE			0x70
 
+#define RES_MASK(bits)	((1 << (bits)) - 1) /* TODO: move this into a common header */
+
 enum {
 	ad7991,
 	ad7995,
@@ -83,30 +85,21 @@ struct ad799x_state;
 
 /**
  * struct ad799x_chip_info - chip specifc information
- * @num_inputs:		number of physical inputs on chip
- * @bits:		accuracy of the adc in bits
+ * @channel:		channel specification
+ * @num_channels:	number of channels
  * @int_vref_mv:	the internal reference voltage
  * @monitor_mode:	whether the chip supports monitor interrupts
  * @default_config:	device default configuration
- * @dev_attrs:		pointer to the device attribute group
- * @scan_attrs:		pointer to the scan element attribute group
  * @event_attrs:	pointer to the monitor event attribute group
- * @ad799x_set_scan_mode: function pointer to the device specific mode function
-
  */
+
 struct ad799x_chip_info {
-	u8				num_inputs;
-	u8				bits;
-	u8				storagebits;
-	char				sign;
+	struct iio_chan_spec		channel[9];
+	int				num_channels;
 	u16				int_vref_mv;
 	bool				monitor_mode;
 	u16				default_config;
-	struct attribute_group		*dev_attrs;
-	struct attribute_group		*scan_attrs;
 	struct attribute_group		*event_attrs;
-	int (*ad799x_set_scan_mode)	(struct ad799x_state *st,
-					unsigned mask);
 };
 
 struct ad799x_state {
@@ -130,7 +123,7 @@ struct ad799x_platform_data {
 	u16				vref_mv;
 };
 
-int ad799x_set_scan_mode(struct ad799x_state *st, unsigned mask);
+int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask);
 
 #ifdef CONFIG_AD799X_RING_BUFFER
 int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask);
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 3383a35..79580df 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -1,6 +1,6 @@
 /*
  * iio/adc/ad799x.c
- * Copyright (C) 2010 Michael Hennerich, Analog Devices Inc.
+ * Copyright (C) 2010-1011 Michael Hennerich, Analog Devices Inc.
  *
  * based on iio/adc/max1363
  * Copyright (C) 2008-2010 Jonathan Cameron
@@ -100,130 +100,77 @@ static int ad799x_i2c_write8(struct ad799x_state *st, u8 reg, u8 data)
 	return ret;
 }
 
-static int ad799x_scan_el_set_state(struct iio_scan_el *scan_el,
-				       struct iio_dev *indio_dev,
-				       bool state)
-{
-	struct ad799x_state *st = indio_dev->dev_data;
-	return ad799x_set_scan_mode(st, st->indio_dev->ring->scan_mask);
-}
-
-/* Here we claim all are 16 bits. This currently does no harm and saves
- * us a lot of scan element listings */
-
-#define AD799X_SCAN_EL(number)						\
-	IIO_SCAN_EL_C(in##number, number, 0, ad799x_scan_el_set_state);
-
-static AD799X_SCAN_EL(0);
-static AD799X_SCAN_EL(1);
-static AD799X_SCAN_EL(2);
-static AD799X_SCAN_EL(3);
-static AD799X_SCAN_EL(4);
-static AD799X_SCAN_EL(5);
-static AD799X_SCAN_EL(6);
-static AD799X_SCAN_EL(7);
-
-static IIO_SCAN_EL_TIMESTAMP(8);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64)
-
-static ssize_t ad799x_show_type(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct ad799x_state *st = indio_dev->dev_data;
-
-	return sprintf(buf, "%c%d/%d\n", st->chip_info->sign,
-		       st->chip_info->bits, AD799X_STORAGEBITS);
-}
-static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad799x_show_type, NULL, 0);
-
-static int ad7991_5_9_set_scan_mode(struct ad799x_state *st, unsigned mask)
-{
-	return i2c_smbus_write_byte(st->client,
-		st->config | (mask << AD799X_CHANNEL_SHIFT));
-}
-
-static int ad7992_3_4_set_scan_mode(struct ad799x_state *st, unsigned mask)
-{
-	return ad799x_i2c_write8(st, AD7998_CONF_REG,
-		st->config | (mask << AD799X_CHANNEL_SHIFT));
-}
-
-static int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask)
+int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask)
 {
 	return ad799x_i2c_write16(st, AD7998_CONF_REG,
 		st->config | (mask << AD799X_CHANNEL_SHIFT));
 }
 
-int ad799x_set_scan_mode(struct ad799x_state *st, unsigned mask)
+static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
 {
+	u16 rxbuf;
+	u8 cmd;
 	int ret;
 
-	if (st->chip_info->ad799x_set_scan_mode != NULL) {
-		ret = st->chip_info->ad799x_set_scan_mode(st, mask);
-		return (ret > 0) ? 0 : ret;
+	switch (st->id) {
+	case ad7991:
+	case ad7995:
+	case ad7999:
+		cmd = st->config | ((1 << ch) << AD799X_CHANNEL_SHIFT);
+		break;
+	case ad7992:
+	case ad7993:
+	case ad7994:
+		cmd = (1 << ch) << AD799X_CHANNEL_SHIFT;
+		break;
+	case ad7997:
+	case ad7998:
+		cmd = (ch << AD799X_CHANNEL_SHIFT) | AD7997_8_READ_SINGLE;
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	return 0;
+	ret = ad799x_i2c_read16(st, cmd, &rxbuf);
+	if (ret < 0)
+		return ret;
+
+	return rxbuf;
 }
 
-static ssize_t ad799x_read_single_channel(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
+static int ad799x_read_raw(struct iio_dev *dev_info,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret = 0, len = 0;
-	u32 data ;
-	u16 rxbuf[1];
-	u8 cmd;
-	long mask;
+	int ret;
+	struct ad799x_state *st = dev_info->dev_data;
+	unsigned int scale_uv;
+
+	switch (m) {
+	case 0:
+		mutex_lock(&dev_info->mlock);
+		if (iio_ring_enabled(dev_info))
+			ret = ad799x_single_channel_from_ring(st,
+				1 << chan->address);
+		else
+			ret = ad799x_scan_direct(st, chan->address);
+		mutex_unlock(&dev_info->mlock);
 
-	mutex_lock(&dev_info->mlock);
-	mask = 1 << this_attr->address;
-	/* If ring buffer capture is occurring, query the buffer */
-	if (iio_ring_enabled(dev_info)) {
-		data = ret = ad799x_single_channel_from_ring(st, mask);
-		if (ret < 0)
-			goto error_ret;
-		ret = 0;
-	} else {
-		switch (st->id) {
-		case ad7991:
-		case ad7995:
-		case ad7999:
-			cmd = st->config | (mask << AD799X_CHANNEL_SHIFT);
-			break;
-		case ad7992:
-		case ad7993:
-		case ad7994:
-			cmd = mask << AD799X_CHANNEL_SHIFT;
-			break;
-		case ad7997:
-		case ad7998:
-			cmd = (this_attr->address <<
-				AD799X_CHANNEL_SHIFT) | AD7997_8_READ_SINGLE;
-			break;
-		default:
-			cmd = 0;
-
-		}
-		ret = ad799x_i2c_read16(st, cmd, rxbuf);
 		if (ret < 0)
-			goto error_ret;
-
-		data = rxbuf[0];
+			return ret;
+		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
+			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		scale_uv = (st->int_vref_mv * 1000)
+			>> st->chip_info->channel[0].scan_type.realbits;
+		*val =  scale_uv / 1000;
+		*val2 = (scale_uv % 1000) * 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
-
-	/* Pretty print the result */
-	len = sprintf(buf, "%u\n", data & ((1 << (st->chip_info->bits)) - 1));
-
-error_ret:
-	mutex_unlock(&dev_info->mlock);
-	return ret ? ret : len;
+	return -EINVAL;
 }
 
 static ssize_t ad799x_read_frequency(struct device *dev,
@@ -331,7 +278,6 @@ error_ret_mutex:
 	return ret ? ret : len;
 }
 
-
 static ssize_t ad799x_read_channel_config(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -400,140 +346,6 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-/* Direct read attribtues */
-static IIO_DEV_ATTR_IN_RAW(0, ad799x_read_single_channel, 0);
-static IIO_DEV_ATTR_IN_RAW(1, ad799x_read_single_channel, 1);
-static IIO_DEV_ATTR_IN_RAW(2, ad799x_read_single_channel, 2);
-static IIO_DEV_ATTR_IN_RAW(3, ad799x_read_single_channel, 3);
-static IIO_DEV_ATTR_IN_RAW(4, ad799x_read_single_channel, 4);
-static IIO_DEV_ATTR_IN_RAW(5, ad799x_read_single_channel, 5);
-static IIO_DEV_ATTR_IN_RAW(6, ad799x_read_single_channel, 6);
-static IIO_DEV_ATTR_IN_RAW(7, ad799x_read_single_channel, 7);
-
-static ssize_t ad799x_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	/* Driver currently only support internal vref */
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
-
-	/* Corresponds to Vref / 2^(bits) */
-	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
-}
-
-static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad799x_show_scale, NULL, 0);
-
-static struct attribute *ad7991_5_9_3_4_device_attrs[] = {
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_dev_attr_in2_raw.dev_attr.attr,
-	&iio_dev_attr_in3_raw.dev_attr.attr,
-	&iio_dev_attr_in_scale.dev_attr.attr,
-	NULL
-};
-
-static struct attribute_group ad7991_5_9_3_4_dev_attr_group = {
-	.attrs = ad7991_5_9_3_4_device_attrs,
-};
-
-static struct attribute *ad7991_5_9_3_4_scan_el_attrs[] = {
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_const_attr_in0_index.dev_attr.attr,
-	&iio_scan_el_in1.dev_attr.attr,
-	&iio_const_attr_in1_index.dev_attr.attr,
-	&iio_scan_el_in2.dev_attr.attr,
-	&iio_const_attr_in2_index.dev_attr.attr,
-	&iio_scan_el_in3.dev_attr.attr,
-	&iio_const_attr_in3_index.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	&iio_dev_attr_in_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group ad7991_5_9_3_4_scan_el_group = {
-	.name = "scan_elements",
-	.attrs = ad7991_5_9_3_4_scan_el_attrs,
-};
-
-static struct attribute *ad7992_device_attrs[] = {
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_dev_attr_in_scale.dev_attr.attr,
-	NULL
-};
-
-static struct attribute_group ad7992_dev_attr_group = {
-	.attrs = ad7992_device_attrs,
-};
-
-static struct attribute *ad7992_scan_el_attrs[] = {
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
-static struct attribute_group ad7992_scan_el_group = {
-	.name = "scan_elements",
-	.attrs = ad7992_scan_el_attrs,
-};
-
-static struct attribute *ad7997_8_device_attrs[] = {
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_dev_attr_in2_raw.dev_attr.attr,
-	&iio_dev_attr_in3_raw.dev_attr.attr,
-	&iio_dev_attr_in4_raw.dev_attr.attr,
-	&iio_dev_attr_in5_raw.dev_attr.attr,
-	&iio_dev_attr_in6_raw.dev_attr.attr,
-	&iio_dev_attr_in7_raw.dev_attr.attr,
-	&iio_dev_attr_in_scale.dev_attr.attr,
-	NULL
-};
-
-static struct attribute_group ad7997_8_dev_attr_group = {
-	.attrs = ad7997_8_device_attrs,
-};
-
-static struct attribute *ad7997_8_scan_el_attrs[] = {
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
-static struct attribute_group ad7997_8_scan_el_group = {
-	.name = "scan_elements",
-	.attrs = ad7997_8_scan_el_attrs,
-};
-
 static IIO_DEVICE_ATTR(in0_thresh_low_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
@@ -651,91 +463,173 @@ static struct attribute_group ad7992_event_attrs_group = {
 
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
-		.num_inputs = 4,
-		.bits = 12,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       1, 1, IIO_ST('u', 12, 16, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       2, 2, IIO_ST('u', 12, 16, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       3, 3, IIO_ST('u', 12, 16, 0), 0),
+		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+		.num_channels = 5,
 		.int_vref_mv = 4096,
-		.dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
-		.scan_attrs = &ad7991_5_9_3_4_scan_el_group,
-		.ad799x_set_scan_mode = ad7991_5_9_set_scan_mode,
 	},
 	[ad7995] = {
-		.num_inputs = 4,
-		.bits = 10,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 10, 16, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       1, 1, IIO_ST('u', 10, 16, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       2, 2, IIO_ST('u', 10, 16, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       3, 3, IIO_ST('u', 10, 16, 0), 0),
+		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+		.num_channels = 5,
 		.int_vref_mv = 1024,
-		.dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
-		.scan_attrs = &ad7991_5_9_3_4_scan_el_group,
-		.ad799x_set_scan_mode = ad7991_5_9_set_scan_mode,
 	},
 	[ad7999] = {
-		.num_inputs = 4,
-		.bits = 10,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 10, 16, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       1, 1, IIO_ST('u', 10, 16, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       2, 2, IIO_ST('u', 10, 16, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       3, 3, IIO_ST('u', 10, 16, 0), 0),
+		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+		.num_channels = 5,
 		.int_vref_mv = 1024,
-		.dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
-		.scan_attrs = &ad7991_5_9_3_4_scan_el_group,
-		.ad799x_set_scan_mode = ad7991_5_9_set_scan_mode,
 	},
 	[ad7992] = {
-		.num_inputs = 2,
-		.bits = 12,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       1, 1, IIO_ST('u', 12, 16, 0), 0),
+		.channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
+		.num_channels = 3,
 		.int_vref_mv = 4096,
 		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.dev_attrs = &ad7992_dev_attr_group,
-		.scan_attrs = &ad7992_scan_el_group,
 		.event_attrs = &ad7992_event_attrs_group,
-		.ad799x_set_scan_mode = ad7992_3_4_set_scan_mode,
 	},
 	[ad7993] = {
-		.num_inputs = 4,
-		.bits = 10,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 10, 16, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       1, 1, IIO_ST('u', 10, 16, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       2, 2, IIO_ST('u', 10, 16, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       3, 3, IIO_ST('u', 10, 16, 0), 0),
+		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+		.num_channels = 5,
 		.int_vref_mv = 1024,
 		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
-		.scan_attrs = &ad7991_5_9_3_4_scan_el_group,
 		.event_attrs = &ad7993_4_7_8_event_attrs_group,
-		.ad799x_set_scan_mode = ad7992_3_4_set_scan_mode,
 	},
 	[ad7994] = {
-		.num_inputs = 4,
-		.bits = 12,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       1, 1, IIO_ST('u', 12, 16, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       2, 2, IIO_ST('u', 12, 16, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       3, 3, IIO_ST('u', 12, 16, 0), 0),
+		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+		.num_channels = 5,
 		.int_vref_mv = 4096,
 		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
-		.scan_attrs = &ad7991_5_9_3_4_scan_el_group,
 		.event_attrs = &ad7993_4_7_8_event_attrs_group,
-		.ad799x_set_scan_mode = ad7992_3_4_set_scan_mode,
 	},
 	[ad7997] = {
-		.num_inputs = 8,
-		.bits = 10,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  0, 0, IIO_ST('u', 10, 16, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  1, 1, IIO_ST('u', 10, 16, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  2, 2, IIO_ST('u', 10, 16, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  3, 3, IIO_ST('u', 10, 16, 0), 0),
+		.channel[4] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  4, 4, IIO_ST('u', 10, 16, 0), 0),
+		.channel[5] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  5, 5, IIO_ST('u', 10, 16, 0), 0),
+		.channel[6] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 6, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  6, 6, IIO_ST('u', 10, 16, 0), 0),
+		.channel[7] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 7, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  7, 7, IIO_ST('u', 10, 16, 0), 0),
+		.channel[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
+		.num_channels = 9,
 		.int_vref_mv = 1024,
 		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.dev_attrs = &ad7997_8_dev_attr_group,
-		.scan_attrs = &ad7997_8_scan_el_group,
 		.event_attrs = &ad7993_4_7_8_event_attrs_group,
-		.ad799x_set_scan_mode = ad7997_8_set_scan_mode,
 	},
 	[ad7998] = {
-		.num_inputs = 8,
-		.bits = 12,
-		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       1, 1, IIO_ST('u', 12, 16, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       2, 2, IIO_ST('u', 12, 16, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       3, 3, IIO_ST('u', 12, 16, 0), 0),
+		.channel[4] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       4, 4, IIO_ST('u', 12, 16, 0), 0),
+		.channel[5] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       5, 5, IIO_ST('u', 12, 16, 0), 0),
+		.channel[6] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 6, 0,
+				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       6, 6, IIO_ST('u', 12, 16, 0), 0),
+		.channel[7] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 7, 0,
+					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
+					  7, 7, IIO_ST('u', 12, 16, 0), 0),
+		.channel[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
+		.num_channels = 9,
 		.int_vref_mv = 4096,
 		.monitor_mode = true,
 		.default_config = AD7998_ALERT_EN,
-		.dev_attrs = &ad7997_8_dev_attr_group,
-		.scan_attrs = &ad7997_8_scan_el_group,
 		.event_attrs = &ad7993_4_7_8_event_attrs_group,
-		.ad799x_set_scan_mode = ad7997_8_set_scan_mode,
 	},
 };
 
@@ -778,19 +672,16 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 		goto error_disable_reg;
 	}
 
-	/* Estabilish that the iio_dev is a child of the i2c device */
 	st->indio_dev->dev.parent = &client->dev;
-	st->indio_dev->attrs = st->chip_info->dev_attrs;
 	st->indio_dev->event_attrs = st->chip_info->event_attrs;
 	st->indio_dev->name = id->name;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 	st->indio_dev->num_interrupt_lines = 1;
-
-	ret = ad799x_set_scan_mode(st, 0);
-	if (ret)
-		goto error_free_device;
+	st->indio_dev->channels = st->chip_info->channel;
+	st->indio_dev->num_channels = st->chip_info->num_channels;
+	st->indio_dev->read_raw = &ad799x_read_raw;
 
 	ret = ad799x_register_ring_funcs_and_init(st->indio_dev);
 	if (ret)
@@ -801,7 +692,9 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 		goto error_cleanup_ring;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  st->indio_dev->channels,
+					  st->indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index f0a0aae..488cbc4 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -80,7 +80,7 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 	 */
 
 	if (st->id == ad7997 || st->id == ad7998)
-		ad799x_set_scan_mode(st, ring->scan_mask);
+		ad7997_8_set_scan_mode(st, ring->scan_mask);
 
 	st->d_size = ring->scan_count * 2;
 
@@ -119,7 +119,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 
 	rxbuf = kmalloc(st->d_size, GFP_KERNEL);
 	if (rxbuf == NULL)
-		return -ENOMEM;
+		goto out;
 
 	switch (st->id) {
 	case ad7991:
@@ -157,6 +157,9 @@ done:
 	kfree(rxbuf);
 	if (b_sent < 0)
 		return b_sent;
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
 	return IRQ_HANDLED;
 }
 
@@ -195,8 +198,6 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
 	indio_dev->ring->scan_timestamp = true;
 
-	indio_dev->ring->scan_el_attrs = st->chip_info->scan_attrs;
-
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
-- 
1.7.3.4

