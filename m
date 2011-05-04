Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 87/99] drivers:staging:iio:adis16400 avoid allocating rx, tx, and state separately from iio_dev.
Date: Wed,  4 May 2011 12:58:59 +0100
Message-Id: <1304510351-10922-88-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Uses the iio_allocate_device parameter to set aside space for adis16400_state and
____cacheline_aligned buffers for tx and rx to avoid separatel allocating them.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400.h         |    7 +-
 drivers/staging/iio/imu/adis16400_core.c    |  112 +++++++++++----------------
 drivers/staging/iio/imu/adis16400_ring.c    |   17 ++--
 drivers/staging/iio/imu/adis16400_trigger.c |   17 ++--
 4 files changed, 63 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 9804c41..db184d1 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -141,7 +141,6 @@ struct adis16400_chip_info {
 /**
  * struct adis16400_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
@@ -149,12 +148,12 @@ struct adis16400_chip_info {
  **/
 struct adis16400_state {
 	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
 	struct mutex			buf_lock;
 	struct adis16400_chip_info	*variant;
+
+	u8	tx[ADIS16400_MAX_TX] ____cacheline_aligned;
+	u8	rx[ADIS16400_MAX_RX] ____cacheline_aligned;
 };
 
 int adis16400_set_irq(struct iio_dev *indio_dev, bool enable);
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 6419b75..0067bc7 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -66,7 +66,7 @@ static int adis16400_spi_write_reg_8(struct iio_dev *indio_dev,
 				     u8 val)
 {
 	int ret;
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16400_WRITE_REG(reg_address);
@@ -91,7 +91,7 @@ static int adis16400_spi_write_reg_16(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct spi_message msg;
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -132,7 +132,7 @@ static int adis16400_spi_read_reg_16(struct iio_dev *indio_dev,
 		u16 *val)
 {
 	struct spi_message msg;
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -195,7 +195,7 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 	long val;
 	int ret;
 	u8 t;
@@ -356,11 +356,12 @@ error_ret:
 	return ret;
 }
 
-static int adis16400_initial_setup(struct adis16400_state *st)
+static int adis16400_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
 	u16 prod_id, smp_prd;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &indio_dev->dev;
+	struct adis16400_state *st = iio_priv(indio_dev);
 
 	/* use low spi speed for init */
 	st->us->max_speed_hz = ADIS16400_SPI_SLOW;
@@ -368,33 +369,33 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 	spi_setup(st->us);
 
 	/* Disable IRQ */
-	ret = adis16400_set_irq(st->indio_dev, false);
+	ret = adis16400_set_irq(indio_dev, false);
 	if (ret) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
 	}
 
 	/* Do self test */
-	ret = adis16400_self_test(st->indio_dev);
+	ret = adis16400_self_test(indio_dev);
 	if (ret) {
 		dev_err(dev, "self test failure");
 		goto err_ret;
 	}
 
 	/* Read status register to check the result */
-	ret = adis16400_check_status(st->indio_dev);
+	ret = adis16400_check_status(indio_dev);
 	if (ret) {
-		adis16400_reset(st->indio_dev);
+		adis16400_reset(indio_dev);
 		dev_err(dev, "device not playing ball -> reset");
 		msleep(ADIS16400_STARTUP_DELAY);
-		ret = adis16400_check_status(st->indio_dev);
+		ret = adis16400_check_status(indio_dev);
 		if (ret) {
 			dev_err(dev, "giving up");
 			goto err_ret;
 		}
 	}
 	if (st->variant->flags & ADIS16400_HAS_PROD_ID) {
-		ret = adis16400_spi_read_reg_16(st->indio_dev,
+		ret = adis16400_spi_read_reg_16(indio_dev,
 						ADIS16400_PRODUCT_ID, &prod_id);
 		if (ret)
 			goto err_ret;
@@ -406,7 +407,7 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 		       prod_id, st->us->chip_select, st->us->irq);
 	}
 	/* use high spi speed if possible */
-	ret = adis16400_spi_read_reg_16(st->indio_dev,
+	ret = adis16400_spi_read_reg_16(indio_dev,
 					ADIS16400_SMPL_PRD, &smp_prd);
 	if (!ret && (smp_prd & ADIS16400_SMPL_PRD_DIV_MASK) < 0x0A) {
 		st->us->max_speed_hz = ADIS16400_SPI_SLOW;
@@ -487,7 +488,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			      int *val2,
 			      long mask)
 {
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 	int ret;
 	s16 val16;
 	int shift;
@@ -774,55 +775,41 @@ static struct adis16400_chip_info adis16400_chips[] = {
 static int __devinit adis16400_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16400_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
+	struct adis16400_state *st;
+	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret =  -ENOMEM;
 		goto error_ret;
 	}
+	st = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16400_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16400_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
 	st->us = spi;
 	mutex_init(&st->buf_lock);
+
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
 	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->attrs = &adis16400_attribute_group;
-	st->indio_dev->channels = st->variant->channels;
-	st->indio_dev->num_channels = st->variant->num_channels;
-	st->indio_dev->read_raw = &adis16400_read_raw;
-	st->indio_dev->write_raw = &adis16400_write_raw;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis16400_configure_ring(st->indio_dev);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->attrs = &adis16400_attribute_group;
+	indio_dev->channels = st->variant->channels;
+	indio_dev->num_channels = st->variant->num_channels;
+	indio_dev->read_raw = &adis16400_read_raw;
+	indio_dev->write_raw = &adis16400_write_raw;
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis16400_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  st->variant->channels,
 					  st->variant->num_channels);
 	if (ret) {
@@ -831,35 +818,29 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-		ret = adis16400_probe_trigger(st->indio_dev);
+		ret = adis16400_probe_trigger(indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
 	}
 
 	/* Get the device into a sane initial state */
-	ret = adis16400_initial_setup(st);
+	ret = adis16400_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		adis16400_remove_trigger(st->indio_dev);
+	if (indio_dev->modes & INDIO_RING_TRIGGERED)
+		adis16400_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16400_unconfigure_ring(st->indio_dev);
+	adis16400_unconfigure_ring(indio_dev);
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
@@ -868,22 +849,17 @@ error_ret:
 static int adis16400_remove(struct spi_device *spi)
 {
 	int ret;
-	struct adis16400_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev =  spi_get_drvdata(spi);
 
 	ret = adis16400_stop_device(indio_dev);
 	if (ret)
 		goto err_ret;
 
 	adis16400_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 	adis16400_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
-
 	return 0;
 
 err_ret:
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index c56c655..271fe1d 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -27,7 +27,7 @@ static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 	u32 old_speed_hz = st->us->max_speed_hz;
 	int ret;
 
@@ -81,20 +81,19 @@ static const u16 read_all_tx_array[] = {
 static int adis16350_spi_read_all(struct device *dev, u8 *rx)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 
 	struct spi_message msg;
 	int i, j = 0, ret;
 	struct spi_transfer *xfers;
 
-	xfers = kzalloc(sizeof(*xfers)*
-			st->indio_dev->ring->scan_count + 1,
-		GFP_KERNEL);
+	xfers = kzalloc(sizeof(*xfers)*indio_dev->ring->scan_count + 1,
+			GFP_KERNEL);
 	if (xfers == NULL)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(read_all_tx_array); i++)
-		if (st->indio_dev->ring->scan_mask & (1 << i)) {
+		if (indio_dev->ring->scan_mask & (1 << i)) {
 			xfers[j].tx_buf = &read_all_tx_array[i];
 			xfers[j].bits_per_word = 16;
 			xfers[j].len = 2;
@@ -105,7 +104,7 @@ static int adis16350_spi_read_all(struct device *dev, u8 *rx)
 	xfers[j].len = 2;
 
 	spi_message_init(&msg);
-	for (j = 0; j < st->indio_dev->ring->scan_count + 1; j++)
+	for (j = 0; j < indio_dev->ring->scan_count + 1; j++)
 		spi_message_add_tail(&xfers[j], &msg);
 
 	ret = spi_sync(st->us, &msg);
@@ -121,7 +120,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0, j, ret = 0;
 	s16 *data;
@@ -174,7 +173,7 @@ void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 int adis16400_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16400_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index d426fba..c6ec41a 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -18,17 +18,16 @@
 static int adis16400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct adis16400_state *st = trig->private_data;
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = trig->private_data;
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	return adis16400_set_irq(st->indio_dev, state);
+	return adis16400_set_irq(indio_dev, state);
 }
 
 int adis16400_probe_trigger(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct adis16400_state *st = indio_dev->dev_data;
+	struct adis16400_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("%s-dev%d",
 					spi_get_device_id(st->us)->name,
@@ -47,7 +46,7 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
-	st->trig->private_data = st;
+	st->trig->private_data = indio_dev;
 	st->trig->set_trigger_state = &adis16400_data_rdy_trigger_set_state;
 	ret = iio_trigger_register(st->trig);
 
@@ -68,9 +67,9 @@ error_ret:
 
 void adis16400_remove_trigger(struct iio_dev *indio_dev)
 {
-	struct adis16400_state *state = indio_dev->dev_data;
+	struct adis16400_state *st = iio_priv(indio_dev);
 
-	iio_trigger_unregister(state->trig);
-	free_irq(state->us->irq, state->trig);
-	iio_free_trigger(state->trig);
+	iio_trigger_unregister(st->trig);
+	free_irq(st->us->irq, st->trig);
+	iio_free_trigger(st->trig);
 }
-- 
1.7.3.4
