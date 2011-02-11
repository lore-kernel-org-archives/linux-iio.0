Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39393 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab1BKOHf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2011 09:07:35 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/4] staging:iio:meter remove stubs from ade7854.
Date: Fri, 11 Feb 2011 14:07:43 +0000
Message-Id: <1297433263-23166-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297433263-23166-1-git-send-email-jic23@cam.ac.uk>
References: <1297433263-23166-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

General cleanup and use of standard functions to simplfy some spi reads
as well.

Also added a device id table to the spi version.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/meter/ade7854-spi.c |  120 +++++++++++++++++--------------
 drivers/staging/iio/meter/ade7854.c     |   78 +++-----------------
 drivers/staging/iio/meter/ade7854.h     |   69 ------------------
 3 files changed, 76 insertions(+), 191 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index fe58103e..84da8fb 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -22,12 +22,10 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 4,
-		}
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx,
+		.bits_per_word = 8,
+		.len = 4,
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -37,7 +35,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 	st->tx[3] = value & 0xFF;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfer, &msg);
 	ret = spi_sync(st->spi, &msg);
 	mutex_unlock(&st->buf_lock);
 
@@ -52,12 +50,10 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 5,
-		}
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx,
+		.bits_per_word = 8,
+		.len = 5,
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -68,7 +64,7 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 	st->tx[4] = value & 0xFF;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfer, &msg);
 	ret = spi_sync(st->spi, &msg);
 	mutex_unlock(&st->buf_lock);
 
@@ -83,12 +79,10 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 6,
-		}
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx,
+		.bits_per_word = 8,
+		.len = 6,
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -100,7 +94,7 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 	st->tx[5] = value & 0xFF;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfer, &msg);
 	ret = spi_sync(st->spi, &msg);
 	mutex_unlock(&st->buf_lock);
 
@@ -115,12 +109,10 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 7,
-		}
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx,
+		.bits_per_word = 8,
+		.len = 7,
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -133,7 +125,7 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 	st->tx[6] = value & 0xFF;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfer, &msg);
 	ret = spi_sync(st->spi, &msg);
 	mutex_unlock(&st->buf_lock);
 
@@ -152,8 +144,12 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 		{
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
-			.len = 4,
-		},
+			.len = 3,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 1,
+		}
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -161,17 +157,17 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 	st->tx[0] = ADE7854_READ_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = 0;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->spi, &msg);
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
 				reg_address);
 		goto error_ret;
 	}
-	*val = st->rx[3];
+	*val = st->rx[0];
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -190,26 +186,29 @@ static int ade7854_spi_read_reg_16(struct device *dev,
 		{
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
-			.len = 5,
-		},
+			.len = 3,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 2,
+		}
 	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7854_READ_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = 0;
-	st->tx[4] = 0;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->spi, &msg);
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
 				reg_address);
 		goto error_ret;
 	}
-	*val = (st->rx[3] << 8) | st->rx[4];
+	*val = be16_to_cpup((const __be16 *)st->rx);
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -228,8 +227,12 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 		{
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
-			.len = 6,
-		},
+			.len = 3,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 3,
+		}
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -237,19 +240,17 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 	st->tx[0] = ADE7854_READ_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = 0;
-	st->tx[4] = 0;
-	st->tx[5] = 0;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->spi, &msg);
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
 				reg_address);
 		goto error_ret;
 	}
-	*val = (st->rx[3] << 16) | (st->rx[4] << 8) | st->rx[5];
+	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -268,8 +269,12 @@ static int ade7854_spi_read_reg_32(struct device *dev,
 		{
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
-			.len = 7,
-		},
+			.len = 3,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 4,
+		}
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -277,20 +282,17 @@ static int ade7854_spi_read_reg_32(struct device *dev,
 	st->tx[0] = ADE7854_READ_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = 0;
-	st->tx[4] = 0;
-	st->tx[5] = 0;
-	st->tx[6] = 0;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->spi, &msg);
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
 				reg_address);
 		goto error_ret;
 	}
-	*val = (st->rx[3] << 24) | (st->rx[4] << 16) | (st->rx[5] << 8) | st->rx[6];
+	*val = be32_to_cpup((const __be32 *)st->rx);
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -333,6 +335,13 @@ static int ade7854_spi_remove(struct spi_device *spi)
 
 	return 0;
 }
+static const struct spi_device_id ade7854_id[] = {
+	{ "ade7854", 0 },
+	{ "ade7858", 0 },
+	{ "ade7868", 0 },
+	{ "ade7878", 0 },
+	{ }
+};
 
 static struct spi_driver ade7854_driver = {
 	.driver = {
@@ -341,6 +350,7 @@ static struct spi_driver ade7854_driver = {
 	},
 	.probe = ade7854_spi_probe,
 	.remove = __devexit_p(ade7854_spi_remove),
+	.id_table = ade7854_id,
 };
 
 static __init int ade7854_init(void)
@@ -356,5 +366,5 @@ static __exit void ade7854_exit(void)
 module_exit(ade7854_exit);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC SPI Driver");
+MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 SPI Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index a13d504..866e585 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -61,7 +61,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
 		char *buf)
 {
 	int ret;
-	u32 val = 0;
+	u32 val;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
@@ -70,7 +70,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u\n", val & 0xFFFFFF);
+	return sprintf(buf, "%u\n", val);
 }
 
 static ssize_t ade7854_read_32bit(struct device *dev,
@@ -178,15 +178,12 @@ static int ade7854_reset(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-
-	int ret;
 	u16 val;
 
 	st->read_reg_16(dev, ADE7854_CONFIG, &val);
 	val |= 1 << 7; /* Software Chip Reset */
-	ret = st->write_reg_16(dev, ADE7854_CONFIG, val);
 
-	return ret;
+	return st->write_reg_16(dev, ADE7854_CONFIG, val);
 }
 
 
@@ -477,14 +474,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
 
 static IIO_CONST_ATTR(name, "ade7854");
 
-static struct attribute *ade7854_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group ade7854_event_attribute_group = {
-	.attrs = ade7854_event_attributes,
-};
-
 static struct attribute *ade7854_attributes[] = {
 	&iio_dev_attr_aigain.dev_attr.attr,
 	&iio_dev_attr_bigain.dev_attr.attr,
@@ -564,7 +553,7 @@ static const struct attribute_group ade7854_attribute_group = {
 
 int ade7854_probe(struct ade7854_state *st, struct device *dev)
 {
-	int ret, regdone = 0;
+	int ret;
 
 	/* Allocate the comms buffers */
 	st->rx = kzalloc(sizeof(*st->rx)*ADE7854_MAX_RX, GFP_KERNEL);
@@ -586,71 +575,34 @@ int ade7854_probe(struct ade7854_state *st, struct device *dev)
 	}
 
 	st->indio_dev->dev.parent = dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &ade7854_event_attribute_group;
 	st->indio_dev->attrs = &ade7854_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ade7854_configure_ring(st->indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	ret = iio_device_register(st->indio_dev);
 	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
-	ret = ade7854_initialize_ring(st->indio_dev->ring);
-	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
+		goto error_free_dev;
 
-	if (st->irq) {
-		ret = iio_register_interrupt_line(st->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_FALLING,
-				"ade7854");
-		if (ret)
-			goto error_uninitialize_ring;
-
-		ret = ade7854_probe_trigger(st->indio_dev);
-		if (ret)
-			goto error_unregister_line;
-	}
 	/* Get the device into a sane initial state */
 	ret = ade7854_initial_setup(st);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_unreg_dev;
 
 	return 0;
 
-error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		ade7854_remove_trigger(st->indio_dev);
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	ade7854_uninitialize_ring(st->indio_dev->ring);
-error_unreg_ring_funcs:
-	ade7854_unconfigure_ring(st->indio_dev);
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
 	kfree(st->rx);
 error_free_st:
 	kfree(st);
-	return ret;
 
+	return ret;
 }
 EXPORT_SYMBOL(ade7854_probe);
 
@@ -658,14 +610,6 @@ int ade7854_remove(struct ade7854_state *st)
 {
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	flush_scheduled_work();
-
-	ade7854_remove_trigger(indio_dev);
-	if (st->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
-	ade7854_uninitialize_ring(indio_dev->ring);
-	ade7854_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
@@ -676,5 +620,5 @@ int ade7854_remove(struct ade7854_state *st)
 EXPORT_SYMBOL(ade7854_remove);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver");
+MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Energy Meter");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 47690e5..4ad84a3 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -147,11 +147,7 @@
 /**
  * struct ade7854_state - device instance specific data
  * @spi:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
- * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
@@ -159,10 +155,7 @@
 struct ade7854_state {
 	struct spi_device		*spi;
 	struct i2c_client               *i2c;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
 	u8				*tx;
 	u8				*rx;
 	int				(*read_reg_8) (struct device *, u16, u8 *);
@@ -180,66 +173,4 @@ struct ade7854_state {
 extern int ade7854_probe(struct ade7854_state *st, struct device *dev);
 extern int ade7854_remove(struct ade7854_state *st);
 
-#if defined(CONFIG_IIO_RING_BUFFER) && defined(THIS_HAS_RING_BUFFER_SUPPORT)
-/* At the moment triggers are only used for ring buffer
- * filling. This may change!
- */
-
-enum ade7854_scan {
-	ADE7854_SCAN_PHA_V,
-	ADE7854_SCAN_PHB_V,
-	ADE7854_SCAN_PHC_V,
-	ADE7854_SCAN_PHA_I,
-	ADE7854_SCAN_PHB_I,
-	ADE7854_SCAN_PHC_I,
-};
-
-void ade7854_remove_trigger(struct iio_dev *indio_dev);
-int ade7854_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t ade7854_read_data_from_ring(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf);
-
-
-int ade7854_configure_ring(struct iio_dev *indio_dev);
-void ade7854_unconfigure_ring(struct iio_dev *indio_dev);
-
-int ade7854_initialize_ring(struct iio_ring_buffer *ring);
-void ade7854_uninitialize_ring(struct iio_ring_buffer *ring);
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void ade7854_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-static inline int ade7854_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-ade7854_read_data_from_ring(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return 0;
-}
-
-static inline int ade7854_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void ade7854_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-static inline int ade7854_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-static inline void ade7854_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-#endif /* CONFIG_IIO_RING_BUFFER */
-
 #endif
-- 
1.7.3.4

