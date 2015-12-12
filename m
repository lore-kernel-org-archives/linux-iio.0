Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56932 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbbLLROl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 12:14:41 -0500
Subject: Re: [PATCH 3/3] iio: ina2xx: add support for CHAN_INFO_SCALE
To: Marc Titinger <mtitinger@baylibre.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1449852557-3138-1-git-send-email-mtitinger@baylibre.com>
 <1449852557-3138-3-git-send-email-mtitinger@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566C5600.7070306@kernel.org>
Date: Sat, 12 Dec 2015 17:14:40 +0000
MIME-Version: 1.0
In-Reply-To: <1449852557-3138-3-git-send-email-mtitinger@baylibre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/15 16:49, Marc Titinger wrote:
> Provide client apps with the scales to apply to the register values
> read from the software buffer.
> 
> Follow the ABI documentation so that values are in milli-unit after scales
> are applied.
Umm. The below looks like it is doing rather more than this..

There is an endian switch!   I'm going to assume that is correct
for now and merge it into the original patch (rather than as a follow
up).  If this is wrong and should not be here shout quickly and loudly!

Will take the rest of this patch as is though I would much have
prefered that this one was rolled into the original driver as
I hadn't taken that when you sent this change...

Actually never mind I'll smash it into the original driver as git
seems to be happy to handle that bit of reordering and I haven't
pushed out yet.

So applied as a fixup to the original driver patch.
Hmm. a few mor bits came up build testing this - such as lack of static on the
the buffer enable / disable functions.

Please check nothing went wrong in my making various minor changes.
I've done basic build tests but obviously that doesn't catch everything!

Jonathan

> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> ---
>  drivers/iio/adc/ina2xx-adc.c | 85 +++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 99afa6e..98939ba 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -82,6 +82,11 @@ static bool ina2xx_is_volatile_reg(struct device *dev, unsigned int reg)
>  	return (reg != INA2XX_CONFIG);
>  }
>  
> +static inline bool is_signed_reg(unsigned int reg)
> +{
> +	return (reg == INA2XX_SHUNT_VOLTAGE) || (reg == INA2XX_CURRENT);
> +}
> +
>  static const struct regmap_config ina2xx_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 16,
> @@ -133,43 +138,6 @@ static const struct ina2xx_config ina2xx_config[] = {
>  		    },
>  };
>  
> -static int ina2xx_get_value(struct ina2xx_chip_info *chip, u8 reg,
> -			    unsigned int regval, int *val, int *uval)
> -{
> -	*val = 0;
> -
> -	switch (reg) {
> -	case INA2XX_SHUNT_VOLTAGE:
> -		/* signed register */
> -		*uval = DIV_ROUND_CLOSEST((s16) regval,
> -					  chip->config->shunt_div);
> -		return IIO_VAL_INT_PLUS_MICRO;
> -
> -	case INA2XX_BUS_VOLTAGE:
> -		*uval = (regval >> chip->config->bus_voltage_shift)
> -			* chip->config->bus_voltage_lsb;
> -		*val = *uval / 1000000;
> -		*uval = *uval % 1000000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> -
> -	case INA2XX_POWER:
> -		*uval = regval * chip->config->power_lsb;
> -		*val = *uval / 1000000;
> -		*uval = *uval % 1000000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> -
> -	case INA2XX_CURRENT:
> -		/* signed register, LSB=1mA (selected), in mA */
> -		*uval = (s16) regval * 1000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> -
> -	default:
> -		/* programmer goofed */
> -		WARN_ON_ONCE(1);
> -	}
> -	return -EINVAL;
> -}
> -
>  static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -184,7 +152,12 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		return ina2xx_get_value(chip, chan->address, regval, val, val2);
> +		if (is_signed_reg(chan->address))
> +			*val = (s16) regval;
> +		else
> +			*val  = regval;
> +
> +		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = chip->avg;
> @@ -208,11 +181,34 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  
> -	default:
> -		return -EINVAL;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->address) {
> +		case INA2XX_SHUNT_VOLTAGE:
> +			/* processed (mV) = raw*1000/shunt_div */
> +			*val2 = chip->config->shunt_div;
> +			*val = 1000;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case INA2XX_BUS_VOLTAGE:
> +			/* processed (mV) = raw*lsb (uV) / (1000 << shift) */
> +			*val = chip->config->bus_voltage_lsb;
> +			*val2 = 1000 << chip->config->bus_voltage_shift;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case INA2XX_POWER:
> +			/* processed (mW) = raw*lsb (uW) / 1000 */
> +			*val = chip->config->power_lsb;
> +			*val2 = 1000;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case INA2XX_CURRENT:
> +			/* processed (mA) = raw (mA) */
> +			*val = 1;
> +			return IIO_VAL_INT;
> +		}
>  	}
>  
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  /*
> @@ -395,7 +391,7 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>  	.address = (_address), \
>  	.indexed = 1, \
>  	.channel = (_index), \
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)|BIT(IIO_CHAN_INFO_SCALE), \
Spacing wrong about the |
>  	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
>  				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>  	.scan_index = (_index), \
> @@ -403,7 +399,7 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>  		.sign = 'u', \
>  		.realbits = 16, \
>  		.storagebits = 16, \
> -		.endianness = IIO_BE, \
> +		.endianness = IIO_LE, \
>  	} \
>  }
>  
> @@ -417,13 +413,14 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>  	.indexed = 1, \
>  	.channel = (_index), \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_SCALE) | \
>  			      BIT(IIO_CHAN_INFO_INT_TIME), \
>  	.scan_index = (_index), \
>  	.scan_type = { \
>  		.sign = 'u', \
>  		.realbits = 16, \
>  		.storagebits = 16, \
> -		.endianness = IIO_BE, \
> +		.endianness = IIO_LE, \
>  	} \
>  }
>  
> 

