Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698205;
	b=GPLi4HWPttYyefKK7exYyZmNr6ruf91rNd4zXk4Xdpe2siBGTflKutebjCSlDj4o/H5Y
	 1DLgsALJLHOG++cL3aP18slcdXl9qK7AKlmY+J5mled/jWFXM/G1K9bfpQr3jCMJtqXQC
	 ADg2DG6J2cFznau0XHNn3rP0Unjeak0GZgsiR0u+yhYebz4brJPXQqpJRCsJtN8zsVIi4
	 VH8um/jKRSKFayTW1/BU+Lh+wlUI4ZQKgNSJHkS8UGu+8TTWiEcNkFfR2tdiUz9Ej8Iy7
	 quVZfa5IHh8ONooPmeFDK6R+FvQBKkp+IvWyL1L1+MxDMlSgUes3V8Jh8fFswWTddkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698205;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=79ksDii4s7CLZnmejbxE4792h8Xt7p7jEiyY96vDxXo=;
	b=ydejfmwZ8uhWcaX2M4kudE3u4azbmO6zxjIIX8Hzj6Bfb8tL4NvKA6TwsVfsLJdY5iuy
	 Vko9VZU2/RkmczbzWCIf1b0GtjsAlG/aeBWlaHa8YnfpNip72ZtD3Drg8fifs1btZIbK0
	 AfT3BY6YQRjuliIj3QJMVKmB0WyTiG+8T4ghp3f5SF7LgfIw/UGqkmzW1n9UH+PjABu1L
	 c4V9nLqmO4piofHH8ktE9kUy8OXlA4V4TpRJRFw83vxoCN696emI5e+uOCyVM4ukl+UjB
	 r+xk6H8a7xtA6NGCKa01bQH0Sa0nPMLLP3crs9to2Ph2gpxe+hjrk7ThOH5/Mo+rvaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7xQK29i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD79606A323;
	Sat, 14 Nov 2026 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7xQK29i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D816B1F000C4;
	Sat, 14 Nov 2026 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698205;
	bh=79ksDii4s7CLZnmejbxE4792h8Xt7p7jEiyY96vDxXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K7xQK29iea6sAQi0ZvtPSFLJL2a8gQ+0prHqZ3AoohNDBGiVOUjcOwcs7v+uc5NGA
	 3eTwKuVqXHY94JRwOg684WHF+pnDsNT/bvipWlFZHkKucDrBDmECEwm6YmaH/mBXh0
	 oeOGExfhV5Vc+l1RzWgCGYF3teHkjC/fAmr8yyftpAebn9gC4S+CmjRSZGVWiqc2xs
	 5Yjk8aj7r2GId4zlFhbS3Vlrr/xRF5dG0Stk/4m2pPs+MMwYYvzJWfVpV31rGgwPUA
	 ixL4M9gin7EVu2YTKLSVHXuFWEuk1JrgsejhVD7iffuQvSlCLySB4uHtXWMUP5VCEz
	 SXgepGnuv/gRg==
Date: Sat, 14 Nov 2026 23:16:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Raffaele Tranfaglia via B4 Relay
 <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Cc: raffaele.tranfaglia@gmail.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: adux1020: use guard() to simplify lock
 handling
Message-ID: <20261114231638.420e70f4@jic23-hlaptop>
In-Reply-To: <20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com>
References: <20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 08 Nov 2026 20:16:13 +0000
Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org> wrote:

> From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> Use guard(mutex) in adux1020_read_raw(), adux1020_write_raw() and
> adux1020_write_event_config() so the lock is released automatically on
> return. This allows returning directly instead of jumping to a common
> unlock label, and lets adux1020_write_raw() drop its ret variable.
> 
> No functional change intended.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/all/20261107222957.5332237b@jic23-hlaptop/
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Nice change, but in the way of cleanups it reveals some more options
to improve things whilst we are here.

This often happens with cleanup.h changes as simpler early error
paths etc no longer need gotos and so end up being worth doing
when perhaps they were not previously.


> ---
> This follows Jonathan's suggestion, made when applying the sampling
> frequency hardening patch. It applies on top of iio/testing.
> 
> Tested on arm64 QEMU with i2c-stub and lockdep enabled: reading and
> writing the sampling frequency (valid and invalid values), reading the
> LED current, reading in_proximity_raw (error path) and enabling the
> threshold event. No lockdep warnings and no hangs after the error
> paths.
> 
> I prepared this patch with the help of an AI coding assistant, and
> reviewed and tested it myself.
> ---
>  drivers/iio/light/adux1020.c | 104 ++++++++++++++++---------------------------
>  1 file changed, 39 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index d4281b9754c3..3e8f53e5a1a0 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> @@ -362,10 +363,10 @@ static int adux1020_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adux1020_data *data = iio_priv(indio_dev);
>  	u16 buf[3];
> -	int ret = -EINVAL;
> +	int ret;
>  	unsigned int regval;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
Now we have guard and direct returns are an option there are
some nice things we can do.
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -373,69 +374,56 @@ static int adux1020_read_raw(struct iio_dev *indio_dev,
>  		case IIO_PROXIMITY:
Style wise this is curiously different from write_raw().
I'd take a leaf out of that book and make this similar (but not quite - see below)
	switch (mask) {
	case IIO_CHAN_INFO_RAW:
		if (chan->type != IIO_PROXIMITY)
			return -EVIAL;

		ret = adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
		if (ret < 0)
// could switch to simpler if (ret)  but maybe not worth it.
			return ret;
  
		ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
		if (ret < 0)
			return ret;

		*val = buf[0];

		return IIO_VAL_INT;

	case IIO_CHAN_INFO_PROCESSED:
		if (chan->type != IIO_CURRENT(
			return -EINVAL;

...

	default:
		return -EINVAL;
	}
}

>  			ret = adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
>  			if (ret < 0)
> -				goto fail;
> +				return ret;
>  
>  			ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
>  			if (ret < 0)
> -				goto fail;
> +				return ret;
>  
>  			*val = buf[0];
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_CURRENT:
>  			ret = regmap_read(data->regmap,
>  					  ADUX1020_REG_LED_CURRENT, &regval);
>  			if (ret < 0)
> -				goto fail;
> +				return ret;
>  
>  			regval = regval & ADUX1020_LED_CURRENT_MASK;
>  
>  			*val = adux1020_led_currents[regval][0];
>  			*val2 = adux1020_led_currents[regval][1];
>  
> -			ret = IIO_VAL_INT_PLUS_MICRO;
> -			break;
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		switch (chan->type) {
>  		case IIO_PROXIMITY:
>  			ret = regmap_read(data->regmap, ADUX1020_REG_FREQUENCY,
>  					  &regval);
>  			if (ret < 0)
> -				goto fail;
> +				return ret;
>  
>  			regval = FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
> -			if (regval >= ARRAY_SIZE(adux1020_rates)) {
> -				ret = -EINVAL;
> -				goto fail;
> -			}
> +			if (regval >= ARRAY_SIZE(adux1020_rates))
> +				return -EINVAL;
>  
>  			*val = adux1020_rates[regval][0];
>  			*val2 = adux1020_rates[regval][1];
>  
> -			ret = IIO_VAL_INT_PLUS_MICRO;
> -			break;
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	default:
> -		break;
> +		return -EINVAL;
>  	}
> -
> -fail:
> -	mutex_unlock(&data->lock);
> -
> -	return ret;
>  };
>  
>  static inline int adux1020_find_index(const int array[][2], int count, int val,
> @@ -455,9 +443,9 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
>  			      int val, int val2, long mask)
>  {
>  	struct adux1020_data *data = iio_priv(indio_dev);
> -	int i, ret = -EINVAL;
> +	int i;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -465,15 +453,13 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
In here, I'd do similar to above and use an inverted condition to exit
early.

		if (chan->type != IIO_PROXIMITY)
			return -EINVAL;

		i = adux1020_find_index(adux1020_rates,
 					ARRAY_SIZE(adux1020_rates),
  					val, val2);
...

>  			i = adux1020_find_index(adux1020_rates,
>  						ARRAY_SIZE(adux1020_rates),
>  						val, val2);
> -			if (i < 0) {
> -				ret = i;
> -				goto fail;
> -			}
> -
> -			ret = regmap_update_bits(data->regmap,
> -						 ADUX1020_REG_FREQUENCY,
> -						 ADUX1020_PROX_FREQ_MASK,
> -						 ADUX1020_PROX_FREQ(i));
> +			if (i < 0)
> +				return i;
> +
> +			return regmap_update_bits(data->regmap,
> +						  ADUX1020_REG_FREQUENCY,
> +						  ADUX1020_PROX_FREQ_MASK,
> +						  ADUX1020_PROX_FREQ(i));
>  		}
>  		break;
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -481,24 +467,19 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
>  			i = adux1020_find_index(adux1020_led_currents,
>  					ARRAY_SIZE(adux1020_led_currents),
>  					val, val2);
> -			if (i < 0) {
> -				ret = i;
> -				goto fail;
> -			}
> -
> -			ret = regmap_update_bits(data->regmap,
> -						 ADUX1020_REG_LED_CURRENT,
> -						 ADUX1020_LED_CURRENT_MASK, i);
> +			if (i < 0)
> +				return i;
> +
> +			return regmap_update_bits(data->regmap,
> +						  ADUX1020_REG_LED_CURRENT,
> +						  ADUX1020_LED_CURRENT_MASK, i);
>  		}
>  		break;
>  	default:
>  		break;
>  	}
>  
> -fail:
> -	mutex_unlock(&data->lock);
> -
> -	return ret;
> +	return -EINVAL;
>  }

> 

