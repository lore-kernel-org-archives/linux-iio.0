Return-Path: <lars@metafoo.de>
Message-ID: <528A5C83.9020200@metafoo.de>
Date: Mon, 18 Nov 2013 19:29:23 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/11] iio:adc:ad7793: use samp_freq element of info_mask_shared_by_all.
References: <1384701302-26564-1-git-send-email-jic23@kernel.org> <1384701302-26564-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-8-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/17/2013 04:14 PM, Jonathan Cameron wrote:
> This replaces the previous use of a custom attribute to create the same
> interface.  One big advantage is that this allows in kernel access.

Looks mostly good, can probably also be merged without waiting for the reset
of the series

[...]
> @@ -512,6 +457,10 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
>  			*val -= offset;
>  		}
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->chip_info->
> +			sample_freq_avail[AD7793_MODE_RATE(st->mode)];
> +		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
>  }
> @@ -551,6 +500,20 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
>  				break;
>  			}
>  		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val == 0)
> +			return -EINVAL;
> +
> +		ret = -EINVAL;
> +		for (i = 0; i < 16; i++)
> +			if (val == st->chip_info->sample_freq_avail[i]) {
> +				st->mode &= ~AD7793_MODE_RATE(-1);
> +				st->mode |= AD7793_MODE_RATE(i);
> +				ad_sd_write_reg(&st->sd, AD7793_REG_MODE,
> +						sizeof(st->mode), st->mode);
> +				ret = 0;
> +			}

In order to keep the indentation level low I'd put this into it's own function.

> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
[...]
>  #define DECLARE_AD7799_CHANNELS(_name, _b, _sb) \
>  const struct iio_chan_spec _name##_channels[] = { \
>  	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
> -	0, 0, 0), \
> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>  	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0, \
> -	0, 0, 0), \
> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>  	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0, \
> -	0, 0, 0), \
> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>  	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
> -	0, 0, 0), \
> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>  	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
> -	0, 0, 0), \
> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>  	IIO_CHAN_SOFT_TIMESTAMP(5), \
>  }

Do we actually have any channels that won't have the SAMP_FREQ attribute set?
