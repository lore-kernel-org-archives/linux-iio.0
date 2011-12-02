Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:35889 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889Ab1LBPfj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2011 10:35:39 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/5] ARM: AT91: IIO: Add AT91 ADC driver.
Date: Fri,  2 Dec 2011 16:35:01 +0100
Message-Id: <1322840104-3525-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1322840104-3525-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1322840104-3525-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/staging/iio/adc/Kconfig    |    6 +
 drivers/staging/iio/adc/Makefile   |    1 +
 drivers/staging/iio/adc/at91_adc.c |  335 ++++++++++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/adc/at91_adc.c

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index d9decea..93de64d 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -169,6 +169,12 @@ config AD7280
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7280a
 
+config AT91_ADC
+       tristate "Atmel AT91 ADC"
+       depends on SYSFS && ARCH_AT91
+       help
+         Say yes here to build support for Atmel AT91 ADC
+
 config MAX1363
 	tristate "Maxim max1363 ADC driver"
 	depends on I2C
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ceee7f3..6ef78fb 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_ADT7310) += adt7310.o
 obj-$(CONFIG_ADT7410) += adt7410.o
 obj-$(CONFIG_AD7280) += ad7280a.o
+obj-$(CONFIG_AT91_ADC) += at91_adc.o
diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
new file mode 100644
index 0000000..d10df7a
--- /dev/null
+++ b/drivers/staging/iio/adc/at91_adc.c
@@ -0,0 +1,335 @@
+/*
+ * Driver for the ADC present in the Atmel AT91 evaluation boards.
+ *
+ * Copyright 2011 Free Electrons
+ *
+ * Licensed under the GPLv2 or later.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#include "../iio.h"
+#include <linux/platform_data/at91_adc.h>
+
+#include <mach/at91_adc.h>
+
+struct at91_adc_state {
+	struct clk *clk;
+	bool done;
+	struct mutex lock;
+	int irq;
+	wait_queue_head_t wq_data_avail;
+	u16 last_value;
+	void __iomem *reg_base;
+	unsigned int vref_mv;
+	unsigned long channels_mask;
+};
+
+static inline u32 at91_adc_reg_read(struct at91_adc_state *st,
+				    u8 reg)
+{
+	return readl_relaxed(st->reg_base + reg);
+}
+
+static inline void at91_adc_reg_write(struct at91_adc_state *st,
+				      u8 reg,
+				      u32 val)
+{
+	writel_relaxed(val, st->reg_base + reg);
+}
+
+static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
+{
+	struct iio_dev *idev = private;
+	struct at91_adc_state *st = iio_priv(idev);
+	unsigned int status = at91_adc_reg_read(st, AT91_ADC_SR);
+
+	if (!(status & AT91_ADC_DRDY))
+		return IRQ_HANDLED;
+
+	if (status & st->channels_mask) {
+		st->done = true;
+		st->last_value = at91_adc_reg_read(st, AT91_ADC_LCDR);
+	}
+
+	wake_up_interruptible(&st->wq_data_avail);
+
+	return IRQ_HANDLED;
+}
+
+static int at91_adc_channel_init(struct iio_dev *idev,
+				struct at91_adc_data *pdata)
+{
+	struct iio_chan_spec *chan_array;
+	int bit, idx = 0;
+
+	idev->num_channels = bitmap_weight(&pdata->channels_used,
+					   pdata->num_channels);
+	chan_array = kcalloc(idev->num_channels, sizeof(struct iio_chan_spec),
+			     GFP_KERNEL);
+
+	if (chan_array == NULL)
+		return -ENOMEM;
+
+	for_each_set_bit(bit, &pdata->channels_used, pdata->num_channels) {
+		struct iio_chan_spec *chan = chan_array + idx;
+		chan->type = IIO_VOLTAGE;
+		chan->indexed = 1;
+		chan->channel = bit;
+		chan->scan_type.sign = 'u';
+		chan->scan_type.realbits = 10;
+		chan->scan_type.storagebits = 16;
+		chan->info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT;
+		idx++;
+	}
+
+	idev->channels = chan_array;
+	return idev->num_channels;
+}
+
+static void at91_adc_channel_remove(struct iio_dev *idev)
+{
+	kfree(idev->channels);
+}
+
+static int at91_adc_read_raw(struct iio_dev *idev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct at91_adc_state *st = iio_priv(idev);
+	int ret;
+
+	switch (mask) {
+	case 0:
+		mutex_lock(&st->lock);
+
+		at91_adc_reg_write(st, AT91_ADC_CHER,
+				  AT91_ADC_CH(chan->channel));
+		at91_adc_reg_write(st, AT91_ADC_IER,
+				  AT91_ADC_EOC(chan->channel));
+		at91_adc_reg_write(st, AT91_ADC_CR, AT91_ADC_START);
+
+		ret = wait_event_interruptible_timeout(st->wq_data_avail,
+						       st->done,
+						       msecs_to_jiffies(1000));
+		if (ret == 0)
+			return -ETIMEDOUT;
+		else if (ret < 0)
+			return ret;
+
+		*val = st->last_value;
+
+		at91_adc_reg_write(st, AT91_ADC_CHDR,
+				  AT91_ADC_CH(chan->channel));
+		at91_adc_reg_write(st, AT91_ADC_IDR,
+				  AT91_ADC_EOC(chan->channel));
+
+		st->last_value = 0;
+		st->done = false;
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = (st->vref_mv * 1000) >> chan->scan_type.realbits;
+		*val2 = 0;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info at91_adc_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &at91_adc_read_raw,
+};
+
+static int __devinit at91_adc_probe(struct platform_device *pdev)
+{
+	unsigned int prsc, mstrclk, ticks;
+	int ret;
+	struct iio_dev *idev;
+	struct at91_adc_state *st;
+	struct resource *res;
+	struct at91_adc_data *pdata = pdev->dev.platform_data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "No resource defined\n");
+		ret = -ENXIO;
+		goto error_ret;
+	}
+
+	idev = iio_allocate_device(sizeof(struct at91_adc_state));
+	if (idev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	platform_set_drvdata(pdev, idev);
+
+	idev->dev.parent = &pdev->dev;
+	idev->name = dev_name(&pdev->dev);
+	idev->modes = INDIO_DIRECT_MODE;
+	idev->info = &at91_adc_info;
+
+	st = iio_priv(idev);
+	st->irq = platform_get_irq(pdev, 0);
+	if (st->irq < 0) {
+		dev_err(&pdev->dev, "No IRQ ID is designated\n");
+		ret = -ENODEV;
+		goto error_free_device;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res),
+				"AT91 adc registers")) {
+		dev_err(&pdev->dev, "Resources are unavailable.\n");
+		ret = -EBUSY;
+		goto error_free_device;
+	}
+
+	st->reg_base = ioremap(res->start, resource_size(res));
+	if (!st->reg_base) {
+		dev_err(&pdev->dev, "Failed to map registers.\n");
+		ret = -ENOMEM;
+		goto error_release_mem;
+	}
+
+	/*
+	 * Disable all IRQs before setting up the handler
+	 */
+	at91_adc_reg_write(st, AT91_ADC_CR, AT91_ADC_SWRST);
+	at91_adc_reg_write(st, AT91_ADC_IDR, 0xFFFFFFFF);
+	ret = request_irq(st->irq,
+			  at91_adc_eoc_trigger,
+			  0,
+			  pdev->dev.driver->name,
+			  idev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
+		goto error_unmap_reg;
+	}
+
+	st->clk = clk_get(&pdev->dev, "adc_clk");
+	if (IS_ERR(st->clk)) {
+		dev_err(&pdev->dev, "Failed to get the clock.\n");
+		ret = PTR_ERR(st->clk);
+		goto error_free_irq;
+	}
+
+	clk_enable(st->clk);
+	mstrclk = clk_get_rate(st->clk);
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data available.\n");
+		ret = -EINVAL;
+		goto error_free_clk;
+	}
+
+	if (!pdata->adc_clock) {
+		dev_err(&pdev->dev, "No ADCClock available.\n");
+		ret = -EINVAL;
+		goto error_free_clk;
+	}
+
+	/*
+	 * Prescaler rate computation using the formula from the Atmel's
+	 * datasheet : ADC Clock = MCK / ((Prescaler + 1) * 2), ADC Clock being
+	 * specified by the electrical characteristics of the board.
+	 */
+	prsc = (mstrclk / (2 * pdata->adc_clock)) - 1;
+
+	if (!pdata->startup_time) {
+		dev_err(&pdev->dev, "No startup time available.\n");
+		ret = -EINVAL;
+		goto error_free_clk;
+	}
+
+	/*
+	 * Number of ticks needed to cover the startup time of the ADC as
+	 * defined in the electrical characteristics of the board, divided by 8.
+	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
+	 */
+	ticks = round_up((pdata->startup_time * pdata->adc_clock /
+			  1000000) - 1, 8) / 8;
+	at91_adc_reg_write(st, AT91_ADC_MR,
+			  (AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
+			  (AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
+
+	/* Setup the ADC channels available on the board */
+	ret = at91_adc_channel_init(idev, pdata);
+	if (ret < 0)
+		goto error_free_clk;
+
+	init_waitqueue_head(&st->wq_data_avail);
+	mutex_init(&st->lock);
+
+	st->vref_mv = pdata->vref;
+	st->channels_mask = pdata->channels_used;
+
+	ret = iio_device_register(idev);
+	if (ret < 0)
+		goto error_free_channels;
+
+	return 0;
+
+error_free_channels:
+	at91_adc_channel_remove(idev);
+error_free_clk:
+	clk_disable(st->clk);
+	clk_put(st->clk);
+error_free_irq:
+	free_irq(st->irq, idev);
+error_unmap_reg:
+	iounmap(st->reg_base);
+error_release_mem:
+	release_mem_region(res->start, resource_size(res));
+error_free_device:
+	iio_free_device(idev);
+error_ret:
+	return ret;
+}
+
+static int __devexit at91_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *idev = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct at91_adc_state *st = iio_priv(idev);
+
+	iio_device_unregister(idev);
+	at91_adc_channel_remove(idev);
+	clk_disable(st->clk);
+	clk_put(st->clk);
+	free_irq(st->irq, idev);
+	iounmap(st->reg_base);
+	release_mem_region(res->start, resource_size(res));
+	iio_free_device(idev);
+
+	return 0;
+}
+
+static struct platform_driver at91_adc_driver = {
+	.probe = at91_adc_probe,
+	.remove = __devexit_p(at91_adc_remove),
+	.driver = {
+		   .name = "at91_adc",
+	},
+};
+
+module_platform_driver(at91_adc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Atmel AT91 ADC Driver");
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-- 
1.7.4.1

