Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50713 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdANKXA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 05:23:00 -0500
Subject: Re: [PATCH v4 1/2] iio: adc: Add Maxim MAX11100 driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        marek.vasut@gmail.com, geert@linux-m68k.org, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1484301038-16386-1-git-send-email-jacopo+renesas@jmondi.org>
 <1484301038-16386-2-git-send-email-jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <138a6eee-a845-89d3-003a-8045c57c56c3@kernel.org>
Date: Sat, 14 Jan 2017 10:22:54 +0000
MIME-Version: 1.0
In-Reply-To: <1484301038-16386-2-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/01/17 09:50, Jacopo Mondi wrote:
> From: Jacopo Mondi <jacopo@jmondi.org>
> 
> Add iio driver for Maxim MAX11100 single-channel ADC.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Tested-by: Marek Vasut <marek.vasut@gmail.com>
>
Small issue with DMA using SPI controllers and the location of buffer
in your read.

Otherwise looks good to me.

Jonathan
> ---
>  drivers/iio/adc/Kconfig    |   9 +++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max11100.c | 187 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 drivers/iio/adc/max11100.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 38bc319..c32bc7a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -307,6 +307,15 @@ config MAX1027
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max1027.
>  
> +config MAX11100
> +	tristate "Maxim max11100 ADC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Maxim max11100 SPI ADC
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max11100.
> +
>  config MAX1363
>  	tristate "Maxim max1363 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d36c4be..5684369 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LTC2485) += ltc2485.o
>  obj-$(CONFIG_MAX1027) += max1027.o
> +obj-$(CONFIG_MAX11100) += max11100.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> new file mode 100644
> index 0000000..78e2a45
> --- /dev/null
> +++ b/drivers/iio/adc/max11100.c
> @@ -0,0 +1,187 @@
> +/*
> + * iio/adc/max11100.c
> + * Maxim max11100 ADC Driver with IIO interface
> + *
> + * Copyright (C) 2016 Renesas Electronics Corporation
> + * Copyright (C) 2016 Jacopo Mondi
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/driver.h>
> +
> +/*
> + * LSB is the ADC single digital step
> + * 1 LSB = (vref_mv / 2 ^ 16)
> + *
> + * LSB is used to calculate analog voltage value
> + * from the number of ADC steps count
> + *
> + * Ain = (count * LSB)
> + */
> +#define MAX11100_LSB_DIV		(1 << 16)
> +
> +struct max11100_state {
> +	const struct max11100_chip_desc *desc;
> +	struct regulator *vref_reg;
> +	struct spi_device *spi;
> +};
> +
> +static struct iio_chan_spec max11100_channels[] = {
> +	{ /* [0] */
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static struct max11100_chip_desc {
> +	unsigned int num_chan;
> +	const struct iio_chan_spec *channels;
> +} max11100_desc = {
> +	.num_chan = ARRAY_SIZE(max11100_channels),
> +	.channels = max11100_channels,
> +};
> +
> +static int max11100_read_single(struct iio_dev *indio_dev, int *val)
> +{
> +	int ret;
> +	struct max11100_state *state = iio_priv(indio_dev);
> +	uint8_t buffer[3];
> +
> +	ret = spi_read(state->spi, buffer, sizeof(buffer));
Buffer needs to be __cacheline_aligned to safely use spi_read on spi
controllers that use DMA.

Two easy ways of doing this, either allocate buffer using kmalloc or
take advantage of the fact that spi_priv() is cache line aligned and
stick you buffer at the end of your private structure and mark it
__cacheline_aligned to ensure it also appropriately aligned in it's own
cacheline.

> +	if (ret) {
> +		dev_err(&indio_dev->dev, "SPI transfer failed\n");
> +		return ret;
> +	}
> +
> +	/* the first 8 bits sent out from ADC must be 0s */
> +	if (buffer[0]) {
> +		dev_err(&indio_dev->dev, "Invalid value: buffer[0] != 0\n");
> +		return -EINVAL;
> +	}
> +
> +	*val = (buffer[1] << 8) | buffer[2];
> +
> +	return 0;
> +}
> +
> +static int max11100_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	int ret, vref_uv;
> +	struct max11100_state *state = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = max11100_read_single(indio_dev, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		vref_uv = regulator_get_voltage(state->vref_reg);
> +		if (vref_uv < 0)
> +			/* dummy regulator "get_voltage" returns -EINVAL */
> +			return -EINVAL;
> +
> +		*val =  vref_uv / 1000;
> +		*val2 = MAX11100_LSB_DIV;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info max11100_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = max11100_read_raw,
> +};
> +
> +static int max11100_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct max11100_state *state;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	state = iio_priv(indio_dev);
> +	state->spi = spi;
> +	state->desc = &max11100_desc;
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.of_node = spi->dev.of_node;
> +	indio_dev->info = &max11100_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = state->desc->channels;
> +	indio_dev->num_channels = state->desc->num_chan;
> +
> +	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(state->vref_reg))
> +		return PTR_ERR(state->vref_reg);
> +
> +	ret = regulator_enable(state->vref_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto disable_regulator;
> +
> +	return 0;
> +
> +disable_regulator:
> +	regulator_disable(state->vref_reg);
> +
> +	return ret;
> +}
> +
> +static int max11100_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct max11100_state *state = iio_priv(indio_dev);
> +
> +	regulator_disable(state->vref_reg);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max11100_ids[] = {
> +	{.compatible = "maxim,max11100"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, max11100_ids);
> +
> +static struct spi_driver max11100_driver = {
> +	.driver = {
> +		.name	= "max11100",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(max11100_ids),
> +	},
> +	.probe		= max11100_probe,
> +	.remove		= max11100_remove,
> +};
> +
> +module_spi_driver(max11100_driver);
> +
> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> +MODULE_DESCRIPTION("Maxim max11100 ADC Driver");
> +MODULE_LICENSE("GPL v2");
> 

