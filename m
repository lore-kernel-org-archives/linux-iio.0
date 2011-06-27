Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 40/54] staging:iio:gyro:adis16260: allocate chip state with iio_dev and use iio_priv to access.
Date: Mon, 27 Jun 2011 11:04:50 +0100
Message-Id: <1309169104-22139-41-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adis16260.h         |   18 ++---
 drivers/staging/iio/gyro/adis16260_core.c    |   98 ++++++++++----------------
 drivers/staging/iio/gyro/adis16260_ring.c    |    9 +--
 drivers/staging/iio/gyro/adis16260_trigger.c |   15 ++--
 4 files changed, 56 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index 702dc98..4059fe9 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -85,21 +85,19 @@
 /**
  * struct adis16260_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
- * @tx:			transmit buffer
- * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
  * @negate:		negate the scale parameter
+ * @tx:			transmit buffer
+ * @rx:			receive buffer
  **/
 struct adis16260_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
-	unsigned			negate:1;
+	struct spi_device	*us;
+	struct iio_trigger	*trig;
+	struct mutex		buf_lock;
+	unsigned		negate:1;
+	u8			tx[ADIS16260_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADIS16260_MAX_RX];
 };
 
 int adis16260_set_irq(struct iio_dev *indio_dev, bool enable);
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 3dc9a27..801c820 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -41,7 +41,7 @@ static int adis16260_spi_write_reg_8(struct iio_dev *indio_dev,
 		u8 val)
 {
 	int ret;
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16260_WRITE_REG(reg_address);
@@ -66,7 +66,7 @@ static int adis16260_spi_write_reg_16(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct spi_message msg;
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -109,7 +109,7 @@ static int adis16260_spi_read_reg_16(struct iio_dev *indio_dev,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -152,7 +152,7 @@ static ssize_t adis16260_read_frequency_available(struct device *dev,
 						  char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 	if (spi_get_device_id(st->us)->driver_data)
 		return sprintf(buf, "%s\n", "0.129 ~ 256");
 	else
@@ -164,7 +164,7 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 	int ret, len = 0;
 	u16 t;
 	int sps;
@@ -189,7 +189,7 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 	long val;
 	int ret;
 	u8 t;
@@ -435,7 +435,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2,
 			      long mask)
 {
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 	int ret;
 	int bits;
 	u8 addr;
@@ -576,71 +576,58 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
 	struct adis16260_platform_data *pd = spi->dev.platform_data;
-	struct adis16260_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct adis16260_state *st;
+	struct iio_dev *indio_dev;
+
+	/* setup the industrialio driver allocated elements */
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
 		goto error_ret;
 	}
+	st = iio_priv(indio_dev);
 	if (pd)
 		st->negate = pd->negate;
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, st);
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16260_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16260_MAX_TX, GFP_KERNEL);
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
 
-	st->indio_dev->name = spi_get_device_id(st->us)->name;
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->info = &adis16260_info;
-	st->indio_dev->num_channels
+	indio_dev->name = spi_get_device_id(st->us)->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16260_info;
+	indio_dev->num_channels
 		= ARRAY_SIZE(adis16260_channels_x);
 	if (pd && pd->direction)
 		switch (pd->direction) {
 		case 'x':
-			st->indio_dev->channels = adis16260_channels_x;
+			indio_dev->channels = adis16260_channels_x;
 			break;
 		case 'y':
-			st->indio_dev->channels = adis16260_channels_y;
+			indio_dev->channels = adis16260_channels_y;
 			break;
 		case 'z':
-			st->indio_dev->channels = adis16260_channels_z;
+			indio_dev->channels = adis16260_channels_z;
 			break;
 		default:
 			return -EINVAL;
 		}
 	else
-		st->indio_dev->channels = adis16260_channels_x;
+		indio_dev->channels = adis16260_channels_x;
 
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis16260_configure_ring(st->indio_dev);
+	ret = adis16260_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
-					  st->indio_dev->channels,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+					  indio_dev->channels,
 					  ARRAY_SIZE(adis16260_channels_x));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
@@ -648,34 +635,28 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq) {
-		ret = adis16260_probe_trigger(st->indio_dev);
+		ret = adis16260_probe_trigger(indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16260_initial_setup(st->indio_dev);
+	ret = adis16260_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
-	adis16260_remove_trigger(st->indio_dev);
+	adis16260_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16260_unconfigure_ring(st->indio_dev);
+	adis16260_unconfigure_ring(indio_dev);
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
@@ -683,8 +664,7 @@ error_ret:
 static int adis16260_remove(struct spi_device *spi)
 {
 	int ret;
-	struct adis16260_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	ret = adis16260_stop_device(indio_dev);
 	if (ret)
@@ -693,13 +673,9 @@ static int adis16260_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16260_remove_trigger(indio_dev);
-
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	iio_device_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index a092504..a4df8b3 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -17,7 +17,6 @@
 #include "../trigger.h"
 #include "adis16260.h"
 
-
 /**
  * adis16260_read_ring_data() read data registers which will be placed into ring
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
@@ -27,7 +26,7 @@ static int adis16260_read_ring_data(struct device *dev, u8 *rx)
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[ADIS16260_OUTPUTS + 1];
 	int ret;
 	int i;
@@ -70,7 +69,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16260_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0;
 	s16 *data;
@@ -83,7 +82,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	}
 
 	if (ring->scan_count &&
-	    adis16260_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
+	    adis16260_read_ring_data(&indio_dev->dev, st->rx) >= 0)
 		for (; i < ring->scan_count; i++)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
@@ -93,7 +92,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(st->indio_dev->trig);
+	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
 
 	return IRQ_HANDLED;
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index 4f10fb5..01094d0 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -18,8 +18,7 @@
 static int adis16260_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct adis16260_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = trig->private_data;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
 	return adis16260_set_irq(indio_dev, state);
@@ -28,7 +27,7 @@ static int adis16260_data_rdy_trigger_set_state(struct iio_trigger *trig,
 int adis16260_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16260_state *st = indio_dev->dev_data;
+	struct adis16260_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("%s-dev%d",
 					spi_get_device_id(st->us)->name,
@@ -48,7 +47,7 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &adis16260_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
@@ -69,9 +68,9 @@ error_ret:
 
 void adis16260_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct adis16260_state *state = indio_dev->dev_data;
+	struct adis16260_state *st = iio_priv(indio_dev);
 
-	iio_trigger_unregister(state->trig);
-	free_irq(state->us->irq, state->trig);
-	iio_free_trigger(state->trig);
+	iio_trigger_unregister(st->trig);
+	free_irq(st->us->irq, st->trig);
+	iio_free_trigger(st->trig);
 }
-- 
1.7.3.4
