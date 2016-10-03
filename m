Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58368 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbcJCT1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 15:27:11 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/18] staging:iio:accel:sca3000 merge files into one.
Date: Mon,  3 Oct 2016 20:26:46 +0100
Message-Id: <20161003192702.24361-3-jic23@kernel.org>
In-Reply-To: <20161003192702.24361-1-jic23@kernel.org>
References: <20161003192702.24361-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In the early days of IIO we were much more inclined to keep the impact
of the core IIO elements to the minimum.  As time has moved on it has
become clear that hardly any builds are done without buffer support
and that it adds considerable complexity to the drivers.

Hence merge down the buffer and non buffer elements of the sca3000 driver
also allowing us to drop the header file used for the interfaces between
the two.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/Makefile                 |   3 +-
 .../iio/accel/{sca3000_core.c => sca3000.c}        | 498 ++++++++++++++++++++-
 drivers/staging/iio/accel/sca3000.h                | 279 ------------
 drivers/staging/iio/accel/sca3000_ring.c           | 350 ---------------
 4 files changed, 496 insertions(+), 634 deletions(-)

diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 1810a434a755..6ab95708e696 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -14,5 +14,4 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
 adis16240-y             := adis16240_core.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
 
-sca3000-y		:= sca3000_core.o sca3000_ring.o
-obj-$(CONFIG_SCA3000)	+= sca3000.o
+obj-$(CONFIG_SCA3000)	:= sca3000.o
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000.c
similarity index 69%
rename from drivers/staging/iio/accel/sca3000_core.c
rename to drivers/staging/iio/accel/sca3000.c
index 564b36d4f648..62ab1aef2528 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -18,12 +18,189 @@
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
+#include <linux/uaccess.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
+#include "../ring_hw.h"
 
-#include "sca3000.h"
+#define SCA3000_WRITE_REG(a) (((a) << 2) | 0x02)
+#define SCA3000_READ_REG(a) ((a) << 2)
+
+#define SCA3000_REG_ADDR_REVID			0x00
+#define SCA3000_REVID_MAJOR_MASK		0xf0
+#define SCA3000_REVID_MINOR_MASK		0x0f
+
+#define SCA3000_REG_ADDR_STATUS			0x02
+#define SCA3000_LOCKED				0x20
+#define SCA3000_EEPROM_CS_ERROR			0x02
+#define SCA3000_SPI_FRAME_ERROR			0x01
+
+/* All reads done using register decrement so no need to directly access LSBs */
+#define SCA3000_REG_ADDR_X_MSB			0x05
+#define SCA3000_REG_ADDR_Y_MSB			0x07
+#define SCA3000_REG_ADDR_Z_MSB			0x09
+
+#define SCA3000_REG_ADDR_RING_OUT		0x0f
+
+/* Temp read untested - the e05 doesn't have the sensor */
+#define SCA3000_REG_ADDR_TEMP_MSB		0x13
+
+#define SCA3000_REG_ADDR_MODE			0x14
+#define SCA3000_MODE_PROT_MASK			0x28
+
+#define SCA3000_RING_BUF_ENABLE			0x80
+#define SCA3000_RING_BUF_8BIT			0x40
+/*
+ * Free fall detection triggers an interrupt if the acceleration
+ * is below a threshold for equivalent of 25cm drop
+ */
+#define SCA3000_FREE_FALL_DETECT		0x10
+#define SCA3000_MEAS_MODE_NORMAL		0x00
+#define SCA3000_MEAS_MODE_OP_1			0x01
+#define SCA3000_MEAS_MODE_OP_2			0x02
+
+/*
+ * In motion detection mode the accelerations are band pass filtered
+ * (approx 1 - 25Hz) and then a programmable threshold used to trigger
+ * and interrupt.
+ */
+#define SCA3000_MEAS_MODE_MOT_DET		0x03
+
+#define SCA3000_REG_ADDR_BUF_COUNT		0x15
+
+#define SCA3000_REG_ADDR_INT_STATUS		0x16
+
+#define SCA3000_INT_STATUS_THREE_QUARTERS	0x80
+#define SCA3000_INT_STATUS_HALF			0x40
+
+#define SCA3000_INT_STATUS_FREE_FALL		0x08
+#define SCA3000_INT_STATUS_Y_TRIGGER		0x04
+#define SCA3000_INT_STATUS_X_TRIGGER		0x02
+#define SCA3000_INT_STATUS_Z_TRIGGER		0x01
+
+/* Used to allow access to multiplexed registers */
+#define SCA3000_REG_ADDR_CTRL_SEL		0x18
+/* Only available for SCA3000-D03 and SCA3000-D01 */
+#define SCA3000_REG_CTRL_SEL_I2C_DISABLE	0x01
+#define SCA3000_REG_CTRL_SEL_MD_CTRL		0x02
+#define SCA3000_REG_CTRL_SEL_MD_Y_TH		0x03
+#define SCA3000_REG_CTRL_SEL_MD_X_TH		0x04
+#define SCA3000_REG_CTRL_SEL_MD_Z_TH		0x05
+/*
+ * BE VERY CAREFUL WITH THIS, IF 3 BITS ARE NOT SET the device
+ * will not function
+ */
+#define SCA3000_REG_CTRL_SEL_OUT_CTRL		0x0B
+#define SCA3000_OUT_CTRL_PROT_MASK		0xE0
+#define SCA3000_OUT_CTRL_BUF_X_EN		0x10
+#define SCA3000_OUT_CTRL_BUF_Y_EN		0x08
+#define SCA3000_OUT_CTRL_BUF_Z_EN		0x04
+#define SCA3000_OUT_CTRL_BUF_DIV_MASK		0x03
+#define SCA3000_OUT_CTRL_BUF_DIV_4		0x02
+#define SCA3000_OUT_CTRL_BUF_DIV_2		0x01
+
+/*
+ * Control which motion detector interrupts are on.
+ * For now only OR combinations are supported.
+ */
+#define SCA3000_MD_CTRL_PROT_MASK		0xC0
+#define SCA3000_MD_CTRL_OR_Y			0x01
+#define SCA3000_MD_CTRL_OR_X			0x02
+#define SCA3000_MD_CTRL_OR_Z			0x04
+/* Currently unsupported */
+#define SCA3000_MD_CTRL_AND_Y			0x08
+#define SCA3000_MD_CTRL_AND_X			0x10
+#define SAC3000_MD_CTRL_AND_Z			0x20
+
+/*
+ * Some control registers of complex access methods requiring this register to
+ * be used to remove a lock.
+ */
+#define SCA3000_REG_ADDR_UNLOCK			0x1e
+
+#define SCA3000_REG_ADDR_INT_MASK		0x21
+#define SCA3000_INT_MASK_PROT_MASK		0x1C
+
+#define SCA3000_INT_MASK_RING_THREE_QUARTER	0x80
+#define SCA3000_INT_MASK_RING_HALF		0x40
+
+#define SCA3000_INT_MASK_ALL_INTS		0x02
+#define SCA3000_INT_MASK_ACTIVE_HIGH		0x01
+#define SCA3000_INT_MASK_ACTIVE_LOW		0x00
+
+/* Values of multiplexed registers (write to ctrl_data after select) */
+#define SCA3000_REG_ADDR_CTRL_DATA		0x22
+
+/*
+ * Measurement modes available on some sca3000 series chips. Code assumes others
+ * may become available in the future.
+ *
+ * Bypass - Bypass the low-pass filter in the signal channel so as to increase
+ *          signal bandwidth.
+ *
+ * Narrow - Narrow low-pass filtering of the signal channel and half output
+ *          data rate by decimation.
+ *
+ * Wide - Widen low-pass filtering of signal channel to increase bandwidth
+ */
+#define SCA3000_OP_MODE_BYPASS			0x01
+#define SCA3000_OP_MODE_NARROW			0x02
+#define SCA3000_OP_MODE_WIDE			0x04
+#define SCA3000_MAX_TX 6
+#define SCA3000_MAX_RX 2
+
+/**
+ * struct sca3000_state - device instance state information
+ * @us:			the associated spi device
+ * @info:			chip variant information
+ * @interrupt_handler_ws:	event interrupt handler for all events
+ * @last_timestamp:		the timestamp of the last event
+ * @mo_det_use_count:		reference counter for the motion detection unit
+ * @lock:			lock used to protect elements of sca3000_state
+ *				and the underlying device state.
+ * @bpse:			number of bits per scan element
+ * @tx:			dma-able transmit buffer
+ * @rx:			dma-able receive buffer
+ **/
+struct sca3000_state {
+	struct spi_device		*us;
+	const struct sca3000_chip_info	*info;
+	struct work_struct		interrupt_handler_ws;
+	s64				last_timestamp;
+	int				mo_det_use_count;
+	struct mutex			lock;
+	int				bpse;
+	/* Can these share a cacheline ? */
+	u8				rx[2] ____cacheline_aligned;
+	u8				tx[6] ____cacheline_aligned;
+};
+
+/**
+ * struct sca3000_chip_info - model dependent parameters
+ * @scale:			scale * 10^-6
+ * @temp_output:		some devices have temperature sensors.
+ * @measurement_mode_freq:	normal mode sampling frequency
+ * @option_mode_1:		first optional mode. Not all models have one
+ * @option_mode_1_freq:		option mode 1 sampling frequency
+ * @option_mode_2:		second optional mode. Not all chips have one
+ * @option_mode_2_freq:		option mode 2 sampling frequency
+ *
+ * This structure is used to hold information about the functionality of a given
+ * sca3000 variant.
+ **/
+struct sca3000_chip_info {
+	unsigned int		scale;
+	bool			temp_output;
+	int			measurement_mode_freq;
+	int			option_mode_1;
+	int			option_mode_1_freq;
+	int			option_mode_2;
+	int			option_mode_2_freq;
+	int			mot_det_mult_xz[6];
+	int			mot_det_mult_y[7];
+};
 
 enum sca3000_variant {
 	d01,
@@ -80,14 +257,14 @@ static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
 	},
 };
 
-int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
+static int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
 {
 	st->tx[0] = SCA3000_WRITE_REG(address);
 	st->tx[1] = val;
 	return spi_write(st->us, st->tx, 2);
 }
 
-int sca3000_read_data_short(struct sca3000_state *st,
+static int sca3000_read_data_short(struct sca3000_state *st,
 			    u8 reg_address_high,
 			    int len)
 {
@@ -759,6 +936,21 @@ static const struct attribute_group sca3000_attribute_group = {
 };
 
 /**
+ * sca3000_ring_int_process() ring specific interrupt handling.
+ *
+ * This is only split from the main interrupt handler so as to
+ * reduce the amount of code if the ring buffer is not enabled.
+ **/
+static void sca3000_ring_int_process(u8 val, struct iio_buffer *ring)
+{
+	if (val & (SCA3000_INT_STATUS_THREE_QUARTERS |
+		   SCA3000_INT_STATUS_HALF)) {
+		ring->stufftoread = true;
+		wake_up_interruptible(&ring->pollq);
+	}
+}
+
+/**
  * sca3000_event_handler() - handling ring and non ring events
  *
  * Ring related interrupt handler. Depending on event, push to
@@ -1017,6 +1209,306 @@ static struct attribute_group sca3000_event_attribute_group = {
 	.name = "events",
 };
 
+static int sca3000_read_data(struct sca3000_state *st,
+			     u8 reg_address_high,
+			     u8 **rx_p,
+			     int len)
+{
+	int ret;
+	struct spi_transfer xfer[2] = {
+		{
+			.len = 1,
+			.tx_buf = st->tx,
+		}, {
+			.len = len,
+		}
+	};
+	*rx_p = kmalloc(len, GFP_KERNEL);
+	if (!*rx_p) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	xfer[1].rx_buf = *rx_p;
+	st->tx[0] = SCA3000_READ_REG(reg_address_high);
+	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
+	if (ret) {
+		dev_err(get_device(&st->us->dev), "problem reading register");
+		goto error_free_rx;
+	}
+
+	return 0;
+error_free_rx:
+	kfree(*rx_p);
+error_ret:
+	return ret;
+}
+
+/**
+ * sca3000_read_first_n_hw_rb() - main ring access, pulls data from ring
+ * @r:			the ring
+ * @count:		number of samples to try and pull
+ * @data:		output the actual samples pulled from the hw ring
+ *
+ * Currently does not provide timestamps.  As the hardware doesn't add them they
+ * can only be inferred approximately from ring buffer events such as 50% full
+ * and knowledge of when buffer was last emptied.  This is left to userspace.
+ **/
+static int sca3000_read_first_n_hw_rb(struct iio_buffer *r,
+				      size_t count, char __user *buf)
+{
+	struct iio_hw_buffer *hw_ring = iio_to_hw_buf(r);
+	struct iio_dev *indio_dev = hw_ring->private;
+	struct sca3000_state *st = iio_priv(indio_dev);
+	u8 *rx;
+	int ret, i, num_available, num_read = 0;
+	int bytes_per_sample = 1;
+
+	if (st->bpse == 11)
+		bytes_per_sample = 2;
+
+	mutex_lock(&st->lock);
+	if (count % bytes_per_sample) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_BUF_COUNT, 1);
+	if (ret)
+		goto error_ret;
+	num_available = st->rx[0];
+	/*
+	 * num_available is the total number of samples available
+	 * i.e. number of time points * number of channels.
+	 */
+	if (count > num_available * bytes_per_sample)
+		num_read = num_available * bytes_per_sample;
+	else
+		num_read = count;
+
+	ret = sca3000_read_data(st,
+				SCA3000_REG_ADDR_RING_OUT,
+				&rx, num_read);
+	if (ret)
+		goto error_ret;
+
+	for (i = 0; i < num_read / sizeof(u16); i++)
+		*(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
+
+	if (copy_to_user(buf, rx, num_read))
+		ret = -EFAULT;
+	kfree(rx);
+	r->stufftoread = 0;
+error_ret:
+	mutex_unlock(&st->lock);
+
+	return ret ? ret : num_read;
+}
+
+static size_t sca3000_ring_buf_data_available(struct iio_buffer *r)
+{
+	return r->stufftoread ? r->watermark : 0;
+}
+
+/**
+ * sca3000_query_ring_int() is the hardware ring status interrupt enabled
+ **/
+static ssize_t sca3000_query_ring_int(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret, val;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sca3000_state *st = iio_priv(indio_dev);
+
+	mutex_lock(&st->lock);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	val = st->rx[0];
+	mutex_unlock(&st->lock);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", !!(val & this_attr->address));
+}
+
+/**
+ * sca3000_set_ring_int() set state of ring status interrupt
+ **/
+static ssize_t sca3000_set_ring_int(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sca3000_state *st = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	u8 val;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	if (ret)
+		goto error_ret;
+	if (val)
+		ret = sca3000_write_reg(st,
+					SCA3000_REG_ADDR_INT_MASK,
+					st->rx[0] | this_attr->address);
+	else
+		ret = sca3000_write_reg(st,
+					SCA3000_REG_ADDR_INT_MASK,
+					st->rx[0] & ~this_attr->address);
+error_ret:
+	mutex_unlock(&st->lock);
+
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(50_percent, S_IRUGO | S_IWUSR,
+		       sca3000_query_ring_int,
+		       sca3000_set_ring_int,
+		       SCA3000_INT_MASK_RING_HALF);
+
+static IIO_DEVICE_ATTR(75_percent, S_IRUGO | S_IWUSR,
+		       sca3000_query_ring_int,
+		       sca3000_set_ring_int,
+		       SCA3000_INT_MASK_RING_THREE_QUARTER);
+
+static ssize_t sca3000_show_buffer_scale(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sca3000_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "0.%06d\n", 4 * st->info->scale);
+}
+
+static IIO_DEVICE_ATTR(in_accel_scale,
+		       S_IRUGO,
+		       sca3000_show_buffer_scale,
+		       NULL,
+		       0);
+
+/*
+ * Ring buffer attributes
+ * This device is a bit unusual in that the sampling frequency and bpse
+ * only apply to the ring buffer.  At all times full rate and accuracy
+ * is available via direct reading from registers.
+ */
+static const struct attribute *sca3000_ring_attributes[] = {
+	&iio_dev_attr_50_percent.dev_attr.attr,
+	&iio_dev_attr_75_percent.dev_attr.attr,
+	&iio_dev_attr_in_accel_scale.dev_attr.attr,
+	NULL,
+};
+
+static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buf;
+	struct iio_hw_buffer *ring;
+
+	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
+	if (!ring)
+		return NULL;
+
+	ring->private = indio_dev;
+	buf = &ring->buf;
+	buf->stufftoread = 0;
+	buf->length = 64;
+	buf->attrs = sca3000_ring_attributes;
+	iio_buffer_init(buf);
+
+	return buf;
+}
+
+static void sca3000_ring_release(struct iio_buffer *r)
+{
+	kfree(iio_to_hw_buf(r));
+}
+
+static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
+	.read_first_n = &sca3000_read_first_n_hw_rb,
+	.data_available = sca3000_ring_buf_data_available,
+	.release = sca3000_ring_release,
+
+	.modes = INDIO_BUFFER_HARDWARE,
+};
+
+static int sca3000_configure_ring(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer;
+
+	buffer = sca3000_rb_allocate(indio_dev);
+	if (!buffer)
+		return -ENOMEM;
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
+
+	buffer->access = &sca3000_ring_access_funcs;
+	iio_device_attach_buffer(indio_dev, buffer);
+
+	return 0;
+}
+
+static void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
+{
+	iio_buffer_put(indio_dev->buffer);
+}
+
+static inline
+int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
+{
+	struct sca3000_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	if (ret)
+		goto error_ret;
+	if (state) {
+		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
+		ret = sca3000_write_reg(st,
+					SCA3000_REG_ADDR_MODE,
+					(st->rx[0] | SCA3000_RING_BUF_ENABLE));
+	} else
+		ret = sca3000_write_reg(st,
+					SCA3000_REG_ADDR_MODE,
+					(st->rx[0] & ~SCA3000_RING_BUF_ENABLE));
+error_ret:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+/**
+ * sca3000_hw_ring_preenable() hw ring buffer preenable function
+ *
+ * Very simple enable function as the chip will allows normal reads
+ * during ring buffer operation so as long as it is indeed running
+ * before we notify the core, the precise ordering does not matter.
+ **/
+static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
+{
+	return __sca3000_hw_ring_state_set(indio_dev, 1);
+}
+
+static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
+{
+	return __sca3000_hw_ring_state_set(indio_dev, 0);
+}
+
+static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
+	.preenable = &sca3000_hw_ring_preenable,
+	.postdisable = &sca3000_hw_ring_postdisable,
+};
+
+static void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
+{
+	indio_dev->setup_ops = &sca3000_ring_setup_ops;
+}
+
 /**
  * sca3000_clean_setup() get the device into a predictable state
  *
diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
deleted file mode 100644
index 4dcc8575cbe3..000000000000
--- a/drivers/staging/iio/accel/sca3000.h
+++ /dev/null
@@ -1,279 +0,0 @@
-/*
- * sca3000.c -- support VTI sca3000 series accelerometers
- *              via SPI
- *
- * Copyright (c) 2007 Jonathan Cameron <jic23@kernel.org>
- *
- * Partly based upon tle62x0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Initial mode is direct measurement.
- *
- * Untested things
- *
- * Temperature reading (the e05 I'm testing with doesn't have a sensor)
- *
- * Free fall detection mode - supported but untested as I'm not droping my
- * dubious wire rig far enough to test it.
- *
- * Unsupported as yet
- *
- * Time stamping of data from ring. Various ideas on how to do this but none
- * are remotely simple. Suggestions welcome.
- *
- * Individual enabling disabling of channels going into ring buffer
- *
- * Overflow handling (this is signaled for all but 8 bit ring buffer mode.)
- *
- * Motion detector using AND combinations of signals.
- *
- * Note: Be very careful about not touching an register bytes marked
- * as reserved on the data sheet. They really mean it as changing convents of
- * some will cause the device to lock up.
- *
- * Known issues - on rare occasions the interrupts lock up. Not sure why as yet.
- * Can probably alleviate this by reading the interrupt register on start, but
- * that is really just brushing the problem under the carpet.
- */
-#ifndef _SCA3000
-#define _SCA3000
-
-#define SCA3000_WRITE_REG(a) (((a) << 2) | 0x02)
-#define SCA3000_READ_REG(a) ((a) << 2)
-
-#define SCA3000_REG_ADDR_REVID			0x00
-#define SCA3000_REVID_MAJOR_MASK		0xf0
-#define SCA3000_REVID_MINOR_MASK		0x0f
-
-#define SCA3000_REG_ADDR_STATUS			0x02
-#define SCA3000_LOCKED				0x20
-#define SCA3000_EEPROM_CS_ERROR			0x02
-#define SCA3000_SPI_FRAME_ERROR			0x01
-
-/* All reads done using register decrement so no need to directly access LSBs */
-#define SCA3000_REG_ADDR_X_MSB			0x05
-#define SCA3000_REG_ADDR_Y_MSB			0x07
-#define SCA3000_REG_ADDR_Z_MSB			0x09
-
-#define SCA3000_REG_ADDR_RING_OUT		0x0f
-
-/* Temp read untested - the e05 doesn't have the sensor */
-#define SCA3000_REG_ADDR_TEMP_MSB		0x13
-
-#define SCA3000_REG_ADDR_MODE			0x14
-#define SCA3000_MODE_PROT_MASK			0x28
-
-#define SCA3000_RING_BUF_ENABLE			0x80
-#define SCA3000_RING_BUF_8BIT			0x40
-/*
- * Free fall detection triggers an interrupt if the acceleration
- * is below a threshold for equivalent of 25cm drop
- */
-#define SCA3000_FREE_FALL_DETECT		0x10
-#define SCA3000_MEAS_MODE_NORMAL		0x00
-#define SCA3000_MEAS_MODE_OP_1			0x01
-#define SCA3000_MEAS_MODE_OP_2			0x02
-
-/*
- * In motion detection mode the accelerations are band pass filtered
- * (approx 1 - 25Hz) and then a programmable threshold used to trigger
- * and interrupt.
- */
-#define SCA3000_MEAS_MODE_MOT_DET		0x03
-
-#define SCA3000_REG_ADDR_BUF_COUNT		0x15
-
-#define SCA3000_REG_ADDR_INT_STATUS		0x16
-
-#define SCA3000_INT_STATUS_THREE_QUARTERS	0x80
-#define SCA3000_INT_STATUS_HALF			0x40
-
-#define SCA3000_INT_STATUS_FREE_FALL		0x08
-#define SCA3000_INT_STATUS_Y_TRIGGER		0x04
-#define SCA3000_INT_STATUS_X_TRIGGER		0x02
-#define SCA3000_INT_STATUS_Z_TRIGGER		0x01
-
-/* Used to allow access to multiplexed registers */
-#define SCA3000_REG_ADDR_CTRL_SEL		0x18
-/* Only available for SCA3000-D03 and SCA3000-D01 */
-#define SCA3000_REG_CTRL_SEL_I2C_DISABLE	0x01
-#define SCA3000_REG_CTRL_SEL_MD_CTRL		0x02
-#define SCA3000_REG_CTRL_SEL_MD_Y_TH		0x03
-#define SCA3000_REG_CTRL_SEL_MD_X_TH		0x04
-#define SCA3000_REG_CTRL_SEL_MD_Z_TH		0x05
-/*
- * BE VERY CAREFUL WITH THIS, IF 3 BITS ARE NOT SET the device
- * will not function
- */
-#define SCA3000_REG_CTRL_SEL_OUT_CTRL		0x0B
-#define SCA3000_OUT_CTRL_PROT_MASK		0xE0
-#define SCA3000_OUT_CTRL_BUF_X_EN		0x10
-#define SCA3000_OUT_CTRL_BUF_Y_EN		0x08
-#define SCA3000_OUT_CTRL_BUF_Z_EN		0x04
-#define SCA3000_OUT_CTRL_BUF_DIV_MASK		0x03
-#define SCA3000_OUT_CTRL_BUF_DIV_4		0x02
-#define SCA3000_OUT_CTRL_BUF_DIV_2		0x01
-
-/*
- * Control which motion detector interrupts are on.
- * For now only OR combinations are supported.
- */
-#define SCA3000_MD_CTRL_PROT_MASK		0xC0
-#define SCA3000_MD_CTRL_OR_Y			0x01
-#define SCA3000_MD_CTRL_OR_X			0x02
-#define SCA3000_MD_CTRL_OR_Z			0x04
-/* Currently unsupported */
-#define SCA3000_MD_CTRL_AND_Y			0x08
-#define SCA3000_MD_CTRL_AND_X			0x10
-#define SAC3000_MD_CTRL_AND_Z			0x20
-
-/*
- * Some control registers of complex access methods requiring this register to
- * be used to remove a lock.
- */
-#define SCA3000_REG_ADDR_UNLOCK			0x1e
-
-#define SCA3000_REG_ADDR_INT_MASK		0x21
-#define SCA3000_INT_MASK_PROT_MASK		0x1C
-
-#define SCA3000_INT_MASK_RING_THREE_QUARTER	0x80
-#define SCA3000_INT_MASK_RING_HALF		0x40
-
-#define SCA3000_INT_MASK_ALL_INTS		0x02
-#define SCA3000_INT_MASK_ACTIVE_HIGH		0x01
-#define SCA3000_INT_MASK_ACTIVE_LOW		0x00
-
-/* Values of multiplexed registers (write to ctrl_data after select) */
-#define SCA3000_REG_ADDR_CTRL_DATA		0x22
-
-/*
- * Measurement modes available on some sca3000 series chips. Code assumes others
- * may become available in the future.
- *
- * Bypass - Bypass the low-pass filter in the signal channel so as to increase
- *          signal bandwidth.
- *
- * Narrow - Narrow low-pass filtering of the signal channel and half output
- *          data rate by decimation.
- *
- * Wide - Widen low-pass filtering of signal channel to increase bandwidth
- */
-#define SCA3000_OP_MODE_BYPASS			0x01
-#define SCA3000_OP_MODE_NARROW			0x02
-#define SCA3000_OP_MODE_WIDE			0x04
-#define SCA3000_MAX_TX 6
-#define SCA3000_MAX_RX 2
-
-/**
- * struct sca3000_state - device instance state information
- * @us:			the associated spi device
- * @info:			chip variant information
- * @interrupt_handler_ws:	event interrupt handler for all events
- * @last_timestamp:		the timestamp of the last event
- * @mo_det_use_count:		reference counter for the motion detection unit
- * @lock:			lock used to protect elements of sca3000_state
- *				and the underlying device state.
- * @bpse:			number of bits per scan element
- * @tx:			dma-able transmit buffer
- * @rx:			dma-able receive buffer
- **/
-struct sca3000_state {
-	struct spi_device		*us;
-	const struct sca3000_chip_info	*info;
-	struct work_struct		interrupt_handler_ws;
-	s64				last_timestamp;
-	int				mo_det_use_count;
-	struct mutex			lock;
-	int				bpse;
-	/* Can these share a cacheline ? */
-	u8				rx[2] ____cacheline_aligned;
-	u8				tx[6] ____cacheline_aligned;
-};
-
-/**
- * struct sca3000_chip_info - model dependent parameters
- * @scale:			scale * 10^-6
- * @temp_output:		some devices have temperature sensors.
- * @measurement_mode_freq:	normal mode sampling frequency
- * @option_mode_1:		first optional mode. Not all models have one
- * @option_mode_1_freq:		option mode 1 sampling frequency
- * @option_mode_2:		second optional mode. Not all chips have one
- * @option_mode_2_freq:		option mode 2 sampling frequency
- *
- * This structure is used to hold information about the functionality of a given
- * sca3000 variant.
- **/
-struct sca3000_chip_info {
-	unsigned int		scale;
-	bool			temp_output;
-	int			measurement_mode_freq;
-	int			option_mode_1;
-	int			option_mode_1_freq;
-	int			option_mode_2;
-	int			option_mode_2_freq;
-	int			mot_det_mult_xz[6];
-	int			mot_det_mult_y[7];
-};
-
-int sca3000_read_data_short(struct sca3000_state *st,
-			    u8 reg_address_high,
-			    int len);
-
-/**
- * sca3000_write_reg() write a single register
- * @address:	address of register on chip
- * @val:	value to be written to register
- *
- * The main lock must be held.
- **/
-int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val);
-
-#ifdef CONFIG_IIO_BUFFER
-/**
- * sca3000_register_ring_funcs() setup the ring state change functions
- **/
-void sca3000_register_ring_funcs(struct iio_dev *indio_dev);
-
-/**
- * sca3000_configure_ring() - allocate and configure ring buffer
- * @indio_dev: iio-core device whose ring is to be configured
- *
- * The hardware ring buffer needs far fewer ring buffer functions than
- * a software one as a lot of things are handled automatically.
- * This function also tells the iio core that our device supports a
- * hardware ring buffer mode.
- **/
-int sca3000_configure_ring(struct iio_dev *indio_dev);
-
-/**
- * sca3000_unconfigure_ring() - deallocate the ring buffer
- * @indio_dev: iio-core device whose ring we are freeing
- **/
-void sca3000_unconfigure_ring(struct iio_dev *indio_dev);
-
-/**
- * sca3000_ring_int_process() handles ring related event pushing and escalation
- * @val:	the event code
- **/
-void sca3000_ring_int_process(u8 val, struct iio_buffer *ring);
-
-#else
-static inline void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
-{
-}
-
-static inline
-int sca3000_register_ring_access_and_init(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void sca3000_ring_int_process(u8 val, void *ring)
-{
-}
-
-#endif
-#endif /* _SCA3000 */
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
deleted file mode 100644
index e5de52d05a5c..000000000000
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ /dev/null
@@ -1,350 +0,0 @@
-/*
- * sca3000_ring.c -- support VTI sca3000 series accelerometers via SPI
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * Copyright (c) 2009 Jonathan Cameron <jic23@kernel.org>
- *
- */
-
-#include <linux/interrupt.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/sysfs.h>
-#include <linux/sched.h>
-#include <linux/poll.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include "../ring_hw.h"
-#include "sca3000.h"
-
-/* RFC / future work
- *
- * The internal ring buffer doesn't actually change what it holds depending
- * on which signals are enabled etc, merely whether you can read them.
- * As such the scan mode selection is somewhat different than for a software
- * ring buffer and changing it actually covers any data already in the buffer.
- * Currently scan elements aren't configured so it doesn't matter.
- */
-
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
-/**
- * sca3000_query_ring_int() is the hardware ring status interrupt enabled
- **/
-static ssize_t sca3000_query_ring_int(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret, val;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
-	val = st->rx[0];
-	mutex_unlock(&st->lock);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "%d\n", !!(val & this_attr->address));
-}
-
-/**
- * sca3000_set_ring_int() set state of ring status interrupt
- **/
-static ssize_t sca3000_set_ring_int(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 val;
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = kstrtou8(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
-	if (ret)
-		goto error_ret;
-	if (val)
-		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_INT_MASK,
-					st->rx[0] | this_attr->address);
-	else
-		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_INT_MASK,
-					st->rx[0] & ~this_attr->address);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
-static IIO_DEVICE_ATTR(50_percent, S_IRUGO | S_IWUSR,
-		       sca3000_query_ring_int,
-		       sca3000_set_ring_int,
-		       SCA3000_INT_MASK_RING_HALF);
-
-static IIO_DEVICE_ATTR(75_percent, S_IRUGO | S_IWUSR,
-		       sca3000_query_ring_int,
-		       sca3000_set_ring_int,
-		       SCA3000_INT_MASK_RING_THREE_QUARTER);
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
-	&iio_dev_attr_50_percent.dev_attr.attr,
-	&iio_dev_attr_75_percent.dev_attr.attr,
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
-int sca3000_configure_ring(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-
-	buffer = sca3000_rb_allocate(indio_dev);
-	if (!buffer)
-		return -ENOMEM;
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-
-
-	buffer->access = &sca3000_ring_access_funcs;
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	return 0;
-}
-
-void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
-{
-	iio_buffer_put(indio_dev->buffer);
-}
-
-static inline
-int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
-{
-	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
-	if (ret)
-		goto error_ret;
-	if (state) {
-		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
-		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_MODE,
-					(st->rx[0] | SCA3000_RING_BUF_ENABLE));
-	} else
-		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_MODE,
-					(st->rx[0] & ~SCA3000_RING_BUF_ENABLE));
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
-}
-
-/**
- * sca3000_hw_ring_preenable() hw ring buffer preenable function
- *
- * Very simple enable function as the chip will allows normal reads
- * during ring buffer operation so as long as it is indeed running
- * before we notify the core, the precise ordering does not matter.
- **/
-static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
-{
-	return __sca3000_hw_ring_state_set(indio_dev, 1);
-}
-
-static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
-{
-	return __sca3000_hw_ring_state_set(indio_dev, 0);
-}
-
-static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
-	.preenable = &sca3000_hw_ring_preenable,
-	.postdisable = &sca3000_hw_ring_postdisable,
-};
-
-void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
-{
-	indio_dev->setup_ops = &sca3000_ring_setup_ops;
-}
-
-/**
- * sca3000_ring_int_process() ring specific interrupt handling.
- *
- * This is only split from the main interrupt handler so as to
- * reduce the amount of code if the ring buffer is not enabled.
- **/
-void sca3000_ring_int_process(u8 val, struct iio_buffer *ring)
-{
-	if (val & (SCA3000_INT_STATUS_THREE_QUARTERS |
-		   SCA3000_INT_STATUS_HALF)) {
-		ring->stufftoread = true;
-		wake_up_interruptible(&ring->pollq);
-	}
-}
-- 
2.10.0

