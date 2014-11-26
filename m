Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/11] iio: Move buffer registration to the core
Date: Wed, 26 Nov 2014 18:55:12 +0100
Message-Id: <1417024517-7564-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1417024517-7564-1-git-send-email-lars@metafoo.de>
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Originally device and buffer registration were kept as separate operations
in IIO to allow to register two distinct sets of channels for buffered and
non-buffered operations. This has since already been further restricted and
the channel set registered for the buffer needs to be a subset of the
channel set registered for the device. Additionally the possibility to not
have a raw (or processed) attribute for a channel which was registered for
the device was added a while ago. This means it is possible to not register
any device level attributes for a channel even if it is registered for the
device. Also if a channel's scan_index is set to -1 and the channel is
registered for the buffer it is ignored.

So in summery it means it is possible to register the same channel array for
both the device and the buffer yet still end up with distinctive sets of
channels for both of them. This makes the argument for having to have to
manually register the channels for both the device and the buffer invalid.
Considering that the vast majority of all drivers want to register the same
set of channels for both the buffer and the device it makes sense to move
the buffer registration into the core to avoid some boiler-plate code in the
device driver setup path.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ti_am335x_adc.c                 |  9 ---------
 drivers/iio/iio_core.h                          |  9 +++++++++
 drivers/iio/industrialio-buffer.c               | 18 ++++++++++-------
 drivers/iio/industrialio-core.c                 | 14 ++++++++++++-
 drivers/iio/industrialio-triggered-buffer.c     |  9 ---------
 drivers/staging/iio/accel/lis3l02dq_core.c      | 13 +------------
 drivers/staging/iio/accel/sca3000_core.c        | 10 +---------
 drivers/staging/iio/iio_simple_dummy_buffer.c   |  8 --------
 drivers/staging/iio/impedance-analyzer/ad5933.c | 12 ++----------
 drivers/staging/iio/meter/ade7758.h             |  1 -
 drivers/staging/iio/meter/ade7758_core.c        | 15 ++------------
 drivers/staging/iio/meter/ade7758_ring.c        |  5 -----
 include/linux/iio/buffer.h                      | 26 -------------------------
 13 files changed, 39 insertions(+), 110 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index b730864..d550ac7 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -264,16 +264,8 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
 	indio_dev->setup_ops = setup_ops;
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
-	ret = iio_buffer_register(indio_dev,
-				  indio_dev->channels,
-				  indio_dev->num_channels);
-	if (ret)
-		goto error_free_irq;
-
 	return 0;
 
-error_free_irq:
-	free_irq(irq, indio_dev);
 error_kfifo_free:
 	iio_kfifo_free(indio_dev->buffer);
 	return ret;
@@ -285,7 +277,6 @@ static void tiadc_iio_buffered_hardware_remove(struct iio_dev *indio_dev)
 
 	free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
 	iio_kfifo_free(indio_dev->buffer);
-	iio_buffer_unregister(indio_dev);
 }
 
 
diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 5f0ea77..2631921 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -48,6 +48,8 @@ unsigned int iio_buffer_poll(struct file *filp,
 ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 				      size_t n, loff_t *f_ps);
 
+int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev);
+void iio_buffer_free_sysfs(struct iio_dev *indio_dev);
 
 #define iio_buffer_poll_addr (&iio_buffer_poll)
 #define iio_buffer_read_first_n_outer_addr (&iio_buffer_read_first_n_outer)
@@ -60,6 +62,13 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
 #define iio_buffer_poll_addr NULL
 #define iio_buffer_read_first_n_outer_addr NULL
 
+static inline int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void iio_buffer_free_sysfs(struct iio_dev *indio_dev) {}
+
 static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
 static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f667e4e..e1906ad 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -385,14 +385,16 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 
 static const char * const iio_scan_elements_group_name = "scan_elements";
 
-int iio_buffer_register(struct iio_dev *indio_dev,
-			const struct iio_chan_spec *channels,
-			int num_channels)
+int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p;
 	struct attribute **attr;
 	struct iio_buffer *buffer = indio_dev->buffer;
 	int ret, i, attrn, attrcount, attrcount_orig = 0;
+	const struct iio_chan_spec *channels;
+
+	if (!buffer)
+		return 0;
 
 	if (buffer->attrs)
 		indio_dev->groups[indio_dev->groupcounter++] = buffer->attrs;
@@ -404,9 +406,10 @@ int iio_buffer_register(struct iio_dev *indio_dev,
 	}
 	attrcount = attrcount_orig;
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
+	channels = indio_dev->channels;
 	if (channels) {
 		/* new magic */
-		for (i = 0; i < num_channels; i++) {
+		for (i = 0; i < indio_dev->num_channels; i++) {
 			if (channels[i].scan_index < 0)
 				continue;
 
@@ -463,15 +466,16 @@ error_cleanup_dynamic:
 
 	return ret;
 }
-EXPORT_SYMBOL(iio_buffer_register);
 
-void iio_buffer_unregister(struct iio_dev *indio_dev)
+void iio_buffer_free_sysfs(struct iio_dev *indio_dev)
 {
+	if (!indio_dev->buffer)
+		return;
+
 	kfree(indio_dev->buffer->scan_mask);
 	kfree(indio_dev->buffer->scan_el_group.attrs);
 	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
 }
-EXPORT_SYMBOL(iio_buffer_unregister);
 
 ssize_t iio_buffer_read_length(struct device *dev,
 			       struct device_attribute *attr,
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 45bb3a4..0e596b4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1158,11 +1158,19 @@ int iio_device_register(struct iio_dev *indio_dev)
 			"Failed to register debugfs interfaces\n");
 		return ret;
 	}
+
+	ret = iio_buffer_alloc_sysfs(indio_dev);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+			"Failed to create buffer sysfs interfaces\n");
+		goto error_unreg_debugfs;
+	}
+
 	ret = iio_device_register_sysfs(indio_dev);
 	if (ret) {
 		dev_err(indio_dev->dev.parent,
 			"Failed to register sysfs interfaces\n");
-		goto error_unreg_debugfs;
+		goto error_buffer_free_sysfs;
 	}
 	ret = iio_device_register_eventset(indio_dev);
 	if (ret) {
@@ -1195,6 +1203,8 @@ error_unreg_eventset:
 	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
 	iio_device_unregister_sysfs(indio_dev);
+error_buffer_free_sysfs:
+	iio_buffer_free_sysfs(indio_dev);
 error_unreg_debugfs:
 	iio_device_unregister_debugfs(indio_dev);
 	return ret;
@@ -1223,6 +1233,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	iio_buffer_wakeup_poll(indio_dev);
 
 	mutex_unlock(&indio_dev->info_exist_lock);
+
+	iio_buffer_free_sysfs(indio_dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
 
diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
index d6f54930..ac97685 100644
--- a/drivers/iio/industrialio-triggered-buffer.c
+++ b/drivers/iio/industrialio-triggered-buffer.c
@@ -78,16 +78,8 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
-	ret = iio_buffer_register(indio_dev,
-				  indio_dev->channels,
-				  indio_dev->num_channels);
-	if (ret)
-		goto error_dealloc_pollfunc;
-
 	return 0;
 
-error_dealloc_pollfunc:
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
 error_kfifo_free:
 	iio_kfifo_free(indio_dev->buffer);
 error_ret:
@@ -101,7 +93,6 @@ EXPORT_SYMBOL(iio_triggered_buffer_setup);
  */
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev)
 {
-	iio_buffer_unregister(indio_dev);
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_kfifo_free(indio_dev->buffer);
 }
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index f5e145c..b78c9c5 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -716,14 +716,6 @@ static int lis3l02dq_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_buffer_register(indio_dev,
-				  lis3l02dq_channels,
-				  ARRAY_SIZE(lis3l02dq_channels));
-	if (ret) {
-		dev_err(&spi->dev, "failed to initialize the buffer\n");
-		goto error_unreg_buffer_funcs;
-	}
-
 	if (spi->irq) {
 		ret = request_threaded_irq(st->us->irq,
 					   &lis3l02dq_th,
@@ -732,7 +724,7 @@ static int lis3l02dq_probe(struct spi_device *spi)
 					   "lis3l02dq",
 					   indio_dev);
 		if (ret)
-			goto error_uninitialize_buffer;
+			goto error_unreg_buffer_funcs;
 
 		ret = lis3l02dq_probe_trigger(indio_dev);
 		if (ret)
@@ -756,8 +748,6 @@ error_remove_trigger:
 error_free_interrupt:
 	if (spi->irq)
 		free_irq(st->us->irq, indio_dev);
-error_uninitialize_buffer:
-	iio_buffer_unregister(indio_dev);
 error_unreg_buffer_funcs:
 	lis3l02dq_unconfigure_buffer(indio_dev);
 	return ret;
@@ -804,7 +794,6 @@ static int lis3l02dq_remove(struct spi_device *spi)
 		free_irq(st->us->irq, indio_dev);
 
 	lis3l02dq_remove_trigger(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	lis3l02dq_unconfigure_buffer(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 9eedb93..ba6d5ee 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1155,11 +1155,6 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	ret = iio_buffer_register(indio_dev, indio_dev->channels,
-		indio_dev->num_channels);
-	if (ret < 0)
-		goto error_unregister_dev;
-
 	if (spi->irq) {
 		ret = request_threaded_irq(spi->irq,
 					   NULL,
@@ -1168,7 +1163,7 @@ static int sca3000_probe(struct spi_device *spi)
 					   "sca3000",
 					   indio_dev);
 		if (ret)
-			goto error_unregister_ring;
+			goto error_unregister_dev;
 	}
 	sca3000_register_ring_funcs(indio_dev);
 	ret = sca3000_clean_setup(st);
@@ -1179,8 +1174,6 @@ static int sca3000_probe(struct spi_device *spi)
 error_free_irq:
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
-error_unregister_ring:
-	iio_buffer_unregister(indio_dev);
 error_unregister_dev:
 	iio_device_unregister(indio_dev);
 	return ret;
@@ -1214,7 +1207,6 @@ static int sca3000_remove(struct spi_device *spi)
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	sca3000_unconfigure_ring(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 35d60d5..a2d72c1 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -172,15 +172,8 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 	 */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
-	ret = iio_buffer_register(indio_dev, indio_dev->channels,
-				  indio_dev->num_channels);
-	if (ret)
-		goto error_dealloc_pollfunc;
-
 	return 0;
 
-error_dealloc_pollfunc:
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
 error_free_buffer:
 	iio_kfifo_free(indio_dev->buffer);
 error_ret:
@@ -194,7 +187,6 @@ error_ret:
  */
 void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
 {
-	iio_buffer_unregister(indio_dev);
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_kfifo_free(indio_dev->buffer);
 }
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index aa6a368..c50b138 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -752,23 +752,16 @@ static int ad5933_probe(struct i2c_client *client,
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_buffer_register(indio_dev, ad5933_channels,
-		ARRAY_SIZE(ad5933_channels));
-	if (ret)
-		goto error_unreg_ring;
-
 	ret = ad5933_setup(st);
 	if (ret)
-		goto error_uninitialize_ring;
+		goto error_unreg_ring;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_uninitialize_ring;
+		goto error_unreg_ring;
 
 	return 0;
 
-error_uninitialize_ring:
-	iio_buffer_unregister(indio_dev);
 error_unreg_ring:
 	iio_kfifo_free(indio_dev->buffer);
 error_disable_reg:
@@ -784,7 +777,6 @@ static int ad5933_remove(struct i2c_client *client)
 	struct ad5933_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_buffer_unregister(indio_dev);
 	iio_kfifo_free(indio_dev->buffer);
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index 0731820..762d7dc 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -146,7 +146,6 @@ ssize_t ade7758_read_data_from_ring(struct device *dev,
 int ade7758_configure_ring(struct iio_dev *indio_dev);
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev);
 
-void ade7758_uninitialize_ring(struct iio_dev *indio_dev);
 int ade7758_set_irq(struct device *dev, bool enable);
 
 int ade7758_spi_write_reg_8(struct device *dev,
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index abc6006..6e8b011 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -885,23 +885,15 @@ static int ade7758_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_tx;
 
-	ret = iio_buffer_register(indio_dev,
-				  &ade7758_channels[0],
-				  ARRAY_SIZE(ade7758_channels));
-	if (ret) {
-		dev_err(&spi->dev, "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
-
 	/* Get the device into a sane initial state */
 	ret = ade7758_initial_setup(indio_dev);
 	if (ret)
-		goto error_uninitialize_ring;
+		goto error_unreg_ring_funcs;
 
 	if (spi->irq) {
 		ret = ade7758_probe_trigger(indio_dev);
 		if (ret)
-			goto error_uninitialize_ring;
+			goto error_unreg_ring_funcs;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -913,8 +905,6 @@ static int ade7758_probe(struct spi_device *spi)
 error_remove_trigger:
 	if (spi->irq)
 		ade7758_remove_trigger(indio_dev);
-error_uninitialize_ring:
-	ade7758_uninitialize_ring(indio_dev);
 error_unreg_ring_funcs:
 	ade7758_unconfigure_ring(indio_dev);
 error_free_tx:
@@ -932,7 +922,6 @@ static int ade7758_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	ade7758_stop_device(&indio_dev->dev);
 	ade7758_remove_trigger(indio_dev);
-	ade7758_uninitialize_ring(indio_dev);
 	ade7758_unconfigure_ring(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index c0accf8..27c3ed6 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -181,8 +181,3 @@ error_iio_kfifo_free:
 	iio_kfifo_free(indio_dev->buffer);
 	return ret;
 }
-
-void ade7758_uninitialize_ring(struct iio_dev *indio_dev)
-{
-	iio_buffer_unregister(indio_dev);
-}
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 8c8ce61..b0e006c 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -151,22 +151,6 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 int iio_update_demux(struct iio_dev *indio_dev);
 
 /**
- * iio_buffer_register() - register the buffer with IIO core
- * @indio_dev:		device with the buffer to be registered
- * @channels:		the channel descriptions used to construct buffer
- * @num_channels:	the number of channels
- **/
-int iio_buffer_register(struct iio_dev *indio_dev,
-			const struct iio_chan_spec *channels,
-			int num_channels);
-
-/**
- * iio_buffer_unregister() - unregister the buffer from IIO core
- * @indio_dev:		the device with the buffer to be unregistered
- **/
-void iio_buffer_unregister(struct iio_dev *indio_dev);
-
-/**
  * iio_buffer_read_length() - attr func to get number of datums in the buffer
  **/
 ssize_t iio_buffer_read_length(struct device *dev,
@@ -223,16 +207,6 @@ static inline void iio_device_attach_buffer(struct iio_dev *indio_dev,
 
 #else /* CONFIG_IIO_BUFFER */
 
-static inline int iio_buffer_register(struct iio_dev *indio_dev,
-					   const struct iio_chan_spec *channels,
-					   int num_channels)
-{
-	return 0;
-}
-
-static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
-{}
-
 static inline void iio_buffer_get(struct iio_buffer *buffer) {}
 static inline void iio_buffer_put(struct iio_buffer *buffer) {}
 
-- 
1.8.0
