Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47013
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935062AbdIZPQj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Sep 2017 11:16:39 -0400
Date: Tue, 26 Sep 2017 17:16:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Aastha Gupta <aastha.gupta4104@gmail.com>
cc: outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: iio: adc: ad7192: Replace
 mlock with driver private lock
In-Reply-To: <1506437917-7219-2-git-send-email-aastha.gupta4104@gmail.com>
Message-ID: <alpine.DEB.2.20.1709261714430.2866@hadrien>
References: <1506437917-7219-1-git-send-email-aastha.gupta4104@gmail.com> <1506437917-7219-2-git-send-email-aastha.gupta4104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Tue, 26 Sep 2017, Aastha Gupta wrote:

> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.

At least from the point of view of someone who doesn't know this code, I
think that the commit message could be clearer.  For example, what is
mlock?  Is a special locking function?  A global variable?  It seems that
actually a field in some structre.  Why is the lock of that structure less
appropriate than the lock of the structure that you have chosen?

julia


>
> Signed-off-by: Aastha Gupta <aastha.gupta4104@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7192.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d11c6de..096d29d 100644
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
> @@ -634,6 +635,8 @@ static int ad7192_probe(struct spi_device *spi)
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1506437917-7219-2-git-send-email-aastha.gupta4104%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
