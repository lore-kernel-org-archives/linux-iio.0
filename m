Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:31687 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754339AbdI0Et4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Sep 2017 00:49:56 -0400
Date: Wed, 27 Sep 2017 06:49:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Aastha Gupta <aastha.gupta4104@gmail.com>
cc: outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3] staging: iio: adc: ad7192: use
 driver private lock to protect hardware changes
In-Reply-To: <1506478672-5937-1-git-send-email-aastha.gupta4104@gmail.com>
Message-ID: <alpine.DEB.2.20.1709270645440.2790@hadrien>
References: <1506478672-5937-1-git-send-email-aastha.gupta4104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Wed, 27 Sep 2017, Aastha Gupta wrote:

> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.

Up to here, this is much easier to understand.  Although I don't think
"devices global data" is correct.  Driver-specific state seems better.

> Also, private driver lock is being used to protect hardware
> state changes as here state variables are being changed.

This I don't understand at all.  If you refer to the same thing twice, you
should use the same terminology.  It seems that "lock in the devices
global state" has become "private driver lock".It is not clear that these
are the same thing.  And in this case you are adding locking where there
was none before.  Why was it not needed before but it is needed now?

julia

> Signed-off-by: Aastha Gupta <aastha.gupta4104@gmail.com>
> ---
> changes in v3:
> 	- combined patch 1 and patch 2 into one patch
>
>  drivers/staging/iio/adc/ad7192.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d11c6de..609a649 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -162,6 +162,7 @@ struct ad7192_state {
>  	u32				scale_avail[8][2];
>  	u8				gpocon;
>  	u8				devid;
> +	struct mutex			lock;
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1506478672-5937-1-git-send-email-aastha.gupta4104%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
