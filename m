Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44582 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbcBIVEP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 16:04:15 -0500
Subject: Re: [PATCH 5/5] iio:ad5064: Add
 AD5625/AD5627/AD5645/AD5647/AD4665/AD5657 support
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1454950910-26049-1-git-send-email-lars@metafoo.de>
 <1454950910-26049-5-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Andre <marc.andre@netline.ch>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BA544D.8010800@kernel.org>
Date: Tue, 9 Feb 2016 21:04:13 +0000
MIME-Version: 1.0
In-Reply-To: <1454950910-26049-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/16 17:01, Lars-Peter Clausen wrote:
> The AD5625/AD5645/AD5665 are a family of 4 channel DACs with 12-bit, 14-bit
> and 16-bit precision respectively. The devices come in 3 flavors in terms
> of built-in reference, either no built-in reference, built-in 1.25V
> reference or built-in 2.5V reference.
> 
> The AD5627/AD5647/AD5667 are similar to the AD5625/AD5645/AD5665 except
> that they have 2 instead of 4 channels.
> 
> While these new devices are mostly register map compatible with the
> existing devices support by the driver some offsets and register addresses
> have been shuffled around. To accommodate this introduce a new register map
> layout. For the lack of a better name we will just call it version 2.
> 
> Datasheets:
> 	http://www.analog.com/media/en/technical-documentation/data-sheets/AD5625R_5645R_5665R_5625_5665.pdf
> 	http://www.analog.com/media/en/technical-documentation/data-sheets/AD5627R_5647R_5667R_5627_5667.pdf
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Hmm. And just to follow up on missing the earlier patches, I think I applied
this one and didn't actually let you know.

Anyhow, was applied yesterday to the togreg branch of iio.git etc etc.

Jonathan
> ---
>  drivers/iio/dac/Kconfig  |   7 +-
>  drivers/iio/dac/ad5064.c | 192 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 188 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index a56b52d..3c809e2 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -10,9 +10,10 @@ config AD5064
>  	depends on (SPI_MASTER && I2C!=m) || I2C
>  	help
>  	  Say yes here to build support for Analog Devices AD5024, AD5025, AD5044,
> -	  AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5629R, AD5648, AD5666, AD5668,
> -	  AD5669R, LTC2606, LTC2607, LTC2609, LTC2616, LTC2617, LTC2619, LTC2626,
> -	  LTC2627, LTC2629 Digital to Analog Converter.
> +	  AD5045, AD5064, AD5064-1, AD5065, AD5625, AD5625R, AD5627, AD5627R,
> +	  AD5628, AD5629R, AD5645R, AD5647R, AD5648, AD5665, AD5665R, AD5666,
> +	  AD5667, AD5667R, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
> +	  LTC2617, LTC2619, LTC2626, LTC2627, LTC2629 Digital to Analog Converter.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5064.
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index b7f717c..6803e4a 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -1,6 +1,7 @@
>  /*
> - * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5629R,
> - * AD5648, AD5666, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
> + * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5625, AD5625R,
> + * AD5627, AD5627R, AD5628, AD5629R, AD5645R, AD5647R, AD5648, AD5665, AD5665R,
> + * AD5666, AD5667, AD5667R, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
>   * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629 Digital to analog converters
>   * driver
>   *
> @@ -41,6 +42,9 @@
>  #define AD5064_CMD_RESET			0x7
>  #define AD5064_CMD_CONFIG			0x8
>  
> +#define AD5064_CMD_RESET_V2			0x5
> +#define AD5064_CMD_CONFIG_V2			0x7
> +
>  #define AD5064_CONFIG_DAISY_CHAIN_ENABLE	BIT(1)
>  #define AD5064_CONFIG_INT_VREF_ENABLE		BIT(0)
>  
> @@ -51,11 +55,13 @@
>  
>  /**
>   * enum ad5064_regmap_type - Register layout variant
> - * @AD5064_REGMAP_ADI: Analog Devices register map layout
> + * @AD5064_REGMAP_ADI: Old Analog Devices register map layout
> + * @AD5064_REGMAP_ADI2: New Analog Devices register map layout
>   * @AD5064_REGMAP_LTC: LTC register map layout
>   */
>  enum ad5064_regmap_type {
>  	AD5064_REGMAP_ADI,
> +	AD5064_REGMAP_ADI2,
>  	AD5064_REGMAP_LTC,
>  };
>  
> @@ -125,14 +131,30 @@ enum ad5064_type {
>  	ID_AD5064,
>  	ID_AD5064_1,
>  	ID_AD5065,
> +	ID_AD5625,
> +	ID_AD5625R_1V25,
> +	ID_AD5625R_2V5,
> +	ID_AD5627,
> +	ID_AD5627R_1V25,
> +	ID_AD5627R_2V5,
>  	ID_AD5628_1,
>  	ID_AD5628_2,
>  	ID_AD5629_1,
>  	ID_AD5629_2,
> +	ID_AD5645R_1V25,
> +	ID_AD5645R_2V5,
> +	ID_AD5647R_1V25,
> +	ID_AD5647R_2V5,
>  	ID_AD5648_1,
>  	ID_AD5648_2,
> +	ID_AD5665,
> +	ID_AD5665R_1V25,
> +	ID_AD5665R_2V5,
>  	ID_AD5666_1,
>  	ID_AD5666_2,
> +	ID_AD5667,
> +	ID_AD5667R_1V25,
> +	ID_AD5667R_2V5,
>  	ID_AD5668_1,
>  	ID_AD5668_2,
>  	ID_AD5669_1,
> @@ -160,17 +182,23 @@ static int ad5064_sync_powerdown_mode(struct ad5064_state *st,
>  	const struct iio_chan_spec *chan)
>  {
>  	unsigned int val, address;
> +	unsigned int shift;
>  	int ret;
>  
>  	if (st->chip_info->regmap_type == AD5064_REGMAP_LTC) {
>  		val = 0;
>  		address = chan->address;
>  	} else {
> -		address = 0;
> +		if (st->chip_info->regmap_type == AD5064_REGMAP_ADI2)
> +			shift = 4;
> +		else
> +			shift = 8;
> +
>  		val = (0x1 << chan->address);
> +		address = 0;
>  
>  		if (st->pwr_down[chan->channel])
> -			val |= st->pwr_down_mode[chan->channel] << 8;
> +			val |= st->pwr_down_mode[chan->channel] << shift;
>  	}
>  
>  	ret = ad5064_write(st, AD5064_CMD_POWERDOWN_DAC, address, val, 0);
> @@ -391,6 +419,7 @@ static DECLARE_AD5065_CHANNELS(ad5045_channels, 14, 6, ad5064_ext_info);
>  static DECLARE_AD5065_CHANNELS(ad5065_channels, 16, 4, ad5064_ext_info);
>  
>  static DECLARE_AD5064_CHANNELS(ad5629_channels, 12, 4, ad5064_ext_info);
> +static DECLARE_AD5064_CHANNELS(ad5645_channels, 14, 2, ad5064_ext_info);
>  static DECLARE_AD5064_CHANNELS(ad5669_channels, 16, 0, ad5064_ext_info);
>  
>  static DECLARE_AD5064_CHANNELS(ltc2607_channels, 16, 0, ltc2617_ext_info);
> @@ -440,6 +469,46 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  		.num_channels = 2,
>  		.regmap_type = AD5064_REGMAP_ADI,
>  	},
> +	[ID_AD5625] = {
> +		.shared_vref = true,
> +		.channels = ad5629_channels,
> +		.num_channels = 4,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5625R_1V25] = {
> +		.shared_vref = true,
> +		.internal_vref = 1250000,
> +		.channels = ad5629_channels,
> +		.num_channels = 4,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5625R_2V5] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5629_channels,
> +		.num_channels = 4,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5627] = {
> +		.shared_vref = true,
> +		.channels = ad5629_channels,
> +		.num_channels = 2,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5627R_1V25] = {
> +		.shared_vref = true,
> +		.internal_vref = 1250000,
> +		.channels = ad5629_channels,
> +		.num_channels = 2,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5627R_2V5] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5629_channels,
> +		.num_channels = 2,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
>  	[ID_AD5628_1] = {
>  		.shared_vref = true,
>  		.internal_vref = 2500000,
> @@ -468,6 +537,34 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  		.num_channels = 8,
>  		.regmap_type = AD5064_REGMAP_ADI,
>  	},
> +	[ID_AD5645R_1V25] = {
> +		.shared_vref = true,
> +		.internal_vref = 1250000,
> +		.channels = ad5645_channels,
> +		.num_channels = 4,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5645R_2V5] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5645_channels,
> +		.num_channels = 4,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5647R_1V25] = {
> +		.shared_vref = true,
> +		.internal_vref = 1250000,
> +		.channels = ad5645_channels,
> +		.num_channels = 2,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5647R_2V5] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5645_channels,
> +		.num_channels = 2,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
>  	[ID_AD5648_1] = {
>  		.shared_vref = true,
>  		.internal_vref = 2500000,
> @@ -482,6 +579,26 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  		.num_channels = 8,
>  		.regmap_type = AD5064_REGMAP_ADI,
>  	},
> +	[ID_AD5665] = {
> +		.shared_vref = true,
> +		.channels = ad5669_channels,
> +		.num_channels = 4,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5665R_1V25] = {
> +		.shared_vref = true,
> +		.internal_vref = 1250000,
> +		.channels = ad5669_channels,
> +		.num_channels = 4,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5665R_2V5] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5669_channels,
> +		.num_channels = 4,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
>  	[ID_AD5666_1] = {
>  		.shared_vref = true,
>  		.internal_vref = 2500000,
> @@ -496,6 +613,26 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>  		.num_channels = 4,
>  		.regmap_type = AD5064_REGMAP_ADI,
>  	},
> +	[ID_AD5667] = {
> +		.shared_vref = true,
> +		.channels = ad5669_channels,
> +		.num_channels = 2,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5667R_1V25] = {
> +		.shared_vref = true,
> +		.internal_vref = 1250000,
> +		.channels = ad5669_channels,
> +		.num_channels = 2,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
> +	[ID_AD5667R_2V5] = {
> +		.shared_vref = true,
> +		.internal_vref = 2500000,
> +		.channels = ad5669_channels,
> +		.num_channels = 2,
> +		.regmap_type = AD5064_REGMAP_ADI2
> +	},
>  	[ID_AD5668_1] = {
>  		.shared_vref = true,
>  		.internal_vref = 2500000,
> @@ -607,6 +744,22 @@ static const char * const ad5064_vref_name(struct ad5064_state *st,
>  	return st->chip_info->shared_vref ? "vref" : ad5064_vref_names[vref];
>  }
>  
> +static int ad5064_set_config(struct ad5064_state *st, unsigned int val)
> +{
> +	unsigned int cmd;
> +
> +	switch (st->chip_info->regmap_type) {
> +	case AD5064_REGMAP_ADI2:
> +		cmd = AD5064_CMD_CONFIG_V2;
> +		break;
> +	default:
> +		cmd = AD5064_CMD_CONFIG;
> +		break;
> +	}
> +
> +	return ad5064_write(st, cmd, 0, val, 0);
> +}
> +
>  static int ad5064_probe(struct device *dev, enum ad5064_type type,
>  			const char *name, ad5064_write_func write)
>  {
> @@ -636,8 +789,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
>  		if (!st->chip_info->internal_vref)
>  			return ret;
>  		st->use_internal_vref = true;
> -		ret = ad5064_write(st, AD5064_CMD_CONFIG, 0,
> -			AD5064_CONFIG_INT_VREF_ENABLE, 0);
> +		ret = ad5064_set_config(st, AD5064_CONFIG_INT_VREF_ENABLE);
>  		if (ret) {
>  			dev_err(dev, "Failed to enable internal vref: %d\n",
>  				ret);
> @@ -766,9 +918,19 @@ static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
>  	unsigned int addr, unsigned int val)
>  {
>  	struct i2c_client *i2c = to_i2c_client(st->dev);
> +	unsigned int cmd_shift;
>  	int ret;
>  
> -	st->data.i2c[0] = (cmd << 4) | addr;
> +	switch (st->chip_info->regmap_type) {
> +	case AD5064_REGMAP_ADI2:
> +		cmd_shift = 3;
> +		break;
> +	default:
> +		cmd_shift = 4;
> +		break;
> +	}
> +
> +	st->data.i2c[0] = (cmd << cmd_shift) | addr;
>  	put_unaligned_be16(val, &st->data.i2c[1]);
>  
>  	ret = i2c_master_send(i2c, st->data.i2c, 3);
> @@ -791,9 +953,23 @@ static int ad5064_i2c_remove(struct i2c_client *i2c)
>  }
>  
>  static const struct i2c_device_id ad5064_i2c_ids[] = {
> +	{"ad5625", ID_AD5625 },
> +	{"ad5625r-1v25", ID_AD5625R_1V25 },
> +	{"ad5625r-2v5", ID_AD5625R_2V5 },
> +	{"ad5627", ID_AD5627 },
> +	{"ad5627r-1v25", ID_AD5627R_1V25 },
> +	{"ad5627r-2v5", ID_AD5627R_2V5 },
>  	{"ad5629-1", ID_AD5629_1},
>  	{"ad5629-2", ID_AD5629_2},
>  	{"ad5629-3", ID_AD5629_2}, /* similar enough to ad5629-2 */
> +	{"ad5645r-1v25", ID_AD5645R_1V25 },
> +	{"ad5645r-2v5", ID_AD5645R_2V5 },
> +	{"ad5665", ID_AD5665 },
> +	{"ad5665r-1v25", ID_AD5665R_1V25 },
> +	{"ad5665r-2v5", ID_AD5665R_2V5 },
> +	{"ad5667", ID_AD5667 },
> +	{"ad5667r-1v25", ID_AD5667R_1V25 },
> +	{"ad5667r-2v5", ID_AD5667R_2V5 },
>  	{"ad5669-1", ID_AD5669_1},
>  	{"ad5669-2", ID_AD5669_2},
>  	{"ad5669-3", ID_AD5669_2}, /* similar enough to ad5669-2 */
> 

