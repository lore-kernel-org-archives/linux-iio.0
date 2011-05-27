Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/50] staging:iio:accel:adis16203 move buffers into state and use iio_priv to avoid allocating state separately.
Date: Fri, 27 May 2011 19:35:42 +0100
Message-Id: <1306521390-24897-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16203.h         |   12 ++--
 drivers/staging/iio/accel/adis16203_core.c    |   85 +++++++++----------------
 drivers/staging/iio/accel/adis16203_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16203_trigger.c |   17 +++---
 4 files changed, 48 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.h b/drivers/staging/iio/accel/adis16203.h
index 8bb8ce5..4761789 100644
--- a/drivers/staging/iio/accel/adis16203.h
+++ b/drivers/staging/iio/accel/adis16203.h
@@ -59,19 +59,17 @@
 /**
  * struct adis16203_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16203_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct iio_trigger	*trig;
+	struct mutex		buf_lock;
+	u8			tx[ADIS16203_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADIS16203_MAX_RX];
 };
 
 int adis16203_set_irq(struct iio_dev *indio_dev, bool enable);
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 36be4d5..bf19888 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -36,7 +36,7 @@ static int adis16203_spi_write_reg_8(struct iio_dev *indio_dev,
 				     u8 val)
 {
 	int ret;
-	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16203_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16203_WRITE_REG(reg_address);
@@ -61,7 +61,7 @@ static int adis16203_spi_write_reg_16(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct spi_message msg;
-	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16203_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -102,7 +102,7 @@ static int adis16203_spi_read_reg_16(struct iio_dev *indio_dev,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16203_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -418,51 +418,38 @@ static const struct iio_info adis16203_info = {
 static int __devinit adis16203_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16203_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
-		goto error_ret;
-	}
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	struct iio_dev *indio_dev;
+	struct adis16203_state *st;
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16203_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16203_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
+	/* setup the industrialio driver allocated elements */
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
-		goto error_free_rx;
+		goto error_ret;
 	}
+	st = iio_priv(indio_dev);
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, indio_dev);
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
-	st->indio_dev->name = spi->dev.driver->name;
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->channels = adis16203_channels;
-	st->indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
-	st->indio_dev->info = &adis16203_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis16203_configure_ring(st->indio_dev);
+
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->channels = adis16203_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
+	indio_dev->info = &adis16203_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis16203_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  adis16203_channels,
 					  ARRAY_SIZE(adis16203_channels));
 	if (ret) {
@@ -471,50 +458,40 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = adis16203_probe_trigger(st->indio_dev);
+		ret = adis16203_probe_trigger(indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16203_initial_setup(st->indio_dev);
+	ret = adis16203_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
-	adis16203_remove_trigger(st->indio_dev);
+	adis16203_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16203_unconfigure_ring(st->indio_dev);
+	adis16203_unconfigure_ring(indio_dev);
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(st->indio_dev);
+		iio_device_unregister(indio_dev);
 	else
-		iio_free_device(st->indio_dev);
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
 
 static int adis16203_remove(struct spi_device *spi)
 {
-	struct adis16203_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16203_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index a9a789d..d2c07c5 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -26,7 +26,7 @@ static int adis16203_read_ring_data(struct device *dev, u8 *rx)
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16203_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[ADIS16203_OUTPUTS + 1];
 	int ret;
 	int i;
@@ -68,7 +68,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16203_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	int i = 0;
@@ -82,7 +82,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	}
 
 	if (ring->scan_count)
-		if (adis16203_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+		if (adis16203_read_ring_data(&indio_dev->dev, st->rx) >= 0)
 			for (; i < ring->scan_count; i++)
 				data[i] = be16_to_cpup(
 					(__be16 *)&(st->rx[i*2]));
@@ -95,7 +95,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 			      (u8 *)data,
 			      pf->timestamp);
 
-	iio_trigger_notify_done(st->indio_dev->trig);
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
 
 	return IRQ_HANDLED;
diff --git a/drivers/staging/iio/accel/adis16203_trigger.c b/drivers/staging/iio/accel/adis16203_trigger.c
index ca5db17..3caf3e8 100644
--- a/drivers/staging/iio/accel/adis16203_trigger.c
+++ b/drivers/staging/iio/accel/adis16203_trigger.c
@@ -18,17 +18,16 @@
 static int adis16203_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct adis16203_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = trig->private_data;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16203_set_irq(st->indio_dev, state);
+	return adis16203_set_irq(indio_dev, state);
 }
 
 int adis16203_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16203_state *st = indio_dev->dev_data;
+	struct adis16203_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("adis16203-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
@@ -46,7 +45,7 @@ int adis16203_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &adis16203_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
@@ -67,9 +66,9 @@ error_ret:
 
 void adis16203_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct adis16203_state *state = indio_dev->dev_data;
+	struct adis16203_state *st = iio_priv(indio_dev);
 
-	iio_trigger_unregister(state->trig);
-	free_irq(state->us->irq, state->trig);
-	iio_free_trigger(state->trig);
+	iio_trigger_unregister(st->trig);
+	free_irq(st->us->irq, st->trig);
+	iio_free_trigger(st->trig);
 }
-- 
1.7.3.4
