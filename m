Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/4] staging:iio:meter remove stubs from ade7754.
Date: Sat,  5 Feb 2011 19:34:17 +0000
Message-Id: <1296934459-15760-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1296934459-15760-1-git-send-email-jic23@cam.ac.uk>
References: <1296934459-15760-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

General cleanup and use of standard functions to simplfy some spi reads
as well.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7754.c |  165 ++++++-----------------------------
 drivers/staging/iio/meter/ade7754.h |   67 --------------
 2 files changed, 26 insertions(+), 206 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 23dedfa..4272818 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -46,25 +46,14 @@ static int ade7754_spi_write_reg_16(struct device *dev,
 		u16 value)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7754_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7754_WRITE_REG(reg_address);
 	st->tx[1] = (value >> 8) & 0xFF;
 	st->tx[2] = value & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_write(st->us, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -74,73 +63,40 @@ static int ade7754_spi_read_reg_8(struct device *dev,
 		u8 reg_address,
 		u8 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7754_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 2,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7754_READ_REG(reg_address);
-	st->tx[1] = 0;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
+	ret = spi_w8r8(st->us, ADE7754_READ_REG(reg_address));
+	if (ret < 0) {
 		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
 				reg_address);
-		goto error_ret;
+		return ret;
 	}
-	*val = st->rx[1];
+	*val = ret;
 
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return 0;
 }
 
 static int ade7754_spi_read_reg_16(struct device *dev,
 		u8 reg_address,
 		u16 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7754_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 3,
-		},
-	};
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7754_READ_REG(reg_address);
-	st->tx[1] = 0;
-	st->tx[2] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
+	ret = spi_w8r16(st->us, ADE7754_READ_REG(reg_address));
+	if (ret < 0) {
 		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
-				reg_address);
-		goto error_ret;
+			reg_address);
+		return ret;
 	}
-	*val = (st->rx[1] << 8) | st->rx[2];
 
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	*val = ret;
+	*val = be16_to_cpup(val);
+
+	return 0;
 }
 
 static int ade7754_spi_read_reg_24(struct device *dev,
@@ -264,17 +220,11 @@ error_ret:
 
 static int ade7754_reset(struct device *dev)
 {
-	int ret;
 	u8 val;
-	ade7754_spi_read_reg_8(dev,
-			ADE7754_OPMODE,
-			&val);
-	val |= 1 << 6; /* Software Chip Reset */
-	ret = ade7754_spi_write_reg_8(dev,
-			ADE7754_OPMODE,
-			val);
 
-	return ret;
+	ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
+	val |= 1 << 6; /* Software Chip Reset */
+	return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
 }
 
 
@@ -431,17 +381,11 @@ error_ret:
 /* Power down the device */
 static int ade7754_stop_device(struct device *dev)
 {
-	int ret;
 	u8 val;
-	ade7754_spi_read_reg_8(dev,
-			ADE7754_OPMODE,
-			&val);
-	val |= 7 << 3;  /* ADE7754 powered down */
-	ret = ade7754_spi_write_reg_8(dev,
-			ADE7754_OPMODE,
-			val);
 
-	return ret;
+	ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
+	val |= 7 << 3;  /* ADE7754 powered down */
+	return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
 }
 
 static int ade7754_initial_setup(struct ade7754_state *st)
@@ -471,7 +415,7 @@ static ssize_t ade7754_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	int ret, len = 0;
+	int ret;
 	u8 t;
 	int sps;
 	ret = ade7754_spi_read_reg_8(dev,
@@ -483,8 +427,7 @@ static ssize_t ade7754_read_frequency(struct device *dev,
 	t = (t >> 3) & 0x3;
 	sps = 26000 / (1 + t);
 
-	len = sprintf(buf, "%d SPS\n", sps);
-	return len;
+	return sprintf(buf, "%d\n", sps);
 }
 
 static ssize_t ade7754_write_frequency(struct device *dev,
@@ -513,18 +456,14 @@ static ssize_t ade7754_write_frequency(struct device *dev,
 	else
 		st->us->max_speed_hz = ADE7754_SPI_FAST;
 
-	ret = ade7754_spi_read_reg_8(dev,
-			ADE7754_WAVMODE,
-			&reg);
+	ret = ade7754_spi_read_reg_8(dev, ADE7754_WAVMODE, &reg);
 	if (ret)
 		goto out;
 
 	reg &= ~(3 << 3);
 	reg |= t << 3;
 
-	ret = ade7754_spi_write_reg_8(dev,
-			ADE7754_WAVMODE,
-			reg);
+	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
 
 out:
 	mutex_unlock(&indio_dev->mlock);
@@ -545,14 +484,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
 
 static IIO_CONST_ATTR(name, "ade7754");
 
-static struct attribute *ade7754_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group ade7754_event_attribute_group = {
-	.attrs = ade7754_event_attributes,
-};
-
 static struct attribute *ade7754_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -633,58 +564,22 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &ade7754_event_attribute_group;
 	st->indio_dev->attrs = &ade7754_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ade7754_configure_ring(st->indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	ret = iio_device_register(st->indio_dev);
 	if (ret)
-		goto error_unreg_ring_funcs;
+		goto error_free_dev;
 	regdone = 1;
 
-	ret = ade7754_initialize_ring(st->indio_dev->ring);
-	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
-
-	if (spi->irq) {
-		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_FALLING,
-				"ade7754");
-		if (ret)
-			goto error_uninitialize_ring;
-
-		ret = ade7754_probe_trigger(st->indio_dev);
-		if (ret)
-			goto error_unregister_line;
-	}
-
 	/* Get the device into a sane initial state */
 	ret = ade7754_initial_setup(st);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_free_dev;
 	return 0;
 
-error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		ade7754_remove_trigger(st->indio_dev);
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	ade7754_uninitialize_ring(st->indio_dev->ring);
-error_unreg_ring_funcs:
-	ade7754_unconfigure_ring(st->indio_dev);
 error_free_dev:
 	if (regdone)
 		iio_device_unregister(st->indio_dev);
@@ -711,14 +606,6 @@ static int ade7754_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	flush_scheduled_work();
-
-	ade7754_remove_trigger(indio_dev);
-	if (spi->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
-	ade7754_uninitialize_ring(indio_dev->ring);
-	ade7754_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
diff --git a/drivers/staging/iio/meter/ade7754.h b/drivers/staging/iio/meter/ade7754.h
index f6a3e4b..8faa9b3 100644
--- a/drivers/staging/iio/meter/ade7754.h
+++ b/drivers/staging/iio/meter/ade7754.h
@@ -78,84 +78,17 @@
 /**
  * struct ade7754_state - device instance specific data
  * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
- * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct ade7754_state {
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
 };
-#if defined(CONFIG_IIO_RING_BUFFER) && defined(THIS_HAS_RING_BUFFER_SUPPORT)
-/* At the moment triggers are only used for ring buffer
- * filling. This may change!
- */
-
-enum ade7754_scan {
-	ADE7754_SCAN_PHA_V,
-	ADE7754_SCAN_PHB_V,
-	ADE7754_SCAN_PHC_V,
-	ADE7754_SCAN_PHA_I,
-	ADE7754_SCAN_PHB_I,
-	ADE7754_SCAN_PHC_I,
-};
-
-void ade7754_remove_trigger(struct iio_dev *indio_dev);
-int ade7754_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t ade7754_read_data_from_ring(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf);
-
-
-int ade7754_configure_ring(struct iio_dev *indio_dev);
-void ade7754_unconfigure_ring(struct iio_dev *indio_dev);
-
-int ade7754_initialize_ring(struct iio_ring_buffer *ring);
-void ade7754_uninitialize_ring(struct iio_ring_buffer *ring);
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void ade7754_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-static inline int ade7754_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-ade7754_read_data_from_ring(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return 0;
-}
-
-static int ade7754_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-static inline void ade7754_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-static inline int ade7754_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-static inline void ade7754_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-#endif /* CONFIG_IIO_RING_BUFFER */
 
 #endif
-- 
1.7.3.4
