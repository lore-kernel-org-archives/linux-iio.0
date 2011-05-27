Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/50] staging:iio:accel:adis16201 general cleanup, move to iio_priv and buffers in adis16201_state
Date: Fri, 27 May 2011 19:35:41 +0100
Message-Id: <1306521390-24897-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Basically use various new facilities to tidy up.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201.h         |   12 +--
 drivers/staging/iio/accel/adis16201_core.c    |  125 ++++++++++---------------
 drivers/staging/iio/accel/adis16201_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16201_trigger.c |   11 +-
 4 files changed, 63 insertions(+), 93 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.h b/drivers/staging/iio/accel/adis16201.h
index 0b9b854..22b82fe 100644
--- a/drivers/staging/iio/accel/adis16201.h
+++ b/drivers/staging/iio/accel/adis16201.h
@@ -64,19 +64,17 @@
 /**
  * struct adis16201_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16201_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct iio_trigger	*trig;
+	struct mutex		buf_lock;
+	u8			tx[14] ____cacheline_aligned;
+	u8			rx[14];
 };
 
 int adis16201_set_irq(struct iio_dev *indio_dev, bool enable);
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index e4c49f0..cbc59c5 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -24,8 +24,6 @@
 
 #include "adis16201.h"
 
-#define DRIVER_NAME		"adis16201"
-
 enum adis16201_chan {
 	in_supply,
 	temp,
@@ -42,13 +40,12 @@ enum adis16201_chan {
  * @reg_address: the address of the register to be written
  * @val: the value to write
  **/
-static int adis16201_spi_write_reg_8(struct device *dev,
+static int adis16201_spi_write_reg_8(struct iio_dev *indio_dev,
 		u8 reg_address,
 		u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16201_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16201_WRITE_REG(reg_address);
@@ -73,7 +70,7 @@ static int adis16201_spi_write_reg_16(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct spi_message msg;
-	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16201_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -114,7 +111,7 @@ static int adis16201_spi_read_reg_16(struct iio_dev *indio_dev,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16201_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -151,14 +148,16 @@ error_ret:
 	return ret;
 }
 
-static int adis16201_reset(struct device *dev)
+static int adis16201_reset(struct iio_dev *indio_dev)
 {
 	int ret;
-	ret = adis16201_spi_write_reg_8(dev,
+	struct adis16201_state *st = iio_priv(indio_dev);
+
+	ret = adis16201_spi_write_reg_8(indio_dev,
 			ADIS16201_GLOB_CMD,
 			ADIS16201_GLOB_CMD_SW_RESET);
 	if (ret)
-		dev_err(dev, "problem resetting device");
+		dev_err(&st->us->dev, "problem resetting device");
 
 	return ret;
 }
@@ -167,15 +166,15 @@ static ssize_t adis16201_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
 {
+	int ret;
+	bool res;
+
 	if (len < 1)
 		return -EINVAL;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return adis16201_reset(dev);
-	}
-	return -EINVAL;
+	ret = strtobool(buf, &res);
+	if (ret || !res)
+		return ret;
+	return adis16201_reset(dev_get_drvdata(dev));
 }
 
 int adis16201_set_irq(struct iio_dev *indio_dev, bool enable)
@@ -245,41 +244,38 @@ err_ret:
 	return ret;
 }
 
-static int adis16201_initial_setup(struct adis16201_state *st)
+static int adis16201_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &indio_dev->dev;
 
 	/* Disable IRQ */
-	ret = adis16201_set_irq(st->indio_dev, false);
+	ret = adis16201_set_irq(indio_dev, false);
 	if (ret) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16201_self_test(st->indio_dev);
+	ret = adis16201_self_test(indio_dev);
 	if (ret) {
 		dev_err(dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16201_check_status(st->indio_dev);
+	ret = adis16201_check_status(indio_dev);
 	if (ret) {
-		adis16201_reset(dev);
+		adis16201_reset(indio_dev);
 		dev_err(dev, "device not playing ball -> reset");
 		msleep(ADIS16201_STARTUP_DELAY);
-		ret = adis16201_check_status(st->indio_dev);
+		ret = adis16201_check_status(indio_dev);
 		if (ret) {
 			dev_err(dev, "giving up");
 			goto err_ret;
 		}
 	}
 
-	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
-			st->us->chip_select, st->us->irq);
-
 err_ret:
 	return ret;
 }
@@ -467,53 +463,40 @@ static const struct iio_info adis16201_info = {
 static int __devinit adis16201_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16201_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct adis16201_state *st;
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
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16201_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16201_MAX_TX, GFP_KERNEL);
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
-	st->indio_dev->info = &adis16201_info;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16201_info;
 
-	st->indio_dev->channels = adis16201_channels;
-	st->indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adis16201_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis16201_configure_ring(st->indio_dev);
+	ret = adis16201_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  adis16201_channels,
 					  ARRAY_SIZE(adis16201_channels));
 	if (ret) {
@@ -522,50 +505,40 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = adis16201_probe_trigger(st->indio_dev);
+		ret = adis16201_probe_trigger(indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16201_initial_setup(st);
+	ret = adis16201_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
-	adis16201_remove_trigger(st->indio_dev);
+	adis16201_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16201_unconfigure_ring(st->indio_dev);
+	adis16201_unconfigure_ring(indio_dev);
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
 
 static int adis16201_remove(struct spi_device *spi)
 {
-	struct adis16201_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16201_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index c61f981..66e708d 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -23,7 +23,7 @@
 static int adis16201_read_ring_data(struct iio_dev *indio_dev, u8 *rx)
 {
 	struct spi_message msg;
-	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16201_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[ADIS16201_OUTPUTS + 1];
 	int ret;
 	int i;
@@ -63,7 +63,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16201_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	int i = 0;
@@ -77,7 +77,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	}
 
 	if (ring->scan_count)
-		if (adis16201_read_ring_data(st->indio_dev, st->rx) >= 0)
+		if (adis16201_read_ring_data(indio_dev, st->rx) >= 0)
 			for (; i < ring->scan_count; i++)
 				data[i] = be16_to_cpup(
 					(__be16 *)&(st->rx[i*2]));
@@ -88,7 +88,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(st->indio_dev->trig);
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
 
 	return IRQ_HANDLED;
diff --git a/drivers/staging/iio/accel/adis16201_trigger.c b/drivers/staging/iio/accel/adis16201_trigger.c
index bea917e..3a95c08 100644
--- a/drivers/staging/iio/accel/adis16201_trigger.c
+++ b/drivers/staging/iio/accel/adis16201_trigger.c
@@ -17,17 +17,16 @@
 static int adis16201_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct adis16201_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = trig->private_data;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16201_set_irq(st->indio_dev, state);
+	return adis16201_set_irq(indio_dev, state);
 }
 
 int adis16201_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16201_state *st = indio_dev->dev_data;
+	struct adis16201_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("adis16201-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
@@ -43,7 +42,7 @@ int adis16201_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &adis16201_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
@@ -64,7 +63,7 @@ error_ret:
 
 void adis16201_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct adis16201_state *state = indio_dev->dev_data;
+	struct adis16201_state *state = iio_priv(indio_dev);
 
 	iio_trigger_unregister(state->trig);
 	free_irq(state->us->irq, state->trig);
-- 
1.7.3.4
