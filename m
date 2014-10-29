Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:20178 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398AbaJ2Upn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Oct 2014 16:45:43 -0400
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <jic23@kernel.org>,
	<Naidu.Tellapati@imgtec.com>, <james.hartley@imgtec.com>,
	<abrestic@chromium.org>
CC: Phani Movva <Phani.Movva@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 1/2] iio: adc: Cosmic Circuits 10001 ADC driver
Date: Wed, 29 Oct 2014 20:45:30 +0000
Message-ID: <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Phani Movva <Phani.Movva@imgtec.com>

This commit adds support for Cosmic Circuits 10001 10-bit ADC device.

Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
[Ezequiel: code style cleaning]
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/iio/adc/Kconfig        |   7 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/cc_10001_adc.c | 421 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 429 insertions(+)
 create mode 100644 drivers/iio/adc/cc_10001_adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 88bdc8f..be86c99 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -127,6 +127,13 @@ config AT91_ADC
 	help
 	  Say yes here to build support for Atmel AT91 ADC.
 
+config CC_10001_ADC
+	tristate "Cosmic Circuits 10001 ADC driver"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Cosmic Circuits 10001 ADC driver
+
 config EXYNOS_ADC
 	tristate "Exynos ADC driver support"
 	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index cb88a6a..f4d522d 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
 obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
+obj-$(CONFIG_CC_10001_ADC) += cc_10001_adc.o
 obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_MAX1027) += max1027.o
diff --git a/drivers/iio/adc/cc_10001_adc.c b/drivers/iio/adc/cc_10001_adc.c
new file mode 100644
index 0000000..d8cc2c3
--- /dev/null
+++ b/drivers/iio/adc/cc_10001_adc.c
@@ -0,0 +1,421 @@
+/**
+ * Copyright (c) 2014 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* Registers */
+#define CC_10001_ADC_CONFIG		0x00
+#define CC_10001_ADC_START_CONV		BIT(4)
+#define CC_10001_ADC_MODE_SINGLE_CONV	BIT(5)
+
+#define CC_10001_ADC_DDATA_OUT		0x04
+#define CC_10001_ADC_EOC		0x08
+#define CC_10001_ADC_EOC_SET		BIT(0)
+
+#define CC_10001_ADC_CHSEL_SAMPLED	0x0C
+#define CC_10001_ADC_POWER_DOWN		0x10
+#define CC_10001_ADC_DEBUG		0x14
+#define CC_10001_ADC_DATA_COUNT		0x20
+
+#define CC_10001_ADC_DATA_MASK		0x3ff /* 10-bit data mask */
+#define CC_10001_ADC_NUM_CHANNELS	8
+#define CC_10001_ADC_CH_MASK		(CC_10001_ADC_NUM_CHANNELS - 1)
+
+/**
+  * The following macro is used to indicate the driver consumer that the
+  * 10-bit sampled output data is invalid on corresponding ADC channel.
+  *
+  * Push invalid data (0xFFFF) to IIO FIFO corresponding to a channel on
+  * which poll for end of conversion bit times-out. This is a remote
+  * possibility.
+  *
+  * After end-of-conversion bit is set, poll the sampled output channel
+  * register to see the channel number written into the register is equal to
+  * the channel number on which the driver has started conversion. If the poll
+  * times-out, push invalid data (0xFFFF) to IIO FIFO. This is again a remote
+  * possibility.
+  */
+#define INVALID_SAMPLED_OUTPUT		0xFFFF
+#define MAX_POLL_COUNT			20
+
+/*
+ * As per device specification, wait six clock cycles after power-up to
+ * activate START. Since adding two more clock cycles delay does not
+ * impact the performance too much, we are adding two additional cycles delay
+ * intentionally here.
+ */
+#define	WAIT_CYCLES			8
+
+struct cc_10001_adc_device {
+	void __iomem *reg_base;
+	struct iio_dev *dev;
+	struct clk *adc_clk;
+	struct regulator *reg;
+	struct mutex lock;
+	unsigned long channel_map;
+	unsigned int start_delay_ns;
+	unsigned int eoc_delay_ns;
+	unsigned long vref_mv;
+};
+
+static inline void cc_adc_write_reg(struct cc_10001_adc_device *adc_dev,
+			unsigned int reg, unsigned int value)
+{
+	writel(value, adc_dev->reg_base + reg);
+}
+
+static inline unsigned int cc_adc_read_reg(struct cc_10001_adc_device *adc_dev,
+				unsigned int reg)
+{
+	return readl(adc_dev->reg_base + reg);
+}
+
+static void cc_adc_start(struct cc_10001_adc_device *adc_dev, int ch_num)
+{
+	u32 val;
+
+	/* Channel selection and mode of operation */
+	val = (ch_num & CC_10001_ADC_CH_MASK) | CC_10001_ADC_MODE_SINGLE_CONV;
+	cc_adc_write_reg(adc_dev, CC_10001_ADC_CONFIG, val);
+
+	val = cc_adc_read_reg(adc_dev, CC_10001_ADC_CONFIG);
+	val = val | CC_10001_ADC_START_CONV;
+	cc_adc_write_reg(adc_dev, CC_10001_ADC_CONFIG, val);
+}
+
+static int cc_adc_poll_done(struct iio_dev *dev, int channel,
+			    unsigned int delay)
+{
+	struct cc_10001_adc_device *adc_dev = iio_priv(dev);
+	int val = INVALID_SAMPLED_OUTPUT;
+	int poll_count = 0;
+
+	while (!(cc_adc_read_reg(adc_dev, CC_10001_ADC_EOC) &
+			CC_10001_ADC_EOC_SET)) {
+
+		ndelay(delay);
+		if (poll_count++ == MAX_POLL_COUNT)
+			return val;
+	}
+
+	poll_count = 0;
+	while ((cc_adc_read_reg(adc_dev, CC_10001_ADC_CHSEL_SAMPLED) &
+			CC_10001_ADC_CH_MASK) != channel) {
+
+		ndelay(delay);
+		if (poll_count++ == MAX_POLL_COUNT)
+			return val;
+	}
+
+	/* Read the 10 bit output register */
+	return cc_adc_read_reg(adc_dev, CC_10001_ADC_DDATA_OUT);
+}
+
+static irqreturn_t cc_10001_adc_trigger_h(int irq, void *p)
+{
+	u16 *data;
+	u16 val = 0;
+	unsigned int delay_ns = 0;
+	struct iio_dev *dev;
+	struct iio_poll_func *pf = p;
+	struct cc_10001_adc_device *adc_dev;
+
+	dev = pf->indio_dev;
+	adc_dev = iio_priv(dev);
+
+	data = kmalloc(dev->scan_bytes, GFP_KERNEL);
+	if (!data)
+		goto done;
+
+	mutex_lock(&adc_dev->lock);
+
+	/* Power-up ADC */
+	cc_adc_write_reg(adc_dev, CC_10001_ADC_POWER_DOWN, 1);
+
+	/* Wait for 8 (6+2) clock cycles before activating START */
+	ndelay(adc_dev->start_delay_ns);
+
+	/* Calculate delay step for eoc and sampled data */
+	delay_ns = (adc_dev->eoc_delay_ns / MAX_POLL_COUNT);
+
+	if (!bitmap_empty(dev->active_scan_mask, dev->masklength)) {
+		int i, j;
+		for (i = 0, j = 0;
+		     i < bitmap_weight(dev->active_scan_mask, dev->masklength);
+		     i++, j++) {
+
+			j = find_next_bit(dev->active_scan_mask,
+					  dev->masklength, j);
+
+			cc_adc_start(adc_dev, j);
+			val = cc_adc_poll_done(dev, j, delay_ns);
+			data[i] = val & CC_10001_ADC_DATA_MASK;
+		}
+	}
+
+	/* Power-down ADC */
+	cc_adc_write_reg(adc_dev, CC_10001_ADC_POWER_DOWN, 0);
+
+	mutex_unlock(&adc_dev->lock);
+
+	iio_push_to_buffers_with_timestamp(dev, data, iio_get_time_ns());
+
+	kfree(data);
+done:
+	/*
+	 * Tell the core we are done with this trigger and ready for the
+	 * next one.
+	 */
+	iio_trigger_notify_done(dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int cc_10001_adc_read_raw_voltage(struct iio_dev *dev,
+					 struct iio_chan_spec const *chan)
+{
+	struct cc_10001_adc_device *adc_dev = iio_priv(dev);
+	unsigned int delay_ns;
+	int val;
+
+	/* Power-up ADC */
+	cc_adc_write_reg(adc_dev, CC_10001_ADC_POWER_DOWN, 1);
+
+	/* Wait for 8 (6+2) clock cycles before activating START */
+	ndelay(adc_dev->start_delay_ns);
+
+	/* Calculate delay step for eoc and sampled data */
+	delay_ns = (adc_dev->eoc_delay_ns / MAX_POLL_COUNT);
+
+	cc_adc_start(adc_dev, chan->channel);
+
+	val = cc_adc_poll_done(dev, chan->channel, delay_ns);
+
+	/* Power-down ADC */
+	cc_adc_write_reg(adc_dev, CC_10001_ADC_POWER_DOWN, 0);
+
+	return val;
+}
+
+static int cc_10001_adc_read_raw(struct iio_dev *dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	struct cc_10001_adc_device *adc_dev = iio_priv(dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(dev))
+			return -EBUSY;
+		mutex_lock(&adc_dev->lock);
+		*val = cc_10001_adc_read_raw_voltage(dev, chan);
+		mutex_unlock(&adc_dev->lock);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = adc_dev->vref_mv;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info cc_10001_adc_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &cc_10001_adc_read_raw,
+};
+
+static int cc_10001_adc_channel_init(struct iio_dev *dev)
+{
+	struct cc_10001_adc_device *adc_dev = iio_priv(dev);
+	struct iio_chan_spec *chan_array, *timestamp;
+	int bit, idx = 0;
+
+	dev->num_channels = 1 + bitmap_weight(&adc_dev->channel_map,
+					      CC_10001_ADC_NUM_CHANNELS);
+
+	chan_array = devm_kcalloc(&dev->dev, dev->num_channels + 1,
+				  sizeof(struct iio_chan_spec),
+				  GFP_KERNEL);
+	if (!chan_array)
+		return -ENOMEM;
+
+	for_each_set_bit(bit, &adc_dev->channel_map,
+			 CC_10001_ADC_NUM_CHANNELS) {
+		struct iio_chan_spec *chan = chan_array + idx;
+
+		chan->type = IIO_VOLTAGE;
+		chan->indexed = 1;
+		chan->channel = bit;
+		chan->scan_index = idx;
+		chan->scan_type.sign = 'u';
+		chan->scan_type.realbits = 10;
+		chan->scan_type.storagebits = 16;
+		chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		idx++;
+	}
+
+	timestamp = chan_array + idx;
+	timestamp->type = IIO_TIMESTAMP;
+	timestamp->channel = -1;
+	timestamp->scan_index = idx;
+	timestamp->scan_type.sign = 's';
+	timestamp->scan_type.realbits = 64;
+	timestamp->scan_type.storagebits = 64;
+
+	dev->channels = chan_array;
+
+	return dev->num_channels;
+}
+
+static int cc_10001_adc_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct cc_10001_adc_device *adc_dev;
+	unsigned long adc_clk_rate;
+	struct resource *res;
+	struct iio_dev *dev;
+	int ret;
+
+	dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
+	if (dev == NULL)
+		return -ENOMEM;
+
+	adc_dev = iio_priv(dev);
+
+	if (of_property_read_u32(node, "cosmic,adc-available-channels", &ret)) {
+		dev_err(&dev->dev, "Missing adc-available-channels property\n");
+		return -EINVAL;
+	}
+	adc_dev->channel_map = ret;
+
+	adc_dev->reg = devm_regulator_get(&pdev->dev, "vref");
+	if (IS_ERR_OR_NULL(adc_dev->reg))
+		return -EINVAL;
+
+	ret = regulator_enable(adc_dev->reg);
+	if (ret)
+		return ret;
+
+	ret = regulator_get_voltage(adc_dev->reg);
+	if (ret < 0)
+		goto err_disable_reg;
+	adc_dev->vref_mv = ret / 1000;
+
+	dev->dev.parent = &pdev->dev;
+	dev->name = dev_name(&pdev->dev);
+	dev->info = &cc_10001_adc_info;
+	dev->modes = INDIO_DIRECT_MODE;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(adc_dev->reg_base))
+		return PTR_ERR(adc_dev->reg_base);
+
+	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "adc");
+	if (IS_ERR(adc_dev->adc_clk)) {
+		dev_err(&pdev->dev, "Failed to get the clock\n");
+		return PTR_ERR(adc_dev->adc_clk);
+	}
+
+	ret = clk_prepare_enable(adc_dev->adc_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable the clock\n");
+		return ret;
+	}
+
+	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
+
+	adc_dev->start_delay_ns = (NSEC_PER_SEC / adc_clk_rate) * WAIT_CYCLES;
+	adc_dev->eoc_delay_ns = (NSEC_PER_SEC / adc_clk_rate);
+
+	/* Setup the ADC channels available on the device */
+	ret = cc_10001_adc_channel_init(dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not initialize the channels.\n");
+		goto err_disable_clk;
+	}
+
+	mutex_init(&adc_dev->lock);
+
+	ret = iio_triggered_buffer_setup(dev, NULL,
+					&cc_10001_adc_trigger_h, NULL);
+
+	ret = iio_device_register(dev);
+	if (ret < 0)
+		goto err_cleanup_buffer;
+
+	platform_set_drvdata(pdev, dev);
+
+	return 0;
+
+err_disable_reg:
+	regulator_disable(adc_dev->reg);
+err_disable_clk:
+	clk_disable_unprepare(adc_dev->adc_clk);
+err_cleanup_buffer:
+	iio_triggered_buffer_cleanup(dev);
+	return 0;
+}
+
+static int cc_10001_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *dev = platform_get_drvdata(pdev);
+	struct cc_10001_adc_device *adc_dev = iio_priv(dev);
+
+	iio_device_unregister(dev);
+	iio_triggered_buffer_cleanup(dev);
+	clk_disable_unprepare(adc_dev->adc_clk);
+	regulator_disable(adc_dev->reg);
+
+	return 0;
+}
+
+static const struct of_device_id cc_10001_adc_dt_ids[] = {
+	{ .compatible = "cosmic,10001-adc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cc_10001_adc_dt_ids);
+
+static struct platform_driver cc_10001_adc_driver = {
+	.driver = {
+		.name   = "cc-10001-adc",
+		.owner	= THIS_MODULE,
+		.of_match_table = cc_10001_adc_dt_ids,
+	},
+	.probe	= cc_10001_adc_probe,
+	.remove	= cc_10001_adc_remove,
+};
+module_platform_driver(cc_10001_adc_driver);
+
+MODULE_AUTHOR("Phani Movva <Phani.Movva@imgtec.com>");
+MODULE_DESCRIPTION("Cosmic circuits ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.2

