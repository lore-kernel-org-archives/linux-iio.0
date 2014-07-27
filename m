Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:53020 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbaG0N2A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 27 Jul 2014 09:28:00 -0400
Message-ID: <53D4FEF0.5040402@kernel.org>
Date: Sun, 27 Jul 2014 14:30:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Add TI ADC128S052
References: <1406300618-8873-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1406300618-8873-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/07/14 16:03, Angelo Compagnucci wrote:
> This patch adds support for ADC128S052 from TI.
>
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Hi Angelo,

Looking pretty good.  You need to deal with the alignement of the SPI
buffers to allow them to be used with spi controllers that use DMA.
Couple of other really minor bits.

Jonathan
> ---
>   drivers/iio/adc/Kconfig         |  10 +++
>   drivers/iio/adc/Makefile        |   1 +
>   drivers/iio/adc/ti-adc128s052.c | 185 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 196 insertions(+)
>   create mode 100644 drivers/iio/adc/ti-adc128s052.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 11b048a..9dbab93 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -216,6 +216,16 @@ config TI_ADC081C
>   	  This driver can also be built as a module. If so, the module will be
>   	  called ti-adc081c.
>
> +config TI_ADC128S052
> +	tristate "Texas Instruments ADC128S052"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments ADC128S052
> +	  chip.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-adc128s052.
> +
>   config TI_AM335X_ADC
>   	tristate "TI's AM335X ADC driver"
>   	depends on MFD_TI_AM335X_TSCADC
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ad81b51..9cc37f6 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_MCP3422) += mcp3422.o
>   obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>   obj-$(CONFIG_NAU7802) += nau7802.o
>   obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
> +obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>   obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>   obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>   obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> new file mode 100644
> index 0000000..b7c34f4
> --- /dev/null
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -0,0 +1,185 @@
> +/*
> + * Copyright (C) 2014 Angelo Compagnucci <angelo.compagnucci@gmail.com>
> + *
> + * Driver for Texas Instruments' ADC128S052 ADC chip.
> + * Datasheet can be found here:
> + * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> +
> +struct adc128 {
> +	struct spi_device *spi;
> +	struct spi_message msg;
> +	struct spi_transfer transfer[2];
> +
THis an spi device which means the buffers used in spi_sync need
to be dma safe.  That is they have to exist in their own cacheline
to avoid possible corruption if the spi controller in question is using
DMA.   Easiest way of doing this is to move them to the end of this
struct and use the magic of ____cacheline_aligned. Not that as this
is a common situation, the iio_priv allocation is also aligned to
a cacheline ensuring that when you do another such alignment inside
it the result will be that everything ends up where it should.

> +	u8 tx_buf;
> +	u8 rx_buf[2];
> +
> +	struct regulator *reg;
> +	struct mutex lock;
> +};
> +
> +static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
> +{
> +	int ret;
> +
> +	adc->tx_buf = channel << 3;
> +	ret = spi_sync(adc->spi, &adc->msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ((adc->rx_buf[0] << 8 | adc->rx_buf[1]) & 0xFFF);
> +}
> +
> +static int adc128_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct adc128 *adc = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +
> +		ret = adc128_adc_conversion(adc, channel->channel);
> +
> +		if (ret < 0)
> +			goto out;
> +
> +		*val = ret;
> +		ret = IIO_VAL_INT;
> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Digital output code = (4096 * Vin) / Vref */
> +		ret = regulator_get_voltage(adc->reg);
> +		if (ret < 0)
> +			goto out;
> +
> +		*val = ret / 1000;
> +		*val2 = 12;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +out:
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +#define ADC128_VOLTAGE_CHANNEL(num)				\
> +	{							\
> +		.type = IIO_VOLTAGE,				\
> +		.indexed = 1,					\
> +		.channel = (num),				\
> +		.address = (num),				\
You don't use address (and it's the same as channel anyway so there
would be little point in any case) so don't set it.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
> +	}
> +
> +static const struct iio_chan_spec adc128_channels[] = {
> +	ADC128_VOLTAGE_CHANNEL(0),
> +	ADC128_VOLTAGE_CHANNEL(1),
> +	ADC128_VOLTAGE_CHANNEL(2),
> +	ADC128_VOLTAGE_CHANNEL(3),
> +	ADC128_VOLTAGE_CHANNEL(4),
> +	ADC128_VOLTAGE_CHANNEL(5),
> +	ADC128_VOLTAGE_CHANNEL(6),
> +	ADC128_VOLTAGE_CHANNEL(7),
> +};
> +
> +static const struct iio_info adc128_info = {
> +	.read_raw = adc128_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int adc128_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adc128 *adc;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->spi = spi;
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc128_info;
> +
> +	indio_dev->channels = adc128_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adc128_channels);
> +
> +	adc->transfer[0].tx_buf = &adc->tx_buf;
> +	adc->transfer[0].len = sizeof(adc->tx_buf);
> +	adc->transfer[1].rx_buf = adc->rx_buf;
> +	adc->transfer[1].len = sizeof(adc->rx_buf);
> +
> +	spi_message_init_with_transfers(&adc->msg, adc->transfer,
> +					ARRAY_SIZE(adc->transfer));
> +
> +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(adc->reg))
> +		return PTR_ERR(adc->reg);
> +
> +	ret = regulator_enable(adc->reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_init(&adc->lock);
> +
> +	ret = iio_device_register(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int adc128_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adc128 *adc = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(adc->reg);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id adc128_id[] = {
> +	{ "adc128s052", 1 },
Why the 1?  If you aren't doing anything with the data element
of the device_id, usual convention is to set it to 0 or not
bother actively setting it at all!

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adc128_id);
> +
> +static struct spi_driver adc128_driver = {
> +	.driver = {
> +		.name = "adc128s052",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = adc128_probe,
> +	.remove = adc128_remove,
> +	.id_table = adc128_id,
> +};
> +module_spi_driver(adc128_driver);
> +
> +MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADC128S052");
> +MODULE_LICENSE("GPL v2");
>

