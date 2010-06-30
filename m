Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: barry.song@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/5] staging:iio:lis3l02dq use iio_sw_ring_helper_state and funcs
Date: Wed, 30 Jun 2010 15:27:55 +0100
Message-Id: <1277908076-28592-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
References: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq.h      |   11 +--
 drivers/staging/iio/accel/lis3l02dq_core.c |  116 ++++++++++++++-----------
 drivers/staging/iio/accel/lis3l02dq_ring.c |  131 +++++++++-------------------
 3 files changed, 113 insertions(+), 145 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 6de172e..44669ee 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -148,30 +148,29 @@ Form of high byte dependant on justification set in ctrl reg */
 #define LIS3L02DQ_MAX_RX 12
 /**
  * struct lis3l02dq_state - device instance specific data
+ * @helper:		data and func pointer allowing generic functions
  * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
  * @work_thresh:	bh for threshold events
  * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct lis3l02dq_state {
+	struct iio_sw_ring_helper_state	help;
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
 	struct work_struct		work_thresh;
 	bool				inter;
-	s64				last_timestamp;
-	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
 };
 
+#define lis3l02dq_h_to_s(_h)				\
+	container_of(_h, struct lis3l02dq_state, help)
+
 int lis3l02dq_spi_read_reg_8(struct device *dev,
 			     u8 reg_address,
 			     u8 *val);
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index f86ffb8..2ce8d11 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -28,6 +28,8 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
+#include "../ring_sw.h"
+
 #include "accel.h"
 
 #include "lis3l02dq.h"
@@ -48,7 +50,9 @@ int lis3l02dq_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct lis3l02dq_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev); 
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx,
 		.rx_buf = st->rx,
@@ -83,7 +87,9 @@ int lis3l02dq_spi_write_reg_8(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct lis3l02dq_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_sw_ring_helper_state *h
+		= iio_dev_get_devdata(indio_dev);
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx,
 		.bits_per_word = 8,
@@ -117,7 +123,9 @@ static int lis3l02dq_spi_write_reg_s16(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct lis3l02dq_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_sw_ring_helper_state *h
+		= iio_dev_get_devdata(indio_dev);
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 	struct spi_transfer xfers[] = { {
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
@@ -159,7 +167,9 @@ static int lis3l02dq_spi_read_reg_s16(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct lis3l02dq_state *st = iio_dev_get_devdata(indio_dev);
+	struct iio_sw_ring_helper_state *h
+		= iio_dev_get_devdata(indio_dev);
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 	int ret;
 	struct spi_transfer xfers[] = { {
 			.tx_buf = st->tx,
@@ -412,7 +422,7 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 
 	val = LIS3L02DQ_DEFAULT_CTRL1;
 	/* Write suitable defaults to ctrl1 */
-	ret = lis3l02dq_spi_write_reg_8(&st->indio_dev->dev,
+	ret = lis3l02dq_spi_write_reg_8(&st->help.indio_dev->dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
 					&val);
 	if (ret) {
@@ -420,7 +430,7 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 		goto err_ret;
 	}
 	/* Repeat as sometimes doesn't work first time?*/
-	ret = lis3l02dq_spi_write_reg_8(&st->indio_dev->dev,
+	ret = lis3l02dq_spi_write_reg_8(&st->help.indio_dev->dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
 					&val);
 	if (ret) {
@@ -430,17 +440,17 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 
 	/* Read back to check this has worked acts as loose test of correct
 	 * chip */
-	ret = lis3l02dq_spi_read_reg_8(&st->indio_dev->dev,
+	ret = lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
 				       LIS3L02DQ_REG_CTRL_1_ADDR,
 				       &valtest);
 	if (ret || (valtest != val)) {
-		dev_err(&st->indio_dev->dev, "device not playing ball");
+		dev_err(&st->help.indio_dev->dev, "device not playing ball");
 		ret = -EINVAL;
 		goto err_ret;
 	}
 
 	val = LIS3L02DQ_DEFAULT_CTRL2;
-	ret = lis3l02dq_spi_write_reg_8(&st->indio_dev->dev,
+	ret = lis3l02dq_spi_write_reg_8(&st->help.indio_dev->dev,
 					LIS3L02DQ_REG_CTRL_2_ADDR,
 					&val);
 	if (ret) {
@@ -449,7 +459,7 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 	}
 
 	val = LIS3L02DQ_REG_WAKE_UP_CFG_LATCH_SRC;
-	ret = lis3l02dq_spi_write_reg_8(&st->indio_dev->dev,
+	ret = lis3l02dq_spi_write_reg_8(&st->help.indio_dev->dev,
 					LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
 					&val);
 	if (ret)
@@ -595,15 +605,17 @@ error_mutex_unlock:
 }
 
 
-static int lis3l02dq_thresh_handler_th(struct iio_dev *dev_info,
+static int lis3l02dq_thresh_handler_th(struct iio_dev *indio_dev,
 				       int index,
 				       s64 timestamp,
 				       int no_test)
 {
-	struct lis3l02dq_state *st = dev_info->dev_data;
+	struct iio_sw_ring_helper_state *h
+		= iio_dev_get_devdata(indio_dev);
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 
 	/* Stash the timestamp somewhere convenient for the bh */
-	st->last_timestamp = timestamp;
+	h->last_timestamp = timestamp;
 	schedule_work(&st->work_thresh);
 
 	return 0;
@@ -621,43 +633,43 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
 
 	u8 t;
 
-	lis3l02dq_spi_read_reg_8(&st->indio_dev->dev,
+	lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
 				 LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
 				 &t);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_HIGH)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_Z_HIGH,
-			       st->last_timestamp);
+			       st->help.last_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_LOW)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_Z_LOW,
-			       st->last_timestamp);
+			       st->help.last_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_HIGH)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_Y_HIGH,
-			       st->last_timestamp);
+			       st->help.last_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_LOW)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_Y_LOW,
-			       st->last_timestamp);
+			       st->help.last_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_HIGH)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_X_HIGH,
-			       st->last_timestamp);
+			       st->help.last_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_LOW)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(st->help.indio_dev, 0,
 			       IIO_EVENT_CODE_ACCEL_X_LOW,
-			       st->last_timestamp);
+			       st->help.last_timestamp);
 	/* reenable the irq */
 	enable_irq(st->us->irq);
 	/* Ack and allow for new interrupts */
-	lis3l02dq_spi_read_reg_8(&st->indio_dev->dev,
+	lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
 				 LIS3L02DQ_REG_WAKE_UP_ACK_ADDR,
 				 &t);
 
@@ -769,30 +781,30 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
-	if (st->indio_dev == NULL) {
+	st->help.indio_dev = iio_allocate_device();
+	if (st->help.indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
 	}
 
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &lis3l02dq_event_attribute_group;
-	st->indio_dev->attrs = &lis3l02dq_attribute_group;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	st->help.indio_dev->dev.parent = &spi->dev;
+	st->help.indio_dev->num_interrupt_lines = 1;
+	st->help.indio_dev->event_attrs = &lis3l02dq_event_attribute_group;
+	st->help.indio_dev->attrs = &lis3l02dq_attribute_group;
+	st->help.indio_dev->dev_data = (void *)(&st->help);
+	st->help.indio_dev->driver_module = THIS_MODULE;
+	st->help.indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = lis3l02dq_configure_ring(st->indio_dev);
+	ret = lis3l02dq_configure_ring(st->help.indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(st->help.indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register(st->help.indio_dev->ring, 0);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -801,14 +813,14 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
 		st->inter = 0;
 		ret = iio_register_interrupt_line(spi->irq,
-						  st->indio_dev,
+						  st->help.indio_dev,
 						  0,
 						  IRQF_TRIGGER_RISING,
 						  "lis3l02dq");
 		if (ret)
 			goto error_uninitialize_ring;
 
-		ret = lis3l02dq_probe_trigger(st->indio_dev);
+		ret = lis3l02dq_probe_trigger(st->help.indio_dev);
 		if (ret)
 			goto error_unregister_line;
 	}
@@ -820,20 +832,20 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		lis3l02dq_remove_trigger(st->indio_dev);
+	if (st->help.indio_dev->modes & INDIO_RING_TRIGGERED)
+		lis3l02dq_remove_trigger(st->help.indio_dev);
 error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
+	if (st->help.indio_dev->modes & INDIO_RING_TRIGGERED)
+		iio_unregister_interrupt_line(st->help.indio_dev, 0);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(st->help.indio_dev->ring);
 error_unreg_ring_funcs:
-	lis3l02dq_unconfigure_ring(st->indio_dev);
+	lis3l02dq_unconfigure_ring(st->help.indio_dev);
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(st->indio_dev);
+		iio_device_unregister(st->help.indio_dev);
 	else
-		iio_free_device(st->indio_dev);
+		iio_free_device(st->help.indio_dev);
 error_free_tx:
 	kfree(st->tx);
 error_free_rx:
@@ -848,7 +860,9 @@ error_ret:
 static int lis3l02dq_stop_device(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct lis3l02dq_state *st = indio_dev->dev_data;
+	struct iio_sw_ring_helper_state *h
+		= iio_dev_get_devdata(indio_dev);
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 	u8 val = 0;
 
 	mutex_lock(&indio_dev->mlock);
@@ -875,7 +889,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 {
 	int ret;
 	struct lis3l02dq_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = st->help.indio_dev;
 
 	ret = lis3l02dq_stop_device(indio_dev);
 	if (ret)
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 2c11209..48e0f21 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -105,11 +105,13 @@ static struct attribute_group lis3l02dq_scan_el_group = {
  **/
 static void lis3l02dq_poll_func_th(struct iio_dev *indio_dev, s64 time)
 {
-	struct lis3l02dq_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = time;
-	schedule_work(&st->work_trigger_to_ring);
-	/* Indicate that this interrupt is being handled */
+	struct iio_sw_ring_helper_state *h
+		= iio_dev_get_devdata(indio_dev);
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	/* in this case we need to slightly extend the helper function */
+	iio_sw_poll_func_th(indio_dev, time);
 
+	/* Indicate that this interrupt is being handled */
 	/* Technically this is trigger related, but without this
 	 * handler running there is currently now way for the interrupt
 	 * to clear.
@@ -120,15 +122,16 @@ static void lis3l02dq_poll_func_th(struct iio_dev *indio_dev, s64 time)
 /**
  * lis3l02dq_data_rdy_trig_poll() the event handler for the data rdy trig
  **/
-static int lis3l02dq_data_rdy_trig_poll(struct iio_dev *dev_info,
+static int lis3l02dq_data_rdy_trig_poll(struct iio_dev *indio_dev,
 				       int index,
 				       s64 timestamp,
 				       int no_test)
 {
-	struct lis3l02dq_state *st = iio_dev_get_devdata(dev_info);
-	struct iio_trigger *trig = st->trig;
+	struct iio_sw_ring_helper_state *h
+		= iio_dev_get_devdata(indio_dev);
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 
-	iio_trigger_poll(trig, timestamp);
+	iio_trigger_poll(st->trig, timestamp);
 
 	return IRQ_HANDLED;
 }
@@ -212,7 +215,7 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
 	struct spi_message msg;
 	int ret, i, j = 0;
 
-	xfers = kzalloc((st->indio_dev->scan_count) * 2
+	xfers = kzalloc((st->help.indio_dev->scan_count) * 2
 			* sizeof(*xfers), GFP_KERNEL);
 	if (!xfers)
 		return -ENOMEM;
@@ -220,7 +223,7 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
 	mutex_lock(&st->buf_lock);
 
 	for (i = 0; i < ARRAY_SIZE(read_all_tx_array)/4; i++) {
-		if (st->indio_dev->scan_mask & (1 << i)) {
+		if (st->help.indio_dev->scan_mask & (1 << i)) {
 			/* lower byte */
 			xfers[j].tx_buf = st->tx + 2*j;
 			st->tx[2*j] = read_all_tx_array[i*4];
@@ -248,7 +251,7 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
 	 * values in alternate bytes
 	 */
 	spi_message_init(&msg);
-	for (j = 0; j < st->indio_dev->scan_count * 2; j++)
+	for (j = 0; j < st->help.indio_dev->scan_count * 2; j++)
 		spi_message_add_tail(&xfers[j], &msg);
 
 	ret = spi_sync(st->us, &msg);
@@ -258,62 +261,19 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
 	return ret;
 }
 
-
-/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
- * specific to be rolled into the core.
- */
-static void lis3l02dq_trigger_bh_to_ring(struct work_struct *work_s)
-{
-	struct lis3l02dq_state *st
-		= container_of(work_s, struct lis3l02dq_state,
-			       work_trigger_to_ring);
-
-	u8 *rx_array;
-	int i = 0;
-	u16 *data;
-	size_t datasize = st->indio_dev
-		->ring->access.get_bpd(st->indio_dev->ring);
-
-	data = kmalloc(datasize , GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
-	}
-	/* Due to interleaved nature of transmission this buffer must be
-	 * twice the number of bytes, or 4 times the number of channels
-	 */
-	rx_array = kmalloc(4 * (st->indio_dev->scan_count), GFP_KERNEL);
-	if (rx_array == NULL) {
-		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		kfree(data);
-		return;
+static int lis3l02dq_get_ring_element(struct iio_sw_ring_helper_state *h,
+				u8 *buf) {
+	int ret, i;
+	u8 *rx_array = NULL;
+	ret = lis3l02dq_read_all(lis3l02dq_h_to_s(h), rx_array);
+	if (ret > 0) {
+		for (i = 0; i < h->indio_dev->scan_count; i++)
+			buf[i] = combine_8_to_16(rx_array[i*4+1],
+						rx_array[i*4+3]);
+		kfree(rx_array);
+		return 0;
 	}
-
-	/* whilst trigger specific, if this read does nto occur the data
-	   ready interrupt will not be cleared.  Need to add a mechanism
-	   to provide a dummy read function if this is not triggering on
-	   the data ready function but something else is.
-	*/
-	st->inter = 0;
-
-	if (st->indio_dev->scan_count)
-		if (lis3l02dq_read_all(st, rx_array) >= 0)
-			for (; i < st->indio_dev->scan_count; i++)
-				data[i] = combine_8_to_16(rx_array[i*4+1],
-							  rx_array[i*4+3]);
-	/* Guaranteed to be aligned with 8 byte boundary */
-	if (st->indio_dev->scan_timestamp)
-		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
-
-	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
-					    (u8 *)data,
-					    st->last_timestamp);
-
-	iio_trigger_notify_done(st->indio_dev->trig);
-	kfree(rx_array);
-	kfree(data);
-
-	return;
+	return ret;
 }
 
 /* Caller responsible for locking as necessary. */
@@ -387,7 +347,7 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct lis3l02dq_state *st = trig->private_data;
 	int ret = 0;
 	u8 t;
-	__lis3l02dq_write_data_ready_config(&st->indio_dev->dev,
+	__lis3l02dq_write_data_ready_config(&st->help.indio_dev->dev,
 					    &iio_event_data_rdy_trig,
 					    state);
 	if (state == false) {
@@ -397,7 +357,7 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		/* Clear any outstanding ready events */
 		ret = lis3l02dq_read_all(st, NULL);
 	}
-	lis3l02dq_spi_read_reg_8(&st->indio_dev->dev,
+	lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
 				 LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
 				 &t);
 	return ret;
@@ -500,12 +460,12 @@ void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
 
 int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 {
-	int ret = 0;
-	struct lis3l02dq_state *st = indio_dev->dev_data;
-	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, lis3l02dq_trigger_bh_to_ring);
+	int ret;
+	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
+	
+	INIT_WORK(&h->work_trigger_to_ring, iio_sw_trigger_bh_to_ring);
 	/* Set default scan mode */
-
+	h->get_ring_element = &lis3l02dq_get_ring_element;
 	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
 	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
 	iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
@@ -513,19 +473,17 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 
 	indio_dev->scan_el_attrs = &lis3l02dq_scan_el_group;
 
-	ring = iio_sw_rb_allocate(indio_dev);
-	if (!ring) {
-		ret = -ENOMEM;
-		return ret;
-	}
-	indio_dev->ring = ring;
+	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->ring)
+		return -ENOMEM;
+
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
-	ring->bpe = 2;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
-	ring->owner = THIS_MODULE;
+	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	indio_dev->ring->bpe = 2;
+	indio_dev->ring->preenable = &iio_sw_ring_preenable;
+	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
+	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
+	indio_dev->ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &lis3l02dq_poll_func_th);
 	if (ret)
@@ -537,6 +495,3 @@ error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
 	return ret;
 }
-
-
-
-- 
1.7.0.4
