Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:52288 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab1JSQms (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2011 12:42:48 -0400
Message-ID: <4E9EFE0B.2030205@cam.ac.uk>
Date: Wed, 19 Oct 2011 17:42:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Maxime,

Afraid I'm out of time for today, but just thought I'd ask one quick question...

Why isn't this touchscreen ADC in input?

(needs to be firmly stated as early as possible!)


> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/staging/iio/adc/Kconfig   |    6 +
>  drivers/staging/iio/adc/Makefile  |    1 +
>  drivers/staging/iio/adc/at91adc.c |  295 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 302 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/at91adc.c
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 070efd3..98e8005 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -206,6 +206,12 @@ config AD7280
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7280a
>  
> +config AT91ADC
> +	tristate "Atmel Touchscreen ADC Controller"
> +	depends on SYSFS && ARCH_AT91
> +	help
> +	  Say yes here to build support for Atmel TSADCC.
> +
>  config MAX1363
>  	tristate "Maxim max1363 ADC driver"
>  	depends on I2C
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index 8adf096..03e517a 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -42,3 +42,4 @@ obj-$(CONFIG_ADT75) += adt75.o
>  obj-$(CONFIG_ADT7310) += adt7310.o
>  obj-$(CONFIG_ADT7410) += adt7410.o
>  obj-$(CONFIG_AD7280) += ad7280a.o
> +obj-$(CONFIG_AT91ADC) += at91adc.o
> diff --git a/drivers/staging/iio/adc/at91adc.c b/drivers/staging/iio/adc/at91adc.c
> new file mode 100644
> index 0000000..2737261
> --- /dev/null
> +++ b/drivers/staging/iio/adc/at91adc.c
> @@ -0,0 +1,295 @@
> +/*
> + * Driver for the TouchScreen ADC Controller present in the Atmel AT91
> + * evaluation boards.
> + *
> + * Copyright 2011 Free Electrons
> + *
> + * Licensed under the GPLv2 or later.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +
> +#include "../iio.h"
> +
> +#include <mach/at91_adc.h>
> +#include <mach/board.h>
> +
> +#define at91adc_reg_read(base, reg)        __raw_readl((base) + (reg))
> +#define at91adc_reg_write(base, reg, val)  __raw_writel((val), (base) + (reg))
> +
> +struct at91adc_state {
> +	struct clk *clk;
> +	bool done;
> +	struct mutex lock;
> +	struct iio_chan_spec *channels;
> +	int nb_chan;
> +	int irq;
> +	wait_queue_head_t wq_data_avail;
> +	u16 lcdr;
> +	void __iomem *reg_base;
> +
> +};
> +
> +static irqreturn_t at91adc_eoc_trigger(int irq, void *private)
> +{
> +	int chan;
> +	struct at91adc_state *st = private;
> +	struct iio_dev *idev = iio_priv_to_dev(st);
> +	unsigned int status = at91adc_reg_read(st->reg_base, AT91_ADC_SR);
> +
> +	if (!(status & AT91_ADC_DRDY))
> +		return IRQ_HANDLED;
> +
> +	for (chan = 0; chan < st->nb_chan; chan++) {
> +		if (status & AT91_ADC_EOC(chan)) {
> +			st->done = true;
> +			st->lcdr = at91adc_reg_read(st->reg_base,
> +						    AT91_ADC_CHR(chan));
> +		}
> +	}
> +	wake_up_interruptible(&st->wq_data_avail);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int at91adc_channel_init(struct at91adc_state *st)
> +{
> +	int ret = 0, i;
> +	st->channels = kzalloc(sizeof(struct iio_chan_spec) * st->nb_chan,
> +			       GFP_KERNEL);
> +	if (st->channels == NULL)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < st->nb_chan; i++) {
> +		struct iio_chan_spec *chan = st->channels + i;
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->channel = i;
> +		++ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int at91adc_read_raw(struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct at91adc_state *st = iio_priv(idev);
> +
> +	switch (mask) {
> +	case 0:
> +		mutex_lock(&st->lock);
> +
> +		at91adc_reg_write(st->reg_base, AT91_ADC_CHER,
> +				  AT91_ADC_CH(chan->channel));
> +		at91adc_reg_write(st->reg_base, AT91_ADC_IER,
> +				  AT91_ADC_EOC(chan->channel));
> +		at91adc_reg_write(st->reg_base, AT91_ADC_CR, AT91_ADC_START);
> +
> +		wait_event_interruptible(st->wq_data_avail, st->done);
> +		*val = st->lcdr;
> +
> +		at91adc_reg_write(st->reg_base, AT91_ADC_CHDR,
> +				  AT91_ADC_CH(chan->channel));
> +		at91adc_reg_write(st->reg_base, AT91_ADC_IDR,
> +				  AT91_ADC_EOC(chan->channel));
> +
> +		st->lcdr = 0;
> +		st->done = false;
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info at91adc_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &at91adc_read_raw,
> +};
> +
> +static int __devinit at91adc_probe(struct platform_device *pdev)
> +{
> +	unsigned int prsc, mstrclk, ticks;
> +	int ret;
> +	struct iio_dev *idev;
> +	struct at91adc_state *st;
> +	struct resource *res;
> +	struct at91_adc_data *pdata = pdev->dev.platform_data;
> +
> +	dev_dbg(&pdev->dev, "AT91ADC probed\n");
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "No resource defined\n");
> +		ret = -ENXIO;
> +		goto error_ret;
> +	}
> +
> +	idev = iio_allocate_device(sizeof(*st));
> +	if (idev == NULL) {
> +		dev_err(&pdev->dev, "Failed to allocate memory.\n");
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	platform_set_drvdata(pdev, idev);
> +
> +	idev->dev.parent = &pdev->dev;
> +	idev->name = platform_get_device_id(pdev)->name;
> +	idev->modes = INDIO_DIRECT_MODE;
> +	idev->info = &at91adc_info;
> +
> +	st = iio_priv(idev);
> +	st->irq = platform_get_irq(pdev, 0);
> +	if (st->irq < 0) {
> +		dev_err(&pdev->dev, "No IRQ ID is designated\n");
> +		ret = -ENODEV;
> +		goto error_free_device;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				"AT91 adc registers")) {
> +		dev_err(&pdev->dev, "Resources are unavailable.\n");
> +		ret = -EBUSY;
> +		goto error_free_device;
> +	}
> +
> +	st->reg_base = ioremap(res->start, resource_size(res));
> +	if (!st->reg_base) {
> +		dev_err(&pdev->dev, "Failed to map registers.\n");
> +		ret = -ENOMEM;
> +		goto error_release_mem;
> +	}
> +
> +	/*
> +	 * Disable all IRQs before setting up the handler
> +	 */
> +	at91adc_reg_write(st->reg_base, AT91_ADC_CR, AT91_ADC_SWRST);
> +	at91adc_reg_write(st->reg_base, AT91_ADC_IDR, 0xFFFFFFFF);
> +	ret = request_irq(st->irq,
> +			  at91adc_eoc_trigger, 0, pdev->dev.driver->name, st);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
> +		goto error_unmap_reg;
> +	}
> +
> +	st->clk = clk_get(&pdev->dev, "adc_clk");
> +	if (IS_ERR(st->clk)) {
> +		dev_err(&pdev->dev, "Failed to get the clock.\n");
> +		ret = PTR_ERR(st->clk);
> +		goto error_free_irq;
> +	}
> +
> +	clk_enable(st->clk);
> +	mstrclk = clk_get_rate(st->clk);
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "No platform data available.\n");
> +		ret = -EINVAL;
> +		goto error_free_clk;
> +	}
> +
> +	if (!pdata->adc_clock) {
> +		dev_err(&pdev->dev, "No ADCClock available.\n");
> +		ret = -EINVAL;
> +		goto error_free_clk;
> +	}
> +
> +	prsc = (mstrclk / (2 * pdata->adc_clock)) - 1;
> +
> +	if (!pdata->startup_time) {
> +		dev_err(&pdev->dev, "No startup time available.\n");
> +		ret = -EINVAL;
> +		goto error_free_clk;
> +	}
> +
> +	ticks = round_up((pdata->startup_time * pdata->adc_clock /
> +			  1000000) - 1, 8) / 8;
> +	at91adc_reg_write(st->reg_base, AT91_ADC_MR,
> +			  (AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
> +			  (AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
> +
> +	/* Setup the ADC channels available on the board */
> +	st->nb_chan = pdata->channels;
> +	ret = at91adc_channel_init(st);
> +	if (ret < 0) {
> +		goto error_free_clk;
> +	}
> +
> +	idev->channels = st->channels;
> +	idev->num_channels = st->nb_chan;
> +
> +	init_waitqueue_head(&st->wq_data_avail);
> +	mutex_init(&st->lock);
> +
> +	ret = iio_device_register(idev);
> +	if (ret < 0) {
> +		goto error_free_clk;
> +	}
> +
> +	return 0;
> +
> +error_free_clk:
> +	clk_disable(st->clk);
> +	clk_put(st->clk);
> +error_free_irq:
> +	free_irq(st->irq, st);
> +error_unmap_reg:
> +	iounmap(st->reg_base);
> +error_release_mem:
> +	release_mem_region(res->start, resource_size(res));
> +error_free_device:
> +	iio_free_device(idev);
> +error_ret:
> +	return ret;
> +}
> +
> +static int __devexit at91adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *idev = platform_get_drvdata(pdev);
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct at91adc_state *st = iio_priv(idev);
> +
> +	free_irq(st->irq, st);
> +	iounmap(st->reg_base);
> +	release_mem_region(res->start, resource_size(res));
> +	iio_device_unregister(idev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver at91adc_driver = {
> +	.probe = at91adc_probe,
> +	.remove = __devexit_p(at91adc_remove),
> +	.driver = {
> +		   .name = "at91adc",
> +		   },
> +};
> +
> +static int __init at91adc_init(void)
> +{
> +	return platform_driver_register(&at91adc_driver);
> +}
> +
> +static void __exit at91adc_exit(void)
> +{
> +	platform_driver_unregister(&at91adc_driver);
> +}
> +
> +module_init(at91adc_init);
> +module_exit(at91adc_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Atmel AT91 ADC Driver");
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");

