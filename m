Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbeETLJO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 07:09:14 -0400
Date: Sun, 20 May 2018 12:09:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 09/12] staging: iio: ad2s1200: Add scaling factor for
 angular velocity channel
Message-ID: <20180520120909.0c8af494@archlinux>
In-Reply-To: <6d616883c8431021cdfd0eaa551790e41d80a664.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <6d616883c8431021cdfd0eaa551790e41d80a664.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:23:01 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> The sysfs iio ABI states radians per second is expected as the unit for
> angular velocity, but the 12-bit angular velocity register has
> revolution per seconds as its unit. So a scaling factor of approximately
> 2 * Pi is added to the angular velocity channel.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v4:
>  - Changed rps to revolutions per second in commit message
>    to prevent confusion.
> 
>  drivers/staging/iio/resolver/ad2s1200.c | 71 ++++++++++++++++---------
>  1 file changed, 45 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 67d9747f88a6..7b8af558e921 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -55,37 +55,55 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>  	struct ad2s1200_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> -	gpiod_set_value(st->sample, 0);
> -
> -	/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
> -	udelay(1);
> -	gpiod_set_value(st->sample, 1);
> -	gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
> -
> -	ret = spi_read(st->sdev, &st->rx, 2);
> -	if (ret < 0) {
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			/* 2 * Pi ~= 6.283185 */
> +			*val = 6;
> +			*val2 = 283185;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		gpiod_set_value(st->sample, 0);
> +
> +		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
> +		udelay(1);
> +		gpiod_set_value(st->sample, 1);
> +		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
> +
> +		ret = spi_read(st->sdev, &st->rx, 2);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			*val = be16_to_cpup(&st->rx) >> 4;
> +			break;
> +		case IIO_ANGL_VEL:
> +			*val = sign_extend32(be16_to_cpup(&st->rx) >> 4, 11);
> +			break;
> +		default:
> +			mutex_unlock(&st->lock);
> +			return -EINVAL;
> +		}
> +
> +		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
> +		udelay(1);
>  		mutex_unlock(&st->lock);
> -		return ret;
> -	}
>  
> -	switch (chan->type) {
> -	case IIO_ANGL:
> -		*val = be16_to_cpup(&st->rx) >> 4;
> -		break;
> -	case IIO_ANGL_VEL:
> -		*val = sign_extend32(be16_to_cpup(&st->rx) >> 4, 11);
> -		break;
> +		return IIO_VAL_INT;
>  	default:
> -		mutex_unlock(&st->lock);
> -		return -EINVAL;
> +		break;
>  	}
>  
> -	/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
> -	udelay(1);
> -	mutex_unlock(&st->lock);
> -
> -	return IIO_VAL_INT;
> +	return -EINVAL;
>  }
>  
>  static const struct iio_chan_spec ad2s1200_channels[] = {
> @@ -99,6 +117,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
>  		.indexed = 1,
>  		.channel = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  	}
>  };
>  

