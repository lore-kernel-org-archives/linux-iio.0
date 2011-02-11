Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39385 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab1BKOHf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2011 09:07:35 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/4] staging:iio:meter remove stubs from ade7753.
Date: Fri, 11 Feb 2011 14:07:40 +0000
Message-Id: <1297433263-23166-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297433263-23166-1-git-send-email-jic23@cam.ac.uk>
References: <1297433263-23166-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

General cleanup and use of standard functions to simplfy some spi reads
as well.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/meter/ade7753.c |  208 ++++++++---------------------------
 drivers/staging/iio/meter/ade7753.h |   64 -----------
 2 files changed, 48 insertions(+), 224 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index e72afbd..8b86d82 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -1,5 +1,5 @@
 /*
- * ADE7753 Single-Phase Multifunction Metering IC with di/dt Sensor Interface Driver
+ * ADE7753 Single-Phase Multifunction Metering IC with di/dt Sensor Interface
  *
  * Copyright 2010 Analog Devices Inc.
  *
@@ -23,9 +23,9 @@
 #include "meter.h"
 #include "ade7753.h"
 
-int ade7753_spi_write_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 val)
+static int ade7753_spi_write_reg_8(struct device *dev,
+				   u8 reg_address,
+				   u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -46,25 +46,14 @@ static int ade7753_spi_write_reg_16(struct device *dev,
 		u16 value)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7753_WRITE_REG(reg_address);
 	st->tx[1] = (value >> 8) & 0xFF;
 	st->tx[2] = value & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_write(st->us, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -74,73 +63,40 @@ static int ade7753_spi_read_reg_8(struct device *dev,
 		u8 reg_address,
 		u8 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
-	int ret;
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
-	st->tx[0] = ADE7753_READ_REG(reg_address);
-	st->tx[1] = 0;
+	ssize_t ret;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
+	ret = spi_w8r8(st->us, ADE7753_READ_REG(reg_address));
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
 
 static int ade7753_spi_read_reg_16(struct device *dev,
 		u8 reg_address,
 		u16 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
-	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 3,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7753_READ_REG(reg_address);
-	st->tx[1] = 0;
-	st->tx[2] = 0;
+	ssize_t ret;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
+	ret = spi_w8r16(st->us, ADE7753_READ_REG(reg_address));
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
 
 static int ade7753_spi_read_reg_24(struct device *dev,
@@ -154,27 +110,28 @@ static int ade7753_spi_read_reg_24(struct device *dev,
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
-			.rx_buf = st->rx,
 			.bits_per_word = 8,
-			.len = 4,
-		},
+			.len = 1,
+		}, {
+			.rx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 3,
+		}
 	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7753_READ_REG(reg_address);
-	st->tx[1] = 0;
-	st->tx[2] = 0;
-	st->tx[3] = 0;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->us, &msg);
 	if (ret) {
 		dev_err(&st->us->dev, "problem when reading 24 bit register 0x%02X",
 				reg_address);
 		goto error_ret;
 	}
-	*val = (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -186,7 +143,7 @@ static ssize_t ade7753_read_8bit(struct device *dev,
 		char *buf)
 {
 	int ret;
-	u8 val = 0;
+	u8 val;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = ade7753_spi_read_reg_8(dev, this_attr->address, &val);
@@ -201,7 +158,7 @@ static ssize_t ade7753_read_16bit(struct device *dev,
 		char *buf)
 {
 	int ret;
-	u16 val = 0;
+	u16 val;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = ade7753_spi_read_reg_16(dev, this_attr->address, &val);
@@ -216,14 +173,14 @@ static ssize_t ade7753_read_24bit(struct device *dev,
 		char *buf)
 {
 	int ret;
-	u32 val = 0;
+	u32 val;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = ade7753_spi_read_reg_24(dev, this_attr->address, &val);
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u\n", val & 0xFFFFFF);
+	return sprintf(buf, "%u\n", val);
 }
 
 static ssize_t ade7753_write_8bit(struct device *dev,
@@ -264,17 +221,12 @@ error_ret:
 
 static int ade7753_reset(struct device *dev)
 {
-	int ret;
 	u16 val;
-	ade7753_spi_read_reg_16(dev,
-			ADE7753_MODE,
-			&val);
+
+	ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
 	val |= 1 << 6; /* Software Chip Reset */
-	ret = ade7753_spi_write_reg_16(dev,
-			ADE7753_MODE,
-			val);
 
-	return ret;
+	return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
 }
 
 static ssize_t ade7753_write_reset(struct device *dev,
@@ -401,27 +353,20 @@ static int ade7753_set_irq(struct device *dev, bool enable)
 		irqen &= ~(1 << 3);
 
 	ret = ade7753_spi_write_reg_8(dev, ADE7753_IRQEN, irqen);
-	if (ret)
-		goto error_ret;
 
 error_ret:
 	return ret;
 }
 
 /* Power down the device */
-int ade7753_stop_device(struct device *dev)
+static int ade7753_stop_device(struct device *dev)
 {
-	int ret;
 	u16 val;
-	ade7753_spi_read_reg_16(dev,
-			ADE7753_MODE,
-			&val);
+
+	ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
 	val |= 1 << 4;  /* AD converters can be turned off */
-	ret = ade7753_spi_write_reg_16(dev,
-			ADE7753_MODE,
-			val);
 
-	return ret;
+	return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
 }
 
 static int ade7753_initial_setup(struct ade7753_state *st)
@@ -454,16 +399,14 @@ static ssize_t ade7753_read_frequency(struct device *dev,
 	int ret, len = 0;
 	u8 t;
 	int sps;
-	ret = ade7753_spi_read_reg_8(dev,
-			ADE7753_MODE,
-			&t);
+	ret = ade7753_spi_read_reg_8(dev, ADE7753_MODE,	&t);
 	if (ret)
 		return ret;
 
 	t = (t >> 11) & 0x3;
 	sps = 27900 / (1 + t);
 
-	len = sprintf(buf, "%d SPS\n", sps);
+	len = sprintf(buf, "%d\n", sps);
 	return len;
 }
 
@@ -493,24 +436,21 @@ static ssize_t ade7753_write_frequency(struct device *dev,
 	else
 		st->us->max_speed_hz = ADE7753_SPI_FAST;
 
-	ret = ade7753_spi_read_reg_16(dev,
-			ADE7753_MODE,
-			&reg);
+	ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &reg);
 	if (ret)
 		goto out;
 
 	reg &= ~(3 << 11);
 	reg |= t << 11;
 
-	ret = ade7753_spi_write_reg_16(dev,
-			ADE7753_MODE,
-			reg);
+	ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
 
 out:
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
+
 static IIO_DEV_ATTR_TEMP_RAW(ade7753_read_8bit);
 static IIO_CONST_ATTR(temp_offset, "-25 C");
 static IIO_CONST_ATTR(temp_scale, "0.67 C");
@@ -525,14 +465,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
 static IIO_CONST_ATTR(name, "ade7753");
 
-static struct attribute *ade7753_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group ade7753_event_attribute_group = {
-	.attrs = ade7753_event_attributes,
-};
-
 static struct attribute *ade7753_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
@@ -607,58 +539,22 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &ade7753_event_attribute_group;
 	st->indio_dev->attrs = &ade7753_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ade7753_configure_ring(st->indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	ret = iio_device_register(st->indio_dev);
 	if (ret)
-		goto error_unreg_ring_funcs;
+		goto error_free_dev;
 	regdone = 1;
 
-	ret = ade7753_initialize_ring(st->indio_dev->ring);
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
-				"ade7753");
-		if (ret)
-			goto error_uninitialize_ring;
-
-		ret = ade7753_probe_trigger(st->indio_dev);
-		if (ret)
-			goto error_unregister_line;
-	}
-
 	/* Get the device into a sane initial state */
 	ret = ade7753_initial_setup(st);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_free_dev;
 	return 0;
 
-error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		ade7753_remove_trigger(st->indio_dev);
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	ade7753_uninitialize_ring(st->indio_dev->ring);
-error_unreg_ring_funcs:
-	ade7753_unconfigure_ring(st->indio_dev);
 error_free_dev:
 	if (regdone)
 		iio_device_unregister(st->indio_dev);
@@ -685,14 +581,6 @@ static int ade7753_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	flush_scheduled_work();
-
-	ade7753_remove_trigger(indio_dev);
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
-	ade7753_uninitialize_ring(indio_dev->ring);
-	ade7753_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
@@ -726,5 +614,5 @@ static __exit void ade7753_exit(void)
 module_exit(ade7753_exit);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADE7753/6 Single-Phase Multifunction Metering IC Driver");
+MODULE_DESCRIPTION("Analog Devices ADE7753/6 Single-Phase Multifunction Meter");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7753.h b/drivers/staging/iio/meter/ade7753.h
index a3722b8..70dabae 100644
--- a/drivers/staging/iio/meter/ade7753.h
+++ b/drivers/staging/iio/meter/ade7753.h
@@ -60,81 +60,17 @@
 /**
  * struct ade7753_state - device instance specific data
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
 struct ade7753_state {
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
-enum ade7753_scan {
-	ADE7753_SCAN_ACTIVE_POWER,
-	ADE7753_SCAN_CH1,
-	ADE7753_SCAN_CH2,
-};
-
-void ade7753_remove_trigger(struct iio_dev *indio_dev);
-int ade7753_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t ade7753_read_data_from_ring(struct device *dev,
-		struct device_attribute *attr,
-		char *buf);
-
-
-int ade7753_configure_ring(struct iio_dev *indio_dev);
-void ade7753_unconfigure_ring(struct iio_dev *indio_dev);
-
-int ade7753_initialize_ring(struct iio_ring_buffer *ring);
-void ade7753_uninitialize_ring(struct iio_ring_buffer *ring);
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void ade7753_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-static inline int ade7753_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-ade7753_read_data_from_ring(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return 0;
-}
-
-static int ade7753_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-static inline void ade7753_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-static inline int ade7753_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-static inline void ade7753_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-#endif /* CONFIG_IIO_RING_BUFFER */
 
 #endif
-- 
1.7.3.4

