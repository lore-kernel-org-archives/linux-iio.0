Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 077/111] staging:iio:meter:ade7758: Use iio channel spec and miscellaneous other changes.
Date: Wed, 18 May 2011 14:42:07 +0100
Message-Id: <1305726161-5606-78-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Use iio channel spec for the ring buffer channels.
Add/update file comment/license headers.
Use available_scan_masks to prevent that multiple channels are enabled.
Remove wavefrom type attributes. (no handled directly by the scan_elements)
Use SPI_MODE_1.
Move ade7758_initial_setup() before ade7758_probe_trigger() to ensure the
ADE7758 interrupt is disabled when the host interrupt get's enabled.
Add spi_device_id.
Update ring buffer setup.

Some backporting needed to ensure driver builds all the way through core
changes.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7758.h      |   66 ++++++---
 drivers/staging/iio/meter/ade7758_core.c |  173 ++++++++++++-----------
 drivers/staging/iio/meter/ade7758_ring.c |  231 ++++++++++++++++--------------
 3 files changed, 258 insertions(+), 212 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index 169982b..372a9f6 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -1,3 +1,11 @@
+/*
+ * ADE7758 Poly Phase Multifunction Energy Metering IC driver
+ *
+ * Copyright 2010-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
 #ifndef _ADE7758_H
 #define _ADE7758_H
 
@@ -83,12 +91,23 @@
 #define ADE7758_MAX_RX    4
 #define ADE7758_STARTUP_DELAY 1
 
-#define ADE7758_SPI_SLOW	(u32)(300 * 1000)
-#define ADE7758_SPI_BURST	(u32)(1000 * 1000)
-#define ADE7758_SPI_FAST	(u32)(2000 * 1000)
+#define AD7758_NUM_WAVSEL	5
+#define AD7758_NUM_PHSEL	3
+#define AD7758_NUM_WAVESRC	(AD7758_NUM_WAVSEL * AD7758_NUM_PHSEL)
+
+#define AD7758_PHASE_A		0
+#define AD7758_PHASE_B		1
+#define AD7758_PHASE_C		2
+#define AD7758_CURRENT		0
+#define AD7758_VOLTAGE		1
+#define AD7758_ACT_PWR		2
+#define AD7758_REACT_PWR	3
+#define AD7758_APP_PWR		4
+#define AD7758_WT(p, w)		(((w) << 2) | (p))
 
 #define DRIVER_NAME		"ade7758"
 
+
 /**
  * struct ade7758_state - device instance specific data
  * @us:			actual spi_device
@@ -99,22 +118,29 @@
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct ade7758_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct iio_dev		*indio_dev;
+	struct iio_trigger	*trig;
+	u8			*tx;
+	u8			*rx;
+	struct mutex		buf_lock;
+	u32			available_scan_masks[AD7758_NUM_WAVESRC];
+	struct iio_chan_spec	*ade7758_ring_channels;
+	struct spi_transfer		ring_xfer[4];
+	struct spi_message		ring_msg;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	unsigned char			rx_buf[8] ____cacheline_aligned;
+	unsigned char			tx_buf[8];
+
 };
 #ifdef CONFIG_IIO_RING_BUFFER
 /* At the moment triggers are only used for ring buffer
  * filling. This may change!
  */
 
-enum ade7758_scan {
-	ADE7758_SCAN_WFORM,
-};
-
 void ade7758_remove_trigger(struct iio_dev *indio_dev);
 int ade7758_probe_trigger(struct iio_dev *indio_dev);
 
@@ -129,6 +155,12 @@ void ade7758_unconfigure_ring(struct iio_dev *indio_dev);
 int ade7758_initialize_ring(struct iio_ring_buffer *ring);
 void ade7758_uninitialize_ring(struct iio_ring_buffer *ring);
 int ade7758_set_irq(struct device *dev, bool enable);
+
+int ade7758_spi_write_reg_8(struct device *dev,
+		u8 reg_address, u8 val);
+int ade7758_spi_read_reg_8(struct device *dev,
+		u8 reg_address, u8 *val);
+
 #else /* CONFIG_IIO_RING_BUFFER */
 
 static inline void ade7758_remove_trigger(struct iio_dev *indio_dev)
@@ -139,14 +171,6 @@ static inline int ade7758_probe_trigger(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static inline ssize_t
-ade7758_read_data_from_ring(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	return 0;
-}
-
 static int ade7758_configure_ring(struct iio_dev *indio_dev)
 {
 	return 0;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 26ff31b..42682ad 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -20,10 +20,11 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../ring_generic.h"
 #include "meter.h"
 #include "ade7758.h"
 
-static int ade7758_spi_write_reg_8(struct device *dev,
+int ade7758_spi_write_reg_8(struct device *dev,
 		u8 reg_address,
 		u8 val)
 {
@@ -490,7 +491,7 @@ static int ade7758_initial_setup(struct ade7758_state *st)
 	struct device *dev = &st->indio_dev->dev;
 
 	/* use low spi speed for init */
-	st->us->mode = SPI_MODE_3;
+	st->us->mode = SPI_MODE_1;
 	spi_setup(st->us);
 
 	/* Disable IRQ */
@@ -580,63 +581,6 @@ out:
 	return ret ? ret : len;
 }
 
-static ssize_t ade7758_read_waveform_type(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret, len = 0;
-	u8 t;
-	ret = ade7758_spi_read_reg_8(dev,
-			ADE7758_WAVMODE,
-			&t);
-	if (ret)
-		return ret;
-
-	t = (t >> 2) & 0x7;
-
-	len = sprintf(buf, "%d\n", t);
-
-	return len;
-}
-
-static ssize_t ade7758_write_waveform_type(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	unsigned long val;
-	int ret;
-	u8 reg;
-
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	if (val > 4)
-		return -EINVAL;
-
-	mutex_lock(&indio_dev->mlock);
-
-	ret = ade7758_spi_read_reg_8(dev,
-			ADE7758_WAVMODE,
-			&reg);
-	if (ret)
-		goto out;
-
-	reg &= ~(7 << 2);
-	reg |= val << 2;
-
-	ret = ade7758_spi_write_reg_8(dev,
-			ADE7758_WAVMODE,
-			reg);
-
-out:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-}
-
 static IIO_DEV_ATTR_TEMP_RAW(ade7758_read_8bit);
 static IIO_CONST_ATTR(temp_offset, "129 C");
 static IIO_CONST_ATTR(temp_scale, "4 C");
@@ -664,19 +608,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		ade7758_read_frequency,
 		ade7758_write_frequency);
 
-/**
- * IIO_DEV_ATTR_WAVEFORM_TYPE - set the type of waveform.
- * @_mode: sysfs file mode/permissions
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- **/
-#define IIO_DEV_ATTR_WAVEFORM_TYPE(_mode, _show, _store)			\
-	IIO_DEVICE_ATTR(waveform_type, _mode, _show, _store, 0)
-
-static IIO_DEV_ATTR_WAVEFORM_TYPE(S_IWUSR | S_IRUGO,
-		ade7758_read_waveform_type,
-		ade7758_write_waveform_type);
-
 static IIO_DEV_ATTR_RESET(ade7758_write_reset);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26040 13020 6510 3255");
@@ -686,7 +617,6 @@ static struct attribute *ade7758_attributes[] = {
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_waveform_type.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_awatthr.dev_attr.attr,
@@ -730,11 +660,73 @@ static const struct attribute_group ade7758_attribute_group = {
 	.attrs = ade7758_attributes,
 };
 
-
+static struct iio_chan_spec ade7758_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, "raw", 0, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
+		0, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_CURRENT, 0, 1, 0, "raw", 0, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_A, AD7758_CURRENT),
+		1, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "apparent_raw", 0, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_A, AD7758_APP_PWR),
+		2, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "active_raw", 0, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_A, AD7758_ACT_PWR),
+		3, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "reactive_raw", 0, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
+		4, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, "raw", 1, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
+		5, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_CURRENT, 0, 1, 0, "raw", 1, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_B, AD7758_CURRENT),
+		6, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "apparent_raw", 1, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_B, AD7758_APP_PWR),
+		7, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "active_raw", 1, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_B, AD7758_ACT_PWR),
+		8, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "reactive_raw", 1, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
+		9, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, "raw", 2, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
+		10, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_CURRENT, 0, 1, 0, "raw", 2, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_C, AD7758_CURRENT),
+		11, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "apparent_raw", 2, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_C, AD7758_APP_PWR),
+		12, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "active_raw", 2, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_C, AD7758_ACT_PWR),
+		13, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN(IIO_POWER, 0, 1, 0, "reactive_raw", 2, 0,
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		AD7758_WT(AD7758_PHASE_C, AD7758_REACT_PWR),
+		14, IIO_ST('s', 24, 32, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(15),
+};
 
 static int __devinit ade7758_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int i, ret, regdone = 0;
 	struct ade7758_state *st = kzalloc(sizeof *st, GFP_KERNEL);
 	if (!st) {
 		ret =  -ENOMEM;
@@ -755,6 +747,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 		goto error_free_rx;
 	}
 	st->us = spi;
+	st->ade7758_ring_channels = &ade7758_channels[0];
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
 	st->indio_dev = iio_allocate_device(0);
@@ -770,6 +763,11 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
+	for (i = 0; i < AD7758_NUM_WAVESRC; i++)
+		st->available_scan_masks[i] = 1 << i;
+
+	st->indio_dev->available_scan_masks = st->available_scan_masks;
+
 	ret = ade7758_configure_ring(st->indio_dev);
 	if (ret)
 		goto error_free_dev;
@@ -779,22 +777,25 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = ade7758_initialize_ring(st->indio_dev->ring);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  &ade7758_channels[0],
+					  ARRAY_SIZE(ade7758_channels));
 	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
+		dev_err(&spi->dev, "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
 	}
 
+	/* Get the device into a sane initial state */
+	ret = ade7758_initial_setup(st);
+	if (ret)
+		goto error_uninitialize_ring;
+
 	if (spi->irq) {
 		ret = ade7758_probe_trigger(st->indio_dev);
 		if (ret)
-			goto error_uninitialize_ring;
+			goto error_remove_trigger;
 	}
 
-	/* Get the device into a sane initial state */
-	ret = ade7758_initial_setup(st);
-	if (ret)
-		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
@@ -829,8 +830,6 @@ static int ade7758_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	flush_scheduled_work();
-
 	ade7758_remove_trigger(indio_dev);
 	ade7758_uninitialize_ring(indio_dev->ring);
 	iio_device_unregister(indio_dev);
@@ -845,6 +844,11 @@ err_ret:
 	return ret;
 }
 
+static const struct spi_device_id ade7758_id[] = {
+	{"ade7758", 0},
+	{}
+};
+
 static struct spi_driver ade7758_driver = {
 	.driver = {
 		.name = "ade7758",
@@ -852,6 +856,7 @@ static struct spi_driver ade7758_driver = {
 	},
 	.probe = ade7758_probe,
 	.remove = __devexit_p(ade7758_remove),
+	.id_table = ade7758_id,
 };
 
 static __init int ade7758_init(void)
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 2c9865d..c8ebfd2 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -1,3 +1,10 @@
+/*
+ * ADE7758 Poly Phase Multifunction Energy Metering IC driver
+ *
+ * Copyright 2010-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
@@ -9,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
+#include <asm/unaligned.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -18,82 +26,40 @@
 #include "ade7758.h"
 
 /**
- * combine_8_to_32() utility function to munge to u8s into u32
- **/
-static inline u32 combine_8_to_32(u8 lower, u8 mid, u8 upper)
-{
-	u32 _lower = lower;
-	u32 _mid = mid;
-	u32 _upper = upper;
-
-	return _lower | (_mid << 8) | (_upper << 16);
-}
-
-static IIO_SCAN_EL_C(wform, ADE7758_SCAN_WFORM, ADE7758_WFORM, NULL);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(wform, s, 24, 32);
-static IIO_SCAN_EL_TIMESTAMP(1);
-static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
-
-static struct attribute *ade7758_scan_el_attrs[] = {
-	&iio_scan_el_wform.dev_attr.attr,
-	&iio_const_attr_wform_index.dev_attr.attr,
-	&iio_const_attr_wform_type.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	&iio_const_attr_timestamp_index.dev_attr.attr,
-	&iio_const_attr_timestamp_type.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group ade7758_scan_el_group = {
-	.attrs = ade7758_scan_el_attrs,
-	.name = "scan_elements",
-};
-
-/**
- * ade7758_spi_read_burst() - read all data registers
+ * ade7758_spi_read_burst() - read data registers
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @rx: somewhere to pass back the value read (min size is 24 bytes)
  **/
-static int ade7758_spi_read_burst(struct device *dev, u8 *rx)
+static int ade7758_spi_read_burst(struct device *dev)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.rx_buf = rx,
-			.bits_per_word = 8,
-			.len = 4,
-		}, {
-			.tx_buf = st->tx + 4,
-			.rx_buf = rx,
-			.bits_per_word = 8,
-			.len = 4,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7758_READ_REG(ADE7758_RSTATUS);
-	st->tx[1] = 0;
-	st->tx[2] = 0;
-	st->tx[3] = 0;
-	st->tx[4] = ADE7758_READ_REG(ADE7758_WFORM);
-	st->tx[5] = 0;
-	st->tx[6] = 0;
-	st->tx[7] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_sync(st->us, &st->ring_msg);
 	if (ret)
 		dev_err(&st->us->dev, "problem when reading WFORM value\n");
 
-	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade7758_write_waveform_type(struct device *dev, unsigned type)
+{
+	int ret;
+	u8 reg;
+
+	ret = ade7758_spi_read_reg_8(dev,
+			ADE7758_WAVMODE,
+			&reg);
+	if (ret)
+		goto out;
+
+	reg &= ~0x1F;
+	reg |= type & 0x1F;
 
+	ret = ade7758_spi_write_reg_8(dev,
+			ADE7758_WAVMODE,
+			reg);
+out:
 	return ret;
 }
 
@@ -106,41 +72,70 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->private_data;
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
-	int i = 0;
-	s32 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
-
-	data = kmalloc(datasize, GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return -ENOMEM;
-	}
+	s64 dat64[2];
+	u32 *dat32 = (u32 *)dat64;
 
 	if (ring->scan_count)
-		if (ade7758_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
-				data[i] = combine_8_to_32(st->rx[i*2+2],
-						st->rx[i*2+1],
-						st->rx[i*2]);
+		if (ade7758_spi_read_burst(&st->indio_dev->dev) >= 0)
+			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
-		*((s64 *)
-		(((u32)data + 4 * ring->scan_count + 4) & ~0x7)) =
-			pf->timestamp;
+		dat64[1] = pf->timestamp;
 
-	ring->access.store_to(ring,
-			      (u8 *)data,
-			      pf->timestamp);
+	ring->access.store_to(ring, (u8 *)dat64, pf->timestamp);
 
 	iio_trigger_notify_done(st->indio_dev->trig);
-	kfree(data);
 
 	return IRQ_HANDLED;
 }
 
+/**
+ * ade7758_ring_preenable() setup the parameters of the ring before enabling
+ *
+ * The complex nature of the setting of the nuber of bytes per datum is due
+ * to this driver currently ensuring that the timestamp is stored at an 8
+ * byte boundary.
+ **/
+static int ade7758_ring_preenable(struct iio_dev *indio_dev)
+{
+	struct ade7758_state *st = indio_dev->dev_data;
+	struct iio_ring_buffer *ring = indio_dev->ring;
+	size_t d_size;
+	unsigned channel;
+
+	if (!ring->scan_count)
+		return -EINVAL;
+
+	channel = __ffs(ring->scan_mask);
+
+	d_size = st->ade7758_ring_channels[channel].scan_type.storagebits / 8;
+
+	if (ring->scan_timestamp) {
+		d_size += sizeof(s64);
+
+		if (d_size % sizeof(s64))
+			d_size += sizeof(s64) - (d_size % sizeof(s64));
+	}
+
+	if (indio_dev->ring->access.set_bytes_per_datum)
+		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
+							    d_size);
+
+	ade7758_write_waveform_type(&indio_dev->dev,
+		st->ade7758_ring_channels[channel].address);
+
+	return 0;
+}
+
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 {
+	/* ensure that the trigger has been detached */
+	if (indio_dev->trig) {
+		iio_put_trigger(indio_dev->trig);
+		iio_trigger_dettach_poll_func(indio_dev->trig,
+					      indio_dev->pollfunc);
+	}
 	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
@@ -148,34 +143,28 @@ void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 
 int ade7758_configure_ring(struct iio_dev *indio_dev)
 {
+	struct ade7758_state *st = indio_dev->dev_data;
 	int ret = 0;
-	struct iio_ring_buffer *ring;
 
-	ring = iio_sw_rb_allocate(indio_dev);
-	if (!ring) {
+	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
-	indio_dev->ring = ring;
+
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
-	ring->bpe = 4;
-	ring->scan_el_attrs = &ade7758_scan_el_group;
-	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
-	ring->owner = THIS_MODULE;
-
-	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_wform.number);
+	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	indio_dev->ring->preenable = &ade7758_ring_preenable;
+	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
+	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
+	indio_dev->ring->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
 		goto error_iio_sw_rb_free;
 	}
-	indio_dev->pollfunc->private_data = indio_dev->ring;
+	indio_dev->pollfunc->private_data = indio_dev;
 	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
 	indio_dev->pollfunc->thread = &ade7758_trigger_handler;
 	indio_dev->pollfunc->name
@@ -186,6 +175,39 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	}
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 
+	st->tx_buf[0] = ADE7758_READ_REG(ADE7758_RSTATUS);
+	st->tx_buf[1] = 0;
+	st->tx_buf[2] = 0;
+	st->tx_buf[3] = 0;
+	st->tx_buf[4] = ADE7758_READ_REG(ADE7758_WFORM);
+	st->tx_buf[5] = 0;
+	st->tx_buf[6] = 0;
+	st->tx_buf[7] = 0;
+
+	/* build spi ring message */
+	st->ring_xfer[0].tx_buf = &st->tx_buf[0];
+	st->ring_xfer[0].len = 1;
+	st->ring_xfer[0].bits_per_word = 8;
+	st->ring_xfer[0].delay_usecs = 4;
+	st->ring_xfer[1].rx_buf = &st->rx_buf[1];
+	st->ring_xfer[1].len = 3;
+	st->ring_xfer[1].bits_per_word = 8;
+	st->ring_xfer[1].cs_change = 1;
+
+	st->ring_xfer[2].tx_buf = &st->tx_buf[4];
+	st->ring_xfer[2].len = 1;
+	st->ring_xfer[2].bits_per_word = 8;
+	st->ring_xfer[2].delay_usecs = 1;
+	st->ring_xfer[3].rx_buf = &st->rx_buf[5];
+	st->ring_xfer[3].len = 3;
+	st->ring_xfer[3].bits_per_word = 8;
+
+	spi_message_init(&st->ring_msg);
+	spi_message_add_tail(&st->ring_xfer[0], &st->ring_msg);
+	spi_message_add_tail(&st->ring_xfer[1], &st->ring_msg);
+	spi_message_add_tail(&st->ring_xfer[2], &st->ring_msg);
+	spi_message_add_tail(&st->ring_xfer[3], &st->ring_msg);
+
 	return 0;
 
 error_free_pollfunc:
@@ -195,11 +217,6 @@ error_iio_sw_rb_free:
 	return ret;
 }
 
-int ade7758_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
 void ade7758_uninitialize_ring(struct iio_ring_buffer *ring)
 {
 	iio_ring_buffer_unregister(ring);
-- 
1.7.3.4
