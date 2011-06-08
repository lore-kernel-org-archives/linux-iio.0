Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 4/4] IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI ADC
Date: Wed, 8 Jun 2011 16:12:44 +0200
Message-ID: <1307542364-7089-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1307542364-7089-1-git-send-email-michael.hennerich@analog.com>
References: <1307542364-7089-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

New driver for AD7792/AD7793 3-Channel, Low Noise,
Low Power, 16-/24-Bit Sigma-Delta ADC with On-Chip In-Amp
and Reference.

The AD7792/AD7793 features a dual use data out ready DOUT/RDY output.
In order to avoid contentions on the SPI bus, it's necessary to use
spi bus locking. The DOUT/RDY output must also be wired to an
interrupt capable GPIO.

In INDIO_RING_TRIGGERED mode, this driver may block its SPI bus segment
for an extended period of time.

Changes since V1:

Use bool where applicable.
Use data buffer that lives in their own cache line.
Restructure ad7793_calibrate_all to use an array.
Use msleep.
Query REG_ID instead of doing a write/read This is a test.
Add support for unipolar mode.
Drop range attribute in favor of write scale.
Add proper locking.
Use new validate_trigger callbacks.
Use IIO_IN_DIFF for differential channels.
Change attribute naming.
Use available_scan_masks.
Some other miscellaneous cleanup (none functional changes).

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/Kconfig  |   14 +
 drivers/staging/iio/adc/Makefile |    1 +
 drivers/staging/iio/adc/ad7793.c |  987 ++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/ad7793.h |  107 ++++
 4 files changed, 1109 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/adc/ad7793.c
 create mode 100644 drivers/staging/iio/adc/ad7793.h

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 8c751c4..b39f2e1 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -130,6 +130,20 @@ config AD7780
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7780.

+config AD7793
+	tristate "Analog Devices AD7792 AD7793 ADC driver"
+	depends on SPI
+	select IIO_RING_BUFFER
+	select IIO_SW_RING
+	select IIO_TRIGGER
+	help
+	  Say yes here to build support for Analog Devices
+	  AD7792 and AD7793 SPI analog to digital convertors (ADC).
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called AD7793.
+
 config AD7745
 	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
 	depends on I2C
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 1d9b3f5..f020351 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7314) += ad7314.o
 obj-$(CONFIG_AD7745) += ad7745.o
 obj-$(CONFIG_AD7780) += ad7780.o
+obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_ADT75) += adt75.o
 obj-$(CONFIG_ADT7310) += adt7310.o
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
new file mode 100644
index 0000000..90f6c03
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -0,0 +1,987 @@
+/*
+ * AD7792/AD7793 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../ring_generic.h"
+#include "../ring_sw.h"
+#include "../trigger.h"
+#include "adc.h"
+
+#include "ad7793.h"
+
+/* NOTE:
+ * The AD7792/AD7793 features a dual use data out ready DOUT/RDY output.
+ * In order to avoid contentions on the SPI bus, it's therefore necessary
+ * to use spi bus locking.
+ *
+ * The DOUT/RDY output must also be wired to an interrupt capable GPIO.
+ */
+
+struct ad7793_chip_info {
+	struct iio_chan_spec		channel[7];
+};
+
+struct ad7793_state {
+	struct spi_device		*spi;
+	struct iio_trigger		*trig;
+	const struct ad7793_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct ad7793_platform_data	*pdata;
+	wait_queue_head_t		wq_data_avail;
+	bool				done;
+	bool				irq_dis;
+	u16				int_vref_mv;
+	u16				mode;
+	u16				conf;
+	u32				scale_avail[8][2];
+	u32				available_scan_masks[7];
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8				data[4] ____cacheline_aligned;
+};
+
+enum ad7793_supported_device_ids {
+	ID_AD7792,
+	ID_AD7793,
+};
+
+static int __ad7793_write_reg(struct ad7793_state *st, bool locked,
+			      bool cs_change, unsigned char reg,
+			      unsigned size, unsigned val)
+{
+	u8 *data = st->data;
+	struct spi_transfer t = {
+		.tx_buf		= data,
+		.len		= size + 1,
+		.cs_change	= cs_change,
+	};
+	struct spi_message m;
+
+	data[0] = AD7793_COMM_WRITE | AD7793_COMM_ADDR(reg);
+
+	switch (size) {
+	case 3:
+		data[1] = val >> 16;
+		data[2] = val >> 8;
+		data[3] = val;
+		break;
+	case 2:
+		data[1] = val >> 8;
+		data[2] = val;
+		break;
+	case 1:
+		data[1] = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	if (locked)
+		return spi_sync_locked(st->spi, &m);
+	else
+		return spi_sync(st->spi, &m);
+}
+
+static int ad7793_write_reg(struct ad7793_state *st,
+			    unsigned reg, unsigned size, unsigned val)
+{
+	return __ad7793_write_reg(st, false, false, reg, size, val);
+}
+
+static int __ad7793_read_reg(struct ad7793_state *st, bool locked,
+			     bool cs_change, unsigned char reg,
+			     int *val, unsigned size)
+{
+	u8 *data = st->data;
+	int ret;
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = data,
+			.len = 1,
+		}, {
+			.rx_buf = data,
+			.len = size,
+			.cs_change = cs_change,
+		},
+	};
+	struct spi_message m;
+
+	data[0] = AD7793_COMM_READ | AD7793_COMM_ADDR(reg);
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t[0], &m);
+	spi_message_add_tail(&t[1], &m);
+
+	if (locked)
+		ret = spi_sync_locked(st->spi, &m);
+	else
+		ret = spi_sync(st->spi, &m);
+
+	if (ret < 0)
+		return ret;
+
+	switch (size) {
+	case 3:
+		*val = data[0] << 16 | data[1] << 8 | data[2];
+		break;
+	case 2:
+		*val = data[0] << 8 | data[1];
+		break;
+	case 1:
+		*val = data[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ad7793_read_reg(struct ad7793_state *st,
+			   unsigned reg, int *val, unsigned size)
+{
+	return __ad7793_read_reg(st, 0, 0, reg, val, size);
+}
+
+static int ad7793_read(struct ad7793_state *st, unsigned ch,
+		       unsigned len, int *val)
+{
+	int ret;
+	st->conf = (st->conf & ~AD7793_CONF_CHAN(-1)) | AD7793_CONF_CHAN(ch);
+	st->mode = (st->mode & ~AD7793_MODE_SEL(-1)) |
+		AD7793_MODE_SEL(AD7793_MODE_SINGLE);
+
+	ad7793_write_reg(st, AD7793_REG_CONF, sizeof(st->conf), st->conf);
+
+	spi_bus_lock(st->spi->master);
+	st->done = false;
+
+	ret = __ad7793_write_reg(st, 1, 1, AD7793_REG_MODE,
+				 sizeof(st->mode), st->mode);
+	if (ret < 0)
+		goto out;
+
+	st->irq_dis = false;
+	enable_irq(st->spi->irq);
+	wait_event_interruptible(st->wq_data_avail, st->done);
+
+	ret = __ad7793_read_reg(st, 1, 0, AD7793_REG_DATA, val, len);
+out:
+	spi_bus_unlock(st->spi->master);
+
+	return ret;
+}
+
+static int ad7793_calibrate(struct ad7793_state *st, unsigned mode, unsigned ch)
+{
+	int ret;
+
+	st->conf = (st->conf & ~AD7793_CONF_CHAN(-1)) | AD7793_CONF_CHAN(ch);
+	st->mode = (st->mode & ~AD7793_MODE_SEL(-1)) | AD7793_MODE_SEL(mode);
+
+	ad7793_write_reg(st, AD7793_REG_CONF, sizeof(st->conf), st->conf);
+
+	spi_bus_lock(st->spi->master);
+	st->done = false;
+
+	ret = __ad7793_write_reg(st, 1, 1, AD7793_REG_MODE,
+				 sizeof(st->mode), st->mode);
+	if (ret < 0)
+		goto out;
+
+	st->irq_dis = false;
+	enable_irq(st->spi->irq);
+	wait_event_interruptible(st->wq_data_avail, st->done);
+
+	st->mode = (st->mode & ~AD7793_MODE_SEL(-1)) |
+		AD7793_MODE_SEL(AD7793_MODE_IDLE);
+
+	ret = __ad7793_write_reg(st, 1, 0, AD7793_REG_MODE,
+				 sizeof(st->mode), st->mode);
+out:
+	spi_bus_unlock(st->spi->master);
+
+	return ret;
+}
+
+static const u8 ad7793_calib_arr[6][2] = {
+	{AD7793_MODE_CAL_INT_ZERO, AD7793_CH_AIN1P_AIN1M},
+	{AD7793_MODE_CAL_INT_FULL, AD7793_CH_AIN1P_AIN1M},
+	{AD7793_MODE_CAL_INT_ZERO, AD7793_CH_AIN2P_AIN2M},
+	{AD7793_MODE_CAL_INT_FULL, AD7793_CH_AIN2P_AIN2M},
+	{AD7793_MODE_CAL_INT_ZERO, AD7793_CH_AIN3P_AIN3M},
+	{AD7793_MODE_CAL_INT_FULL, AD7793_CH_AIN3P_AIN3M}
+};
+
+static int ad7793_calibrate_all(struct ad7793_state *st)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(ad7793_calib_arr); i++) {
+		ret = ad7793_calibrate(st, ad7793_calib_arr[i][0],
+				       ad7793_calib_arr[i][1]);
+		if (ret)
+			goto out;
+	}
+
+	return 0;
+out:
+	dev_err(&st->spi->dev, "Calibration failed\n");
+	return ret;
+}
+
+static int ad7793_setup(struct ad7793_state *st)
+{
+	int i, ret = -1;
+	unsigned long long scale_uv;
+	u32 id;
+
+	/* reset the serial interface */
+	ret = spi_write(st->spi, (u8 *)&ret, sizeof(ret));
+	if (ret < 0)
+		goto out;
+	msleep(1); /* Wait for at least 500us */
+
+	/* write/read test for device presence */
+	ret = ad7793_read_reg(st, AD7793_REG_ID, &id, 1);
+	if (ret)
+		goto out;
+
+	id &= AD7793_ID_MASK;
+
+	if (!((id == AD7792_ID) || (id == AD7793_ID))) {
+		dev_err(&st->spi->dev, "device ID query failed\n");
+		goto out;
+	}
+
+	st->mode  = (st->pdata->mode & ~AD7793_MODE_SEL(-1)) |
+			AD7793_MODE_SEL(AD7793_MODE_IDLE);
+	st->conf  = st->pdata->conf & ~AD7793_CONF_CHAN(-1);
+
+	ret = ad7793_write_reg(st, AD7793_REG_MODE, sizeof(st->mode), st->mode);
+	if (ret)
+		goto out;
+
+	ret = ad7793_write_reg(st, AD7793_REG_CONF, sizeof(st->conf), st->conf);
+	if (ret)
+		goto out;
+
+	ret = ad7793_write_reg(st, AD7793_REG_IO,
+			       sizeof(st->pdata->io), st->pdata->io);
+	if (ret)
+		goto out;
+
+	ret = ad7793_calibrate_all(st);
+	if (ret)
+		goto out;
+
+	/* Populate available ADC input ranges */
+	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+		scale_uv = ((u64)st->int_vref_mv * 100000000)
+			>> (st->chip_info->channel[0].scan_type.realbits -
+			(!!(st->conf & AD7793_CONF_UNIPOLAR) ? 0 : 1));
+		scale_uv >>= i;
+
+		st->scale_avail[i][1] = do_div(scale_uv, 100000000) * 10;
+		st->scale_avail[i][0] = scale_uv;
+	}
+
+	return 0;
+out:
+	dev_err(&st->spi->dev, "setup failed\n");
+	return ret;
+}
+
+static int ad7793_scan_from_ring(struct ad7793_state *st, unsigned ch, int *val)
+{
+	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	int ret;
+	s64 dat64[2];
+	u32 *dat32 = (u32 *)dat64;
+
+	if (!(ring->scan_mask & (1 << ch)))
+		return  -EBUSY;
+
+	ret = ring->access->read_last(ring, (u8 *) &dat64);
+	if (ret)
+		return ret;
+
+	*val = *dat32;
+
+	return 0;
+}
+
+static int ad7793_ring_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7793_state *st = iio_priv(indio_dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
+	size_t d_size;
+	unsigned channel;
+
+	if (!ring->scan_count)
+		return -EINVAL;
+
+	channel = __ffs(ring->scan_mask);
+
+	d_size = ring->scan_count *
+		 indio_dev->channels[0].scan_type.storagebits / 8;
+
+	if (ring->scan_timestamp) {
+		d_size += sizeof(s64);
+
+		if (d_size % sizeof(s64))
+			d_size += sizeof(s64) - (d_size % sizeof(s64));
+	}
+
+	if (indio_dev->ring->access->set_bytes_per_datum)
+		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
+							     d_size);
+
+	st->mode  = (st->mode & ~AD7793_MODE_SEL(-1)) |
+		    AD7793_MODE_SEL(AD7793_MODE_CONT);
+	st->conf  = (st->conf & ~AD7793_CONF_CHAN(-1)) |
+		    AD7793_CONF_CHAN(indio_dev->channels[channel].address);
+
+	ad7793_write_reg(st, AD7793_REG_CONF, sizeof(st->conf), st->conf);
+
+	spi_bus_lock(st->spi->master);
+	__ad7793_write_reg(st, 1, 1, AD7793_REG_MODE,
+			   sizeof(st->mode), st->mode);
+
+	st->irq_dis = false;
+	enable_irq(st->spi->irq);
+
+	return 0;
+}
+
+static int ad7793_ring_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7793_state *st = iio_priv(indio_dev);
+
+	st->mode  = (st->mode & ~AD7793_MODE_SEL(-1)) |
+		    AD7793_MODE_SEL(AD7793_MODE_IDLE);
+
+	st->done = false;
+	wait_event_interruptible(st->wq_data_avail, st->done);
+
+	if (!st->irq_dis)
+		disable_irq_nosync(st->spi->irq);
+
+	__ad7793_write_reg(st, 1, 0, AD7793_REG_MODE,
+			   sizeof(st->mode), st->mode);
+
+	return spi_bus_unlock(st->spi->master);
+}
+
+/**
+ * ad7793_trigger_handler() bh of trigger launched polling to ring buffer
+ **/
+
+static irqreturn_t ad7793_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct ad7793_state *st = iio_priv(indio_dev);
+	s64 dat64[2];
+	s32 *dat32 = (s32 *)dat64;
+
+	if (ring->scan_count)
+		__ad7793_read_reg(st, 1, 1, AD7793_REG_DATA,
+				  dat32,
+				  indio_dev->channels[0].scan_type.realbits/8);
+
+	/* Guaranteed to be aligned with 8 byte boundary */
+	if (ring->scan_timestamp)
+		dat64[1] = pf->timestamp;
+
+	ring->access->store_to(ring, (u8 *)dat64, pf->timestamp);
+
+	iio_trigger_notify_done(indio_dev->trig);
+	st->irq_dis = false;
+	enable_irq(st->spi->irq);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_ring_setup_ops ad7793_ring_setup_ops = {
+	.preenable = &ad7793_ring_preenable,
+	.postenable = &iio_triggered_ring_postenable,
+	.predisable = &iio_triggered_ring_predisable,
+	.postdisable = &ad7793_ring_postdisable,
+};
+
+static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
+{
+	int ret;
+
+	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->ring) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	/* Effectively select the ring buffer implementation */
+	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &ad7793_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "ad7793_consumer%d",
+						 indio_dev->id);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_deallocate_sw_rb;
+	}
+
+	/* Ring buffer functions - here trigger setup related */
+	indio_dev->ring->setup_ops = &ad7793_ring_setup_ops;
+
+	/* Flag that polled ring buffering is possible */
+	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	return 0;
+
+error_deallocate_sw_rb:
+	iio_sw_rb_free(indio_dev->ring);
+error_ret:
+	return ret;
+}
+
+static void ad7793_ring_cleanup(struct iio_dev *indio_dev)
+{
+	/* ensure that the trigger has been detached */
+	if (indio_dev->trig) {
+		iio_put_trigger(indio_dev->trig);
+		iio_trigger_dettach_poll_func(indio_dev->trig,
+					      indio_dev->pollfunc);
+	}
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+	iio_sw_rb_free(indio_dev->ring);
+}
+
+/**
+ * ad7793_data_rdy_trig_poll() the event handler for the data rdy trig
+ **/
+static irqreturn_t ad7793_data_rdy_trig_poll(int irq, void *private)
+{
+	struct ad7793_state *st = iio_priv(private);
+
+	st->done = true;
+	wake_up_interruptible(&st->wq_data_avail);
+	disable_irq_nosync(irq);
+	st->irq_dis = true;
+	iio_trigger_poll(st->trig, iio_get_time_ns());
+
+	return IRQ_HANDLED;
+}
+
+static int ad7793_probe_trigger(struct iio_dev *indio_dev)
+{
+	struct ad7793_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->trig = iio_allocate_trigger("%s-dev%d",
+					spi_get_device_id(st->spi)->name,
+					indio_dev->id);
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	ret = request_irq(st->spi->irq,
+			  ad7793_data_rdy_trig_poll,
+			  IRQF_TRIGGER_LOW,
+			  spi_get_device_id(st->spi)->name,
+			  indio_dev);
+	if (ret)
+		goto error_free_trig;
+
+	disable_irq_nosync(st->spi->irq);
+	st->irq_dis = true;
+	st->trig->dev.parent = &st->spi->dev;
+	st->trig->owner = THIS_MODULE;
+	st->trig->private_data = indio_dev;
+
+	ret = iio_trigger_register(st->trig);
+
+	/* select default trigger */
+	indio_dev->trig = st->trig;
+	if (ret)
+		goto error_free_irq;
+
+	return 0;
+
+error_free_irq:
+	free_irq(st->spi->irq, indio_dev);
+error_free_trig:
+	iio_free_trigger(st->trig);
+error_ret:
+	return ret;
+}
+
+static void ad7793_remove_trigger(struct iio_dev *indio_dev)
+{
+	struct ad7793_state *st = iio_priv(indio_dev);
+
+	iio_trigger_unregister(st->trig);
+	free_irq(st->spi->irq, indio_dev);
+	iio_free_trigger(st->trig);
+}
+
+static const u16 sample_freq_avail[16] = {0, 470, 242, 123, 62, 50, 39, 33, 19,
+					  17, 16, 12, 10, 8, 6, 4};
+
+static ssize_t ad7793_read_frequency(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7793_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n",
+		       sample_freq_avail[AD7793_MODE_RATE(st->mode)]);
+}
+
+static ssize_t ad7793_write_frequency(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7793_state *st = iio_priv(indio_dev);
+	long lval;
+	int i, ret;
+
+	mutex_lock(&indio_dev->mlock);
+	if (iio_ring_enabled(indio_dev)) {
+		mutex_unlock(&indio_dev->mlock);
+		return -EBUSY;
+	}
+	mutex_unlock(&indio_dev->mlock);
+
+	ret = strict_strtol(buf, 10, &lval);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(sample_freq_avail); i++)
+		if (lval == sample_freq_avail[i]) {
+			mutex_lock(&indio_dev->mlock);
+			st->mode &= ~AD7793_MODE_RATE(-1);
+			st->mode |= AD7793_MODE_RATE(i);
+			ad7793_write_reg(st, AD7793_REG_MODE,
+					 sizeof(st->mode), st->mode);
+			mutex_unlock(&indio_dev->mlock);
+			ret = 0;
+		}
+
+	return ret ? ret : len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+		ad7793_read_frequency,
+		ad7793_write_frequency);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
+	"470 242 123 62 50 39 33 19 17 16 12 10 8 6 4");
+
+static ssize_t ad7793_show_scale_available(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7793_state *st = iio_priv(indio_dev);
+	int i, len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
+		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
+			       st->scale_avail[i][1]);
+
+	len += sprintf(buf + len, "\n");
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available, in-in_scale_available,
+			     S_IRUGO, ad7793_show_scale_available, NULL, 0);
+
+static struct attribute *ad7793_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7793_attribute_group = {
+	.attrs = ad7793_attributes,
+};
+
+static int ad7793_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct ad7793_state *st = iio_priv(indio_dev);
+	int ret, smpl = 0;
+	unsigned long long scale_uv;
+	bool unipolar = !!(st->conf & AD7793_CONF_UNIPOLAR);
+
+	switch (m) {
+	case 0:
+		mutex_lock(&indio_dev->mlock);
+		if (iio_ring_enabled(indio_dev))
+			ret = ad7793_scan_from_ring(st,
+					chan->scan_index, &smpl);
+		else
+			ret = ad7793_read(st, chan->address,
+					chan->scan_type.realbits / 8, &smpl);
+		mutex_unlock(&indio_dev->mlock);
+
+		if (ret < 0)
+			return ret;
+
+		*val = (smpl >> chan->scan_type.shift) &
+			((1 << (chan->scan_type.realbits)) - 1);
+
+		if (!unipolar)
+			*val -= (1 << (chan->scan_type.realbits - 1));
+
+		return IIO_VAL_INT;
+
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		*val = st->scale_avail[(st->conf >> 8) & 0x7][0];
+		*val2 = st->scale_avail[(st->conf >> 8) & 0x7][1];
+
+		return IIO_VAL_INT_PLUS_NANO;
+
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		switch (chan->type) {
+		case IIO_IN:
+			/* 1170mV / 2^23 * 6 */
+			scale_uv = (1170ULL * 100000000ULL * 6ULL)
+				>> (chan->scan_type.realbits -
+				(unipolar ? 0 : 1));
+			break;
+		case IIO_TEMP:
+			/* Always uses unity gain and internal ref */
+			scale_uv = (2500ULL * 100000000ULL)
+				>> (chan->scan_type.realbits -
+				(unipolar ? 0 : 1));
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*val2 = do_div(scale_uv, 100000000) * 10;
+		*val =  scale_uv;
+
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+	return -EINVAL;
+}
+
+static int ad7793_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct ad7793_state *st = iio_priv(indio_dev);
+	int ret, i;
+	unsigned int tmp;
+
+	mutex_lock(&indio_dev->mlock);
+	if (iio_ring_enabled(indio_dev)) {
+		mutex_unlock(&indio_dev->mlock);
+		return -EBUSY;
+	}
+
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		ret = -EINVAL;
+		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
+			if (val2 == st->scale_avail[i][1]) {
+				tmp = st->conf;
+				st->conf &= ~AD7793_CONF_GAIN(-1);
+				st->conf |= AD7793_CONF_GAIN(i);
+
+				if (tmp != st->conf) {
+					ad7793_write_reg(st, AD7793_REG_CONF,
+							 sizeof(st->conf),
+							 st->conf);
+					ad7793_calibrate_all(st);
+				}
+				ret = 0;
+			}
+
+	default:
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+
+static int ad7793_validate_trigger(struct iio_dev *indio_dev,
+				   struct iio_trigger *trig)
+{
+	if (indio_dev->trig != trig)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ad7793_write_raw_get_fmt(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       long mask)
+{
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static const struct iio_info ad7793_info = {
+	.read_raw = &ad7793_read_raw,
+	.write_raw = &ad7793_write_raw,
+	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
+	.attrs = &ad7793_attribute_group,
+	.validate_trigger = ad7793_validate_trigger,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
+	[ID_AD7793] = {
+		.channel[0] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 0, 0,
+				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    AD7793_CH_AIN1P_AIN1M,
+				    0, IIO_ST('s', 24, 32, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 1,
+				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    AD7793_CH_AIN2P_AIN2M,
+				    1, IIO_ST('s', 24, 32, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 2,
+				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    AD7793_CH_AIN3P_AIN3M,
+				    2, IIO_ST('s', 24, 32, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, "shorted", 0, 0,
+				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    AD7793_CH_AIN1M_AIN1M,
+				    3, IIO_ST('s', 24, 32, 0), 0),
+		.channel[4] = IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
+				    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+				    AD7793_CH_TEMP,
+				    4, IIO_ST('s', 24, 32, 0), 0),
+		.channel[5] = IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 4, 0,
+				    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+				    AD7793_CH_AVDD_MONITOR,
+				    5, IIO_ST('s', 24, 32, 0), 0),
+		.channel[6] = IIO_CHAN_SOFT_TIMESTAMP(6),
+	},
+	[ID_AD7792] = {
+		.channel[0] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 0, 0,
+				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    AD7793_CH_AIN1P_AIN1M,
+				    0, IIO_ST('s', 16, 32, 0), 0),
+		.channel[1] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 1,
+				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    AD7793_CH_AIN2P_AIN2M,
+				    1, IIO_ST('s', 16, 32, 0), 0),
+		.channel[2] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 2,
+				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    AD7793_CH_AIN3P_AIN3M,
+				    2, IIO_ST('s', 16, 32, 0), 0),
+		.channel[3] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, "shorted", 0, 0,
+				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    AD7793_CH_AIN1M_AIN1M,
+				    3, IIO_ST('s', 16, 32, 0), 0),
+		.channel[4] = IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
+				    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+				    AD7793_CH_TEMP,
+				    4, IIO_ST('s', 16, 32, 0), 0),
+		.channel[5] = IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 4, 0,
+				    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+				    AD7793_CH_AVDD_MONITOR,
+				    5, IIO_ST('s', 16, 32, 0), 0),
+		.channel[6] = IIO_CHAN_SOFT_TIMESTAMP(6),
+	},
+};
+
+static int __devinit ad7793_probe(struct spi_device *spi)
+{
+	struct ad7793_platform_data *pdata = spi->dev.platform_data;
+	struct ad7793_state *st;
+	struct iio_dev *indio_dev;
+	int ret, i, voltage_uv = 0, regdone = 0;
+
+	if (!pdata) {
+		dev_err(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	if (!spi->irq) {
+		dev_err(&spi->dev, "no IRQ?\n");
+		return -ENODEV;
+	}
+
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			goto error_put_reg;
+
+		voltage_uv = regulator_get_voltage(st->reg);
+	}
+
+	st->chip_info =
+		&ad7793_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+
+	st->pdata = pdata;
+
+	if (pdata && pdata->vref_mv)
+		st->int_vref_mv = pdata->vref_mv;
+	else if (voltage_uv)
+		st->int_vref_mv = voltage_uv / 1000;
+	else
+		st->int_vref_mv = 2500; /* Build-in ref */
+
+	spi_set_drvdata(spi, indio_dev);
+	st->spi = spi;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->chip_info->channel;
+	indio_dev->available_scan_masks = st->available_scan_masks;
+	indio_dev->num_channels = 7;
+	indio_dev->info = &ad7793_info;
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		st->available_scan_masks[i] = (1 << i) | (1 <<
+			indio_dev->channels[indio_dev->num_channels - 1].
+			scan_index);
+
+	init_waitqueue_head(&st->wq_data_avail);
+
+	ret = ad7793_register_ring_funcs_and_init(indio_dev);
+	if (ret)
+		goto error_disable_reg;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unreg_ring;
+	regdone = 1;
+
+	ret = ad7793_probe_trigger(indio_dev);
+	if (ret)
+		goto error_unreg_ring;
+
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+					  indio_dev->channels,
+					  indio_dev->num_channels);
+	if (ret)
+		goto error_remove_trigger;
+
+	ret = ad7793_setup(st);
+	if (ret)
+		goto error_uninitialize_ring;
+
+	return 0;
+
+error_uninitialize_ring:
+	iio_ring_buffer_unregister(indio_dev->ring);
+error_remove_trigger:
+	ad7793_remove_trigger(indio_dev);
+error_unreg_ring:
+	ad7793_ring_cleanup(indio_dev);
+error_disable_reg:
+	if (!IS_ERR(st->reg))
+		regulator_disable(st->reg);
+error_put_reg:
+	if (!IS_ERR(st->reg))
+		regulator_put(st->reg);
+
+	if (regdone)
+		iio_device_unregister(indio_dev);
+	else
+		iio_free_device(indio_dev);
+
+	return ret;
+}
+
+static int ad7793_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7793_state *st = iio_priv(indio_dev);
+
+	iio_ring_buffer_unregister(indio_dev->ring);
+	ad7793_remove_trigger(indio_dev);
+	ad7793_ring_cleanup(indio_dev);
+
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
+	}
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct spi_device_id ad7793_id[] = {
+	{"ad7792", ID_AD7792},
+	{"ad7793", ID_AD7793},
+	{}
+};
+
+static struct spi_driver ad7793_driver = {
+	.driver = {
+		.name	= "ad7793",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad7793_probe,
+	.remove		= __devexit_p(ad7793_remove),
+	.id_table	= ad7793_id,
+};
+
+static int __init ad7793_init(void)
+{
+	return spi_register_driver(&ad7793_driver);
+}
+module_init(ad7793_init);
+
+static void __exit ad7793_exit(void)
+{
+	spi_unregister_driver(&ad7793_driver);
+}
+module_exit(ad7793_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD7792/3 ADC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7793.h b/drivers/staging/iio/adc/ad7793.h
new file mode 100644
index 0000000..64f7d41
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7793.h
@@ -0,0 +1,107 @@
+/*
+ * AD7792/AD7793 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+#ifndef IIO_ADC_AD7793_H_
+#define IIO_ADC_AD7793_H_
+
+/*
+ * TODO: struct ad7793_platform_data needs to go into include/linux/iio
+ */
+
+/* Registers */
+#define AD7793_REG_COMM		0 /* Communications Register (WO, 8-bit) */
+#define AD7793_REG_STAT		0 /* Status Register	     (RO, 8-bit) */
+#define AD7793_REG_MODE		1 /* Mode Register	     (RW, 16-bit */
+#define AD7793_REG_CONF		2 /* Configuration Register  (RW, 16-bit) */
+#define AD7793_REG_DATA		3 /* Data Register	     (RO, 16-/24-bit) */
+#define AD7793_REG_ID		4 /* ID Register	     (RO, 8-bit) */
+#define AD7793_REG_IO		5 /* IO Register	     (RO, 8-bit) */
+#define AD7793_REG_OFFSET	6 /* Offset Register	     (RW, 16-bit
+				   * (AD7792)/24-bit (AD7793)) */
+#define AD7793_REG_FULLSALE	7 /* Full-Scale Register
+				   * (RW, 16-bit (AD7792)/24-bit (AD7793)) */
+
+/* Communications Register Bit Designations (AD7793_REG_COMM) */
+#define AD7793_COMM_WEN		(1 << 7) /* Write Enable */
+#define AD7793_COMM_WRITE	(0 << 6) /* Write Operation */
+#define AD7793_COMM_READ	(1 << 6) /* Read Operation */
+#define AD7793_COMM_ADDR(x)	(((x) & 0x7) << 3) /* Register Address */
+#define AD7793_COMM_CREAD	(1 << 2) /* Continuous Read of Data Register */
+
+/* Status Register Bit Designations (AD7793_REG_STAT) */
+#define AD7793_STAT_RDY		(1 << 7) /* Ready */
+#define AD7793_STAT_ERR		(1 << 6) /* Error (Overrange, Underrange) */
+#define AD7793_STAT_CH3		(1 << 2) /* Channel 3 */
+#define AD7793_STAT_CH2		(1 << 1) /* Channel 2 */
+#define AD7793_STAT_CH1		(1 << 0) /* Channel 1 */
+
+/* Mode Register Bit Designations (AD7793_REG_MODE) */
+#define AD7793_MODE_SEL(x)	(((x) & 0x7) << 13) /* Operation Mode Select */
+#define AD7793_MODE_CLKSRC(x)	(((x) & 0x3) << 6) /* ADC Clock Source Select */
+#define AD7793_MODE_RATE(x)	((x) & 0xF) /* Filter Update Rate Select */
+
+#define AD7793_MODE_CONT		0 /* Continuous Conversion Mode */
+#define AD7793_MODE_SINGLE		1 /* Single Conversion Mode */
+#define AD7793_MODE_IDLE		2 /* Idle Mode */
+#define AD7793_MODE_PWRDN		3 /* Power-Down Mode */
+#define AD7793_MODE_CAL_INT_ZERO	4 /* Internal Zero-Scale Calibration */
+#define AD7793_MODE_CAL_INT_FULL	5 /* Internal Full-Scale Calibration */
+#define AD7793_MODE_CAL_SYS_ZERO	6 /* System Zero-Scale Calibration */
+#define AD7793_MODE_CAL_SYS_FULL	7 /* System Full-Scale Calibration */
+
+#define AD7793_CLK_INT		0 /* Internal 64 kHz Clock not
+				   * available at the CLK pin */
+#define AD7793_CLK_INT_CO	1 /* Internal 64 kHz Clock available
+				   * at the CLK pin */
+#define AD7793_CLK_EXT		2 /* External 64 kHz Clock */
+#define AD7793_CLK_EXT_DIV2	3 /* External Clock divided by 2 */
+
+/* Configuration Register Bit Designations (AD7793_REG_CONF) */
+#define AD7793_CONF_VBIAS(x)	(((x) & 0x3) << 14) /* Bias Voltage
+						     * Generator Enable */
+#define AD7793_CONF_BO_EN	(1 << 13) /* Burnout Current Enable */
+#define AD7793_CONF_UNIPOLAR	(1 << 12) /* Unipolar/Bipolar Enable */
+#define AD7793_CONF_BOOST	(1 << 11) /* Boost Enable */
+#define AD7793_CONF_GAIN(x)	(((x) & 0x7) << 8) /* Gain Select */
+#define AD7793_CONF_REFSEL	(1 << 7) /* INT/EXT Reference Select */
+#define AD7793_CONF_BUF		(1 << 4) /* Buffered Mode Enable */
+#define AD7793_CONF_CHAN(x)	((x) & 0x7) /* Channel select */
+
+#define AD7793_CH_AIN1P_AIN1M	0 /* AIN1(+) - AIN1(-) */
+#define AD7793_CH_AIN2P_AIN2M	1 /* AIN2(+) - AIN2(-) */
+#define AD7793_CH_AIN3P_AIN3M	2 /* AIN3(+) - AIN3(-) */
+#define AD7793_CH_AIN1M_AIN1M	3 /* AIN1(-) - AIN1(-) */
+#define AD7793_CH_TEMP		6 /* Temp Sensor */
+#define AD7793_CH_AVDD_MONITOR	7 /* AVDD Monitor */
+
+/* ID Register Bit Designations (AD7793_REG_ID) */
+#define AD7792_ID		0xA
+#define AD7793_ID		0xB
+#define AD7793_ID_MASK		0xF
+
+/* IO (Excitation Current Sources) Register Bit Designations (AD7793_REG_IO) */
+#define AD7793_IO_IEXC1_IOUT1_IEXC2_IOUT2	0 /* IEXC1 connect to IOUT1,
+						   * IEXC2 connect to IOUT2 */
+#define AD7793_IO_IEXC1_IOUT2_IEXC2_IOUT1	1 /* IEXC1 connect to IOUT2,
+						   * IEXC2 connect to IOUT1 */
+#define AD7793_IO_IEXC1_IEXC2_IOUT1		2 /* Both current sources
+						   * IEXC1,2 connect to IOUT1 */
+#define AD7793_IO_IEXC1_IEXC2_IOUT2		3 /* Both current sources
+						   * IEXC1,2 connect to IOUT2 */
+
+#define AD7793_IO_IXCEN_10uA	(1 << 0) /* Excitation Current 10uA */
+#define AD7793_IO_IXCEN_210uA	(2 << 0) /* Excitation Current 210uA */
+#define AD7793_IO_IXCEN_1mA	(3 << 0) /* Excitation Current 1mA */
+
+struct ad7793_platform_data {
+	u16			vref_mv;
+	u16			mode;
+	u16			conf;
+	u8			io;
+};
+
+#endif /* IIO_ADC_AD7793_H_ */
--
1.7.0.4
