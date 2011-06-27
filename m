Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/54] staging:iio:accel:adis16240 allocate tx and rx in state plus state via iio_priv
Date: Mon, 27 Jun 2011 11:04:19 +0100
Message-Id: <1309169104-22139-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/accel/adis16240.h         |   12 ++--
 drivers/staging/iio/accel/adis16240_core.c    |   82 +++++++++----------------
 drivers/staging/iio/accel/adis16240_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16240_trigger.c |   17 +++---
 4 files changed, 47 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/accel/adis16240.h
index 162b1f4..ed20333 100644
--- a/drivers/staging/iio/accel/adis16240.h
+++ b/drivers/staging/iio/accel/adis16240.h
@@ -126,19 +126,17 @@
 /**
  * struct adis16240_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16240_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct iio_trigger	*trig;
+	struct mutex		buf_lock;
+	u8			tx[ADIS16240_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADIS16240_MAX_RX];
 };
 
 int adis16240_set_irq(struct iio_dev *indio_dev, bool enable);
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index ac60385..4a4eafc 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -41,7 +41,7 @@ static int adis16240_spi_write_reg_8(struct iio_dev *indio_dev,
 				     u8 val)
 {
 	int ret;
-	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16240_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16240_WRITE_REG(reg_address);
@@ -66,7 +66,7 @@ static int adis16240_spi_write_reg_16(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct spi_message msg;
-	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16240_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -109,7 +109,7 @@ static int adis16240_spi_read_reg_16(struct iio_dev *indio_dev,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16240_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -517,52 +517,39 @@ static const struct iio_info adis16240_info = {
 static int __devinit adis16240_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16240_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct adis16240_state *st;
+	struct iio_dev *indio_dev;
+
+	/* setup the industrialio driver allocated elements */
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
 		goto error_ret;
 	}
+	st = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16240_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16240_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
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
-	st->indio_dev->info = &adis16240_info;
-	st->indio_dev->channels = adis16240_channels;
-	st->indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16240_info;
+	indio_dev->channels = adis16240_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis16240_configure_ring(st->indio_dev);
+	ret = adis16240_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  adis16240_channels,
 					  ARRAY_SIZE(adis16240_channels));
 	if (ret) {
@@ -571,42 +558,36 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = adis16240_probe_trigger(st->indio_dev);
+		ret = adis16240_probe_trigger(indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16240_initial_setup(st->indio_dev);
+	ret = adis16240_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
-	adis16240_remove_trigger(st->indio_dev);
+	adis16240_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16240_unconfigure_ring(st->indio_dev);
+	adis16240_unconfigure_ring(indio_dev);
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
 
 static int adis16240_remove(struct spi_device *spi)
 {
-	struct adis16240_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	flush_scheduled_work();
 
@@ -614,9 +595,6 @@ static int adis16240_remove(struct spi_device *spi)
 	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 0c6d781..c812a34 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -26,7 +26,7 @@ static int adis16240_read_ring_data(struct device *dev, u8 *rx)
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16240_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[ADIS16240_OUTPUTS + 1];
 	int ret;
 	int i;
@@ -63,7 +63,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16240_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	int i = 0;
@@ -77,7 +77,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	}
 
 	if (ring->scan_count &&
-	    adis16240_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+	    adis16240_read_ring_data(&indio_dev->dev, st->rx) >= 0)
 		for (; i < ring->scan_count; i++)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
@@ -87,7 +87,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(st->indio_dev->trig);
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
 
 	return IRQ_HANDLED;
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index ece3ca8..17135fc3 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -27,17 +27,16 @@ static irqreturn_t adis16240_data_rdy_trig_poll(int irq, void *trig)
 static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct adis16240_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = trig->private_data;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16240_set_irq(st->indio_dev, state);
+	return adis16240_set_irq(indio_dev, state);
 }
 
 int adis16240_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16240_state *st = indio_dev->dev_data;
+	struct adis16240_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("adis16240-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
@@ -55,7 +54,7 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &adis16240_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
@@ -76,9 +75,9 @@ error_ret:
 
 void adis16240_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct adis16240_state *state = indio_dev->dev_data;
+	struct adis16240_state *st = iio_priv(indio_dev);
 
-	iio_trigger_unregister(state->trig);
-	free_irq(state->us->irq, state->trig);
-	iio_free_trigger(state->trig);
+	iio_trigger_unregister(st->trig);
+	free_irq(st->us->irq, st->trig);
+	iio_free_trigger(st->trig);
 }
-- 
1.7.3.4
