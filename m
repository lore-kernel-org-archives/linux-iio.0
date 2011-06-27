Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48390 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757690Ab1F0J5E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2011 05:57:04 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/54] staging:iio:accel:adis16209 allocate tx and rx in state plus state via iio_priv
Date: Mon, 27 Jun 2011 11:04:18 +0100
Message-Id: <1309169104-22139-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/accel/adis16209.h         |   12 ++--
 drivers/staging/iio/accel/adis16209_core.c    |   82 +++++++++----------------
 drivers/staging/iio/accel/adis16209_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16209_trigger.c |   17 +++---
 4 files changed, 46 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
index 58d08db..1b2a727 100644
--- a/drivers/staging/iio/accel/adis16209.h
+++ b/drivers/staging/iio/accel/adis16209.h
@@ -104,19 +104,17 @@
 /**
  * struct adis16209_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16209_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct iio_trigger	*trig;
+	struct mutex		buf_lock;
+	u8			tx[ADIS16209_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADIS16209_MAX_RX];
 };
 
 int adis16209_set_irq(struct iio_dev *indio_dev, bool enable);
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index c423cc9..55f3a7b 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -37,7 +37,7 @@ static int adis16209_spi_write_reg_8(struct iio_dev *indio_dev,
 				     u8 val)
 {
 	int ret;
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16209_WRITE_REG(reg_address);
@@ -62,7 +62,7 @@ static int adis16209_spi_write_reg_16(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct spi_message msg;
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -105,7 +105,7 @@ static int adis16209_spi_read_reg_16(struct iio_dev *indio_dev,
 				     u16 *val)
 {
 	struct spi_message msg;
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -466,52 +466,38 @@ static const struct iio_info adis16209_info = {
 static int __devinit adis16209_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16209_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
-		goto error_ret;
-	}
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	struct adis16209_state *st;
+	struct iio_dev *indio_dev;
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16209_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16209_MAX_TX, GFP_KERNEL);
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
-	st->indio_dev->info = &adis16209_info;
-	st->indio_dev->channels = adis16209_channels;
-	st->indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16209_info;
+	indio_dev->channels = adis16209_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis16209_configure_ring(st->indio_dev);
+	ret = adis16209_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  adis16209_channels,
 					  ARRAY_SIZE(adis16209_channels));
 	if (ret) {
@@ -520,42 +506,35 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = adis16209_probe_trigger(st->indio_dev);
+		ret = adis16209_probe_trigger(indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16209_initial_setup(st->indio_dev);
+	ret = adis16209_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
-	adis16209_remove_trigger(st->indio_dev);
+	adis16209_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16209_unconfigure_ring(st->indio_dev);
+	adis16209_unconfigure_ring(indio_dev);
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
 
 static int adis16209_remove(struct spi_device *spi)
 {
-	struct adis16209_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	flush_scheduled_work();
 
@@ -563,9 +542,6 @@ static int adis16209_remove(struct spi_device *spi)
 	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 390908b..45017d3 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -26,7 +26,7 @@ static int adis16209_read_ring_data(struct device *dev, u8 *rx)
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[ADIS16209_OUTPUTS + 1];
 	int ret;
 	int i;
@@ -66,7 +66,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16209_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	int i = 0;
@@ -80,7 +80,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	}
 
 	if (ring->scan_count &&
-	    adis16209_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+	    adis16209_read_ring_data(&indio_dev->dev, st->rx) >= 0)
 		for (; i < ring->scan_count; i++)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
@@ -90,7 +90,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(st->indio_dev->trig);
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
 
 	return IRQ_HANDLED;
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 211ee70..6df7b47 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -27,17 +27,16 @@ static irqreturn_t adis16209_data_rdy_trig_poll(int irq, void *trig)
 static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct adis16209_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = trig->private_data;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16209_set_irq(st->indio_dev, state);
+	return adis16209_set_irq(indio_dev, state);
 }
 
 int adis16209_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16209_state *st = indio_dev->dev_data;
+	struct adis16209_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("adis16209-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
@@ -54,7 +53,7 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &adis16209_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
@@ -75,9 +74,9 @@ error_ret:
 
 void adis16209_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct adis16209_state *state = indio_dev->dev_data;
+	struct adis16209_state *st = iio_priv(indio_dev);
 
-	iio_trigger_unregister(state->trig);
-	free_irq(state->us->irq, state->trig);
-	iio_free_trigger(state->trig);
+	iio_trigger_unregister(st->trig);
+	free_irq(st->us->irq, st->trig);
+	iio_free_trigger(st->trig);
 }
-- 
1.7.3.4

