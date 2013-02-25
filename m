Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-129.synserver.de ([212.40.185.129]:1036 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759743Ab3BYKee (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Feb 2013 05:34:34 -0500
Message-ID: <512B3E9B.4090905@metafoo.de>
Date: Mon, 25 Feb 2013 11:36:11 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Darwish <darwish.d.d@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC][PATCH] iio: basic ADC support for Freescale i.MX25
References: <511D50E6.4060801@gmail.com>
In-Reply-To: <511D50E6.4060801@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/14/2013 10:02 PM, Denis Darwish wrote:
> This patch adds basic support for Freescale i.MX25 ADC in the IIO Subsystem.
> It is provides direct access via sysfs, IRQ not used now.
> Compile tested with linux-next.
> Functionality tested with linux 3.3.0.
> 

Hi,

I realize this is a RFC, but this driver definitily needs quite a bit of
work. There a few code style issues, please run checkpatch.pl on your driver.

> 
> From c57696f02b235837a67e2607da517bdcabaa72a5 Mon Sep 17 00:00:00 2001
> From: ddarwish <darwish.d.d@gmail.com>

This should be your full name


> Date: Thu, 14 Feb 2013 11:59:07 +0400
> Subject: [PATCH] simple Freescale i.MX25 ADC driver
> 

This needs a commit message and a Signed-off-by.

> ---
>  arch/arm/mach-imx/clk-imx25.c         |    2 +-
>  arch/arm/mach-imx/mx25.h              |    1 +
>  drivers/staging/iio/adc/Kconfig       |   12 +
>  drivers/staging/iio/adc/Makefile      |    1 +
>  drivers/staging/iio/adc/imx25_adc.c   |  456 +++++++++++++++++++++++++++++++++
>  drivers/staging/iio/adc/imx_adc.h     |   13 +
>  drivers/staging/iio/adc/imx_adc_reg.h |  243 ++++++++++++++++++
>  7 files changed, 727 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/staging/iio/adc/imx25_adc.c
>  create mode 100644 drivers/staging/iio/adc/imx_adc.h
>  create mode 100644 drivers/staging/iio/adc/imx_adc_reg.h
> 
[...]
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index d285596..b64ec6d 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_AD7280) += ad7280a.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
>  obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
> +obj-$(CONFIG_IMX25_ADC) += imx25_adc.o
> diff --git a/drivers/staging/iio/adc/imx25_adc.c b/drivers/staging/iio/adc/imx25_adc.c
> new file mode 100644
> index 0000000..6d3b438
> --- /dev/null
> +++ b/drivers/staging/iio/adc/imx25_adc.c

New drivers should not go into staging. We are trying to move all of the IIO
drivers out of staging.

> @@ -0,0 +1,456 @@
> +/**
> + * Copyright (c) 2013 Denis darwish
> + * Based on code by Freescale Semiconductor
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

No module parameters in this driver

> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>
> +
> + #include "imx_adc_reg.h"
> + #include "imx_adc.h"
> +
> +#define IMX_ADC_DATA_BITS (12)
> +
> +struct imx_adc_state {
> +	struct clk				*adc_clk;
> +	unsigned long			channels_mask;

channels_mask never seems to be used.

> +	u16						value;
> +	struct mutex			lock;
> +	u8						num_channels;

num_channels isn't used either other than in probe().

> +	void __iomem			*reg_base;
> +	u32						vref_mv;
> +};
> +
> +static int adc_clk_enable(struct imx_adc_state *st)
> +{
> +	unsigned long reg;
> +	int ret;
> +	
> +	dev_info(NULL, "st point b2 %p \n", st);
> +
> +	ret = clk_enable(st->adc_clk);
> +	reg = __raw_readl(st->reg_base + TGCR);


You shouldn't use __raw_readl/__raw_writel directly. Use
readl_relaxed/writel_releaxed instead.

> +	reg |= TGCR_IPG_CLK_EN;
> +	__raw_writel(reg, st->reg_base + TGCR);

Considering how often you do this sequence (read reg, update value, write
reg) it may make sense to put this in a helper function.

> +	return (ret);

No need for the extra parenthesis.

> +}
> +
[...]
> +
> +void imx_adc_set_chanel(struct imx_adc_state *st, u8 channel) {
> +	unsigned long reg;
> +
> +	reg = __raw_readl(st->reg_base + GCQ_ITEM_7_0);

reg is always overwritten.

> +	switch (channel) {
> +		case 0:
> +			reg =  (GCQ_ITEM_GCC0 << GCQ_ITEM0_SHIFT);
> +			break;
> +		case 1:
> +			reg =  (GCQ_ITEM_GCC1 << GCQ_ITEM0_SHIFT);
> +			break;
> +		case 2:
> +			reg =  (GCQ_ITEM_GCC2 << GCQ_ITEM0_SHIFT);
> +			break;			
> +		default:
> +			break;
> +	}
> +	__raw_writel(reg, st->reg_base + GCQ_ITEM_7_0);
> +
> +}
> +
> +void imx_adc_read_general(unsigned short *result, struct imx_adc_state *st)
> +{
> +	unsigned long reg;
> +
> +	reg = __raw_readl(st->reg_base + GCQCR);
> +	reg |= CQCR_FQS;
> +	__raw_writel(reg, st->reg_base + GCQCR);
> +
> +	while (!(__raw_readl(st->reg_base + GCQSR) & CQSR_EOQ))
> +		continue;

Does the ADC offer a conversion done IRQ? Busy polling isn't the nicest
thing to do.

> +	reg = __raw_readl(st->reg_base + GCQCR);
> +	reg &= ~CQCR_FQS;
> +	__raw_writel(reg, st->reg_base + GCQCR);
> +	reg = __raw_readl(st->reg_base + GCQSR);
> +	reg |= CQSR_EOQ;
> +	__raw_writel(reg, st->reg_base + GCQSR);
> +
> +	while (!(__raw_readl(st->reg_base + GCQSR) & CQSR_EMPT)) {
> +		*result = __raw_readl(st->reg_base + GCQFIFO) >>
> +				 GCQFIFO_ADCOUT_SHIFT;
> +		
> +	}
> +
> +}
> +
> +#define IMX25_ADC_MAX_CH_NUM (3)
> +static struct iio_chan_spec imx_adc_iio_channels[IMX25_ADC_MAX_CH_NUM];
> +
> +static int imx_adc_read_raw(struct iio_dev *idev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct imx_adc_state *st= iio_priv(idev);
> +	unsigned short rawresult;
> +
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +
> +		imx_adc_set_chanel(st, chan->channel);
> +		imx_adc_read_general (&rawresult, st);
> +		
> +		st->value = rawresult;
> +		*val = st->value;
> +
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = (st->vref_mv * 1000) >> IMX_ADC_DATA_BITS; 
> +		*val2 = 0;
> +		return IIO_VAL_INT_PLUS_MICRO;

Using
		*val = st->vref_mv;
		*val2 = IMX_ADC_DATA_BITS;
		return IIO_VAL_FRACTIONAL_LOG2;

makes sense here.


> +	default:
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info imx_adc_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &imx_adc_read_raw,
> +};
> +
> +static int imx_adc_probe_dt(struct imx_adc_state *st,
> +			     struct platform_device *pdev)
> +{
> +	//ToDo implement adc_probe_dt function
> +	return 1;
> +}
> +
> +/* platform data file should contain next
> +*
> +* static struct resource adc_resources[] = {
> +*         [0] = {
> +*                 .start  = MX25_TSC_BASE_ADDR,
> +*                 .end    = MX25_TSC_BASE_ADDR + SZ_16K - 1,
> +*                 .flags  = IORESOURCE_MEM,
> +*         },
> +* };
> +*
> +* static struct imx_adc_data mpu5_imx_adc_data = {
> +* 	.channels_used = 0x01,
> +* 	.num_channels = 3,
> +* 	.vref = 2500,
> +* };
> +* 
> +* 
> +* static struct platform_device imx_adc = {
> +* 	.name	= "imx25-adc",
> +* 	.id	= -1,
> +* 	.resource       = adc_resources,
> +* 	.num_resources  = ARRAY_SIZE(adc_resources),
> +* 	.dev = {
> +* 		.platform_data = &mpu5_imx_adc_data,
> +* 	}
> +* };
> +*/
> +
> +static int imx_adc_probe_pdata(struct imx_adc_state *st,
> +			     struct platform_device *pdev)
> +{
> +	struct imx_adc_data *pdata = pdev->dev.platform_data;
> +
> +	if (!pdata)
> +		return -EINVAL;
> +
> +
> +	st->vref_mv = pdata->vref;

Usually we use the regulator framework to get the reference voltage.

> +	st->channels_mask = pdata->channels_used;
> +	st->num_channels = pdata->num_channels;
> +	// st->trigger_number = pdata->trigger_number;
> +	// st->trigger_list = pdata->trigger_list;
> +	// st->registers = pdata->registers;
> +
> +	return 0;
> +}
> +
> +static int imx_adc_probe(struct platform_device *pdev)
> +{
> +	struct imx_adc_state *st;
> +	struct iio_dev *iodev = NULL;

The initialization to NULL is not really necessary, since you overwrite it
just a few lines later. Also most other drivers call the iio_dev variable
indio_dev, it would be good if you could do the same for consistency.

> +	int ret = -ENODEV;
> +	struct resource *res;
> +	int i;
> +
> +	dev_info(&pdev->dev, "version 0.0.5 \n");

All these dev_info's are quite a bit of noise.

> +
> +	iodev = iio_device_alloc(sizeof(struct imx_adc_state));
> +	// iodev = iio_allocate_device(sizeof(struct imx_adc_state)); //legasy name
> +	if (iodev == NULL) {
> +		dev_err(&pdev->dev, "failed allocating iio device\n");
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	st = iio_priv(iodev);
> +
> +	if (pdev->dev.of_node)
> +		ret = imx_adc_probe_dt(st, pdev);
> +	else
> +		ret = imx_adc_probe_pdata(st, pdev);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "No platform data available.\n");
> +		ret = -EINVAL;
> +		goto error_free_device;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "No resource defined\n");
> +		ret = -ENXIO;
> +		goto error_ret;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				"IMX adc registers")) {
> +		dev_err(&pdev->dev, "Resources are unavailable.\n");
> +		ret = -EBUSY;
> +		goto error_free_device;
> +	}
> +
> +	dev_info(&pdev->dev, "res->start %p \n", res->start);
> +
> +	st->reg_base = ioremap(res->start, resource_size(res));
> +	if (!st->reg_base) {
> +		dev_err(&pdev->dev, "Failed to map registers.\n");
> +		ret = -ENOMEM;
> +		goto error_release_mem;
> +	}


devm_ioremap_resource can be put to good use here, it will take care of the
request_mem_region and ioremap, as well as printing appropriate error
messages. So all the lines above basically boil down to:

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(st->reg_base)) {
		ret = PTR_ERR(st->reg_base);
		goto err_free_device;
	}

Using managed resources also frees you from the burden of having to free
them manually.


> +
> +	dev_info(&pdev->dev, "reg_base %p \n", st->reg_base);
> +
> +	st->adc_clk = clk_get(&pdev->dev, NULL);

Could use devm_get_get

> +		if (IS_ERR(st->adc_clk)) {
> +		dev_err(&pdev->dev, "Failed to get the clock.\n");
> +		ret = PTR_ERR(st->adc_clk);
> +		goto error_free_clk;
> +	}
> +
> +	dev_info(&pdev->dev, "st point b1 %p \n", st);
> +	
> +	ret = adc_clk_enable(st);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not enable the clock.\n");
> +		goto error_unprepare_clk;
> +	}
> +
> +	dev_info(&pdev->dev, "adc clk enabled\n");
> +
> +	/* Reset */
> +	tsc_self_reset(st);
> +	dev_info(&pdev->dev, "adc reseted\n");
> +
> +	// /* Internal reference */
> +	tsc_intref_enable(st);

If you are using the internal reference shouldn't you set vref_mv to the
voltage of the internal reference.

> +	dev_info(&pdev->dev, "Internal reference enabled\n");
> +
> +	adc_set_clk(st);
> +
> +	/* Set power mode */
> +	adc_set_power_mode(st);
> +
> +	/* Set queue*/
> +	adc_set_queue(st);
> +
> +	platform_set_drvdata(pdev, iodev);
> +
> +	iodev->name = dev_name(&pdev->dev);
> +	iodev->dev.parent = &pdev->dev;
> +	iodev->info = &imx_adc_info;
> +	iodev->modes = INDIO_DIRECT_MODE;
> +
> +	if (st->num_channels > IMX25_ADC_MAX_CH_NUM) {
> +		dev_err(&pdev->dev, "Platform data error. To many adc chanels \n");
> +		ret = -EINVAL;
> +		goto error_dev_cfg;
> +	}
> +	iodev->num_channels = st->num_channels;
> +
> +	for (i = 0; i < st->num_channels; i++) {
> +
> +		imx_adc_iio_channels[i].type = IIO_VOLTAGE;
> +		imx_adc_iio_channels[i].indexed = 1;
> +		imx_adc_iio_channels[i].channel = i;
> +		imx_adc_iio_channels[i].scan_index = 0;
> +		imx_adc_iio_channels[i].scan_type.sign = 'u';
> +		imx_adc_iio_channels[i].scan_type.realbits = 12;
> +		imx_adc_iio_channels[i].scan_type.storagebits = 16;
> +		// imx_adc_iio_channels[0].info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
> +		// 		IIO_CHAN_INFO_RAW_SEPARATE_BIT;
> +		imx_adc_iio_channels[i].info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT;

You should statically initialize imx_adc_iio_channels where you declare it.
It's a resource shared between all instances of a driver, so it shouldn't
depend on a specific instance.

> +	}
> +
> +	iodev->channels = imx_adc_iio_channels;
> +
> +	ret = iio_device_register(iodev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Couldn't register the device.\n");
> +		goto error_dev;
> +	}
> +
> +	//ToDo Setup interrupt
> +
> +	mutex_init(&st->lock);

This nees to happen before the iio_device_register call otherwise you risk a
race condition.

> +
> +	//ToDo Setup buffers
> +	//ToDo Setup triggers
> +	//ToDo Setup registers
> +
> +	return 0;
> +
> +error_dev:
> +
> +error_dev_cfg:
> +
> +error_unprepare_clk:
> +	adc_clk_disable(st);
> +error_free_clk:
> +	clk_put(st->adc_clk);
> +error_release_mem:
> +	release_mem_region(res->start, resource_size(res));
> +error_free_device:
> +	iio_device_free(iodev);
> +error_ret:
> +	return ret;
> +}
> +
> +static int imx_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *iodev = platform_get_drvdata(pdev);
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct imx_adc_state *st = iio_priv(iodev);
> +
> +	iio_device_unregister(iodev);
> +
> +	adc_clk_disable(st);
> +	clk_put(st->adc_clk);
> +	release_mem_region(res->start, resource_size(res));
> +
> +	iio_device_free(iodev);
> +
> +	return 0;
> +}
> +
> +
> +static struct platform_driver imx_adc_driver = {
> +	.probe = imx_adc_probe,
> +	.remove = imx_adc_remove,
> +	.driver = {
> +		   .name = "imx25-adc",
> +//		   .of_match_table = of_match_ptr(imx25_adc_dt_ids),
> +	},
> +};
> +
> +module_platform_driver(imx_adc_driver);
> +
> +MODULE_AUTHOR("Denis Darwish <darwish.d.d@gmail.com>");
> +MODULE_DESCRIPTION("Freescale i.MX25 ADC Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/iio/adc/imx_adc.h b/drivers/staging/iio/adc/imx_adc.h
> new file mode 100644
> index 0000000..9ce3370
> --- /dev/null
> +++ b/drivers/staging/iio/adc/imx_adc.h
> @@ -0,0 +1,13 @@
> +
> +/**
> + * struct imx_adc_data - platform data for ADC driver
> + * @channels_used:              channels in use on the board as a bitmask
> + * @num_channels:               global number of channels available on the board
> + * @vref:                       Reference voltage for the ADC in millivolts
> + */
> + 
> +struct imx_adc_data {
> +		unsigned long	channels_used;
> +		u8				num_channels;
> +		u16				vref;
> +};
> \ No newline at end of file
> diff --git a/drivers/staging/iio/adc/imx_adc_reg.h b/drivers/staging/iio/adc/imx_adc_reg.h
> new file mode 100644
> index 0000000..9d9fc89
> --- /dev/null
> +++ b/drivers/staging/iio/adc/imx_adc_reg.h
> @@ -0,0 +1,243 @@
> +/*
> + * Copyright 2009-2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU Lesser General
> + * Public License.  You may obtain a copy of the GNU Lesser General
> + * Public License Version 2.1 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/lgpl-license.html
> + * http://www.gnu.org/copyleft/lgpl.html
> + */
> +
> +#ifndef __IMX_ADC_H__
> +#define __IMX_ADC_H__

These defines don't seem to be shared with any other file, it makes sense to
just put them into the c file directly. Also it would be good to add a
prefix to them., like IMX_ADC_

> +
> +/* TSC General Config Register */
> +#define TGCR                  0x000
> +#define TGCR_IPG_CLK_EN       (1 << 0)
> +#define TGCR_TSC_RST          (1 << 1)
> +#define TGCR_FUNC_RST         (1 << 2)
> +#define TGCR_SLPC             (1 << 4)
> +#define TGCR_STLC             (1 << 5)
> +#define TGCR_HSYNC_EN         (1 << 6)
> +#define TGCR_HSYNC_POL        (1 << 7)
> +#define TGCR_POWERMODE_SHIFT  8
> +#define TGCR_POWER_OFF        (0x0 << TGCR_POWERMODE_SHIFT)
> +#define TGCR_POWER_SAVE       (0x1 << TGCR_POWERMODE_SHIFT)
> +#define TGCR_POWER_ON         (0x3 << TGCR_POWERMODE_SHIFT)
> +#define TGCR_POWER_MASK       (0x3 << TGCR_POWERMODE_SHIFT)
> +#define TGCR_INTREFEN         (1 << 10)
> +#define TGCR_ADCCLKCFG_SHIFT  16
> +#define TGCR_ADCCLKCFG_MASK	  (0x1F << TGCR_ADCCLKCFG_SHIFT)
> +#define TGCR_PD_EN            (1 << 23)
> +#define TGCR_PDB_EN           (1 << 24)
> +#define TGCR_PDBTIME_SHIFT    25
> +#define TGCR_PDBTIME128       (0x3f << TGCR_PDBTIME_SHIFT)
> +#define TGCR_PDBTIME_MASK     (0x7f << TGCR_PDBTIME_SHIFT)
> +
> +/* TSC General Status Register */
> +#define TGSR                  0x004
> +#define TCQ_INT               (1 << 0)
> +#define GCQ_INT               (1 << 1)
> +#define SLP_INT               (1 << 2)
> +#define TCQ_DMA               (1 << 16)
> +#define GCQ_DMA               (1 << 17)
> +
> +/* TSC IDLE Config Register */
> +#define TICR                  0x008
> +
> +/* TouchScreen Convert Queue FIFO Register */
> +#define TCQFIFO               0x400
> +/* TouchScreen Convert Queue Control Register */
> +#define TCQCR                 0x404
> +#define CQCR_QSM_SHIFT        0
> +#define CQCR_QSM_STOP         (0x0 << CQCR_QSM_SHIFT)
> +#define CQCR_QSM_PEN          (0x1 << CQCR_QSM_SHIFT)
> +#define CQCR_QSM_FQS          (0x2 << CQCR_QSM_SHIFT)
> +#define CQCR_QSM_FQS_PEN      (0x3 << CQCR_QSM_SHIFT)
> +#define CQCR_QSM_MASK         (0x3 << CQCR_QSM_SHIFT)
> +#define CQCR_FQS              (1 << 2)
> +#define CQCR_RPT              (1 << 3)
> +#define CQCR_LAST_ITEM_ID_SHIFT   4
> +#define CQCR_LAST_ITEM_ID_MASK    (0xf << CQCR_LAST_ITEM_ID_SHIFT)
> +#define CQCR_FIFOWATERMARK_SHIFT  8
> +#define CQCR_FIFOWATERMARK_MASK   (0xf << CQCR_FIFOWATERMARK_SHIFT)
> +#define CQCR_REPEATWAIT_SHIFT     12
> +#define CQCR_REPEATWAIT_MASK      (0xf << CQCR_REPEATWAIT_SHIFT)
> +#define CQCR_QRST             (1 << 16)
> +#define CQCR_FRST             (1 << 17)
> +#define CQCR_PD_MSK           (1 << 18)
> +#define CQCR_PD_CFG           (1 << 19)
> +
> +/* TouchScreen Convert Queue Status Register */
> +#define TCQSR                 0x408
> +#define CQSR_PD               (1 << 0)
> +#define CQSR_EOQ              (1 << 1)
> +#define CQSR_FOR              (1 << 4)
> +#define CQSR_FUR              (1 << 5)
> +#define CQSR_FER              (1 << 6)
> +#define CQSR_EMPT             (1 << 13)
> +#define CQSR_FULL             (1 << 14)
> +#define CQSR_FDRY             (1 << 15)
> +
> +/* TouchScreen Convert Queue Mask Register */
> +#define TCQMR                 0x40c
> +#define TCQMR_PD_IRQ_MSK      (1 << 0)
> +#define TCQMR_EOQ_IRQ_MSK     (1 << 1)
> +#define TCQMR_FOR_IRQ_MSK     (1 << 4)
> +#define TCQMR_FUR_IRQ_MSK     (1 << 5)
> +#define TCQMR_FER_IRQ_MSK     (1 << 6)
> +#define TCQMR_PD_DMA_MSK      (1 << 16)
> +#define TCQMR_EOQ_DMA_MSK     (1 << 17)
> +#define TCQMR_FOR_DMA_MSK     (1 << 20)
> +#define TCQMR_FUR_DMA_MSK     (1 << 21)
> +#define TCQMR_FER_DMA_MSK     (1 << 22)
> +#define TCQMR_FDRY_DMA_MSK    (1 << 31)
> +
> +/* TouchScreen Convert Queue ITEM 7~0 */
> +#define TCQ_ITEM_7_0          0x420
> +
> +/* TouchScreen Convert Queue ITEM 15~8 */
> +#define TCQ_ITEM_15_8         0x424
> +
> +#define TCQ_ITEM7_SHIFT       28
> +#define TCQ_ITEM6_SHIFT       24
> +#define TCQ_ITEM5_SHIFT       20
> +#define TCQ_ITEM4_SHIFT       16
> +#define TCQ_ITEM3_SHIFT       12
> +#define TCQ_ITEM2_SHIFT       8
> +#define TCQ_ITEM1_SHIFT       4
> +#define TCQ_ITEM0_SHIFT       0
> +
> +#define TCQ_ITEM_TCC0         0x0
> +#define TCQ_ITEM_TCC1         0x1
> +#define TCQ_ITEM_TCC2         0x2
> +#define TCQ_ITEM_TCC3         0x3
> +#define TCQ_ITEM_TCC4         0x4
> +#define TCQ_ITEM_TCC5         0x5
> +#define TCQ_ITEM_TCC6         0x6
> +#define TCQ_ITEM_TCC7         0x7
> +#define TCQ_ITEM_GCC7         0x8
> +#define TCQ_ITEM_GCC6         0x9
> +#define TCQ_ITEM_GCC5         0xa
> +#define TCQ_ITEM_GCC4         0xb
> +#define TCQ_ITEM_GCC3         0xc
> +#define TCQ_ITEM_GCC2         0xd
> +#define TCQ_ITEM_GCC1         0xe
> +#define TCQ_ITEM_GCC0         0xf
> +
> +/* TouchScreen Convert Config 0-7 */
> +#define TCC0                  0x440
> +#define TCC1                  0x444
> +#define TCC2                  0x448
> +#define TCC3                  0x44c
> +#define TCC4                  0x450
> +#define TCC5                  0x454
> +#define TCC6                  0x458
> +#define TCC7                  0x45c
> +#define CC_PEN_IACK           (1 << 1)
> +#define CC_SEL_REFN_SHIFT     2
> +#define CC_SEL_REFN_YNLR      (0x1 << CC_SEL_REFN_SHIFT)
> +#define CC_SEL_REFN_AGND      (0x2 << CC_SEL_REFN_SHIFT)
> +#define CC_SEL_REFN_MASK      (0x3 << CC_SEL_REFN_SHIFT)
> +#define CC_SELIN_SHIFT        4
> +#define CC_SELIN_XPUL         (0x0 << CC_SELIN_SHIFT)
> +#define CC_SELIN_YPLL         (0x1 << CC_SELIN_SHIFT)
> +#define CC_SELIN_XNUR         (0x2 << CC_SELIN_SHIFT)
> +#define CC_SELIN_YNLR         (0x3 << CC_SELIN_SHIFT)
> +#define CC_SELIN_WIPER        (0x4 << CC_SELIN_SHIFT)
> +#define CC_SELIN_INAUX0       (0x5 << CC_SELIN_SHIFT)
> +#define CC_SELIN_INAUX1       (0x6 << CC_SELIN_SHIFT)
> +#define CC_SELIN_INAUX2       (0x7 << CC_SELIN_SHIFT)
> +#define CC_SELIN_MASK         (0x7 << CC_SELIN_SHIFT)
> +#define CC_SELREFP_SHIFT      7
> +#define CC_SELREFP_YPLL       (0x0 << CC_SELREFP_SHIFT)
> +#define CC_SELREFP_XPUL       (0x1 << CC_SELREFP_SHIFT)
> +#define CC_SELREFP_EXT        (0x2 << CC_SELREFP_SHIFT)
> +#define CC_SELREFP_INT        (0x3 << CC_SELREFP_SHIFT)
> +#define CC_SELREFP_MASK       (0x3 << CC_SELREFP_SHIFT)
> +#define CC_XPULSW             (1 << 9)
> +#define CC_XNURSW_SHIFT       10
> +#define CC_XNURSW_HIGH        (0x0 << CC_XNURSW_SHIFT)
> +#define CC_XNURSW_OFF         (0x1 << CC_XNURSW_SHIFT)
> +#define CC_XNURSW_LOW         (0x3 << CC_XNURSW_SHIFT)
> +#define CC_XNURSW_MASK        (0x3 << CC_XNURSW_SHIFT)
> +#define CC_YPLLSW_SHIFT       12
> +#define CC_YPLLSW_MASK        (0x3 << CC_YPLLSW_SHIFT)
> +#define CC_YNLRSW             (1 << 14)
> +#define CC_WIPERSW            (1 << 15)
> +#define CC_NOS_SHIFT          16
> +#define CC_YPLLSW_HIGH        (0x0 << CC_NOS_SHIFT)
> +#define CC_YPLLSW_OFF         (0x1 << CC_NOS_SHIFT)
> +#define CC_YPLLSW_LOW         (0x3 << CC_NOS_SHIFT)
> +#define CC_NOS_MASK           (0xf << CC_NOS_SHIFT)
> +#define CC_IGS                (1 << 20)
> +#define CC_SETTLING_TIME_SHIFT 24
> +#define CC_SETTLING_TIME_MASK (0xff << CC_SETTLING_TIME_SHIFT)
> +
> +#define TSC_4WIRE_PRECHARGE    0x158c
> +#define TSC_4WIRE_TOUCH_DETECT 0x578e
> +
> +#define TSC_4WIRE_X_MEASUMENT  0x1c90
> +#define TSC_4WIRE_Y_MEASUMENT  0x4604
> +
> +#define TSC_GENERAL_ADC_GCC0   0x17dc
> +#define TSC_GENERAL_ADC_GCC1   0x17ec
> +#define TSC_GENERAL_ADC_GCC2   0x17fc
> +
> +/* GeneralADC Convert Queue FIFO Register */
> +#define GCQFIFO                0x800
> +#define GCQFIFO_ADCOUT_SHIFT   4
> +#define GCQFIFO_ADCOUT_MASK    (0xfff << GCQFIFO_ADCOUT_SHIFT)
> +/* GeneralADC Convert Queue Control Register */
> +#define GCQCR                  0x804
> +/* GeneralADC Convert Queue Status Register */
> +#define GCQSR                  0x808
> +/* GeneralADC Convert Queue Mask Register */
> +#define GCQMR                  0x80c
> +
> +/* GeneralADC Convert Queue ITEM 7~0 */
> +#define GCQ_ITEM_7_0           0x820
> +/* GeneralADC Convert Queue ITEM 15~8 */
> +#define GCQ_ITEM_15_8          0x824
> +
> +#define GCQ_ITEM7_SHIFT        28
> +#define GCQ_ITEM6_SHIFT        24
> +#define GCQ_ITEM5_SHIFT        20
> +#define GCQ_ITEM4_SHIFT        16
> +#define GCQ_ITEM3_SHIFT        12
> +#define GCQ_ITEM2_SHIFT        8
> +#define GCQ_ITEM1_SHIFT        4
> +#define GCQ_ITEM0_SHIFT        0
> +
> +#define GCQ_ITEM_GCC0          0x0
> +#define GCQ_ITEM_GCC1          0x1
> +#define GCQ_ITEM_GCC2          0x2
> +#define GCQ_ITEM_GCC3          0x3
> +
> +/* GeneralADC Convert Config 0-7 */
> +#define GCC0                   0x840
> +#define GCC1                   0x844
> +#define GCC2                   0x848
> +#define GCC3                   0x84c
> +#define GCC4                   0x850
> +#define GCC5                   0x854
> +#define GCC6                   0x858
> +#define GCC7                   0x85c
> +
> +/* TSC Test Register R/W */
> +#define TTR                    0xc00
> +/* TSC Monitor Register 1, 2 */
> +#define MNT1                   0xc04
> +#define MNT2                   0xc04
> +
> +#define DETECT_ITEM_ID_1       1
> +#define DETECT_ITEM_ID_2       5
> +#define TS_X_ITEM_ID           2
> +#define TS_Y_ITEM_ID           3
> +#define TSI_DATA               1
> +#define FQS_DATA               0
> +
> +#endif				/* __IMX_ADC_H__ */

