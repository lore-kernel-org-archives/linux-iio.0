Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:46462 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbbCTRnS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 20 Mar 2015 13:43:18 -0400
Date: Fri, 20 Mar 2015 18:43:15 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Antoine Tenart <antoine.tenart@free-electrons.com>
cc: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, zmxu@marvell.com, jszhang@marvell.com,
	yrliao@marvell.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: add support for Berlin
In-Reply-To: <1426858565-31053-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <alpine.DEB.2.02.1503201819010.21628@pmeerw.net>
References: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com> <1426858565-31053-2-git-send-email-antoine.tenart@free-electrons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Antoine,

> This patch adds the support of the Berlin ADC, available on Berlin SoCs.
> This ADC has 8 channels available, with one connected to a temperature
> sensor.
> 
> The particularity here, is that the temperature sensor connected to the
> ADC has its own registers, and both the ADC and the temperature sensor
> must be configured when using it.

some quick comments inline below;
sometimes this refers to berlin, sometimes to berlin2?

probably these regmap_read() / _write() pairs could be MACRO()'d away 
somehow

regards, p.

> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/iio/adc/Kconfig      |   7 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/berlin-adc.c | 397 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 405 insertions(+)
>  create mode 100644 drivers/iio/adc/berlin-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 202daf889be2..2f10a6d8d442 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -135,6 +135,13 @@ config AXP288_ADC
>  	  device. Depending on platform configuration, this general purpose ADC can
>  	  be used for sampling sensors such as thermal resistors.
>  
> +config BERLIN_ADC
> +	tristate "Marvell Berlin ADC driver"
> +	depends on ARCH_BERLIN
> +	help
> +	  Marvell Berlin ADC driver. This ADC has 8 channels, with one used for
> +	  temparature measurement.

temperature

> +
>  config CC10001_ADC
>  	tristate "Cosmic Circuits 10001 ADC driver"
>  	depends on HAS_IOMEM || HAVE_CLK || REGULATOR
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 0315af640866..d7b2d1df2353 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
> +obj-$(CONFIG_BERLIN_ADC) += berlin-adc.o
>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
> diff --git a/drivers/iio/adc/berlin-adc.c b/drivers/iio/adc/berlin-adc.c
> new file mode 100644
> index 000000000000..8cb0f5800511
> --- /dev/null
> +++ b/drivers/iio/adc/berlin-adc.c
> @@ -0,0 +1,397 @@
> +/*
> + * Marvell Berlin ADC driver
> + *
> + * Copyright (C) 2015 Marvell Technology Group Ltd.
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/machine.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +

the prefix SYSCTL prefix is unexpected, couldn't you use BERLIN_ or 
something?

> +#define SYSCTL_SM_CTRL				0x14
> +#define  SYSCTL_SM_CTRL_SM_SOC_INT		BIT(1)

whitespace issue?

> +#define  SYSCTL_SM_CTRL_SOC_SM_INT		BIT(2)
> +#define  SYSCTL_SM_CTRL_ADC_SEL(x)		(BIT(x) << 5)	/* 0-15 */
> +#define  SYSCTL_SM_CTRL_ADC_SEL_MASK		(0xf << 5)
> +#define  SYSCTL_SM_CTRL_ADC_POWER		BIT(9)
> +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_DIV2		(0x0 << 10)
> +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_DIV3		(0x1 << 10)
> +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_DIV4		(0x2 << 10)
> +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_DIV8		(0x3 << 10)
> +#define  SYSCTL_SM_CTRL_ADC_CLKSEL_MASK		(0x3 << 10)
> +#define  SYSCTL_SM_CTRL_ADC_START		BIT(12)
> +#define  SYSCTL_SM_CTRL_ADC_RESET		BIT(13)
> +#define  SYSCTL_SM_CTRL_ADC_BANDGAP_RDY		BIT(14)
> +#define  SYSCTL_SM_CTRL_ADC_CONT_SINGLE		(0x0 << 15)
> +#define  SYSCTL_SM_CTRL_ADC_CONT_CONTINUOUS	(0x1 << 15)
> +#define  SYSCTL_SM_CTRL_ADC_BUFFER_EN		BIT(16)
> +#define  SYSCTL_SM_CTRL_ADC_VREF_EXT		(0x0 << 17)
> +#define  SYSCTL_SM_CTRL_ADC_VREF_INT		(0x1 << 17)
> +#define  SYSCTL_SM_CTRL_ADC_ROTATE		BIT(19)
> +#define  SYSCTL_SM_CTRL_TSEN_EN			BIT(20)
> +#define  SYSCTL_SM_CTRL_TSEN_CLK_SEL_125	(0x0 << 21)	/* 1.25 MHz */
> +#define  SYSCTL_SM_CTRL_TSEN_CLK_SEL_250	(0x1 << 21)	/* 2.5 MHz */
> +#define  SYSCTL_SM_CTRL_TSEN_MODE_0_125		(0x0 << 22)	/* 0-125 C */
> +#define  SYSCTL_SM_CTRL_TSEN_MODE_10_50		(0x1 << 22)	/* 10-50 C */
> +#define  SYSCTL_SM_CTRL_TSEN_RESET		BIT(29)
> +#define SYSCTL_SM_ADC_DATA			0x20
> +#define  SYSCTL_SM_ADC_MASK			0x3ff
> +#define SYSCTL_SM_ADC_STATUS			0x1c
> +#define  SYSCTL_SM_ADC_STATUS_DATA_RDY(x)	BIT(x)		/* 0-15 */
> +#define  SYSCTL_SM_ADC_STATUS_DATA_RDY_MASK	0xf
> +#define  SYSCTL_SM_ADC_STATUS_INT_EN(x)		(BIT(x) << 16)	/* 0-15 */
> +#define  SYSCTL_SM_ADC_STATUS_INT_EN_MASK	(0xf << 16)
> +#define SYSCTL_SM_TSEN_STATUS			0x24
> +#define  SYSCTL_SM_TSEN_STATUS_DATA_RDY		BIT(0)
> +#define  SYSCTL_SM_TSEN_STATUS_INT_EN		BIT(1)
> +#define SYSCTL_SM_TSEN_DATA			0x28
> +#define  SYSCTL_SM_TSEN_MASK			0x3ff
> +#define SYSCTL_SM_TSEN_CTRL			0x74
> +#define  SYSCTL_SM_TSEN_CTRL_START		BIT(8)
> +#define  SYSCTL_SM_TSEN_CTRL_SETTLING_4		(0x0 << 21)	/* 4 us */
> +#define  SYSCTL_SM_TSEN_CTRL_SETTLING_12	(0x1 << 21)	/* 12 us */
> +#define  SYSCTL_SM_TSEN_CTRL_TRIM(x)		((x) << 22)
> +#define  SYSCTL_SM_TSEN_CTRL_TRIM_MASK		(0xf << 22)
> +
> +struct berlin2_adc_priv {
> +	struct regmap		*regmap;
> +	struct mutex		lock;
> +	wait_queue_head_t	wq;
> +	u32			irq;
> +	u32			tsen_irq;

int rather

> +	bool			data_available;
> +	int			data;
> +};
> +
> +#define BERLIN2_ADC_CHANNEL(n, t)					\
> +		{							\
> +			.channel	= n,				\
> +			.datasheet_name	= "channel"#n,			\
> +			.type		= t,				\
> +			.indexed	= 1,				\
> +			.scan_index	= n,				\
> +			.scan_type	= {				\
> +				.sign		= 'u',			\
> +				.realbits	= 64,			\
> +				.storagebits	= 64,			\
> +			},						\

the data read is not 64 bit I think

the driver does not seem to support buffered reads, so scan_type and 
scan_index can be removed


> +			.info_mask_shared_by_type = 0,			\

.info_mask_shared_by_type = 0 is unnecessary

> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		}
> +
> +#define N_CHANNELS		8

not prefixed; would be good if you could do with ARRAY_SIZE over 
_adc_channels instead

> +static struct iio_chan_spec berlin2_adc_channels[] = {

why berlin2?

> +	BERLIN2_ADC_CHANNEL(0, IIO_VOLTAGE),	/* external input */
> +	BERLIN2_ADC_CHANNEL(1, IIO_VOLTAGE),	/* external input */
> +	BERLIN2_ADC_CHANNEL(2, IIO_VOLTAGE),	/* external input */
> +	BERLIN2_ADC_CHANNEL(3, IIO_VOLTAGE),	/* external input */
> +	BERLIN2_ADC_CHANNEL(4, IIO_VOLTAGE),	/* reserved */
> +	BERLIN2_ADC_CHANNEL(5, IIO_VOLTAGE),	/* reserved */
> +	BERLIN2_ADC_CHANNEL(6, IIO_TEMP),	/* temperature sensor */

the temperature channel is not indexed (there is only one)

> +	BERLIN2_ADC_CHANNEL(7, IIO_VOLTAGE),	/* reserved */
> +	{					/* timestamp */


use IIO_CHAN_SOFT_TIMESTAMP(N_CHANNELS) here

> +		.channel	= -1,
> +		.type		= IIO_TIMESTAMP,
> +		.scan_index	= N_CHANNELS,
> +		.scan_type	= {
> +			.sign		= 's',
> +			.realbits	= 64,
> +			.storagebits	= 64,
> +		},
> +	},
> +};
> +
> +static int berlin2_adc_read(struct iio_dev *idev, int channel)
> +{
> +	struct berlin2_adc_priv *priv = iio_priv(idev);
> +	int val, data, ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	/* Configure the ADC */
> +	regmap_read(priv->regmap, SYSCTL_SM_CTRL, &val);
> +	val &= ~(SYSCTL_SM_CTRL_ADC_RESET | SYSCTL_SM_CTRL_ADC_SEL_MASK);
> +	val |= SYSCTL_SM_CTRL_ADC_SEL(channel) | SYSCTL_SM_CTRL_ADC_START;
> +	regmap_write(priv->regmap, SYSCTL_SM_CTRL, val);
> +
> +	/* Enable the interrupts */
> +	regmap_write(priv->regmap, SYSCTL_SM_ADC_STATUS,
> +			SYSCTL_SM_ADC_STATUS_INT_EN(channel));
> +
> +	ret = wait_event_interruptible_timeout(priv->wq, priv->data_available,
> +			msecs_to_jiffies(1000));
> +
> +	/* Disable the interrupts */
> +	regmap_read(priv->regmap, SYSCTL_SM_ADC_STATUS, &val);
> +	val &= ~SYSCTL_SM_ADC_STATUS_INT_EN(channel);
> +	regmap_write(priv->regmap, SYSCTL_SM_ADC_STATUS, val);
> +
> +	if (ret == 0)
> +		ret = -ETIMEDOUT;
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +
> +	regmap_read(priv->regmap, SYSCTL_SM_CTRL, &val);
> +	val &= ~SYSCTL_SM_CTRL_ADC_START;
> +	regmap_write(priv->regmap, SYSCTL_SM_CTRL, val);
> +
> +	data = priv->data;
> +	priv->data = -1;
> +	priv->data_available = false;
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return data;
> +}
> +
> +static int berlin2_adc_tsen_read(struct iio_dev *idev)
> +{
> +	struct berlin2_adc_priv *priv = iio_priv(idev);
> +	int val, data, ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	/* Configure the ADC */
> +	regmap_read(priv->regmap, SYSCTL_SM_CTRL, &val);
> +	val &= ~SYSCTL_SM_CTRL_TSEN_RESET;
> +	val |= SYSCTL_SM_CTRL_ADC_ROTATE;
> +	regmap_write(priv->regmap, SYSCTL_SM_CTRL, val);
> +
> +	/* Configure the temperature sensor */
> +	regmap_read(priv->regmap, SYSCTL_SM_TSEN_CTRL, &val);
> +	val &= ~SYSCTL_SM_TSEN_CTRL_TRIM_MASK;
> +	val |= SYSCTL_SM_TSEN_CTRL_TRIM(3) | SYSCTL_SM_TSEN_CTRL_SETTLING_12
> +		| SYSCTL_SM_TSEN_CTRL_START;
> +	regmap_write(priv->regmap, SYSCTL_SM_TSEN_CTRL, val);
> +
> +	/* Enable interrupts */
> +	regmap_write(priv->regmap, SYSCTL_SM_TSEN_STATUS,
> +			SYSCTL_SM_TSEN_STATUS_INT_EN);
> +
> +	ret = wait_event_interruptible_timeout(priv->wq, priv->data_available,
> +			msecs_to_jiffies(1000));
> +
> +	/* Disable interrupts */
> +	regmap_read(priv->regmap, SYSCTL_SM_TSEN_STATUS, &val);
> +	val &= ~SYSCTL_SM_TSEN_STATUS_INT_EN;
> +	regmap_write(priv->regmap, SYSCTL_SM_TSEN_STATUS, val);
> +
> +	if (ret == 0)
> +		ret = -ETIMEDOUT;
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +
> +	regmap_read(priv->regmap, SYSCTL_SM_TSEN_CTRL, &val);
> +	val &= ~SYSCTL_SM_TSEN_CTRL_START;
> +	regmap_write(priv->regmap, SYSCTL_SM_TSEN_CTRL, val);
> +
> +	data = priv->data;
> +	priv->data = -1;
> +	priv->data_available = false;
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return data;
> +}
> +
> +static int berlin2_adc_read_raw(struct iio_dev *idev,
> +		struct iio_chan_spec const *chan, int *val, int *val2,
> +		long mask)
> +{
> +	int temp;

maybe named it ret and use instead of *val and temp

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_VOLTAGE) {
> +			*val = berlin2_adc_read(idev, chan->channel);
> +			if (*val < 0)
> +				return *val;

is this milli-Volts?

> +
> +			return IIO_VAL_INT;
> +		} else if (chan->type == IIO_TEMP) {
> +			temp = berlin2_adc_tsen_read(idev);
> +			if (temp < 0)
> +				return temp;
> +
> +			if (temp > 2047)
> +				temp = -(4096 - temp);
> +
> +			/* Convert to Celsius */
> +			*val = (temp * 100) / 264 - 270;

use SCALE and OFFSET IIO_CHAN_INFO_s to that the temperature can be 
interpreted as milli-Celsius (or use _PROCESSED, not _RAW)

> +			return IIO_VAL_INT;
> +		}
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t berlin2_adc_irq(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct berlin2_adc_priv *priv = iio_priv(idev);
> +	unsigned val;
> +
> +	regmap_read(priv->regmap, SYSCTL_SM_ADC_STATUS, &val);
> +	if (val & SYSCTL_SM_ADC_STATUS_DATA_RDY_MASK) {
> +		regmap_read(priv->regmap, SYSCTL_SM_ADC_DATA, &priv->data);
> +		priv->data &= SYSCTL_SM_ADC_MASK;
> +
> +		val &= ~SYSCTL_SM_ADC_STATUS_DATA_RDY_MASK;
> +		regmap_write(priv->regmap, SYSCTL_SM_ADC_STATUS, val);
> +
> +		priv->data_available = true;
> +		wake_up_interruptible(&priv->wq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t berlin2_adc_tsen_irq(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct berlin2_adc_priv *priv = iio_priv(idev);
> +	unsigned val;
> +
> +	regmap_read(priv->regmap, SYSCTL_SM_TSEN_STATUS, &val);
> +	if (val & SYSCTL_SM_TSEN_STATUS_DATA_RDY) {
> +		regmap_read(priv->regmap, SYSCTL_SM_TSEN_DATA, &priv->data);
> +		priv->data &= SYSCTL_SM_TSEN_MASK;
> +
> +		val &= ~SYSCTL_SM_TSEN_STATUS_DATA_RDY;
> +		regmap_write(priv->regmap, SYSCTL_SM_TSEN_STATUS, val);
> +
> +		priv->data_available = true;
> +		wake_up_interruptible(&priv->wq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info berlin2_adc_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= berlin2_adc_read_raw,
> +};
> +
> +static int berlin2_adc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *idev;

people prefer indio_dev instead of idev

> +	struct berlin2_adc_priv *priv;
> +	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
> +	int ret, val;
> +
> +	idev = iio_device_alloc(sizeof(struct berlin2_adc_priv));

devm_iio_device_alloc?

> +	if (!idev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(idev);
> +	platform_set_drvdata(pdev, idev);
> +
> +	priv->regmap = syscon_node_to_regmap(parent_np);
> +	of_node_put(parent_np);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->irq = platform_get_irq_byname(pdev, "adc");
> +	if (priv->irq < 0)

you have irq as u32, should be int otherwise the check does not make sense

> +		return -ENODEV;
> +
> +	priv->tsen_irq = platform_get_irq_byname(pdev, "tsen");
> +	if (priv->tsen_irq < 0)
> +		return -ENODEV;
> +
> +	ret = devm_request_irq(&pdev->dev, priv->irq, berlin2_adc_irq, 0,
> +			pdev->dev.driver->name, idev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(&pdev->dev, priv->tsen_irq, berlin2_adc_tsen_irq,
> +			0, pdev->dev.driver->name, idev);
> +	if (ret)
> +		return ret;
> +
> +	init_waitqueue_head(&priv->wq);
> +	mutex_init(&priv->lock);
> +
> +	idev->dev.parent = &pdev->dev;
> +	idev->name = dev_name(&pdev->dev);
> +	idev->modes = INDIO_DIRECT_MODE;
> +	idev->info = &berlin2_adc_info;
> +
> +	idev->num_channels = N_CHANNELS;
> +	idev->channels = berlin2_adc_channels;
> +
> +	/* Power up the ADC */
> +	regmap_read(priv->regmap, SYSCTL_SM_CTRL, &val);
> +	val |= SYSCTL_SM_CTRL_ADC_POWER;
> +	regmap_write(priv->regmap, SYSCTL_SM_CTRL, val);
> +
> +	ret = iio_device_register(idev);

devm_iio_device_register?

> +	if (ret) {
> +		dev_err(&pdev->dev,  "Failed to register the IIO device: %d\n",
> +			ret);

probably not the most useful error msg and about the only logging; drop 
it?

and just do 
return devm_iio_device_register(idev);

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int berlin2_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *idev = platform_get_drvdata(pdev);
> +	struct berlin2_adc_priv *priv = iio_priv(idev);
> +	int val;
> +
> +	/* Power down the ADC */
> +	regmap_read(priv->regmap, SYSCTL_SM_CTRL, &val);
> +	val &= ~SYSCTL_SM_CTRL_ADC_POWER;
> +	regmap_write(priv->regmap, SYSCTL_SM_CTRL, val);
> +
> +	free_irq(priv->irq, idev);
> +	free_irq(priv->tsen_irq, idev);
> +
> +	iio_device_unregister(idev);
> +	iio_device_free(idev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id berlin2_adc_match[] = {
> +	{ .compatible = "marvell,berlin2-adc", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, berlin2q_adc_match);
> +
> +static struct platform_driver berlin2_adc_driver = {
> +	.driver	= {
> +		.name		= "berlin2-adc",
> +		.of_match_table	= berlin2_adc_match,
> +	},
> +	.probe	= berlin2_adc_probe,
> +	.remove	= berlin2_adc_remove,
> +};
> +module_platform_driver(berlin2_adc_driver);
> +
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
> +MODULE_DESCRIPTION("Marvell Berlin2 ADC driver");
> +MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
