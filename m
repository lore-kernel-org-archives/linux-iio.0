Return-Path: <jic23@kernel.org>
Message-ID: <4FB14701.8020608@kernel.org>
Date: Mon, 14 May 2012 18:55:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [RFC 3/8] staging:iio:dac:ad5446: Use iio_enum for powerdown
 modes
References: <1336751635-7934-1-git-send-email-lars@metafoo.de> <1336751635-7934-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1336751635-7934-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/11/2012 04:53 PM, Lars-Peter Clausen wrote:
> This allows us to remove some boilerplate code for comparing and formatting the
> enum strings.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5446.c |   53 ++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 3e53d0c..f769b74 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -41,47 +41,34 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
>  }
>  
>  static const char * const ad5446_powerdown_modes[] = {
> -	"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"
> +	"1kohm_to_gnd", "100kohm_to_gnd", "three_state"
>  };
>  
> -static ssize_t ad5446_read_powerdown_mode_available(struct iio_dev *indio_dev,
> -	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> -{
> -	return sprintf(buf, "%s %s %s\n", ad5446_powerdown_modes[1],
> -		ad5446_powerdown_modes[2], ad5446_powerdown_modes[3]);
> -}
> -
> -static ssize_t ad5446_write_powerdown_mode(struct iio_dev *indio_dev,
> -					    uintptr_t private,
> -					    const struct iio_chan_spec *chan,
> -					    const char *buf, size_t len)
> +static int ad5446_set_powerdown_mode(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, unsigned int mode)
>  {
>  	struct ad5446_state *st = iio_priv(indio_dev);
> -	int i;
> -
> -	for (i = 1; i < ARRAY_SIZE(ad5446_powerdown_modes); i++) {
> -		if (sysfs_streq(buf, ad5446_powerdown_modes[i])) {
> -			st->pwr_down_mode = i;
> -			break;
> -		}
> -	}
>  
> -	if (i == ARRAY_SIZE(ad5446_powerdown_modes))
> -		return -EINVAL;
> +	st->pwr_down_mode = mode + 1;
>  
> -	return len;
> +	return 0;
>  }
>  
> -static ssize_t ad5446_read_powerdown_mode(struct iio_dev *indio_dev,
> -					   uintptr_t private,
> -					   const struct iio_chan_spec *chan,
> -					   char *buf)
> +static int ad5446_get_powerdown_mode(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan)
>  {
>  	struct ad5446_state *st = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%s\n", ad5446_powerdown_modes[st->pwr_down_mode]);
> +	return st->pwr_down_mode - 1;
>  }
>  
> +static const struct iio_enum ad5446_powerdown_mode_enum = {
> +	.items = ad5446_powerdown_modes,
> +	.num_items = ARRAY_SIZE(ad5446_powerdown_modes),
> +	.get = ad5446_get_powerdown_mode,
> +	.set = ad5446_set_powerdown_mode,
> +};
> +
>  static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
>  					   uintptr_t private,
>  					   const struct iio_chan_spec *chan,
> @@ -128,15 +115,9 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info_powerdown[] = {
>  		.name = "powerdown",
>  		.read = ad5446_read_dac_powerdown,
>  		.write = ad5446_write_dac_powerdown,
> -	}, {
> -		.name = "powerdown_mode",
> -		.read = ad5446_read_powerdown_mode,
> -		.write = ad5446_write_powerdown_mode,
> -	}, {
> -		.name = "powerdown_mode_available",
> -		.shared = true,
> -		.read = ad5446_read_powerdown_mode_available,
>  	},
> +	IIO_ENUM("powerdown_mode", false, &ad5446_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5446_powerdown_mode_enum),
>  	{ },
>  };
>  
