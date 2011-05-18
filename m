Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 025/111] staging:iio:adc:ad799x move to new event handling
Date: Wed, 18 May 2011 14:41:15 +0100
Message-Id: <1305726161-5606-26-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Untested.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x.h      |    1 -
 drivers/staging/iio/adc/ad799x_core.c |  252 +++++++++++++++------------------
 2 files changed, 115 insertions(+), 138 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index a421362..503fa61 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -114,7 +114,6 @@ struct ad799x_state {
 	struct i2c_client		*client;
 	const struct ad799x_chip_info	*chip_info;
 	struct work_struct		poll_work;
-	struct work_struct		work_thresh;
 	atomic_t			protect_ring;
 	size_t				d_size;
 	struct iio_trigger		*trig;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 09d109f..34fc85c 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -338,11 +338,11 @@ static ssize_t ad799x_read_channel_config(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	int ret;
 	u16 val;
-	ret = ad799x_i2c_read16(st, this_attr->mask, &val);
+	ret = ad799x_i2c_read16(st, this_attr->address, &val);
 	if (ret)
 		return ret;
 
@@ -356,7 +356,7 @@ static ssize_t ad799x_write_channel_config(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
-	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	long val;
 	int ret;
@@ -366,54 +366,40 @@ static ssize_t ad799x_write_channel_config(struct device *dev,
 		return ret;
 
 	mutex_lock(&dev_info->mlock);
-	ret = ad799x_i2c_write16(st, this_attr->mask, val);
+	ret = ad799x_i2c_write16(st, this_attr->address, val);
 	mutex_unlock(&dev_info->mlock);
 
 	return ret ? ret : len;
 }
 
-static void ad799x_interrupt_bh(struct work_struct *work_s)
+static irqreturn_t ad799x_event_handler(int irq, void *private)
 {
-	struct ad799x_state *st = container_of(work_s,
-		struct ad799x_state, work_thresh);
+	struct iio_dev *indio_dev = private;
+	struct ad799x_state *st = iio_dev_get_devdata(private);
 	u8 status;
-	int i;
+	int i, ret;
 
-	if (ad799x_i2c_read8(st, AD7998_ALERT_STAT_REG, &status))
-		goto err_out;
+	ret = ad799x_i2c_read8(st, AD7998_ALERT_STAT_REG, &status);
+	if (ret)
+		return ret;
 
 	if (!status)
-		goto err_out;
+		return -EIO;
 
 	ad799x_i2c_write8(st, AD7998_ALERT_STAT_REG, AD7998_ALERT_STAT_CLEAR);
 
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i))
-			iio_push_event(st->indio_dev, 0,
-				i & 0x1 ?
-				IIO_EVENT_CODE_IN_HIGH_THRESH(i >> 1) :
-				IIO_EVENT_CODE_IN_LOW_THRESH(i >> 1),
-				st->last_timestamp);
+			iio_push_event(indio_dev, 0,
+				       i & 0x1 ?
+				       IIO_EVENT_CODE_IN_HIGH_THRESH(i >> 1) :
+				       IIO_EVENT_CODE_IN_LOW_THRESH(i >> 1),
+				       iio_get_time_ns());
 	}
 
-err_out:
-	enable_irq(st->client->irq);
-}
-
-static int ad799x_interrupt(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct ad799x_state *st = dev_info->dev_data;
-
-	st->last_timestamp = timestamp;
-	schedule_work(&st->work_thresh);
-	return 0;
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(ad799x, &ad799x_interrupt);
-
 /* Direct read attribtues */
 static IIO_DEV_ATTR_IN_RAW(0, ad799x_read_single_channel, 0);
 static IIO_DEV_ATTR_IN_RAW(1, ad799x_read_single_channel, 1);
@@ -562,77 +548,77 @@ static struct attribute_group ad7997_8_scan_el_group = {
 	.attrs = ad7997_8_scan_el_attrs,
 };
 
-IIO_EVENT_ATTR_SH(in0_thresh_low_value,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_DATALOW_CH1_REG);
-
-IIO_EVENT_ATTR_SH(in0_thresh_high_value,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_DATAHIGH_CH1_REG);
-
-IIO_EVENT_ATTR_SH(in0_thresh_both_hyst_raw,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_HYST_CH1_REG);
-
-IIO_EVENT_ATTR_SH(in1_thresh_low_value,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_DATALOW_CH2_REG);
-
-IIO_EVENT_ATTR_SH(in1_thresh_high_value,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_DATAHIGH_CH2_REG);
-
-IIO_EVENT_ATTR_SH(in1_thresh_both_hyst_raw,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_HYST_CH2_REG);
-
-IIO_EVENT_ATTR_SH(in2_thresh_low_value,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_DATALOW_CH3_REG);
-
-IIO_EVENT_ATTR_SH(in2_thresh_high_value,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_DATAHIGH_CH3_REG);
-
-IIO_EVENT_ATTR_SH(in2_thresh_both_hyst_raw,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_HYST_CH3_REG);
-
-IIO_EVENT_ATTR_SH(in3_thresh_low_value,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_DATALOW_CH4_REG);
-
-IIO_EVENT_ATTR_SH(in3_thresh_high_value,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_DATAHIGH_CH4_REG);
-
-IIO_EVENT_ATTR_SH(in3_thresh_both_hyst_raw,
-		  iio_event_ad799x,
-		  ad799x_read_channel_config,
-		  ad799x_write_channel_config,
-		  AD7998_HYST_CH4_REG);
+static IIO_DEVICE_ATTR(in0_thresh_low_value,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_DATALOW_CH1_REG);
+
+static IIO_DEVICE_ATTR(in0_thresh_high_value,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_DATAHIGH_CH1_REG);
+
+static IIO_DEVICE_ATTR(in0_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_HYST_CH1_REG);
+
+static IIO_DEVICE_ATTR(in1_thresh_low_value,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_DATALOW_CH2_REG);
+
+static IIO_DEVICE_ATTR(in1_thresh_high_value,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_DATAHIGH_CH2_REG);
+
+static IIO_DEVICE_ATTR(in1_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_HYST_CH2_REG);
+
+static IIO_DEVICE_ATTR(in2_thresh_low_value,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_DATALOW_CH3_REG);
+
+static IIO_DEVICE_ATTR(in2_thresh_high_value,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_DATAHIGH_CH3_REG);
+
+static IIO_DEVICE_ATTR(in2_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_HYST_CH3_REG);
+
+static IIO_DEVICE_ATTR(in3_thresh_low_value,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_DATALOW_CH4_REG);
+
+static IIO_DEVICE_ATTR(in3_thresh_high_value,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_DATAHIGH_CH4_REG);
+
+static IIO_DEVICE_ATTR(in3_thresh_both_hyst_raw,
+		       S_IRUGO | S_IWUSR,
+		       ad799x_read_channel_config,
+		       ad799x_write_channel_config,
+		       AD7998_HYST_CH4_REG);
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 			      ad799x_read_frequency,
@@ -640,18 +626,18 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488 244 0");
 
 static struct attribute *ad7993_4_7_8_event_attributes[] = {
-	&iio_event_attr_in0_thresh_low_value.dev_attr.attr,
-	&iio_event_attr_in0_thresh_high_value.dev_attr.attr,
-	&iio_event_attr_in0_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_event_attr_in1_thresh_low_value.dev_attr.attr,
-	&iio_event_attr_in1_thresh_high_value.dev_attr.attr,
-	&iio_event_attr_in1_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_event_attr_in2_thresh_low_value.dev_attr.attr,
-	&iio_event_attr_in2_thresh_high_value.dev_attr.attr,
-	&iio_event_attr_in2_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_event_attr_in3_thresh_low_value.dev_attr.attr,
-	&iio_event_attr_in3_thresh_high_value.dev_attr.attr,
-	&iio_event_attr_in3_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in0_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in0_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in0_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in1_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in1_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in1_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in2_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in2_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in2_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in3_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in3_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in3_thresh_both_hyst_raw.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
@@ -662,12 +648,12 @@ static struct attribute_group ad7993_4_7_8_event_attrs_group = {
 };
 
 static struct attribute *ad7992_event_attributes[] = {
-	&iio_event_attr_in0_thresh_low_value.dev_attr.attr,
-	&iio_event_attr_in0_thresh_high_value.dev_attr.attr,
-	&iio_event_attr_in0_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_event_attr_in1_thresh_low_value.dev_attr.attr,
-	&iio_event_attr_in1_thresh_high_value.dev_attr.attr,
-	&iio_event_attr_in1_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in0_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in0_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in0_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in1_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in1_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in1_thresh_both_hyst_raw.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
@@ -835,23 +821,15 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 		goto error_cleanup_ring;
 
 	if (client->irq > 0 && st->chip_info->monitor_mode) {
-		INIT_WORK(&st->work_thresh, ad799x_interrupt_bh);
-
-		ret = iio_register_interrupt_line(client->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_FALLING,
-				client->name);
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   ad799x_event_handler,
+					   IRQF_TRIGGER_FALLING |
+					   IRQF_ONESHOT,
+					   client->name,
+					   st->indio_dev);
 		if (ret)
 			goto error_cleanup_ring;
-
-		/*
-		 * The event handler list element refer to iio_event_ad799x.
-		 * All event attributes bind to the same event handler.
-		 * So, only register event handler once.
-		 */
-		iio_add_event_to_list(&iio_event_ad799x,
-				&st->indio_dev->interrupts[0]->ev_list);
 	}
 
 	return 0;
@@ -879,7 +857,7 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	if (client->irq > 0 && st->chip_info->monitor_mode)
-		iio_unregister_interrupt_line(indio_dev, 0);
+		free_irq(client->irq, indio_dev);
 
 	iio_ring_buffer_unregister(indio_dev->ring);
 	ad799x_ring_cleanup(indio_dev);
-- 
1.7.3.4
