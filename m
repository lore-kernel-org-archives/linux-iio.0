Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:34391 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab2BPPOl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2012 10:14:41 -0500
Message-ID: <4F3D1D37.6050005@cam.ac.uk>
Date: Thu, 16 Feb 2012 15:13:59 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 3/5] staging:iio:dac:ad5064: Add AD5628/AD5648/AD5668
 support
References: <1329389351-21584-1-git-send-email-lars@metafoo.de> <1329389351-21584-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1329389351-21584-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/16/2012 10:49 AM, Lars-Peter Clausen wrote:
> The AD5628/AD5648/AD5668 are similar to the AD5024/AD5044/AD5064. They have an
> internal reference voltage and 8 instead of 4 DAC channels.
I'd marginally have preferred this set as a cleanup then the extension 
to cover the 8 channel
parts but it's fine like this.
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/dac/Kconfig  |    4 +-
>   drivers/staging/iio/dac/ad5064.c |  180 +++++++++++++++++++++++++++++---------
>   2 files changed, 139 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index 13e2797..f86179c 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -4,11 +4,11 @@
>   menu "Digital to analog converters"
>
>   config AD5064
> -	tristate "Analog Devices AD5064/64-1/44/24 DAC driver"
> +	tristate "Analog Devices AD5064/64-1/44/24, AD5628/48/68 DAC driver"
>   	depends on SPI
>   	help
>   	  Say yes here to build support for Analog Devices AD5064, AD5064-1,
> -	  AD5044, AD5024 Digital to Analog Converter.
> +	  AD5044, AD5024, AD5628, AD5648, AD5668 Digital to Analog Converter.
>
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called ad5064.
> diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
> index 202f927..8cf8ca3 100644
> --- a/drivers/staging/iio/dac/ad5064.c
> +++ b/drivers/staging/iio/dac/ad5064.c
> @@ -1,5 +1,6 @@
>   /*
> - * AD5064, AD5064-1, AD5044, AD5024 Digital to analog converters  driver
> + * AD5064, AD5064-1, AD5044, AD5024, AD5628, AD5648, AD5668
> + * Digital to analog converters driver
>    *
>    * Copyright 2011 Analog Devices Inc.
>    *
> @@ -19,7 +20,8 @@
>   #include "../sysfs.h"
>   #include "dac.h"
>
> -#define AD5064_DAC_CHANNELS			4
> +#define AD5064_MAX_DAC_CHANNELS			8
> +#define AD5064_MAX_VREFS			4
>
>   #define AD5064_ADDR(x)				((x)<<  20)
>   #define AD5064_CMD(x)				((x)<<  24)
> @@ -35,7 +37,10 @@
>   #define AD5064_CMD_CLEAR			0x5
>   #define AD5064_CMD_LDAC_MASK			0x6
>   #define AD5064_CMD_RESET			0x7
> -#define AD5064_CMD_DAISY_CHAIN_ENABLE		0x8
> +#define AD5064_CMD_CONFIG			0x8
> +
> +#define AD5064_CONFIG_DAISY_CHAIN_ENABLE	BIT(1)
> +#define AD5064_CONFIG_INT_VREF_ENABLE		BIT(0)
>
>   #define AD5064_LDAC_PWRDN_NONE			0x0
>   #define AD5064_LDAC_PWRDN_1K			0x1
> @@ -45,12 +50,17 @@
>   /**
>    * struct ad5064_chip_info - chip specific information
>    * @shared_vref:	whether the vref supply is shared between channels
> + * @internal_vref:	internal reference voltage. 0 if the chip has no internal
> + *			vref.
>    * @channel:		channel specification
> -*/
> + * @num_channels:	number of channels
> + */
>
>   struct ad5064_chip_info {
>   	bool shared_vref;
> -	struct iio_chan_spec channel[AD5064_DAC_CHANNELS];
> +	unsigned long internal_vref;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
>   };
>
>   /**
> @@ -61,16 +71,19 @@ struct ad5064_chip_info {
>    * @pwr_down:		whether channel is powered down
>    * @pwr_down_mode:	channel's current power down mode
>    * @dac_cache:		current DAC raw value (chip does not support readback)
> + * @use_internal_vref:	set to true if the internal reference voltage should be
> + *			used.
>    * @data:		spi transfer buffers
>    */
>
>   struct ad5064_state {
>   	struct spi_device		*spi;
>   	const struct ad5064_chip_info	*chip_info;
> -	struct regulator_bulk_data	vref_reg[AD5064_DAC_CHANNELS];
> -	bool				pwr_down[AD5064_DAC_CHANNELS];
> -	u8				pwr_down_mode[AD5064_DAC_CHANNELS];
> -	unsigned int			dac_cache[AD5064_DAC_CHANNELS];
> +	struct regulator_bulk_data	vref_reg[AD5064_MAX_VREFS];
> +	bool				pwr_down[AD5064_MAX_DAC_CHANNELS];
> +	u8				pwr_down_mode[AD5064_MAX_DAC_CHANNELS];
> +	unsigned int			dac_cache[AD5064_MAX_DAC_CHANNELS];
> +	bool				use_internal_vref;
>
>   	/*
>   	 * DMA (thus cache coherency maintenance) requires the
> @@ -84,6 +97,12 @@ enum ad5064_type {
>   	ID_AD5044,
>   	ID_AD5064,
>   	ID_AD5064_1,
> +	ID_AD5628_1,
> +	ID_AD5628_2,
> +	ID_AD5648_1,
> +	ID_AD5648_2,
> +	ID_AD5668_1,
> +	ID_AD5668_2,
>   };
>
>   static ssize_t ad5064_read_powerdown_mode(struct iio_dev *indio_dev,
> @@ -120,34 +139,78 @@ static struct iio_chan_spec_ext_info ad5064_ext_info[] = {
>   	.ext_info = ad5064_ext_info,				\
>   }
>
> +#define DECLARE_AD5064_CHANNELS(name, bits) \
> +const struct iio_chan_spec name[] = { \
> +	AD5064_CHANNEL(0, bits), \
> +	AD5064_CHANNEL(1, bits), \
> +	AD5064_CHANNEL(2, bits), \
> +	AD5064_CHANNEL(3, bits), \
> +	AD5064_CHANNEL(4, bits), \
> +	AD5064_CHANNEL(5, bits), \
> +	AD5064_CHANNEL(6, bits), \
> +	AD5064_CHANNEL(7, bits), \
> +}
> +
Could make this a neater set by breaking out this tidy up first
(then extend it to 8 channels).   Pretty straight forward though
so doesn't really matter.
> +static DECLARE_AD5064_CHANNELS(ad5024_channels, 12);
> +static DECLARE_AD5064_CHANNELS(ad5044_channels, 14);
> +static DECLARE_AD5064_CHANNELS(ad5064_channels, 16);
> +
>   static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>   	[ID_AD5024] = {
>   		.shared_vref = false,
> -		.channel[0] = AD5064_CHANNEL(0, 12),
> -		.channel[1] = AD5064_CHANNEL(1, 12),
> -		.channel[2] = AD5064_CHANNEL(2, 12),
> -		.channel[3] = AD5064_CHANNEL(3, 12),
> +		.channels = ad5024_channels,
> +		.num_channels = 4,
>   	},
>   	[ID_AD5044] = {
>   		.shared_vref = false,
> -		.channel[0] = AD5064_CHANNEL(0, 14),
> -		.channel[1] = AD5064_CHANNEL(1, 14),
> -		.channel[2] = AD5064_CHANNEL(2, 14),
> -		.channel[3] = AD5064_CHANNEL(3, 14),
> +		.channels = ad5044_channels,
> +		.num_channels = 4,
>   	},
>   	[ID_AD5064] = {
>   		.shared_vref = false,
> -		.channel[0] = AD5064_CHANNEL(0, 16),
> -		.channel[1] = AD5064_CHANNEL(1, 16),
> -		.channel[2] = AD5064_CHANNEL(2, 16),
> -		.channel[3] = AD5064_CHANNEL(3, 16),
> +		.channels = ad5064_channels,
> +		.num_channels = 4,
>   	},
>   	[ID_AD5064_1] = {
>   		.shared_vref = true,
> -		.channel[0] = AD5064_CHANNEL(0, 16),
> -		.channel[1] = AD5064_CHANNEL(1, 16),
> -		.channel[2] = AD5064_CHANNEL(2, 16),
> -		.channel[3] = AD5064_CHANNEL(3, 16),
> +		.channels = ad5064_channels,
> +		.num_channels = 4,
> +	},
> +	[ID_AD5628_1] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5024_channels,
> +		.num_channels = 8,
> +	},
> +	[ID_AD5628_2] = {
> +		.shared_vref = true,
> +		.internal_vref = 5000000,
> +		.channels = ad5024_channels,
> +		.num_channels = 8,
> +	},
> +	[ID_AD5648_1] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5044_channels,
> +		.num_channels = 8,
> +	},
> +	[ID_AD5648_2] = {
> +		.shared_vref = true,
> +		.internal_vref = 5000000,
> +		.channels = ad5044_channels,
> +		.num_channels = 8,
> +	},
> +	[ID_AD5668_1] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5064_channels,
> +		.num_channels = 8,
> +	},
> +	[ID_AD5668_2] = {
> +		.shared_vref = true,
> +		.internal_vref = 5000000,
> +		.channels = ad5064_channels,
> +		.num_channels = 8,
>   	},
>   };
>
> @@ -259,6 +322,18 @@ static const struct attribute_group ad5064_attribute_group = {
>   	.attrs = ad5064_attributes,
>   };
>
> +static int ad5064_get_vref(struct ad5064_state *st,
> +	struct iio_chan_spec const *chan)
> +{
> +	unsigned int i;
> +
> +	if (st->use_internal_vref)
> +		return st->chip_info->internal_vref;
> +
> +	i = st->chip_info->shared_vref ? 0 : chan->channel;
> +	return regulator_get_voltage(st->vref_reg[i].consumer);
> +}
> +
>   static int ad5064_read_raw(struct iio_dev *indio_dev,
>   			   struct iio_chan_spec const *chan,
>   			   int *val,
> @@ -266,7 +341,6 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
>   			   long m)
>   {
>   	struct ad5064_state *st = iio_priv(indio_dev);
> -	unsigned int vref;
>   	int scale_uv;
>
>   	switch (m) {
> @@ -274,8 +348,7 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
>   		*val = st->dac_cache[chan->channel];
>   		return IIO_VAL_INT;
>   	case IIO_CHAN_INFO_SCALE:
> -		vref = st->chip_info->shared_vref ? 0 : chan->channel;
> -		scale_uv = regulator_get_voltage(st->vref_reg[vref].consumer);
> +		scale_uv = ad5064_get_vref(st, chan);
>   		if (scale_uv<  0)
>   			return scale_uv;
>
> @@ -323,7 +396,7 @@ static const struct iio_info ad5064_info = {
>
>   static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
>   {
> -	return st->chip_info->shared_vref ? 1 : AD5064_DAC_CHANNELS;
> +	return st->chip_info->shared_vref ? 1 : st->chip_info->num_channels;
>   }
>
>   static const char * const ad5064_vref_names[] = {
> @@ -362,14 +435,24 @@ static int __devinit ad5064_probe(struct spi_device *spi)
>
>   	ret = regulator_bulk_get(&st->spi->dev, ad5064_num_vref(st),
>   		st->vref_reg);
> -	if (ret)
> -		goto error_free;
> -
> -	ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
> -	if (ret)
> -		goto error_free_reg;
> +	if (ret) {
> +		if (!st->chip_info->internal_vref)
> +			goto error_free;
> +		st->use_internal_vref = true;
> +		ret = ad5064_spi_write(st, AD5064_CMD_CONFIG, 0,
> +			AD5064_CONFIG_INT_VREF_ENABLE, 0);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable internal vref: %d\n",
> +				ret);
> +			goto error_free;
> +		}
> +	} else {
> +		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
> +		if (ret)
> +			goto error_free_reg;
> +	}
>
> -	for (i = 0; i<  AD5064_DAC_CHANNELS; ++i) {
> +	for (i = 0; i<  st->chip_info->num_channels; ++i) {
>   		st->pwr_down_mode[i] = AD5064_LDAC_PWRDN_1K;
>   		st->dac_cache[i] = 0x8000;
>   	}
> @@ -378,8 +461,8 @@ static int __devinit ad5064_probe(struct spi_device *spi)
>   	indio_dev->name = spi_get_device_id(spi)->name;
>   	indio_dev->info =&ad5064_info;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channel;
> -	indio_dev->num_channels = AD5064_DAC_CHANNELS;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = st->chip_info->num_channels;
>
>   	ret = iio_device_register(indio_dev);
>   	if (ret)
> @@ -388,9 +471,11 @@ static int __devinit ad5064_probe(struct spi_device *spi)
>   	return 0;
>
>   error_disable_reg:
> -	regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
> +	if (!st->use_internal_vref)
> +		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
>   error_free_reg:
> -	regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
> +	if (!st->use_internal_vref)
> +		regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
>   error_free:
>   	iio_free_device(indio_dev);
>
> @@ -405,8 +490,10 @@ static int __devexit ad5064_remove(struct spi_device *spi)
>
>   	iio_device_unregister(indio_dev);
>
> -	regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
> -	regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
> +	if (!st->use_internal_vref) {
> +		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
> +		regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
> +	}
>
>   	iio_free_device(indio_dev);
>
> @@ -418,6 +505,13 @@ static const struct spi_device_id ad5064_id[] = {
>   	{"ad5044", ID_AD5044},
>   	{"ad5064", ID_AD5064},
>   	{"ad5064-1", ID_AD5064_1},
> +	{"ad5628-1", ID_AD5628_1},
> +	{"ad5628-2", ID_AD5628_2},
> +	{"ad5648-1", ID_AD5648_1},
> +	{"ad5648-2", ID_AD5648_2},
> +	{"ad5668-1", ID_AD5668_1},
> +	{"ad5668-2", ID_AD5668_2},
> +	{"ad5668-3", ID_AD5668_2}, /* similar enough to ad5668-2 */
>   	{}
>   };
>   MODULE_DEVICE_TABLE(spi, ad5064_id);
> @@ -434,5 +528,5 @@ static struct spi_driver ad5064_driver = {
>   module_spi_driver(ad5064_driver);
>
>   MODULE_AUTHOR("Lars-Peter Clausen<lars@metafoo.de>");
> -MODULE_DESCRIPTION("Analog Devices AD5064/64-1/44/24 DAC");
> +MODULE_DESCRIPTION("Analog Devices AD5064/64-1/44/24, AD5628/48/68 DAC");
>   MODULE_LICENSE("GPL v2");

