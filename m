Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 6/6] IIO-work: meter: ade7758: Use private data space from iio_allocate_device
Date: Wed, 11 May 2011 16:27:00 +0200
Message-ID: <1305124020-2526-6-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
References: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Use private data space from iio_allocate_device.
Drop dev_data in favor of iio_priv().
Fix indention issues from previous patches.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/meter/ade7758.h         |   12 ++--
 drivers/staging/iio/meter/ade7758_core.c    |   94 +++++++++++++--------------
 drivers/staging/iio/meter/ade7758_ring.c    |   12 ++--
 drivers/staging/iio/meter/ade7758_trigger.c |   18 +++---
 4 files changed, 64 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index a516527..fd74e15 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -111,7 +111,6 @@
 /**
  * struct ade7758_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
@@ -119,21 +118,20 @@
  **/
 struct ade7758_state {
 	struct spi_device	*us;
-	struct iio_dev		*indio_dev;
 	struct iio_trigger	*trig;
 	u8			*tx;
 	u8			*rx;
 	struct mutex		buf_lock;
 	u32			available_scan_masks[AD7758_NUM_WAVESRC];
-	struct iio_chan_spec 	*ade7758_ring_channels;
-	struct spi_transfer		ring_xfer[4];
-	struct spi_message		ring_msg;
+	struct iio_chan_spec	*ade7758_ring_channels;
+	struct spi_transfer	ring_xfer[4];
+	struct spi_message	ring_msg;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	unsigned char			rx_buf[8] ____cacheline_aligned;
-	unsigned char			tx_buf[8];
+	unsigned char		rx_buf[8] ____cacheline_aligned;
+	unsigned char		tx_buf[8];
 
 };
 #ifdef CONFIG_IIO_RING_BUFFER
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 31bb5e1..d9dfd83 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -30,7 +30,7 @@ int ade7758_spi_write_reg_8(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7758_WRITE_REG(reg_address);
@@ -49,7 +49,7 @@ static int ade7758_spi_write_reg_16(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -78,7 +78,7 @@ static int ade7758_spi_write_reg_24(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -107,7 +107,7 @@ int ade7758_spi_read_reg_8(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -150,7 +150,7 @@ static int ade7758_spi_read_reg_16(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -196,7 +196,7 @@ static int ade7758_spi_read_reg_24(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -485,10 +485,11 @@ static int ade7758_stop_device(struct device *dev)
 	return ret;
 }
 
-static int ade7758_initial_setup(struct ade7758_state *st)
+static int ade7758_initial_setup(struct iio_dev *indio_dev)
 {
+	struct ade7758_state *st = iio_priv(indio_dev);
+	struct device *dev = &indio_dev->dev;
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
 
 	/* use low spi speed for init */
 	st->us->mode = SPI_MODE_1;
@@ -559,7 +560,7 @@ static ssize_t ade7758_write_frequency(struct device *dev,
 		break;
 	default:
 		ret = -EINVAL;
-	 	goto out;
+		goto out;
 	}
 
 	ret = ade7758_spi_read_reg_8(dev,
@@ -727,19 +728,23 @@ static struct iio_chan_spec ade7758_channels[] = {
 static int __devinit ade7758_probe(struct spi_device *spi)
 {
 	int i, ret, regdone = 0;
-	struct ade7758_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct ade7758_state *st;
+	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
 		goto error_ret;
 	}
+
+	st = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
 	/* Allocate the comms buffers */
 	st->rx = kzalloc(sizeof(*st->rx)*ADE7758_MAX_RX, GFP_KERNEL);
 	if (st->rx == NULL) {
 		ret = -ENOMEM;
-		goto error_free_st;
+		goto error_free_dev;
 	}
 	st->tx = kzalloc(sizeof(*st->tx)*ADE7758_MAX_TX, GFP_KERNEL);
 	if (st->tx == NULL) {
@@ -749,35 +754,28 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	st->us = spi;
 	st->ade7758_ring_channels = &ade7758_channels[0];
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
 
-	st->indio_dev->name = spi->dev.driver->name;
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->attrs = &ade7758_attribute_group;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->attrs = &ade7758_attribute_group;
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	for (i = 0; i < AD7758_NUM_WAVESRC; i++)
 		st->available_scan_masks[i] = 1 << i;
 
-	st->indio_dev->available_scan_masks = st->available_scan_masks;
+	indio_dev->available_scan_masks = st->available_scan_masks;
 
-	ret = ade7758_configure_ring(st->indio_dev);
+	ret = ade7758_configure_ring(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		goto error_free_tx;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  &ade7758_channels[0],
 					  ARRAY_SIZE(ade7758_channels));
 	if (ret) {
@@ -786,12 +784,12 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	}
 
 	/* Get the device into a sane initial state */
-	ret = ade7758_initial_setup(st);
+	ret = ade7758_initial_setup(indio_dev);
 	if (ret)
 		goto error_uninitialize_ring;
 
 	if (spi->irq) {
-		ret = ade7758_probe_trigger(st->indio_dev);
+		ret = ade7758_probe_trigger(indio_dev);
 		if (ret)
 			goto error_remove_trigger;
 	}
@@ -799,47 +797,43 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		ade7758_remove_trigger(st->indio_dev);
+	if (indio_dev->modes & INDIO_RING_TRIGGERED)
+		ade7758_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	ade7758_uninitialize_ring(st->indio_dev->ring);
+	ade7758_uninitialize_ring(indio_dev->ring);
 error_unreg_ring_funcs:
-	ade7758_unconfigure_ring(st->indio_dev);
-error_free_dev:
-	if (regdone)
-		iio_device_unregister(st->indio_dev);
-	else
-		iio_free_device(st->indio_dev);
+	ade7758_unconfigure_ring(indio_dev);
 error_free_tx:
 	kfree(st->tx);
 error_free_rx:
 	kfree(st->rx);
-error_free_st:
-	kfree(st);
+error_free_dev:
+	if (regdone)
+		iio_device_unregister(indio_dev);
+	else
+		iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
 
 static int ade7758_remove(struct spi_device *spi)
 {
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
-	struct ade7758_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
 
-	ret = ade7758_stop_device(&(indio_dev->dev));
+	ret = ade7758_stop_device(&indio_dev->dev);
 	if (ret)
 		goto err_ret;
 
 	ade7758_remove_trigger(indio_dev);
 	ade7758_uninitialize_ring(indio_dev->ring);
-	iio_device_unregister(indio_dev);
 	ade7758_unconfigure_ring(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
-	kfree(st);
+	iio_device_unregister(indio_dev);
 
 	return 0;
-
 err_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 8f47d2a..4c58e4f 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -32,7 +32,7 @@
 static int ade7758_spi_read_burst(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
 	ret = spi_sync(st->us, &st->ring_msg);
@@ -71,12 +71,12 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7758_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
 
 	if (ring->scan_count)
-		if (ade7758_spi_read_burst(&st->indio_dev->dev) >= 0)
+		if (ade7758_spi_read_burst(&indio_dev->dev) >= 0)
 			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
 
 	/* Guaranteed to be aligned with 8 byte boundary */
@@ -85,7 +85,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
 
-	iio_trigger_notify_done(st->indio_dev->trig);
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
@@ -99,7 +99,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
  **/
 static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct ade7758_state *st = indio_dev->dev_data;
+	struct ade7758_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	size_t d_size;
 	unsigned channel;
@@ -149,7 +149,7 @@ static const struct iio_ring_setup_ops ade7758_ring_setup_ops = {
 
 int ade7758_configure_ring(struct iio_dev *indio_dev)
 {
-	struct ade7758_state *st = indio_dev->dev_data;
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index f792ccd..798938e 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -37,8 +37,7 @@ static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
 static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct ade7758_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = trig->private_data;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
 	return ade7758_set_irq(&indio_dev->dev, state);
@@ -50,7 +49,8 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
  **/
 static int ade7758_trig_try_reen(struct iio_trigger *trig)
 {
-	struct ade7758_state *st = trig->private_data;
+	struct iio_dev *indio_dev = trig->private_data;
+	struct ade7758_state *st = iio_priv(indio_dev);
 
 	enable_irq(st->us->irq);
 	/* irq reenabled so success! */
@@ -59,8 +59,8 @@ static int ade7758_trig_try_reen(struct iio_trigger *trig)
 
 int ade7758_probe_trigger(struct iio_dev *indio_dev)
 {
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
-	struct ade7758_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger("%s-dev%d",
 		      spi_get_device_id(st->us)->name,
@@ -80,7 +80,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &ade7758_data_rdy_trigger_set_state;
 	st->trig->try_reenable = &ade7758_trig_try_reen;
 	ret = iio_trigger_register(st->trig);
@@ -102,9 +102,9 @@ error_ret:
 
 void ade7758_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct ade7758_state *state = indio_dev->dev_data;
+	struct ade7758_state *st = iio_priv(indio_dev);
 
-	iio_trigger_unregister(state->trig);
-	free_irq(state->us->irq, state->trig);
-	iio_free_trigger(state->trig);
+	iio_trigger_unregister(st->trig);
+	free_irq(st->us->irq, st->trig);
+	iio_free_trigger(st->trig);
 }
-- 
1.6.0.2
