Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1119 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757439Ab3APMsS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:18 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/15] staging:iio:adis16400: Preallocate transfer message
Date: Wed, 16 Jan 2013 13:48:43 +0100
Message-Id: <1358340531-31350-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Similar to like we already did for the generic adis library preallocate and
pre-construct the SPI transfer message for the adis16400. For devices which do
not support burst mode sampling does not differ from other adis devices and so
we use the generic functions of the adis library in this case. In burst mode we
can only sample all channels at once, so use the IIO cores demux facility
instead of doing this manually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400.h      |  23 +---
 drivers/staging/iio/imu/adis16400_core.c |  89 ++++++++++----
 drivers/staging/iio/imu/adis16400_ring.c | 192 ++++++++++---------------------
 3 files changed, 128 insertions(+), 176 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index ce63ced..a3b9e56 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -190,27 +190,14 @@ ssize_t adis16400_read_data_from_ring(struct device *dev,
 				      char *buf);
 
 
-int adis16400_configure_ring(struct iio_dev *indio_dev);
-void adis16400_unconfigure_ring(struct iio_dev *indio_dev);
+int adis16400_update_scan_mode(struct iio_dev *indio_dev,
+	const unsigned long *scan_mask);
+irqreturn_t adis16400_trigger_handler(int irq, void *p);
 
 #else /* CONFIG_IIO_BUFFER */
 
-static inline ssize_t
-adis16400_read_data_from_ring(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return 0;
-}
-
-static int adis16400_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
+#define adis16400_update_scan_mode NULL
+#define adis16400_trigger_handler NULL
 
 #endif /* CONFIG_IIO_BUFFER */
 
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index f1d747a..aa4ffcf 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -384,7 +384,13 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
 	.address = (addr), \
 	.scan_index = (si), \
-	.scan_type = IIO_ST('u', (bits), 16, 0), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = (bits), \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
 }
 
 #define ADIS16400_SUPPLY_CHAN(addr, bits) \
@@ -403,7 +409,13 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
 	.address = addr, \
 	.scan_index = ADIS16400_SCAN_GYRO_ ## mod, \
-	.scan_type = IIO_ST('s', (bits), 16, 0), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (bits), \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
 }
 
 #define ADIS16400_ACCEL_CHAN(mod, addr, bits) { \
@@ -416,7 +428,13 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
 	.address = (addr), \
 	.scan_index = ADIS16400_SCAN_ACC_ ## mod, \
-	.scan_type = IIO_ST('s', (bits), 16, 0), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (bits), \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
 }
 
 #define ADIS16400_MAGN_CHAN(mod, addr, bits) { \
@@ -428,7 +446,13 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
 	.address = (addr), \
 	.scan_index = ADIS16400_SCAN_MAGN_ ## mod, \
-	.scan_type = IIO_ST('s', (bits), 16, 0), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (bits), \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
 }
 
 #define ADIS16400_MOD_TEMP_NAME_X "x"
@@ -446,7 +470,13 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT, \
 	.address = (addr), \
 	.scan_index = ADIS16350_SCAN_TEMP_ ## mod, \
-	.scan_type = IIO_ST('s', (bits), 16, 0), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (bits), \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
 }
 
 #define ADIS16400_TEMP_CHAN(addr, bits) { \
@@ -458,7 +488,13 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
 	.address = (addr), \
 	.scan_index = ADIS16350_SCAN_TEMP_X, \
-	.scan_type = IIO_ST('s', (bits), 16, 0), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (bits), \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
 }
 
 #define ADIS16400_INCLI_CHAN(mod, addr, bits) { \
@@ -469,7 +505,13 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		IIO_CHAN_INFO_SCALE_SHARED_BIT, \
 	.address = (addr), \
 	.scan_index = ADIS16300_SCAN_INCLI_ ## mod, \
-	.scan_type = IIO_ST('s', (bits), 16, 0), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (bits), \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
 }
 
 static const struct iio_chan_spec adis16400_channels[] = {
@@ -625,6 +667,12 @@ static const struct iio_info adis16400_info = {
 	.read_raw = &adis16400_read_raw,
 	.write_raw = &adis16400_write_raw,
 	.attrs = &adis16400_attribute_group,
+	.update_scan_mode = adis16400_update_scan_mode,
+};
+
+static const unsigned long adis16400_burst_scan_mask[] = {
+	~0UL,
+	0,
 };
 
 static const char * const adis16400_status_error_msgs[] = {
@@ -696,35 +744,30 @@ static int adis16400_probe(struct spi_device *spi)
 	indio_dev->info = &adis16400_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (!(st->variant->flags & ADIS16400_NO_BURST))
+		indio_dev->available_scan_masks = adis16400_burst_scan_mask;
+
 	ret = adis_init(&st->adis, indio_dev, spi, &adis16400_data);
 	if (ret)
 		goto error_free_dev;
 
-	ret = adis16400_configure_ring(indio_dev);
+	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev,
+			adis16400_trigger_handler);
 	if (ret)
 		goto error_free_dev;
 
-	if (spi->irq) {
-		ret = adis_probe_trigger(&st->adis, indio_dev);
-		if (ret)
-			goto error_unreg_ring_funcs;
-	}
-
 	/* Get the device into a sane initial state */
 	ret = adis16400_initial_setup(indio_dev);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_cleanup_buffer;
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_cleanup_buffer;
 
 	return 0;
 
-error_remove_trigger:
-	if (spi->irq)
-		adis_remove_trigger(&st->adis);
-error_unreg_ring_funcs:
-	adis16400_unconfigure_ring(indio_dev);
+error_cleanup_buffer:
+	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
 error_free_dev:
 	iio_device_free(indio_dev);
 error_ret:
@@ -740,9 +783,7 @@ static int adis16400_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	adis16400_stop_device(indio_dev);
 
-	if (spi->irq)
-		adis_remove_trigger(&st->adis);
-	adis16400_unconfigure_ring(indio_dev);
+	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
 
 	iio_device_free(indio_dev);
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index e421278..054c01d 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -13,160 +13,84 @@
 
 #include "adis16400.h"
 
-/**
- * adis16400_spi_read_burst() - read all data registers
- * @indio_dev: the IIO device
- * @rx: somewhere to pass back the value read (min size is 24 bytes)
- **/
-static int adis16400_spi_read_burst(struct iio_dev *indio_dev, u8 *rx)
+int adis16400_update_scan_mode(struct iio_dev *indio_dev,
+	const unsigned long *scan_mask)
 {
-	struct spi_message msg;
 	struct adis16400_state *st = iio_priv(indio_dev);
-	u32 old_speed_hz = st->adis.spi->max_speed_hz;
-	int ret;
+	struct adis *adis = &st->adis;
+	uint16_t *tx, *rx;
 
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->adis.tx,
-			.bits_per_word = 8,
-			.len = 2,
-		}, {
-			.rx_buf = rx,
-			.bits_per_word = 8,
-			.len = 24,
-		},
-	};
-
-	mutex_lock(&st->adis.txrx_lock);
-	st->adis.tx[0] = ADIS_READ_REG(ADIS16400_GLOB_CMD);
-	st->adis.tx[1] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-
-	st->adis.spi->max_speed_hz = min(ADIS16400_SPI_BURST, old_speed_hz);
-	spi_setup(st->adis.spi);
-
-	ret = spi_sync(st->adis.spi, &msg);
-	if (ret)
-		dev_err(&st->adis.spi->dev, "problem when burst reading");
+	if (st->variant->flags & ADIS16400_NO_BURST)
+		return adis_update_scan_mode(indio_dev, scan_mask);
 
-	st->adis.spi->max_speed_hz = old_speed_hz;
-	spi_setup(st->adis.spi);
-	mutex_unlock(&st->adis.txrx_lock);
-	return ret;
-}
-
-static const u16 read_all_tx_array[] = {
-	cpu_to_be16(ADIS_READ_REG(ADIS16400_SUPPLY_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16400_XGYRO_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16400_YGYRO_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16400_ZGYRO_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16400_XACCL_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16400_YACCL_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16400_ZACCL_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16350_XTEMP_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16350_YTEMP_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16350_ZTEMP_OUT)),
-	cpu_to_be16(ADIS_READ_REG(ADIS16400_AUX_ADC)),
-};
-
-static int adis16350_spi_read_all(struct iio_dev *indio_dev, u8 *rx)
-{
-	struct adis16400_state *st = iio_priv(indio_dev);
+	kfree(adis->xfer);
+	kfree(adis->buffer);
 
-	struct spi_message msg;
-	int i, j = 0, ret;
-	struct spi_transfer *xfers;
-	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
-				       indio_dev->masklength);
+	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
+	if (!adis->xfer)
+		return -ENOMEM;
 
-	xfers = kzalloc(sizeof(*xfers)*(scan_count + 1),
-			GFP_KERNEL);
-	if (xfers == NULL)
+	adis->buffer = kzalloc(indio_dev->scan_bytes + sizeof(u16),
+		GFP_KERNEL);
+	if (!adis->buffer)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(read_all_tx_array); i++)
-		if (test_bit(i, indio_dev->active_scan_mask)) {
-			xfers[j].tx_buf = &read_all_tx_array[i];
-			xfers[j].bits_per_word = 16;
-			xfers[j].len = 2;
-			xfers[j + 1].rx_buf = rx + j*2;
-			j++;
-		}
-	xfers[j].bits_per_word = 16;
-	xfers[j].len = 2;
-
-	spi_message_init(&msg);
-	for (j = 0; j < scan_count + 1; j++)
-		spi_message_add_tail(&xfers[j], &msg);
-
-	ret = spi_sync(st->adis.spi, &msg);
-	kfree(xfers);
-
-	return ret;
+	rx = adis->buffer;
+	tx = adis->buffer + indio_dev->scan_bytes;
+
+	tx[0] = ADIS_READ_REG(ADIS16400_GLOB_CMD);
+	tx[1] = 0;
+
+	adis->xfer[0].tx_buf = tx;
+	adis->xfer[0].bits_per_word = 8;
+	adis->xfer[0].len = 2;
+	adis->xfer[1].tx_buf = tx;
+	adis->xfer[1].bits_per_word = 8;
+	adis->xfer[1].len = indio_dev->scan_bytes;
+
+	spi_message_init(&adis->msg);
+	spi_message_add_tail(&adis->xfer[0], &adis->msg);
+	spi_message_add_tail(&adis->xfer[1], &adis->msg);
+
+	return 0;
 }
 
-/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
- * specific to be rolled into the core.
- */
-static irqreturn_t adis16400_trigger_handler(int irq, void *p)
+irqreturn_t adis16400_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16400_state *st = iio_priv(indio_dev);
-	int i = 0, j, ret = 0;
-	s16 *data;
-
-	/* Asumption that long is enough for maximum channels */
-	unsigned long mask = *indio_dev->active_scan_mask;
-	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
-				       indio_dev->masklength);
-	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(&st->adis.spi->dev, "memory alloc failed in ring bh");
-		goto done;
+	struct adis *adis = &st->adis;
+	u32 old_speed_hz = st->adis.spi->max_speed_hz;
+	int ret;
+
+	if (!adis->buffer)
+		return -ENOMEM;
+
+	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
+		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
+		st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;
+		spi_setup(st->adis.spi);
 	}
 
-	if (scan_count) {
-		if (st->variant->flags & ADIS16400_NO_BURST) {
-			ret = adis16350_spi_read_all(indio_dev, st->adis.rx);
-			if (ret < 0)
-				goto done;
-			for (; i < scan_count; i++)
-				data[i]	= *(s16 *)(st->adis.rx + i*2);
-		} else {
-			ret = adis16400_spi_read_burst(indio_dev, st->adis.rx);
-			if (ret < 0)
-				goto done;
-			for (; i < scan_count; i++) {
-				j = __ffs(mask);
-				mask &= ~(1 << j);
-				data[i] = be16_to_cpup(
-					(__be16 *)&(st->adis.rx[j*2]));
-			}
-		}
+	ret = spi_sync(adis->spi, &adis->msg);
+	if (ret)
+		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
+
+	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
+		st->adis.spi->max_speed_hz = old_speed_hz;
+		spi_setup(st->adis.spi);
 	}
+
 	/* Guaranteed to be aligned with 8 byte boundary */
-	if (indio_dev->scan_timestamp)
-		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
-	iio_push_to_buffers(indio_dev, (u8 *) data);
+	if (indio_dev->scan_timestamp) {
+		void *b = adis->buffer + indio_dev->scan_bytes - sizeof(s64);
+		*(s64 *)b = pf->timestamp;
+	}
+
+	iio_push_to_buffers(indio_dev, adis->buffer);
 
-done:
-	kfree(data);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
-
-int adis16400_configure_ring(struct iio_dev *indio_dev)
-{
-	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-		&adis16400_trigger_handler, NULL);
-}
-
-void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
-}
-- 
1.8.0

