Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35391 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756584AbcJHQjd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:33 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/18] staging:iio:accel:sca3000 move to hybrid hard / soft buffer design.
Date: Sat,  8 Oct 2016 17:39:06 +0100
Message-Id: <20161008163918.18758-7-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In a similar fashion to other newer drivers (e.g. ti_am335x), instead
of using the hardware buffer support in IIO to directly access the hardware
fifo, insert a software fifo and feed that from the hardware one when
interrupts occur.  This gives a simpler structure to the data flows and
allows more flexibility over how often data is shipped to userspace etc.

This was also the only direct user of the simplistic generalization found
in ring_hw.h so that header is removed.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/Kconfig   |   3 +-
 drivers/staging/iio/accel/sca3000.c | 256 ++++++++++--------------------------
 drivers/staging/iio/ring_hw.h       |  27 ----
 3 files changed, 72 insertions(+), 214 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 1c994b57c7d2..53389bfdd100 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -52,7 +52,8 @@ config ADIS16240
 	  called adis16240.
 
 config SCA3000
-	depends on IIO_BUFFER
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	depends on SPI
 	tristate "VTI SCA3000 series accelerometers"
 	help
diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index 173e9a69d44f..f9ab7b3f8e87 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -23,7 +23,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
-#include "../ring_hw.h"
+#include <linux/iio/kfifo_buf.h>
 
 #define SCA3000_WRITE_REG(a) (((a) << 2) | 0x02)
 #define SCA3000_READ_REG(a) ((a) << 2)
@@ -173,7 +173,7 @@ struct sca3000_state {
 	struct mutex			lock;
 	int				bpse;
 	/* Can these share a cacheline ? */
-	u8				rx[2] ____cacheline_aligned;
+	u8				rx[384] ____cacheline_aligned;
 	u8				tx[6] ____cacheline_aligned;
 };
 
@@ -572,6 +572,10 @@ static const struct iio_event_spec sca3000_event = {
 	.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
 };
 
+/*
+ * Note the hack in the number of bits to pretend we have 2 more than
+ * we do in the fifo.
+ */
 #define SCA3000_CHAN(index, mod)				\
 	{							\
 		.type = IIO_ACCEL,				\
@@ -584,9 +588,10 @@ static const struct iio_event_spec sca3000_event = {
 		.scan_index = index,				\
 		.scan_type = {					\
 			.sign = 's',				\
-			.realbits = 11,				\
+			.realbits = 13,				\
 			.storagebits = 16,			\
-			.shift = 5,				\
+			.shift = 3,				\
+			.endianness = IIO_BE,			\
 		},						\
 		.event_spec = &sca3000_event,			\
 		.num_event_specs = 1,				\
@@ -935,19 +940,71 @@ static const struct attribute_group sca3000_attribute_group = {
 	.attrs = sca3000_attributes,
 };
 
+static int sca3000_read_data(struct sca3000_state *st,
+			     u8 reg_address_high,
+			     u8 *rx,
+			     int len)
+{
+	int ret;
+	struct spi_transfer xfer[2] = {
+		{
+			.len = 1,
+			.tx_buf = st->tx,
+		}, {
+			.len = len,
+			.rx_buf = rx,
+		}
+	};
+
+	st->tx[0] = SCA3000_READ_REG(reg_address_high);
+	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
+	if (ret) {
+		dev_err(get_device(&st->us->dev), "problem reading register");
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * sca3000_ring_int_process() ring specific interrupt handling.
  *
  * This is only split from the main interrupt handler so as to
  * reduce the amount of code if the ring buffer is not enabled.
  **/
-static void sca3000_ring_int_process(u8 val, struct iio_buffer *ring)
+static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 {
-	if (val & (SCA3000_INT_STATUS_THREE_QUARTERS |
-		   SCA3000_INT_STATUS_HALF)) {
-		ring->stufftoread = true;
-		wake_up_interruptible(&ring->pollq);
+	struct sca3000_state *st = iio_priv(indio_dev);
+	int ret, i, num_available;
+
+	mutex_lock(&st->lock);
+	if (val & SCA3000_INT_STATUS_HALF) {
+		ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_BUF_COUNT,
+					      1);
+		if (ret)
+			goto error_ret;
+		num_available = st->rx[0];
+		/*
+		 * num_available is the total number of samples available
+		 * i.e. number of time points * number of channels.
+		 */
+		ret = sca3000_read_data(st, SCA3000_REG_ADDR_RING_OUT, st->rx,
+					num_available * 2);
+		if (ret)
+			goto error_ret;
+		for (i = 0; i < num_available / 3; i++) {
+			/*
+			 * Dirty hack to cover for 11 bit in fifo, 13 bit
+			 * direct reading.
+			 *
+			 * In theory the bottom two bits are undefined.
+			 * In reality they appear to always be 0.
+			 */
+			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
+		}
 	}
+error_ret:
+	mutex_unlock(&st->lock);
 }
 
 /**
@@ -978,7 +1035,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	if (ret)
 		goto done;
 
-	sca3000_ring_int_process(val, indio_dev->buffer);
+	sca3000_ring_int_process(val, indio_dev);
 
 	if (val & SCA3000_INT_STATUS_FREE_FALL)
 		iio_push_event(indio_dev,
@@ -1209,183 +1266,23 @@ static struct attribute_group sca3000_event_attribute_group = {
 	.name = "events",
 };
 
-static int sca3000_read_data(struct sca3000_state *st,
-			     u8 reg_address_high,
-			     u8 **rx_p,
-			     int len)
-{
-	int ret;
-	struct spi_transfer xfer[2] = {
-		{
-			.len = 1,
-			.tx_buf = st->tx,
-		}, {
-			.len = len,
-		}
-	};
-	*rx_p = kmalloc(len, GFP_KERNEL);
-	if (!*rx_p) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	xfer[1].rx_buf = *rx_p;
-	st->tx[0] = SCA3000_READ_REG(reg_address_high);
-	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
-	if (ret) {
-		dev_err(get_device(&st->us->dev), "problem reading register");
-		goto error_free_rx;
-	}
-
-	return 0;
-error_free_rx:
-	kfree(*rx_p);
-error_ret:
-	return ret;
-}
-
-/**
- * sca3000_read_first_n_hw_rb() - main ring access, pulls data from ring
- * @r:			the ring
- * @count:		number of samples to try and pull
- * @data:		output the actual samples pulled from the hw ring
- *
- * Currently does not provide timestamps.  As the hardware doesn't add them they
- * can only be inferred approximately from ring buffer events such as 50% full
- * and knowledge of when buffer was last emptied.  This is left to userspace.
- **/
-static int sca3000_read_first_n_hw_rb(struct iio_buffer *r,
-				      size_t count, char __user *buf)
-{
-	struct iio_hw_buffer *hw_ring = iio_to_hw_buf(r);
-	struct iio_dev *indio_dev = hw_ring->private;
-	struct sca3000_state *st = iio_priv(indio_dev);
-	u8 *rx;
-	int ret, i, num_available, num_read = 0;
-	int bytes_per_sample = 1;
-
-	if (st->bpse == 11)
-		bytes_per_sample = 2;
-
-	mutex_lock(&st->lock);
-	if (count % bytes_per_sample) {
-		ret = -EINVAL;
-		goto error_ret;
-	}
-
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_BUF_COUNT, 1);
-	if (ret)
-		goto error_ret;
-	num_available = st->rx[0];
-	/*
-	 * num_available is the total number of samples available
-	 * i.e. number of time points * number of channels.
-	 */
-	if (count > num_available * bytes_per_sample)
-		num_read = num_available * bytes_per_sample;
-	else
-		num_read = count;
-
-	ret = sca3000_read_data(st,
-				SCA3000_REG_ADDR_RING_OUT,
-				&rx, num_read);
-	if (ret)
-		goto error_ret;
-
-	for (i = 0; i < num_read / sizeof(u16); i++)
-		*(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
-
-	if (copy_to_user(buf, rx, num_read))
-		ret = -EFAULT;
-	kfree(rx);
-	r->stufftoread = 0;
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : num_read;
-}
-
-static size_t sca3000_ring_buf_data_available(struct iio_buffer *r)
-{
-	return r->stufftoread ? r->watermark : 0;
-}
-
-static ssize_t sca3000_show_buffer_scale(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-
-	return sprintf(buf, "0.%06d\n", 4 * st->info->scale);
-}
-
-static IIO_DEVICE_ATTR(in_accel_scale,
-		       S_IRUGO,
-		       sca3000_show_buffer_scale,
-		       NULL,
-		       0);
-
-/*
- * Ring buffer attributes
- * This device is a bit unusual in that the sampling frequency and bpse
- * only apply to the ring buffer.  At all times full rate and accuracy
- * is available via direct reading from registers.
- */
-static const struct attribute *sca3000_ring_attributes[] = {
-	&iio_dev_attr_in_accel_scale.dev_attr.attr,
-	NULL,
-};
-
-static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buf;
-	struct iio_hw_buffer *ring;
-
-	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
-	if (!ring)
-		return NULL;
-
-	ring->private = indio_dev;
-	buf = &ring->buf;
-	buf->stufftoread = 0;
-	buf->length = 64;
-	buf->attrs = sca3000_ring_attributes;
-	iio_buffer_init(buf);
-
-	return buf;
-}
-
-static void sca3000_ring_release(struct iio_buffer *r)
-{
-	kfree(iio_to_hw_buf(r));
-}
-
-static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
-	.read_first_n = &sca3000_read_first_n_hw_rb,
-	.data_available = sca3000_ring_buf_data_available,
-	.release = sca3000_ring_release,
-
-	.modes = INDIO_BUFFER_HARDWARE,
-};
-
 static int sca3000_configure_ring(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer;
 
-	buffer = sca3000_rb_allocate(indio_dev);
+	buffer = iio_kfifo_allocate();
 	if (!buffer)
 		return -ENOMEM;
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
-	buffer->access = &sca3000_ring_access_funcs;
 	iio_device_attach_buffer(indio_dev, buffer);
+	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
 
 	return 0;
 }
 
 static void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	iio_buffer_put(indio_dev->buffer);
+	iio_kfifo_free(indio_dev->buffer);
 }
 
 static inline
@@ -1425,19 +1322,6 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	/*
-	 * Set stuff to read to indicate no data present.
-	 * Need for cases where the interrupt had fired at the
-	 * end of a cycle, but the data was never read.
-	 */
-	indio_dev->buffer->stufftoread = 0;
-	/*
-	 * Needed to ensure the core will actually read data
-	 * from the device rather than assuming no channels
-	 * are enabled.
-	 */
-	indio_dev->buffer->bytes_per_datum = 6;
-
 	mutex_lock(&st->lock);
 
 	/* Enable the 50% full interrupt */
diff --git a/drivers/staging/iio/ring_hw.h b/drivers/staging/iio/ring_hw.h
deleted file mode 100644
index 75bf47bfee78..000000000000
--- a/drivers/staging/iio/ring_hw.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * ring_hw.h - common functionality for iio hardware ring buffers
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * Copyright (c) 2009 Jonathan Cameron <jic23@kernel.org>
- *
- */
-
-#ifndef _RING_HW_H_
-#define _RING_HW_H_
-
-/**
- * struct iio_hw_ring_buffer- hardware ring buffer
- * @buf:	generic ring buffer elements
- * @private:	device specific data
- */
-struct iio_hw_buffer {
-	struct iio_buffer buf;
-	void *private;
-};
-
-#define iio_to_hw_buf(r) container_of(r, struct iio_hw_buffer, buf)
-
-#endif /* _RING_HW_H_ */
-- 
2.10.0

