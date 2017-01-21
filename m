Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34547 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbdAUMcT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 07:32:19 -0500
Subject: Re: [PATCH] iio: pressure: ms5611: claim direct mode during
 oversampling changes
To: Alison Schofield <amsfield22@gmail.com>
References: <20170120202242.GA2153@d830.WORKGROUP>
Cc: tduszyns@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7afaeb60-2bf5-533b-9af2-7ef9c967bfbd@kernel.org>
Date: Sat, 21 Jan 2017 12:32:14 +0000
MIME-Version: 1.0
In-Reply-To: <20170120202242.GA2153@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/01/17 20:22, Alison Schofield wrote:
> Driver was checking for direct mode before changing oversampling
> ratios, but was not locking it.  Use the claim/release helper
> functions to guarantee the device stays in direct mode while the
> oversampling ratios are being updated.  Continue to use the drivers
> private state lock to protect against conflicting direct mode access
> of the state data.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
I think this one is straight forward enough that I'm happy to take it
without confirmation from Thomaz.  

Anyone feel free to shout if I am missing something.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/ms5611_core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 6bd53e7..2a77a2f 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -308,6 +308,7 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  	const struct ms5611_osr *osr = NULL;
> +	int ret;
>  
>  	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
>  		return -EINVAL;
> @@ -321,12 +322,11 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
>  	if (!osr)
>  		return -EINVAL;
>  
> -	mutex_lock(&st->lock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
>  
> -	if (iio_buffer_enabled(indio_dev)) {
> -		mutex_unlock(&st->lock);
> -		return -EBUSY;
> -	}
> +	mutex_lock(&st->lock);
>  
>  	if (chan->type == IIO_TEMP)
>  		st->temp_osr = osr;
> @@ -334,6 +334,8 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
>  		st->pressure_osr = osr;
>  
>  	mutex_unlock(&st->lock);
> +	iio_device_release_direct_mode(indio_dev);
> +
>  	return 0;
>  }
>  
> 

