Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/54] staging:iio:accel:adis16204 allocate tx and rx in state plus state via iio_priv
Date: Mon, 27 Jun 2011 11:04:17 +0100
Message-Id: <1309169104-22139-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/accel/adis16204.h         |   12 ++--
 drivers/staging/iio/accel/adis16204_core.c    |   84 +++++++++----------------
 drivers/staging/iio/accel/adis16204_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16204_trigger.c |   11 ++--
 4 files changed, 44 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16204.h b/drivers/staging/iio/accel/adis16204.h
index 5310a42..802fc57 100644
--- a/drivers/staging/iio/accel/adis16204.h
+++ b/drivers/staging/iio/accel/adis16204.h
@@ -67,19 +67,17 @@
 /**
  * struct adis16204_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16204_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct iio_trigger	*trig;
+	struct mutex		buf_lock;
+	u8			tx[ADIS16204_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADIS16204_MAX_RX];
 };
 
 int adis16204_set_irq(struct iio_dev *indio_dev, bool enable);
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 1680670..cfd09b3 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -39,7 +39,7 @@ static int adis16204_spi_write_reg_8(struct iio_dev *indio_dev,
 		u8 val)
 {
 	int ret;
-	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16204_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16204_WRITE_REG(reg_address);
@@ -64,7 +64,7 @@ static int adis16204_spi_write_reg_16(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct spi_message msg;
-	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16204_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -106,7 +106,7 @@ static int adis16204_spi_read_reg_16(struct iio_dev *indio_dev,
 				     u16 *val)
 {
 	struct spi_message msg;
-	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16204_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -483,52 +483,38 @@ static const struct iio_info adis16204_info = {
 static int __devinit adis16204_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16204_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
-		goto error_ret;
-	}
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	struct adis16204_state *st;
+	struct iio_dev *indio_dev;
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16204_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16204_MAX_TX, GFP_KERNEL);
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
-	st->indio_dev->info = &adis16204_info;
-	st->indio_dev->channels = adis16204_channels;
-	st->indio_dev->num_channels = ARRAY_SIZE(adis16204_channels);
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16204_info;
+	indio_dev->channels = adis16204_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16204_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis16204_configure_ring(st->indio_dev);
+	ret = adis16204_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  adis16204_channels,
 					  ARRAY_SIZE(adis16204_channels));
 	if (ret) {
@@ -537,50 +523,40 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = adis16204_probe_trigger(st->indio_dev);
+		ret = adis16204_probe_trigger(indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16204_initial_setup(st->indio_dev);
+	ret = adis16204_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
-	adis16204_remove_trigger(st->indio_dev);
+	adis16204_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16204_unconfigure_ring(st->indio_dev);
+	adis16204_unconfigure_ring(indio_dev);
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
 
 static int adis16204_remove(struct spi_device *spi)
 {
-	struct adis16204_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16204_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index a2d36fb..852df06 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -26,7 +26,7 @@ static int adis16204_read_ring_data(struct device *dev, u8 *rx)
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16204_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[ADIS16204_OUTPUTS + 1];
 	int ret;
 	int i;
@@ -66,7 +66,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct adis16204_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16204_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0;
 	s16 *data;
@@ -79,7 +79,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	}
 
 	if (ring->scan_count)
-		if (adis16204_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+		if (adis16204_read_ring_data(&indio_dev->dev, st->rx) >= 0)
 			for (; i < ring->scan_count; i++)
 				data[i] = be16_to_cpup(
 					(__be16 *)&(st->rx[i*2]));
@@ -90,7 +90,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(st->indio_dev->trig);
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
 
 	return IRQ_HANDLED;
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
index 5e1f9ae..01f73b9 100644
--- a/drivers/staging/iio/accel/adis16204_trigger.c
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -18,17 +18,16 @@
 static int adis16204_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct adis16204_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = trig->private_data;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16204_set_irq(st->indio_dev, state);
+	return adis16204_set_irq(indio_dev, state);
 }
 
 int adis16204_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16204_state *st = indio_dev->dev_data;
+	struct adis16204_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("adis16204-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
@@ -46,7 +45,7 @@ int adis16204_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &adis16204_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
@@ -67,7 +66,7 @@ error_ret:
 
 void adis16204_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct adis16204_state *state = indio_dev->dev_data;
+	struct adis16204_state *state = iio_priv(indio_dev);
 
 	iio_trigger_unregister(state->trig);
 	free_irq(state->us->irq, state->trig);
-- 
1.7.3.4
