Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/4] staging:iio:meter remove stubs from ade7759.
Date: Fri, 11 Feb 2011 14:07:42 +0000
Message-Id: <1297433263-23166-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297433263-23166-1-git-send-email-jic23@cam.ac.uk>
References: <1297433263-23166-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

General cleanup and use of standard functions to simplfy some spi reads
as well.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/meter/ade7759.c |  165 +++++++----------------------------
 drivers/staging/iio/meter/ade7759.h |   65 --------------
 2 files changed, 30 insertions(+), 200 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index fafc3c1..a9d3203 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -23,7 +23,7 @@
 #include "meter.h"
 #include "ade7759.h"
 
-int ade7759_spi_write_reg_8(struct device *dev,
+static int ade7759_spi_write_reg_8(struct device *dev,
 		u8 reg_address,
 		u8 val)
 {
@@ -46,25 +46,14 @@ static int ade7759_spi_write_reg_16(struct device *dev,
 		u16 value)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7759_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7759_WRITE_REG(reg_address);
 	st->tx[1] = (value >> 8) & 0xFF;
 	st->tx[2] = value & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_write(st->us, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -74,73 +63,40 @@ static int ade7759_spi_read_reg_8(struct device *dev,
 		u8 reg_address,
 		u8 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7759_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 2,
-		},
-	};
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7759_READ_REG(reg_address);
-	st->tx[1] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
+	ret = spi_w8r8(st->us, ADE7759_READ_REG(reg_address));
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
 
 static int ade7759_spi_read_reg_16(struct device *dev,
 		u8 reg_address,
 		u16 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7759_state *st = iio_dev_get_devdata(indio_dev);
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
-	st->tx[0] = ADE7759_READ_REG(reg_address);
-	st->tx[1] = 0;
-	st->tx[2] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
+	ret = spi_w8r16(st->us, ADE7759_READ_REG(reg_address));
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
 
 static int ade7759_spi_read_reg_40(struct device *dev,
@@ -354,27 +310,22 @@ static int ade7759_set_irq(struct device *dev, bool enable)
 		irqen &= ~(1 << 3);
 
 	ret = ade7759_spi_write_reg_8(dev, ADE7759_IRQEN, irqen);
-	if (ret)
-		goto error_ret;
 
 error_ret:
 	return ret;
 }
 
 /* Power down the device */
-int ade7759_stop_device(struct device *dev)
+static int ade7759_stop_device(struct device *dev)
 {
-	int ret;
 	u16 val;
+
 	ade7759_spi_read_reg_16(dev,
 			ADE7759_MODE,
 			&val);
 	val |= 1 << 4;  /* AD converters can be turned off */
-	ret = ade7759_spi_write_reg_16(dev,
-			ADE7759_MODE,
-			val);
 
-	return ret;
+	return ade7759_spi_write_reg_16(dev, ADE7759_MODE, val);
 }
 
 static int ade7759_initial_setup(struct ade7759_state *st)
@@ -404,7 +355,7 @@ static ssize_t ade7759_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	int ret, len = 0;
+	int ret;
 	u16 t;
 	int sps;
 	ret = ade7759_spi_read_reg_16(dev,
@@ -416,8 +367,7 @@ static ssize_t ade7759_read_frequency(struct device *dev,
 	t = (t >> 3) & 0x3;
 	sps = 27900 / (1 + t);
 
-	len = sprintf(buf, "%d SPS\n", sps);
-	return len;
+	return sprintf(buf, "%d\n", sps);
 }
 
 static ssize_t ade7759_write_frequency(struct device *dev,
@@ -446,18 +396,14 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 	else
 		st->us->max_speed_hz = ADE7759_SPI_FAST;
 
-	ret = ade7759_spi_read_reg_16(dev,
-			ADE7759_MODE,
-			&reg);
+	ret = ade7759_spi_read_reg_16(dev, ADE7759_MODE, &reg);
 	if (ret)
 		goto out;
 
 	reg &= ~(3 << 13);
 	reg |= t << 13;
 
-	ret = ade7759_spi_write_reg_16(dev,
-			ADE7759_MODE,
-			reg);
+	ret = ade7759_spi_write_reg_16(dev, ADE7759_MODE, reg);
 
 out:
 	mutex_unlock(&indio_dev->mlock);
@@ -478,14 +424,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
 static IIO_CONST_ATTR(name, "ade7759");
 
-static struct attribute *ade7759_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group ade7759_event_attribute_group = {
-	.attrs = ade7759_event_attributes,
-};
-
 static struct attribute *ade7759_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -517,7 +455,7 @@ static const struct attribute_group ade7759_attribute_group = {
 
 static int __devinit ade7759_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct ade7759_state *st = kzalloc(sizeof *st, GFP_KERNEL);
 	if (!st) {
 		ret =  -ENOMEM;
@@ -548,62 +486,27 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &ade7759_event_attribute_group;
+
 	st->indio_dev->attrs = &ade7759_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ade7759_configure_ring(st->indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	ret = iio_device_register(st->indio_dev);
 	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
-	ret = ade7759_initialize_ring(st->indio_dev->ring);
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
-				"ade7759");
-		if (ret)
-			goto error_uninitialize_ring;
-
-		ret = ade7759_probe_trigger(st->indio_dev);
-		if (ret)
-			goto error_unregister_line;
-	}
+		goto error_free_dev;
 
 	/* Get the device into a sane initial state */
 	ret = ade7759_initial_setup(st);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_unreg_dev;
 	return 0;
 
-error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		ade7759_remove_trigger(st->indio_dev);
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	ade7759_uninitialize_ring(st->indio_dev->ring);
-error_unreg_ring_funcs:
-	ade7759_unconfigure_ring(st->indio_dev);
+
+error_unreg_dev:
+	iio_device_unregister(st->indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(st->indio_dev);
-	else
-		iio_free_device(st->indio_dev);
+	iio_free_device(st->indio_dev);
 error_free_tx:
 	kfree(st->tx);
 error_free_rx:
@@ -625,14 +528,6 @@ static int ade7759_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	flush_scheduled_work();
-
-	ade7759_remove_trigger(indio_dev);
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
-	ade7759_uninitialize_ring(indio_dev->ring);
-	ade7759_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
diff --git a/drivers/staging/iio/meter/ade7759.h b/drivers/staging/iio/meter/ade7759.h
index 813dea2..e9d1c43 100644
--- a/drivers/staging/iio/meter/ade7759.h
+++ b/drivers/staging/iio/meter/ade7759.h
@@ -41,82 +41,17 @@
 /**
  * struct ade7759_state - device instance specific data
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
 struct ade7759_state {
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
-enum ade7759_scan {
-	ADE7759_SCAN_ACTIVE_POWER,
-	ADE7759_SCAN_CH1_CH2,
-	ADE7759_SCAN_CH1,
-	ADE7759_SCAN_CH2,
-};
-
-void ade7759_remove_trigger(struct iio_dev *indio_dev);
-int ade7759_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t ade7759_read_data_from_ring(struct device *dev,
-		struct device_attribute *attr,
-		char *buf);
-
-
-int ade7759_configure_ring(struct iio_dev *indio_dev);
-void ade7759_unconfigure_ring(struct iio_dev *indio_dev);
-
-int ade7759_initialize_ring(struct iio_ring_buffer *ring);
-void ade7759_uninitialize_ring(struct iio_ring_buffer *ring);
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void ade7759_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-static inline int ade7759_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-ade7759_read_data_from_ring(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return 0;
-}
-
-static int ade7759_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-static inline void ade7759_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-static inline int ade7759_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-static inline void ade7759_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-#endif /* CONFIG_IIO_RING_BUFFER */
 
 #endif
-- 
1.7.3.4
