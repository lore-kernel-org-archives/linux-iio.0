Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Jonathan Cameron <jic23@cam.acuk>
Subject: [PATCH 90/99] staging:iio: Rip out helper for software rings.
Date: Wed,  4 May 2011 12:59:02 +0100
Message-Id: <1304510351-10922-91-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

It seemed like a good idea at the time, it wasn't.
The code with this in place is larger and more complex for
no real gain.  Basically we've cleaned up the core around
it so much that this no longer makes sense.

Only really effects the lis3l02dq driver.

Signed-off-by: Jonathan Cameron <jic23@cam.acuk>
---
 drivers/staging/iio/accel/lis3l02dq.h      |   10 +--
 drivers/staging/iio/accel/lis3l02dq_core.c |  154 +++++++++++-----------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |   88 +++++++++-------
 drivers/staging/iio/ring_sw.c              |   49 ---------
 drivers/staging/iio/ring_sw.h              |   19 ----
 5 files changed, 111 insertions(+), 209 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 43277d1..94d9869 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -148,7 +148,6 @@ Form of high byte dependent on justification set in ctrl reg */
 #define LIS3L02DQ_MAX_RX 12
 /**
  * struct lis3l02dq_state - device instance specific data
- * @helper:		data and func pointer allowing generic functions
  * @us:			actual spi_device
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
@@ -156,17 +155,14 @@ Form of high byte dependent on justification set in ctrl reg */
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct lis3l02dq_state {
-	struct iio_sw_ring_helper_state	help;
 	struct spi_device		*us;
 	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
 	struct mutex			buf_lock;
 	bool				trigger_on;
-};
 
-#define lis3l02dq_h_to_s(_h)				\
-	container_of(_h, struct lis3l02dq_state, help)
+	u8	tx[LIS3L02DQ_MAX_RX] ____cacheline_aligned;
+	u8	rx[LIS3L02DQ_MAX_RX] ____cacheline_aligned;
+};
 
 int lis3l02dq_spi_read_reg_8(struct iio_dev *indio_dev,
 			     u8 reg_address,
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 42261b5..6b5414c 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -25,7 +25,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "../ring_sw.h"
 
 #include "accel.h"
 
@@ -52,8 +51,7 @@ static irqreturn_t lis3l02dq_noring(int irq, void *private)
 int lis3l02dq_spi_read_reg_8(struct iio_dev *indio_dev,
 			     u8 reg_address, u8 *val)
 {
-	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	struct spi_message msg;
 	int ret;
 	struct spi_transfer xfer = {
@@ -87,9 +85,7 @@ int lis3l02dq_spi_write_reg_8(struct iio_dev *indio_dev,
 			      u8 *val)
 {
 	int ret;
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = LIS3L02DQ_WRITE_REG(reg_address);
@@ -113,9 +109,7 @@ static int lis3l02dq_spi_write_reg_s16(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct spi_message msg;
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = { {
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
@@ -147,9 +141,7 @@ static int lis3l02dq_read_reg_s16(struct iio_dev *indio_dev,
 				  u8 lower_reg_address,
 				  int *val)
 {
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	struct spi_message msg;
 	int ret;
@@ -383,8 +375,9 @@ error_ret_mutex:
 	return ret ? ret : len;
 }
 
-static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
+static int lis3l02dq_initial_setup(struct iio_dev *indio_dev)
 {
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	int ret;
 	u8 val, valtest;
 
@@ -394,7 +387,7 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 
 	val = LIS3L02DQ_DEFAULT_CTRL1;
 	/* Write suitable defaults to ctrl1 */
-	ret = lis3l02dq_spi_write_reg_8(st->help.indio_dev,
+	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
 					&val);
 	if (ret) {
@@ -402,7 +395,7 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 		goto err_ret;
 	}
 	/* Repeat as sometimes doesn't work first time?*/
-	ret = lis3l02dq_spi_write_reg_8(st->help.indio_dev,
+	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
 					&val);
 	if (ret) {
@@ -412,18 +405,18 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 
 	/* Read back to check this has worked acts as loose test of correct
 	 * chip */
-	ret = lis3l02dq_spi_read_reg_8(st->help.indio_dev,
+	ret = lis3l02dq_spi_read_reg_8(indio_dev,
 				       LIS3L02DQ_REG_CTRL_1_ADDR,
 				       &valtest);
 	if (ret || (valtest != val)) {
-		dev_err(&st->help.indio_dev->dev,
+		dev_err(&indio_dev->dev,
 			"device not playing ball %d %d\n", valtest, val);
 		ret = -EINVAL;
 		goto err_ret;
 	}
 
 	val = LIS3L02DQ_DEFAULT_CTRL2;
-	ret = lis3l02dq_spi_write_reg_8(st->help.indio_dev,
+	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_2_ADDR,
 					&val);
 	if (ret) {
@@ -432,7 +425,7 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 	}
 
 	val = LIS3L02DQ_REG_WAKE_UP_CFG_LATCH_SRC;
-	ret = lis3l02dq_spi_write_reg_8(st->help.indio_dev,
+	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
 					&val);
 	if (ret)
@@ -451,19 +444,16 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("280 560 1120 4480");
 static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 	u8 t;
 
 	s64 timestamp = iio_get_time_ns();
 
-	lis3l02dq_spi_read_reg_8(st->help.indio_dev,
+	lis3l02dq_spi_read_reg_8(indio_dev,
 				 LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
 				 &t);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_HIGH)
-		iio_push_event(st->help.indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_Z,
@@ -472,7 +462,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_LOW)
-		iio_push_event(st->help.indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_Z,
@@ -481,7 +471,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_HIGH)
-		iio_push_event(st->help.indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_Y,
@@ -490,7 +480,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_LOW)
-		iio_push_event(st->help.indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_Y,
@@ -499,7 +489,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_HIGH)
-		iio_push_event(st->help.indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_X,
@@ -508,7 +498,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 			       timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_LOW)
-		iio_push_event(st->help.indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_X,
@@ -517,7 +507,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 			       timestamp);
 
 	/* Ack and allow for new interrupts */
-	lis3l02dq_spi_read_reg_8(st->help.indio_dev,
+	lis3l02dq_spi_read_reg_8(indio_dev,
 				 LIS3L02DQ_REG_WAKE_UP_ACK_ADDR,
 				 &t);
 
@@ -664,61 +654,45 @@ static const struct attribute_group lis3l02dq_attribute_group = {
 static int __devinit lis3l02dq_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct lis3l02dq_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct lis3l02dq_state *st;
+	struct iio_dev *indio_dev;
+
+	indio_dev = iio_allocate_device(sizeof *st);
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
 		goto error_ret;
 	}
-
+	st = iio_priv(indio_dev);
 	/* this is only used tor removal purposes */
 	spi_set_drvdata(spi, st);
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*LIS3L02DQ_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*LIS3L02DQ_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->help.indio_dev = iio_allocate_device(0);
-	if (st->help.indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
-
-	st->help.indio_dev->name = spi->dev.driver->name;
-	st->help.indio_dev->dev.parent = &spi->dev;
-	st->help.indio_dev->num_interrupt_lines = 1;
-	st->help.indio_dev->channels = lis3l02dq_channels;
-	st->help.indio_dev->num_channels = ARRAY_SIZE(lis3l02dq_channels);
-	st->help.indio_dev->read_raw = &lis3l02dq_read_raw;
-	st->help.indio_dev->write_raw = &lis3l02dq_write_raw;
-	st->help.indio_dev->read_event_value = &lis3l02dq_read_thresh;
-	st->help.indio_dev->write_event_value = &lis3l02dq_write_thresh;
-	st->help.indio_dev->write_event_config = &lis3l02dq_write_event_config;
-	st->help.indio_dev->read_event_config = &lis3l02dq_read_event_config;
-	st->help.indio_dev->attrs = &lis3l02dq_attribute_group;
-	st->help.indio_dev->dev_data = (void *)(&st->help);
-	st->help.indio_dev->driver_module = THIS_MODULE;
-	st->help.indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = lis3l02dq_configure_ring(st->help.indio_dev);
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->num_interrupt_lines = 1;
+	indio_dev->channels = lis3l02dq_channels;
+	indio_dev->num_channels = ARRAY_SIZE(lis3l02dq_channels);
+	indio_dev->read_raw = &lis3l02dq_read_raw;
+	indio_dev->write_raw = &lis3l02dq_write_raw;
+	indio_dev->read_event_value = &lis3l02dq_read_thresh;
+	indio_dev->write_event_value = &lis3l02dq_write_thresh;
+	indio_dev->write_event_config = &lis3l02dq_write_event_config;
+	indio_dev->read_event_config = &lis3l02dq_read_event_config;
+	indio_dev->attrs = &lis3l02dq_attribute_group;
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = lis3l02dq_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->help.indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->help.indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  lis3l02dq_channels,
 					  ARRAY_SIZE(lis3l02dq_channels));
 	if (ret) {
@@ -732,42 +706,36 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 					   &lis3l02dq_event_handler,
 					   IRQF_TRIGGER_RISING,
 					   "lis3l02dq",
-					   st->help.indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 
-		ret = lis3l02dq_probe_trigger(st->help.indio_dev);
+		ret = lis3l02dq_probe_trigger(indio_dev);
 		if (ret)
 			goto error_free_interrupt;
 	}
 
 	/* Get the device into a sane initial state */
-	ret = lis3l02dq_initial_setup(st);
+	ret = lis3l02dq_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
-	if (st->help.indio_dev->modes & INDIO_RING_TRIGGERED)
-		lis3l02dq_remove_trigger(st->help.indio_dev);
+	if (indio_dev->modes & INDIO_RING_TRIGGERED)
+		lis3l02dq_remove_trigger(indio_dev);
 error_free_interrupt:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		free_irq(st->us->irq, st->help.indio_dev);
+		free_irq(st->us->irq, indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->help.indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unreg_ring_funcs:
-	lis3l02dq_unconfigure_ring(st->help.indio_dev);
+	lis3l02dq_unconfigure_ring(indio_dev);
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(st->help.indio_dev);
+		iio_device_unregister(indio_dev);
 	else
-		iio_free_device(st->help.indio_dev);
-error_free_tx:
-	kfree(st->tx);
-error_free_rx:
-	kfree(st->rx);
-error_free_st:
-	kfree(st);
+		iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
@@ -776,9 +744,7 @@ error_ret:
 static int lis3l02dq_stop_device(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	u8 val = 0;
 
 	mutex_lock(&indio_dev->mlock);
@@ -804,8 +770,9 @@ err_ret:
 static int lis3l02dq_remove(struct spi_device *spi)
 {
 	int ret;
-	struct lis3l02dq_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->help.indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
+
 	ret = lis3l02dq_disable_all_events(indio_dev);
 	if (ret)
 		goto err_ret;
@@ -821,9 +788,6 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	iio_ring_buffer_unregister(indio_dev->ring);
 	lis3l02dq_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 	return 0;
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index ab11e52..5029c51 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -32,8 +32,7 @@ static inline u16 combine_8_to_16(u8 lower, u8 upper)
 irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct iio_sw_ring_helper_state *h =  iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	if (st->trigger_on) {
 		iio_trigger_poll(st->trig, iio_get_time_ns());
@@ -83,9 +82,10 @@ static const u8 read_all_tx_array[] = {
  * @rx_array:	(dma capable) receive array, must be at least
  *		4*number of channels
  **/
-static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
+static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 {
-	struct iio_ring_buffer *ring = st->help.indio_dev->ring;
+	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	struct spi_transfer *xfers;
 	struct spi_message msg;
 	int ret, i, j = 0;
@@ -136,32 +136,20 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
 	return ret;
 }
 
-static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
-	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
-
-	h->last_timestamp = pf->timestamp;
-	iio_sw_trigger_to_ring(h);
-
-	return IRQ_HANDLED;
-}
-
-static int lis3l02dq_get_ring_element(struct iio_sw_ring_helper_state *h,
+static int lis3l02dq_get_ring_element(struct iio_dev *indio_dev,
 				u8 *buf)
 {
 	int ret, i;
 	u8 *rx_array ;
 	s16 *data = (s16 *)buf;
 
-	rx_array = kzalloc(4 * (h->indio_dev->ring->scan_count), GFP_KERNEL);
+	rx_array = kzalloc(4 * (indio_dev->ring->scan_count), GFP_KERNEL);
 	if (rx_array == NULL)
 		return -ENOMEM;
-	ret = lis3l02dq_read_all(lis3l02dq_h_to_s(h), rx_array);
+	ret = lis3l02dq_read_all(indio_dev, rx_array);
 	if (ret < 0)
 		return ret;
-	for (i = 0; i < h->indio_dev->ring->scan_count; i++)
+	for (i = 0; i < indio_dev->ring->scan_count; i++)
 		data[i] = combine_8_to_16(rx_array[i*4+1],
 					rx_array[i*4+3]);
 	kfree(rx_array);
@@ -169,6 +157,36 @@ static int lis3l02dq_get_ring_element(struct iio_sw_ring_helper_state *h,
 	return i*sizeof(data[0]);
 }
 
+static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_ring_buffer *ring = indio_dev->ring;
+	int len = 0;
+	size_t datasize = ring->access->get_bytes_per_datum(ring);
+	char *data = kmalloc(datasize, GFP_KERNEL);
+
+	if (data == NULL) {
+		dev_err(indio_dev->dev.parent,
+			"memory alloc failed in ring bh");
+		return -ENOMEM;
+	}
+
+	if (ring->scan_count)
+		len = lis3l02dq_get_ring_element(indio_dev, data);
+
+	  /* Guaranteed to be aligned with 8 byte boundary */
+	if (ring->scan_timestamp)
+		*(s64 *)(((phys_addr_t)data + len
+				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
+			= pf->timestamp;
+	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
+
+	iio_trigger_notify_done(indio_dev->trig);
+	kfree(data);
+	return IRQ_HANDLED;
+}
+
 /* Caller responsible for locking as necessary. */
 static int
 __lis3l02dq_write_data_ready_config(struct device *dev, bool state)
@@ -177,9 +195,7 @@ __lis3l02dq_write_data_ready_config(struct device *dev, bool state)
 	u8 valold;
 	bool currentlyset;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_sw_ring_helper_state *h
-				= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 /* Get the current event mask register */
 	ret = lis3l02dq_spi_read_reg_8(indio_dev,
@@ -242,19 +258,19 @@ error_ret:
 static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct lis3l02dq_state *st = trig->private_data;
+	struct iio_dev *indio_dev = trig->private_data;
 	int ret = 0;
 	u8 t;
 
-	__lis3l02dq_write_data_ready_config(&st->help.indio_dev->dev, state);
+	__lis3l02dq_write_data_ready_config(&indio_dev->dev, state);
 	if (state == false) {
 		/*
 		 * A possible quirk with teh handler is currently worked around
 		 *  by ensuring outstanding read events are cleared.
 		 */
-		ret = lis3l02dq_read_all(st, NULL);
+		ret = lis3l02dq_read_all(indio_dev, NULL);
 	}
-	lis3l02dq_spi_read_reg_8(st->help.indio_dev,
+	lis3l02dq_spi_read_reg_8(indio_dev,
 				 LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
 				 &t);
 	return ret;
@@ -266,14 +282,15 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
  */
 static int lis3l02dq_trig_try_reen(struct iio_trigger *trig)
 {
-	struct lis3l02dq_state *st = trig->private_data;
+	struct iio_dev *indio_dev = trig->private_data;
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	int i;
 
 	/* If gpio still high (or high again) */
 	/* In theory possible we will need to do this several times */
 	for (i = 0; i < 5; i++)
 		if (gpio_get_value(irq_to_gpio(st->us->irq)))
-			lis3l02dq_read_all(st, NULL);
+			lis3l02dq_read_all(indio_dev, NULL);
 		else
 			break;
 	if (i == 5)
@@ -287,9 +304,7 @@ static int lis3l02dq_trig_try_reen(struct iio_trigger *trig)
 int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("lis3l02dq-dev%d", indio_dev->id);
 	if (!st->trig) {
@@ -299,7 +314,7 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &lis3l02dq_data_rdy_trigger_set_state;
 	st->trig->try_reenable = &lis3l02dq_trig_try_reen;
 	ret = iio_trigger_register(st->trig);
@@ -316,9 +331,7 @@ error_ret:
 
 void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	iio_trigger_unregister(st->trig);
 	iio_free_trigger(st->trig);
@@ -409,11 +422,8 @@ static const struct iio_ring_setup_ops lis3l02dq_ring_setup_ops = {
 int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring;
 
-	h->get_ring_element = &lis3l02dq_get_ring_element;
-
 	ring = lis3l02dq_alloc_buf(indio_dev);
 	if (!ring)
 		return -ENOMEM;
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 35896cbb..feb84e2 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -452,55 +452,6 @@ void iio_sw_rb_free(struct iio_ring_buffer *r)
 }
 EXPORT_SYMBOL(iio_sw_rb_free);
 
-void iio_sw_trigger_to_ring(struct iio_sw_ring_helper_state *st)
-{
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
-	int len = 0;
-	size_t datasize = ring->access->get_bytes_per_datum(ring);
-	char *data = kmalloc(datasize, GFP_KERNEL);
-
-	if (data == NULL) {
-		dev_err(st->indio_dev->dev.parent,
-			"memory alloc failed in ring bh");
-		return;
-	}
-
-	if (ring->scan_count)
-		len = st->get_ring_element(st, data);
-
-	  /* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
-		*(s64 *)(((phys_addr_t)data + len
-				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
-			= st->last_timestamp;
-	ring->access->store_to(ring,
-			(u8 *)data,
-			st->last_timestamp);
-
-	iio_trigger_notify_done(st->indio_dev->trig);
-	kfree(data);
-
-	return;
-}
-EXPORT_SYMBOL(iio_sw_trigger_to_ring);
-
-void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
-{
-	struct iio_sw_ring_helper_state *st
-		= container_of(work_s, struct iio_sw_ring_helper_state,
-			work_trigger_to_ring);
-	iio_sw_trigger_to_ring(st);
-}
-EXPORT_SYMBOL(iio_sw_trigger_bh_to_ring);
-
-void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	h->last_timestamp = time;
-	schedule_work(&h->work_trigger_to_ring);
-}
-EXPORT_SYMBOL(iio_sw_poll_func_th);
-
 const struct iio_ring_access_funcs ring_sw_access_funcs = {
 	.mark_in_use = &iio_mark_sw_rb_in_use,
 	.unmark_in_use = &iio_unmark_sw_rb_in_use,
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 9344989..1527163 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -23,10 +23,8 @@
 
 #ifndef _IIO_RING_SW_H_
 #define _IIO_RING_SW_H_
-#include "iio.h"
 #include "ring_generic.h"
 
-#if defined CONFIG_IIO_SW_RING || defined CONFIG_IIO_SW_RING_MODULE
 /**
  * ring_sw_access_funcs - access functions for a software ring buffer
  **/
@@ -34,21 +32,4 @@ extern const struct iio_ring_access_funcs ring_sw_access_funcs;
 
 struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev);
 void iio_sw_rb_free(struct iio_ring_buffer *ring);
-
-struct iio_sw_ring_helper_state {
-	struct work_struct		work_trigger_to_ring;
-	struct iio_dev			*indio_dev;
-	int (*get_ring_element)(struct iio_sw_ring_helper_state *st, u8 *buf);
-	s64				last_timestamp;
-};
-
-void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time);
-void iio_sw_trigger_bh_to_ring(struct work_struct *work_s);
-void iio_sw_trigger_to_ring(struct iio_sw_ring_helper_state *st);
-
-#else /* CONFIG_IIO_RING_BUFFER*/
-struct iio_sw_ring_helper_state {
-	struct iio_dev			*indio_dev;
-};
-#endif /* !CONFIG_IIO_RING_BUFFER */
 #endif /* _IIO_RING_SW_H_ */
-- 
1.7.3.4
