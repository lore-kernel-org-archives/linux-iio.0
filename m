Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42087 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbcH2RSC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:18:02 -0400
Subject: Re: [PATCH v2] iio: dac: AD8801: add Analog Devices AD8801/AD8803
 support
To: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        linux-iio@vger.kernel.org
References: <20160824144420.7326-1-gwenhael.goavec-merou@trabucayre.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Paul Cercueil <paul.cercueil@analog.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <baba8aaf-d3b4-dd20-5c34-54f025ad8667@kernel.org>
Date: Mon, 29 Aug 2016 18:17:59 +0100
MIME-Version: 1.0
In-Reply-To: <20160824144420.7326-1-gwenhael.goavec-merou@trabucayre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/08/16 15:44, Gwenhael Goavec-Merou wrote:
> Add support for Analog Devices AD8801/AD8803, 8 channels 8bits, Digital to
> Analog converters.
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
One utterly trivial point inline that I'll clear up whilst apply.

Nice driver.

Applied to the togreg branch of iio.git which will initially be pushed
out as testing for the autobuilders to try and break it.

Thanks,

Jonathan
> ---
> Changes v1 -> v2:
> 	- fix some whitespace (Lars-Peter Clausen)
> 	- fix signed-off-by (Lars-Peter Clausen)
> 	- supress useless of*.h headers (Lars-Peter Clausen)
> 	- channel numbers must start at 0 (Lars-Peter Clausen)
> 	- ad8801_channels array must be static (Lars-Peter Clausen)
> 	- typo (Peter Meerwald-Stadler)
> 	- suppress parenthesis (Peter Meerwald-Stadler)
> 	- add a return -EINVAL (Peter Meerwald-Stadler)
> ---
>  drivers/iio/dac/Kconfig  |  10 ++
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad8801.c | 241 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 252 insertions(+)
>  create mode 100644 drivers/iio/dac/ad8801.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index ca81447..b03063c 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -181,6 +181,16 @@ config AD7303
>  	  To compile this driver as module choose M here: the module will be called
>  	  ad7303.
>  
> +config AD8801
> +	tristate "Analog Devices AD8801/AD8803 DAC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Analog Devices AD8801, AD8803 Digital to
> +	  Analog Converters (DAC).
> +
> +	  To compile this driver as a module choose M here: the module will be called
> +	  ad8801.
> +
>  config LPC18XX_DAC
>  	tristate "NXP LPC18xx DAC driver"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 8b78d5c..c5767b8 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
>  obj-$(CONFIG_AD5791) += ad5791.o
>  obj-$(CONFIG_AD5686) += ad5686.o
>  obj-$(CONFIG_AD7303) += ad7303.o
> +obj-$(CONFIG_AD8801) += ad8801.o
>  obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
>  obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
> diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
> new file mode 100644
> index 0000000..e81236e
> --- /dev/null
> +++ b/drivers/iio/dac/ad8801.c
> @@ -0,0 +1,241 @@
> +/*
> + * IIO DAC driver for Analog Devices AD8801 DAC
> + *
> + * Copyright (C) 2016 Gwenhael Goavec-Merou
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +
> +#define AD8801_CFG_ADDR_OFFSET 8
> +
> +enum ad8801_device_ids {
> +	ID_AD8801,
> +	ID_AD8803,
> +};
> +
> +struct ad8801_state {
> +	struct spi_device *spi;
> +	unsigned char dac_cache[8]; /* Value write on each channel */
> +	unsigned int vrefh_mv;
> +	unsigned int vrefl_mv;
> +	struct regulator *vrefh_reg;
> +	struct regulator *vrefl_reg;
> +
> +	__be16 data ____cacheline_aligned;
> +};
> +
> +static int ad8801_spi_write(struct ad8801_state *state,
> +	u8 channel, unsigned char value)
> +{
> +	state->data = cpu_to_be16((channel << AD8801_CFG_ADDR_OFFSET) | value);
> +	return spi_write(state->spi, &state->data, sizeof(state->data));
> +}
> +
> +static int ad8801_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	struct ad8801_state *state = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val >= 256 || val < 0)
> +			return -EINVAL;
> +
> +		ret = ad8801_spi_write(state, chan->channel, val);
> +		if (ret == 0)
> +			state->dac_cache[chan->channel] = val;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad8801_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long info)
> +{
> +	struct ad8801_state *state = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = state->dac_cache[chan->channel];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = state->vrefh_mv - state->vrefl_mv;
> +		*val2 = 8;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = state->vrefl_mv;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info ad8801_info = {
> +	.read_raw = ad8801_read_raw,
> +	.write_raw = ad8801_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +#define AD8801_CHANNEL(chan) {		\
> +	.type = IIO_VOLTAGE,			\
> +	.indexed = 1,				\
> +	.output = 1,				\
> +	.channel = chan,			\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +		BIT(IIO_CHAN_INFO_OFFSET), \
> +	.address = chan,			\
You never use this. I'll drop it whilst merging if I don't find anything
more major.
> +}
> +
> +static const struct iio_chan_spec ad8801_channels[] = {
> +	AD8801_CHANNEL(0),
> +	AD8801_CHANNEL(1),
> +	AD8801_CHANNEL(2),
> +	AD8801_CHANNEL(3),
> +	AD8801_CHANNEL(4),
> +	AD8801_CHANNEL(5),
> +	AD8801_CHANNEL(6),
> +	AD8801_CHANNEL(7),
> +};
> +
> +static int ad8801_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad8801_state *state;
> +	const struct spi_device_id *id;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	state->spi = spi;
> +	id = spi_get_device_id(spi);
> +
> +	state->vrefh_reg = devm_regulator_get(&spi->dev, "vrefh");
> +	if (IS_ERR(state->vrefh_reg)) {
> +		dev_err(&spi->dev, "Vrefh regulator not specified\n");
> +		return PTR_ERR(state->vrefh_reg);
> +	}
> +
> +	ret = regulator_enable(state->vrefh_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable vrefh regulator: %d\n",
> +				ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_get_voltage(state->vrefh_reg);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to read vrefh regulator: %d\n",
> +				ret);
> +		goto error_disable_vrefh_reg;
> +	}
> +	state->vrefh_mv = ret / 1000;
> +
> +	if (id->driver_data == ID_AD8803) {
> +		state->vrefl_reg = devm_regulator_get(&spi->dev, "vrefl");
> +		if (IS_ERR(state->vrefl_reg)) {
> +			dev_err(&spi->dev, "Vrefl regulator not specified\n");
> +			ret = PTR_ERR(state->vrefl_reg);
> +			goto error_disable_vrefh_reg;
> +		}
> +
> +		ret = regulator_enable(state->vrefl_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable vrefl regulator: %d\n",
> +					ret);
> +			goto error_disable_vrefh_reg;
> +		}
> +
> +		ret = regulator_get_voltage(state->vrefl_reg);
> +		if (ret < 0) {
> +			dev_err(&spi->dev, "Failed to read vrefl regulator: %d\n",
> +					ret);
> +			goto error_disable_vrefl_reg;
> +		}
> +		state->vrefl_mv = ret / 1000;
> +	} else {
> +		state->vrefl_mv = 0;
> +		state->vrefl_reg = NULL;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &ad8801_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad8801_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad8801_channels);
> +	indio_dev->name = id->name;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to register iio device: %d\n",
> +				ret);
> +		goto error_disable_vrefl_reg;
> +	}
> +
> +	return 0;
> +
> +error_disable_vrefl_reg:
> +	if (state->vrefl_reg)
> +		regulator_disable(state->vrefl_reg);
> +error_disable_vrefh_reg:
> +	regulator_disable(state->vrefh_reg);
> +	return ret;
> +}
> +
> +static int ad8801_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ad8801_state *state = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	if (state->vrefl_reg)
> +		regulator_disable(state->vrefl_reg);
> +	regulator_disable(state->vrefh_reg);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id ad8801_ids[] = {
> +	{"ad8801", ID_AD8801},
> +	{"ad8803", ID_AD8803},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad8801_ids);
> +
> +static struct spi_driver ad8801_driver = {
> +	.driver = {
> +		.name	= "ad8801",
> +	},
> +	.probe		= ad8801_probe,
> +	.remove		= ad8801_remove,
> +	.id_table	= ad8801_ids,
> +};
> +module_spi_driver(ad8801_driver);
> +
> +MODULE_AUTHOR("Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>");
> +MODULE_DESCRIPTION("Analog Devices AD8801/AD8803 DAC");
> +MODULE_LICENSE("GPL v2");
> +
> 

