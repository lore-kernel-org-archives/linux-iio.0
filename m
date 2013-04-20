Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-083.synserver.de ([212.40.185.83]:1069 "EHLO
	smtp-out-081.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755552Ab3DTRO4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Apr 2013 13:14:56 -0400
Message-ID: <5172CCDA.2020304@metafoo.de>
Date: Sat, 20 Apr 2013 19:14:02 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Darwish <darwish.d.d@gmail.com>
CC: linux-iio@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2] iio: basic ADC support for Freescale i.MX25
References: <516FCEBC.7080000@gmail.com>
In-Reply-To: <516FCEBC.7080000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Looks much better than v1 :) Only a few minor things left


On 04/18/2013 12:45 PM, Denis Darwish wrote:
> From: Denis Darwish <darwish.d.d@gmail.com>
> 
> This patch adds basic support for Freescale i.MX25 ADC in the IIO Subsystem.
> 
> Signed-off-by: Denis Darwish <darwish.d.d@gmail.com>
> ---
>  I want to thank Lars-Peter Clausen for a detailed review.
> 
>  Functionality tested with linux 3.8.0 and linux-next.
>  IIO_BUFFER and IIO_TRIGGER unsupported
>  Changes since v1:
>  + end of conversion IRQ support
>  * cleanup debug info messages, vars etc.
>  * all definitions put into c file
>  * iio_chan_spec statically initialized
>  * get resources in modern way (clk, iomem etc)
> 
>  arch/arm/mach-imx/clk-imx25.c                  |    2 +-
>  arch/arm/mach-imx/devices/Kconfig              |    4 +
>  arch/arm/mach-imx/devices/Makefile             |    1 +
>  arch/arm/mach-imx/devices/devices-common.h     |    2 +
>  arch/arm/mach-imx/devices/platform-imx25-adc.c |   27 +
>  arch/arm/mach-imx/mx25.h                       |    2 +
>  drivers/iio/adc/Kconfig                        |    7 +
>  drivers/iio/adc/Makefile                       |    1 +
>  drivers/iio/adc/imx25_adc.c                    |  639 ++++++++++++++++++++++++

This should be split into two patch, the first patch adding the IIO driver,
the second one registering the platform device. Also make sure to put the
imx maintainers on Cc.


>  9 files changed, 684 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-imx/devices/platform-imx25-adc.c
>  create mode 100644 drivers/iio/adc/imx25_adc.c
> 
> diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
> index 69858c7..febc054 100644
> --- a/arch/arm/mach-imx/clk-imx25.c
> +++ b/arch/arm/mach-imx/clk-imx25.c
> @@ -274,7 +274,7 @@ int __init mx25_clocks_init(void)
[...]
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ab0767e6..d56c7e6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -150,6 +150,13 @@ config TI_AM335X_ADC
>  	  Say yes here to build support for Texas Instruments ADC
>  	  driver which is also a MFD client.
>  
> +config IMX25_ADC
> +	tristate "Freescale IMX25 ADC"
> +	depends on ARCH_MXC
> +	select SYSFS
> +	help
> +	  Say yes here to build support for Freescale i.MX25 ADC built into these chips.
> +

Keep the entries sorted alphabetically.

>  config VIPERBOARD_ADC
>  	tristate "Viperboard ADC support"
>  	depends on MFD_VIPERBOARD && USB
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 0a825be..b2b9d63 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> +obj-$(CONFIG_IMX25_ADC) += imx25_adc.o

Same here.

> diff --git a/drivers/iio/adc/imx25_adc.c b/drivers/iio/adc/imx25_adc.c
> new file mode 100644
> index 0000000..a0e3570
> --- /dev/null
> +++ b/drivers/iio/adc/imx25_adc.c
> @@ -0,0 +1,639 @@
> +/**
> + * Copyright (c) 2013 Denis Darwish
> + * Copyright 2009-2011 Freescale Semiconductor, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/completion.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>

You don't use buffers or events.

[...]
> +#define IMX_ADC_GCQ_ITEM_GCC0          0x0
> +#define IMX_ADC_GCQ_ITEM_GCC1          0x1
> +#define IMX_ADC_GCQ_ITEM_GCC2          0x2
> +#define IMX_ADC_GCQ_ITEM_GCC3          0x3

How about using 'IMX_ADC_GCQ_ITEM_GCC(x) (x)', that would allow you to
simplify the code using these defines.

There are a few other places where the register offsets or shifts are linar
based on the number, those could be simplified in a similar way.

[...]
> +static int adc_clk_enable(struct imx_adc_state *st)
> +{
> +	unsigned long reg;
> +	int ret;
> +
> +	ret = clk_prepare_enable(st->adc_clk);
> +	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR);
> +	reg |= IMX_ADC_TGCR_IPG_CLK_EN;
> +	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);

You do this read-modify-write operation quite often it might be worth it
adding a small helper function for this.

> +	return ret;
> +}
> +
[...]
> +void tsc_self_reset(struct imx_adc_state *st)
> +{
> +	unsigned long reg;
> +
> +	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR);
> +	reg |= IMX_ADC_TGCR_TSC_RST;
> +	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);
> +
> +	while (readl_relaxed(st->reg_base + IMX_ADC_TGCR) &
> +		IMX_ADC_TGCR_TSC_RST)
> +		continue;

Needs a timeout in case for the unlikely event the hardware malfunctions.

> +}
[...]

> +void imx_adc_read_general(unsigned short *result, struct imx_adc_state *st)
> +{
> +	unsigned long reg;
> +
> +	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR);
> +	reg |= IMX_ADC_CQCR_FQS;
> +	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
> +
> +	while (!(readl_relaxed(st->reg_base + IMX_ADC_GCQSR) &
> +		IMX_ADC_CQSR_EOQ))
> +		continue;

Needs a timeout

> +	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR);
> +	reg &= ~IMX_ADC_CQCR_FQS;
> +	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
> +	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQSR);
> +	reg |= IMX_ADC_CQSR_EOQ;
> +	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQSR);
> +
> +	while (!(readl_relaxed(st->reg_base + IMX_ADC_GCQSR) &
> +		IMX_ADC_CQSR_EMPT)) {
> +		*result = readl_relaxed(st->reg_base + IMX_ADC_GCQFIFO) >>
> +				 IMX_ADC_GCQFIFO_ADCOUT_SHIFT;
> +	}

This one too

> +
> +}
> +
> +static irqreturn_t imx_adc_handle_irq(int irq, void *private)
> +{
> +	struct iio_dev *iodev = private;
> +	struct imx_adc_state *st = iio_priv(iodev);
> +	unsigned long reg;
> +
> +	reg = readl_relaxed(st->reg_base + IMX_ADC_TGSR);
> +	if (!(reg & IMX_ADC_GCQ_INT))
> +		return IRQ_HANDLED;

Well if there is no interrupt you should return IRQ_NONE,
[...]
> +}
> +
> +[...]
> +static int imx_adc_read_raw(struct iio_dev *idev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct imx_adc_state *st = iio_priv(idev);
> +	int ret;
> +	unsigned long reg;
> +
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = mutex_trylock(&st->lock);

I don't think trylock is necessary. Just use mutex_lock, this will cause
concurrent reads to be serialized instead of returning an error.

> +			if (!ret)
> +				return -EBUSY;
> +
> +		INIT_COMPLETION(st->completion);
> +
> +		imx_adc_set_chanel(st, chan->channel);
> +
> +		/* Enable the IRQ, unmask end-of-queue IRQ */
> +		reg = readl_relaxed(st->reg_base + IMX_ADC_GCQMR);
> +		reg &= ~IMX_ADC_GCQMR_EOQ_IRQ_MSK;
> +		writel_relaxed(reg, st->reg_base + IMX_ADC_GCQMR);
> +
> +		/* Start sampling the channel. */
> +		reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR);
> +		reg |= IMX_ADC_CQCR_FQS;
> +		writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
> +
> +		ret = wait_for_completion_killable_timeout(&st->completion, HZ);
> +		if (!ret)
> +			ret = -ETIMEDOUT;
> +		if (ret > 0) {
> +			while (!(readl_relaxed(st->reg_base + IMX_ADC_GCQSR) &
> +				IMX_ADC_CQSR_EMPT)) {
> +				st->value = readl_relaxed(st->reg_base +
> +					IMX_ADC_GCQFIFO) >>
> +					IMX_ADC_GCQFIFO_ADCOUT_SHIFT;
> +				}

Needs timeout and the closing bracket has a strange indention.

> +			*val = st->value;
> +			ret = IIO_VAL_INT;
> +		}

if the wait was aborted ret can be less than 0, in which case you should
pass the error on to the caller.
[...]
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
[...]
> +}
> +
[...]
> +static int imx_adc_probe(struct platform_device *pdev)
> +{
> +	struct imx_adc_state *st;
> +	struct iio_dev *iodev;

We usually call it indio_dev, it would be nice to use that for consistency
as well.

> +	int ret = -ENODEV;
> +	struct resource *res;
> +
> +	iodev = iio_device_alloc(sizeof(struct imx_adc_state));

sizeof(*st)

> +	if (iodev == NULL) {
> +		dev_err(&pdev->dev, "failed allocating iio device\n");
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	st = iio_priv(iodev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	st->reg_base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (IS_ERR(st->reg_base)) {
> +		ret = PTR_ERR(st->reg_base);
> +		goto error_free_device;
> +	}
> +
> +	/* Reset */
> +	tsc_self_reset(st);
> +
> +	st->reg = regulator_get(&pdev->dev, "ext-vref");
> +	if (!IS_ERR_OR_NULL(st->reg)) {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			goto error_put_reg;
> +		st->vref_mv = regulator_get_voltage(st->reg);
> +	} else {
> +		/* Use internal reference */
> +		st->vref_mv = 2500; /* internal reference = 2.5V */
> +		tsc_intref_enable(st);
> +	}
> +
> +	st->irq = platform_get_irq(pdev, 0);
> +		if (st->irq < 0) {
> +			dev_err(&pdev->dev, "No IRQ ID is designated\n");
> +			ret = -EINVAL;
> +			goto error_disable_reg;
> +		}

Strange idention.

> +
> +	ret = devm_request_irq(&pdev->dev, st->irq,
> +		imx_adc_handle_irq, 0,
> +		pdev->dev.driver->name, iodev);

This is dangerous and racy you need to make sure to free the IRQ before you
free the iio device, otherwise you might run into a use after free condition.

> +	if (ret)
> +		goto error_disable_reg;
> +
> +	st->adc_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(st->adc_clk)) {
> +		dev_err(&pdev->dev, "Failed to get the clock.\n");
> +		ret = PTR_ERR(st->adc_clk);
> +		goto error_free_clk;
> +	}
> +
> +	ret = adc_clk_enable(st);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Could not prepare or enable the clock.\n");
> +		goto error_free_clk;
> +	}
> +
> +	adc_set_clk(st);
> +
> +	/* Set power mode */
> +	adc_set_power_mode(st);
> +
> +	/* Set queue */
> +	adc_set_queue(st);
> +
> +	platform_set_drvdata(pdev, iodev);
> +
> +	iodev->name = dev_name(&pdev->dev);
> +	iodev->dev.parent = &pdev->dev;
> +	iodev->info = &imx_adc_info;
> +	iodev->modes = INDIO_DIRECT_MODE;
> +
> +

nitpick: No need for these two newlines

> +	iodev->channels = imx_adc_iio_channels;
> +	iodev->num_channels = ARRAY_SIZE(imx_adc_iio_channels);
> +
> +	init_completion(&st->completion);
> +	mutex_init(&st->lock);
> +
> +	ret = iio_device_register(iodev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Couldn't register the device.\n");
> +		goto error_dev;
> +	}
> +
> +	return 0;
> +
> +error_dev:

No need for an empty label.

> +
> +error_free_clk:
> +	adc_clk_disable(st);
> +error_disable_reg:
> +	if (!IS_ERR_OR_NULL(st->reg))
> +		regulator_disable(st->reg);
> +error_put_reg:
> +	if (!IS_ERR_OR_NULL(st->reg))
> +		regulator_put(st->reg);
> +error_free_device:
> +	iio_device_free(iodev);
> +error_ret:
> +	return ret;
> +}
> +
> +static int imx_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *iodev = platform_get_drvdata(pdev);
> +	struct imx_adc_state *st = iio_priv(iodev);
> +
> +	iio_device_unregister(iodev);
> +
> +	adc_clk_disable(st);
> +	clk_put(st->adc_clk);

The clock is device managed, so it will be automatically freed.

You forgot to free the regualtor.

> +
> +	iio_device_free(iodev);
> +
> +	return 0;
> +}
/
