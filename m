Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: jbrenner@taosinc.com,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 7/8] staging:iio:max1363 take advantage of new iio_device_allocate private data.
Date: Fri, 15 Apr 2011 18:55:59 +0100
Message-Id: <1302890160-8823-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
References: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The only fiddly bit in here was ensuring the regulator was available until after
the free had occured.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363.h      |    2 -
 drivers/staging/iio/adc/max1363_core.c |  147 +++++++++++++++-----------------
 drivers/staging/iio/adc/max1363_ring.c |   11 +--
 3 files changed, 74 insertions(+), 86 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 8f0fe1c..6a8687f 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -174,7 +174,6 @@ struct max1363_chip_info {
 
 /**
  * struct max1363_state - driver instance specific data
- * @indio_dev:		the industrial I/O device
  * @client:		i2c_client
  * @setupbyte:		cache of current device setup byte
  * @configbyte:		cache of current device config byte
@@ -194,7 +193,6 @@ struct max1363_chip_info {
  * @thresh_work:	bh work structure for event handling
  */
 struct max1363_state {
-	struct iio_dev			*indio_dev;
 	struct i2c_client		*client;
 	u8				setupbyte;
 	u8				configbyte;
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 4134f68..1037087 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -155,8 +155,7 @@ static ssize_t max1363_show_precision_u(struct device *dev,
 				char *buf)
 {
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(ring->indio_dev);
 	return sprintf(buf, "u%d/16\n", st->chip_info->bits);
 }
 
@@ -165,8 +164,7 @@ static ssize_t max1363_show_precision_s(struct device *dev,
 				char *buf)
 {
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(ring->indio_dev);
 	return sprintf(buf, "s%d/16\n", st->chip_info->bits);
 }
 
@@ -239,7 +237,7 @@ static ssize_t max1363_read_single_channel(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct i2c_client *client = st->client;
 	int ret = 0, len = 0;
@@ -337,8 +335,7 @@ static ssize_t max1363_show_scale(struct device *dev,
 				char *buf)
 {
 	/* Driver currently only support internal vref */
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(dev_get_drvdata(dev));
 	/* Corresponds to Vref / 2^(bits) */
 
 	if ((1 << (st->chip_info->bits + 1))
@@ -355,8 +352,7 @@ static ssize_t max1363_show_name(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(dev_get_drvdata(dev));
 	return sprintf(buf, "%s\n", st->client->name);
 }
 
@@ -1012,8 +1008,7 @@ static ssize_t max1363_monitor_show_freq(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(dev_get_drvdata(dev));
 	return sprintf(buf, "%d\n", max1363_monitor_speeds[st->monitor_speed]);
 }
 
@@ -1023,7 +1018,7 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 					size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(indio_dev);
 	int i, ret;
 	unsigned long val;
 	bool found = false;
@@ -1059,7 +1054,7 @@ static ssize_t max1363_show_thresh(struct device *dev,
 				bool high)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	if (high)
@@ -1090,8 +1085,7 @@ static ssize_t max1363_store_thresh_unsigned(struct device *dev,
 					size_t len,
 					bool high)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(dev_get_drvdata(dev));
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned long val;
 	int ret;
@@ -1144,8 +1138,7 @@ static ssize_t max1363_store_thresh_signed(struct device *dev,
 					size_t len,
 					bool high)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(dev_get_drvdata(dev));
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long val;
 	int ret;
@@ -1255,7 +1248,7 @@ static int max1363_int_th(struct iio_dev *indio_dev,
 			s64 timestamp,
 			int not_test)
 {
-	struct max1363_state *st = indio_dev->dev_data;
+	struct max1363_state *st = iio_priv(indio_dev);
 
 	st->last_timestamp = timestamp;
 	schedule_work(&st->thresh_work);
@@ -1266,41 +1259,42 @@ static void max1363_thresh_handler_bh(struct work_struct *work_s)
 {
 	struct max1363_state *st = container_of(work_s, struct max1363_state,
 						thresh_work);
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
 	u8 rx;
 	u8 tx[2] = { st->setupbyte,
 		     MAX1363_MON_INT_ENABLE | (st->monitor_speed << 1) | 0xF0 };
 
 	i2c_master_recv(st->client, &rx, 1);
 	if (rx & (1 << 0))
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_LOW_THRESH(3),
 			st->last_timestamp);
 	if (rx & (1 << 1))
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_HIGH_THRESH(3),
 			st->last_timestamp);
 	if (rx & (1 << 2))
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_LOW_THRESH(2),
 			st->last_timestamp);
 	if (rx & (1 << 3))
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_HIGH_THRESH(2),
 			st->last_timestamp);
 	if (rx & (1 << 4))
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_LOW_THRESH(1),
 			st->last_timestamp);
 	if (rx & (1 << 5))
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_HIGH_THRESH(1),
 			st->last_timestamp);
 	if (rx & (1 << 6))
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_LOW_THRESH(0),
 			st->last_timestamp);
 	if (rx & (1 << 7))
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			IIO_EVENT_CODE_IN_HIGH_THRESH(0),
 			st->last_timestamp);
 	enable_irq(st->client->irq);
@@ -1312,7 +1306,7 @@ static ssize_t max1363_read_interrupt_config(struct device *dev,
 					char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(indio_dev);
 	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int val;
 
@@ -1466,7 +1460,7 @@ static ssize_t max1363_write_interrupt_config(struct device *dev,
 					size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct max1363_state *st = iio_dev_get_devdata(indio_dev);
+	struct max1363_state *st = iio_priv(indio_dev);
 	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	unsigned long val;
 	int ret;
@@ -1474,7 +1468,7 @@ static ssize_t max1363_write_interrupt_config(struct device *dev,
 	ret = strict_strtoul(buf, 10, &val);
 	if (ret)
 		return -EINVAL;
-	mutex_lock(&st->indio_dev->mlock);
+	mutex_lock(&indio_dev->mlock);
 	unifiedmask = st->mask_low | st->mask_high;
 	if (this_attr->mask & 0x08) {
 		/* If we are disabling no need to test */
@@ -1507,7 +1501,7 @@ static ssize_t max1363_write_interrupt_config(struct device *dev,
 
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
 error_ret:
-	mutex_unlock(&st->indio_dev->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return len;
 }
@@ -1687,55 +1681,54 @@ static int __devinit max1363_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	int ret, i, regdone = 0;
-	struct max1363_state *st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, st);
+	struct max1363_state *st;
+	struct iio_dev *indio_dev;
+	struct regulator *reg;
 
-	atomic_set(&st->protect_ring, 0);
-
-	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
-	st->reg = regulator_get(&client->dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
+	reg = regulator_get(&client->dev, "vcc");
+	if (!IS_ERR(reg)) {
+		ret = regulator_enable(reg);
 		if (ret)
 			goto error_put_reg;
 	}
-	st->client = client;
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
+	indio_dev = iio_allocate_device(sizeof(struct max1363_state));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
 	}
+	st = iio_priv(indio_dev);
+	st->reg = reg;
+	/* this is only used for device removal purposes */
+	i2c_set_clientdata(client, indio_dev);
+
+	atomic_set(&st->protect_ring, 0);
+
+	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
+	st->client = client;
 
-	st->indio_dev->available_scan_masks
-		= kzalloc(sizeof(*st->indio_dev->available_scan_masks)*
+	indio_dev->available_scan_masks
+		= kzalloc(sizeof(*indio_dev->available_scan_masks)*
 			  (st->chip_info->num_modes + 1), GFP_KERNEL);
-	if (!st->indio_dev->available_scan_masks) {
+	if (!indio_dev->available_scan_masks) {
 		ret = -ENOMEM;
 		goto error_free_device;
 	}
 
 	for (i = 0; i < st->chip_info->num_modes; i++)
-		st->indio_dev->available_scan_masks[i] =
+		indio_dev->available_scan_masks[i] =
 			max1363_mode_table[st->chip_info->mode_list[i]]
 			.modemask;
 	/* Estabilish that the iio_dev is a child of the i2c device */
-	st->indio_dev->dev.parent = &client->dev;
-	st->indio_dev->attrs = st->chip_info->dev_attrs;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->attrs = st->chip_info->dev_attrs;
 
 	/* Todo: this shouldn't be here. */
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	if (st->chip_info->monitor_mode && client->irq) {
-		st->indio_dev->num_interrupt_lines = 1;
-		st->indio_dev->event_attrs
+		indio_dev->num_interrupt_lines = 1;
+		indio_dev->event_attrs
 			= &max1363_event_attribute_group;
 	}
 
@@ -1743,21 +1736,21 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_free_available_scan_masks;
 
-	ret = max1363_register_ring_funcs_and_init(st->indio_dev);
+	ret = max1363_register_ring_funcs_and_init(indio_dev);
 	if (ret)
 		goto error_free_available_scan_masks;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_cleanup_ring;
 	regdone = 1;
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register(indio_dev->ring, 0);
 	if (ret)
 		goto error_cleanup_ring;
 
 	if (st->chip_info->monitor_mode && client->irq) {
 		ret = iio_register_interrupt_line(client->irq,
-						st->indio_dev,
+						indio_dev,
 						0,
 						IRQF_TRIGGER_RISING,
 						client->name);
@@ -1769,44 +1762,42 @@ static int __devinit max1363_probe(struct i2c_client *client,
 
 	return 0;
 error_uninit_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_cleanup_ring:
-	max1363_ring_cleanup(st->indio_dev);
+	max1363_ring_cleanup(indio_dev);
 error_free_available_scan_masks:
-	kfree(st->indio_dev->available_scan_masks);
+	kfree(indio_dev->available_scan_masks);
 error_free_device:
 	if (!regdone)
-		iio_free_device(st->indio_dev);
+		iio_free_device(indio_dev);
 	else
-		iio_device_unregister(st->indio_dev);
+		iio_device_unregister(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	kfree(st);
 
-error_ret:
 	return ret;
 }
 
 static int max1363_remove(struct i2c_client *client)
 {
-	struct max1363_state *st = i2c_get_clientdata(client);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct max1363_state *st = iio_priv(indio_dev);
+	struct regulator *reg = st->reg;
 
 	if (st->chip_info->monitor_mode && client->irq)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
+		iio_unregister_interrupt_line(indio_dev, 0);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	max1363_ring_cleanup(indio_dev);
-	kfree(st->indio_dev->available_scan_masks);
-	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg)) {
-		regulator_disable(st->reg);
-		regulator_put(st->reg);
+	kfree(indio_dev->available_scan_masks);
+	if (!IS_ERR(reg)) {
+		regulator_disable(reg);
+		regulator_put(reg);
 	}
-	kfree(st);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 96894bd..dbe8c9f 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -27,10 +27,9 @@
 
 #include "max1363.h"
 
-/* Todo: test this */
 int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
 {
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
 	int count = 0, ret;
 	u8 *ring_data;
 	if (!(st->current_mode->modemask & mask)) {
@@ -74,7 +73,7 @@ error_ret:
  **/
 static int max1363_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct max1363_state *st = indio_dev->dev_data;
+	struct max1363_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	size_t d_size = 0;
 	unsigned long numvals;
@@ -116,7 +115,7 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
  **/
 static void max1363_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
-	struct max1363_state *st = indio_dev->dev_data;
+	struct max1363_state *st = iio_priv(indio_dev);
 
 	schedule_work(&st->poll_work);
 
@@ -135,7 +134,7 @@ static void max1363_poll_bh_to_ring(struct work_struct *work_s)
 {
 	struct max1363_state *st = container_of(work_s, struct max1363_state,
 						  poll_work);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
 	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *rxbuf;
@@ -185,7 +184,7 @@ done:
 
 int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	struct max1363_state *st = indio_dev->dev_data;
+	struct max1363_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-- 
1.7.3.4
