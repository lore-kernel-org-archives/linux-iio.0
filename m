Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Wolfgang Denk <wd@denx.de>,
	Juergen Beisert <jbe@pengutronix.de>
Subject: [PATCH] IIO: Add basic MXS LRADC driver
Date: Wed,  4 Jul 2012 04:15:29 +0200
Message-Id: <1341368129-20468-1-git-send-email-marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

This driver is very basic. It supports userland trigger, buffer and
raw access to channels. The support for delay channels is missing
altogether.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Juergen Beisert <jbe@pengutronix.de>
---
 drivers/staging/iio/adc/Kconfig     |   12 +
 drivers/staging/iio/adc/Makefile    |    1 +
 drivers/staging/iio/adc/mxs-lradc.c |  619 +++++++++++++++++++++++++++++++++++
 3 files changed, 632 insertions(+)
 create mode 100644 drivers/staging/iio/adc/mxs-lradc.c

Jonathan, you can now rip me to shreds for not understanding your teachings.
Please kindly review the products of my labor ;-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 67711b7..97ca697 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -200,6 +200,18 @@ config LPC32XX_ADC
 	  activate only one via device tree selection.  Provides direct access
 	  via sysfs.
 
+config MXS_LRADC
+	tristate "Freescale i.MX23/i.MX28 LRADC"
+	depends on ARCH_MXS
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for i.MX23/i.MX28 LRADC convertor
+	  built into these chips.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mxs-lradc.
+
 config SPEAR_ADC
 	tristate "ST SPEAr ADC"
 	depends on PLAT_SPEAR
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 14e98b6..ecac9a0 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -38,4 +38,5 @@ obj-$(CONFIG_ADT7310) += adt7310.o
 obj-$(CONFIG_ADT7410) += adt7410.o
 obj-$(CONFIG_AD7280) += ad7280a.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
+obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
new file mode 100644
index 0000000..d4089c6
--- /dev/null
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -0,0 +1,619 @@
+/*
+ * Freescale i.MX233/i.MX28 LRADC driver
+ *
+ * Copyright (c) 2012 DENX Software Engineering, GmbH.
+ * Marek Vasut <marex@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/stmp_device.h>
+#include <linux/bitops.h>
+
+#include <mach/mxs.h>
+#include <mach/common.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define DRIVER_NAME		"mxs-lradc"
+
+#define LRADC_MAX_DELAY_CHANS	4
+#define LRADC_MAX_MAPPED_CHANS	8
+#define LRADC_MAX_TOTAL_CHANS	16
+
+#define LRADC_DELAY_TIMER_HZ	2000
+
+#define LRADC_CHAN_FLAG_RAW	(1 << 0)
+#define LRADC_CHAN_FLAG_BUF	(1 << 1)
+
+static const char * const mxs_lradc_irq_name[] = {
+	"mxs-lradc-touchscreen",
+	"mxs-lradc-thresh0",
+	"mxs-lradc-thresh1",
+	"mxs-lradc-channel0",
+	"mxs-lradc-channel1",
+	"mxs-lradc-channel2",
+	"mxs-lradc-channel3",
+	"mxs-lradc-channel4",
+	"mxs-lradc-channel5",
+	"mxs-lradc-channel6",
+	"mxs-lradc-channel7",
+	"mxs-lradc-button0",
+	"mxs-lradc-button1",
+};
+
+struct mxs_lradc_chan {
+	uint8_t				slot;
+	uint8_t				flags;
+};
+
+struct mxs_lradc {
+	struct iio_dev		*iio;
+	struct device		*dev;
+	void __iomem		*base;
+	int			irq[13];
+	int			idis;
+
+	uint32_t		*buffer;
+	struct iio_trigger	*trig;
+
+	struct mutex		map_lock;
+	struct mxs_lradc_chan	channel[LRADC_MAX_TOTAL_CHANS];
+	unsigned long		slot_map;
+
+	wait_queue_head_t	wq_data_avail[LRADC_MAX_MAPPED_CHANS];
+	bool			wq_done[LRADC_MAX_MAPPED_CHANS];
+};
+
+struct mxs_lradc_data {
+	struct mxs_lradc	*lradc;
+};
+
+#define	LRADC_CTRL0				0x00
+#define LRADC_CTRL0_TOUCH_DETECT_ENABLE		(1 << 23)
+#define LRADC_CTRL0_TOUCH_SCREEN_TYPE		(1 << 22)
+
+#define	LRADC_CTRL1				0x10
+#define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
+#define	LRADC_CTRL1_LRADC_IRQ_MASK		0x1fff
+#define	LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
+#define	LRADC_CTRL1_LRADC_IRQ_EN_MASK		(0x1fff << 16)
+
+#define	LRADC_CTRL2				0x20
+#define	LRADC_CTRL2_TEMPSENSE_PWD		(1 << 15)
+
+#define	LRADC_CH(n)				(0x50 + (0x10 * (n)))
+#define	LRADC_CH_ACCUMULATE			(1 << 29)
+#define	LRADC_CH_NUM_SAMPLES_MASK		(0x1f << 24)
+#define	LRADC_CH_NUM_SAMPLES_OFFSET		24
+#define	LRADC_CH_VALUE_MASK			0x3ffff
+#define	LRADC_CH_VALUE_OFFSET			0
+
+#define	LRADC_DELAY(n)				(0xd0 + (0x10 * (n)))
+#define	LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xff << 24)
+#define	LRADC_DELAY_TRIGGER_LRADCS_OFFSET	24
+#define	LRADC_DELAY_KICK			(1 << 20)
+#define	LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
+#define	LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
+#define	LRADC_DELAY_LOOP_COUNT_MASK		(0x1f << 11)
+#define	LRADC_DELAY_LOOP_COUNT_OFFSET		11
+#define	LRADC_DELAY_DELAY_MASK			0x7ff
+#define	LRADC_DELAY_DELAY_OFFSET		0
+
+#define	LRADC_CTRL4				0x140
+#define	LRADC_CTRL4_LRADCSELECT_MASK(n)		(0xf << ((n) * 4))
+#define	LRADC_CTRL4_LRADCSELECT_OFFSET(n)	((n) * 4)
+
+/*
+ * Channel management
+ *
+ * This involves crazy mapping between 8 virtual channels the CTRL4 register
+ * can harbor and 16 channels total this hardware supports.
+ */
+static int mxs_lradc_map_channel(struct mxs_lradc *lradc,
+				uint8_t channel, uint8_t flags)
+{
+	int ret;
+
+	/* Invalid channel */
+	if (channel > LRADC_MAX_TOTAL_CHANS)
+		return -EINVAL;
+
+	mutex_lock(&lradc->map_lock);
+
+	/* Channel is already mapped */
+	if (lradc->channel[channel].flags) {
+
+		/* Channel is mapped to requested delay slot */
+		lradc->channel[channel].flags |= flags;
+		ret = lradc->channel[channel].slot;
+		goto exit;
+
+	} else {	/* Channel isn't mapped yet */
+		/* 8 channels already mapped, can't map any more */
+		if (bitmap_full(&lradc->slot_map, LRADC_MAX_MAPPED_CHANS)) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		ret = find_first_zero_bit(&lradc->slot_map,
+					LRADC_MAX_MAPPED_CHANS);
+
+		lradc->channel[channel].slot = ret;
+		lradc->channel[channel].flags |= flags;
+		lradc->slot_map |= 1 << ret;
+
+		writel(LRADC_CTRL4_LRADCSELECT_MASK(ret),
+			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
+		writel(channel << LRADC_CTRL4_LRADCSELECT_OFFSET(ret),
+			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
+
+		writel(LRADC_CTRL1_LRADC_IRQ_EN(ret),
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+
+		writel(0, lradc->base + LRADC_CH(ret));
+	}
+
+exit:
+	mutex_unlock(&lradc->map_lock);
+
+	/* Return the slot the channel was mapped to */
+	return ret;
+}
+
+static int mxs_lradc_unmap_channel(struct mxs_lradc *lradc,
+				uint8_t channel, uint8_t flags)
+{
+	int slot;
+
+	/* Invalid channel */
+	if (channel > LRADC_MAX_TOTAL_CHANS)
+		return -EINVAL;
+
+	mutex_lock(&lradc->map_lock);
+
+	/* Channel not mapped */
+	if (!lradc->channel[channel].flags) {
+		mutex_unlock(&lradc->map_lock);
+		return -EINVAL;
+	}
+
+	lradc->channel[channel].flags &= ~flags;
+	slot = lradc->channel[channel].slot;
+
+	/* No more users of this channel, unmap it */
+	if (!lradc->channel[channel].flags) {
+		lradc->slot_map &= ~(1 << slot);
+
+		writel(LRADC_CTRL1_LRADC_IRQ_EN(slot),
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	}
+
+	mutex_unlock(&lradc->map_lock);
+
+	return slot;
+}
+
+static void mxs_lradc_run_slots(struct mxs_lradc *lradc, uint8_t slots)
+{
+	writel(slots, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+}
+
+/*
+ * Raw I/O operations
+ */
+static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
+			const struct iio_chan_spec *chan,
+			int *val, int *val2, long m)
+{
+	struct mxs_lradc_data *data = iio_priv(iio_dev);
+	struct mxs_lradc *lradc = data->lradc;
+	int ret, slot;
+
+	if (m != 0)
+		return -EINVAL;
+
+	/* Map channel. */
+	slot = mxs_lradc_map_channel(lradc, chan->channel, LRADC_CHAN_FLAG_RAW);
+	if (slot < 0)
+		return slot;
+
+	/* Start sampling. */
+	mxs_lradc_run_slots(lradc, 1 << slot);
+
+	/* Wait for completion on the channel, 1 second max. */
+	lradc->wq_done[slot] = false;
+	ret = wait_event_interruptible_timeout(lradc->wq_data_avail[slot],
+					       lradc->wq_done[slot],
+					       msecs_to_jiffies(1000));
+	if (!ret) {
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	/* Read the data. */
+	*val = readl(lradc->base + LRADC_CH(slot)) & LRADC_CH_VALUE_MASK;
+	ret = IIO_VAL_INT;
+
+err:
+	/* Unmap the channel. */
+	mxs_lradc_unmap_channel(lradc, chan->channel, LRADC_CHAN_FLAG_RAW);
+
+	return ret;
+}
+
+static const struct iio_info mxs_lradc_iio_info = {
+	.driver_module		= THIS_MODULE,
+	.read_raw		= mxs_lradc_read_raw,
+};
+
+/*
+ * IRQ Handling
+ */
+static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
+{
+	struct mxs_lradc *lradc = data;
+	int bit;
+	unsigned long reg = readl(lradc->base + LRADC_CTRL1);
+
+	/*
+	 * Touchscreen IRQ handling code shall probably have priority
+	 * and therefore shall be placed here.
+	 */
+
+	/* Wake up each LRADC channel. */
+	for_each_set_bit(bit, &reg, 8) {
+		lradc->wq_done[bit] = true;
+		wake_up_interruptible(&lradc->wq_data_avail[bit]);
+	}
+
+	if (iio_buffer_enabled(lradc->iio)) {
+		disable_irq_nosync(irq);
+		lradc->idis = irq;
+		iio_trigger_poll(lradc->iio->trig, iio_get_time_ns());
+	}
+
+	writel(0x1fff, lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Trigger handling
+ */
+static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct mxs_lradc_data *data = iio_priv(iio);
+	struct mxs_lradc *lradc = data->lradc;
+	struct iio_buffer *buffer = iio->buffer;
+	int i, j = 0, slot;
+
+	for (i = 0; i < iio->masklength; i++) {
+		if (!test_bit(i, iio->active_scan_mask))
+			continue;
+
+		slot = lradc->channel[i].slot;
+
+		lradc->buffer[j] = readl(lradc->base + LRADC_CH(slot));
+		lradc->buffer[j] &= LRADC_CH_VALUE_MASK;
+
+		j++;
+	}
+
+	if (iio->scan_timestamp) {
+		s64 *timestamp = (s64 *)((u8 *)lradc->buffer +
+					ALIGN(j, sizeof(s64)));
+		*timestamp = pf->timestamp;
+	}
+
+	iio_push_to_buffer(buffer, (u8 *)lradc->buffer, pf->timestamp);
+
+	iio_trigger_notify_done(iio->trig);
+
+	enable_irq(lradc->idis);
+
+	return IRQ_HANDLED;
+}
+
+static int mxs_lradc_configure_trigger(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *iio = trig->private_data;
+	struct mxs_lradc_data *data = iio_priv(iio);
+	struct mxs_lradc *lradc = data->lradc;
+	struct iio_buffer *buffer = iio->buffer;
+	int slot, bit, ret = 0;
+	uint8_t map = 0;
+	unsigned long chans = 0;
+
+	if (!state)
+		goto exit;
+
+	lradc->buffer = kmalloc(iio->scan_bytes, GFP_KERNEL);
+	if (!lradc->buffer)
+		return -ENOMEM;
+
+	for_each_set_bit(bit, buffer->scan_mask, LRADC_MAX_TOTAL_CHANS) {
+		slot = mxs_lradc_map_channel(lradc, bit, LRADC_CHAN_FLAG_BUF);
+
+		if (slot < 0) {
+			ret = -EINVAL;
+			goto exit;
+		}
+		map |= 1 << slot;
+		chans |= 1 << bit;
+	}
+
+	mxs_lradc_run_slots(lradc, map);
+
+	return 0;
+
+exit:
+	for_each_set_bit(bit, &chans, LRADC_MAX_TOTAL_CHANS)
+		mxs_lradc_unmap_channel(lradc, bit, LRADC_CHAN_FLAG_BUF);
+
+	kfree(lradc->buffer);
+
+	return ret;
+}
+
+static const struct iio_trigger_ops mxs_lradc_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &mxs_lradc_configure_trigger,
+};
+
+static int mxs_lradc_trigger_init(struct iio_dev *iio)
+{
+	int ret;
+	struct iio_trigger *trig;
+
+	trig = iio_trigger_alloc("%s-dev%i", iio->name, iio->id);
+	if (trig == NULL)
+		return -ENOMEM;
+
+	trig->dev.parent = iio->dev.parent;
+	trig->private_data = iio;
+	trig->ops = &mxs_lradc_trigger_ops;
+
+	ret = iio_trigger_register(trig);
+	if (ret) {
+		iio_trigger_free(trig);
+		return ret;
+	}
+
+	iio->trig = trig;
+
+	return 0;
+}
+
+static void mxs_lradc_trigger_remove(struct iio_dev *iio)
+{
+	iio_trigger_unregister(iio->trig);
+	iio_trigger_free(iio->trig);
+}
+
+/*
+ * Buffer ops
+ */
+static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
+	.preenable = &iio_sw_buffer_preenable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+};
+
+/*
+ *****************************************************************************
+ * DRIVER INIT STUFF
+ *****************************************************************************
+ */
+
+#define MXS_ADC_CHAN(idx, chan_type) {				\
+	.type = (chan_type),					\
+	.indexed = 1,						\
+	.scan_index = (idx),					\
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,		\
+	.channel = (idx),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 18,					\
+		.storagebits = 32,				\
+	},							\
+}
+
+static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
+	MXS_ADC_CHAN(0, IIO_VOLTAGE),
+	MXS_ADC_CHAN(1, IIO_VOLTAGE),
+	MXS_ADC_CHAN(2, IIO_VOLTAGE),
+	MXS_ADC_CHAN(3, IIO_VOLTAGE),
+	MXS_ADC_CHAN(4, IIO_VOLTAGE),
+	MXS_ADC_CHAN(5, IIO_VOLTAGE),
+	MXS_ADC_CHAN(6, IIO_VOLTAGE),
+	MXS_ADC_CHAN(7, IIO_VOLTAGE),	/* VBATT */
+	MXS_ADC_CHAN(8, IIO_TEMP),	/* Temp sense 0 */
+	MXS_ADC_CHAN(9, IIO_TEMP),	/* Temp sense 1 */
+	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
+	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
+	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
+	MXS_ADC_CHAN(13, IIO_VOLTAGE),	/* VDDD */
+	MXS_ADC_CHAN(14, IIO_VOLTAGE),	/* VBG */
+	MXS_ADC_CHAN(15, IIO_VOLTAGE),	/* VDD5V */
+};
+
+static void mxs_lradc_hw_init(struct mxs_lradc *lradc)
+{
+	int i;
+
+	stmp_reset_block(lradc->base);
+
+	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
+		writel(0, lradc->base + LRADC_DELAY(i));
+
+	/* Start internal temperature sensing. */
+	writel(0, lradc->base + LRADC_CTRL2);
+}
+
+static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
+{
+	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
+		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+}
+
+static int __devinit mxs_lradc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mxs_lradc_data *data;
+	struct mxs_lradc *lradc;
+	struct iio_dev *iio;
+	struct resource *iores;
+	int ret = 0;
+	int i;
+
+	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
+	if (!lradc)
+		return -ENOMEM;
+
+	/* Grab the memory area */
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lradc->base = devm_request_and_ioremap(dev, iores);
+	if (!lradc->base)
+		return -EADDRNOTAVAIL;
+
+	/* Grab all IRQ sources */
+	for (i = 0; i < 13; i++) {
+		lradc->irq[i] = platform_get_irq(pdev, i);
+		if (lradc->irq[i] < 0)
+			return -EINVAL;
+
+		ret = devm_request_irq(dev, lradc->irq[i],
+					mxs_lradc_handle_irq, 0,
+					mxs_lradc_irq_name[i], lradc);
+		if (ret)
+			return ret;
+	}
+
+	/* Init workqueues, one per channel */
+	for (i = 0; i < LRADC_MAX_MAPPED_CHANS; i++)
+		init_waitqueue_head(&lradc->wq_data_avail[i]);
+
+	dev_set_drvdata(&pdev->dev, lradc);
+
+	mutex_init(&lradc->map_lock);
+
+	/* Allocate the IIO device. */
+	iio = iio_device_alloc(sizeof(*data));
+	if (!iio) {
+		dev_err(dev, "Failed to allocate IIO device %i\n", i);
+		return -ENOMEM;
+	}
+
+	lradc->iio = iio;
+
+	iio->name = pdev->name;
+	iio->dev.parent = &pdev->dev;
+	iio->info = &mxs_lradc_iio_info;
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->channels = mxs_lradc_chan_spec;
+	iio->num_channels = ARRAY_SIZE(mxs_lradc_chan_spec);
+
+	/*
+	 * This here is intentional. Once we'll support the delay channels this
+	 * hardware provides, we will need to store more data in IIO devices'
+	 * private data.
+	 */
+	data = iio_priv(iio);
+	data->lradc = lradc;
+
+	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
+				&mxs_lradc_trigger_handler, NULL);
+	if (ret)
+		goto err0;
+
+	ret = mxs_lradc_trigger_init(iio);
+	if (ret)
+		goto err1;
+
+	/* Configure the hardware. */
+	mxs_lradc_hw_init(lradc);
+
+	/*
+	 * Register IIO device
+	 */
+	ret = iio_device_register(iio);
+	if (ret) {
+		dev_err(dev, "Failed to register IIO device\n");
+		goto err2;
+	}
+
+	return 0;
+
+err2:
+	mxs_lradc_trigger_remove(iio);
+err1:
+	iio_triggered_buffer_cleanup(lradc->iio);
+err0:
+	iio_device_free(iio);
+	return ret;
+}
+
+static int __devexit mxs_lradc_remove(struct platform_device *pdev)
+{
+	struct mxs_lradc *lradc = dev_get_drvdata(&pdev->dev);
+
+	mxs_lradc_hw_stop(lradc);
+
+	iio_device_unregister(lradc->iio);
+	iio_triggered_buffer_cleanup(lradc->iio);
+	mxs_lradc_trigger_remove(lradc->iio);
+	iio_device_free(lradc->iio);
+
+	return 0;
+}
+
+static const struct of_device_id mxs_lradc_dt_ids[] = {
+	{ .compatible = "fsl,imx28-lradc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
+
+static struct platform_driver mxs_lradc_driver = {
+	.driver	= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = mxs_lradc_dt_ids,
+	},
+	.probe	= mxs_lradc_probe,
+	.remove	= __devexit_p(mxs_lradc_remove),
+};
+
+module_platform_driver(mxs_lradc_driver);
+
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("Freescale i.MX23/i.MX28 LRADC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.10
