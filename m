Return-Path: <SRS0=tlhc=A4=lip6.fr=julia.lawall@kernel.org>
Date: Wed, 27 Sep 2017 08:55:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Aastha Gupta <aastha.gupta4104@gmail.com>
cc: outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
    jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
    linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v4] staging: iio: adc: ad7192: use
 driver private lock to protect hardware state changes
In-Reply-To: <1506493919-3189-1-git-send-email-aastha.gupta4104@gmail.com>
Message-ID: <alpine.DEB.2.20.1709270854410.3186@hadrien>
References: <1506493919-3189-1-git-send-email-aastha.gupta4104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Wed, 27 Sep 2017, Aastha Gupta wrote:

> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a driver private lock.
>
> Also, as there are state changes in the ad7192_ write_raw function, a lock
> is added to prevent the concurrent state changes.

Why was it not needed before?

julia

>
> Signed-off-by: Aastha Gupta <aastha.gupta4104@gmail.com>
> ---
> changes in v4:
> 	- added comment for mutex
> 	- improved commit message
>  drivers/staging/iio/adc/ad7192.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d11c6de..c1343ec 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -162,6 +162,7 @@ struct ad7192_state {
>  	u32				scale_avail[8][2];
>  	u8				gpocon;
>  	u8				devid;
> +	struct mutex			lock;	/* protect sensor state */
>
>  	struct ad_sigma_delta		sd;
>  };
> @@ -463,10 +464,10 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			mutex_lock(&indio_dev->mlock);
> +			mutex_lock(&st->lock);
>  			*val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
>  			*val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&st->lock);
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_TEMP:
>  			*val = 0;
> @@ -510,6 +511,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = -EINVAL;
> +		mutex_lock(&st->lock);
>  		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
>  			if (val2 == st->scale_avail[i][1]) {
>  				ret = 0;
> @@ -523,6 +525,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  				ad7192_calibrate_all(st);
>  				break;
>  			}
> +		mutex_unlock(&st->lock);
>  		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (!val) {
> @@ -634,6 +637,8 @@ static int ad7192_probe(struct spi_device *spi)
>
>  	st = iio_priv(indio_dev);
>
> +	mutex_init(&st->lock);
> +
>  	st->avdd = devm_regulator_get(&spi->dev, "avdd");
>  	if (IS_ERR(st->avdd))
>  		return PTR_ERR(st->avdd);
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1506493919-3189-1-git-send-email-aastha.gupta4104%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
