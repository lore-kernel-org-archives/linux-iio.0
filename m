Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeCXNlY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:41:24 -0400
Date: Sat, 24 Mar 2018 13:41:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 08/11] staging: iio: tsl2x7x: remove unused variables
 from tsl2x7x_get_lux()
Message-ID: <20180324134119.43c47d0f@archlinux>
In-Reply-To: <20180321102912.5130-9-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-9-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:09 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_get_lux() has a ch0lux and ch1lux variables that are not used
> so this patch removes them.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Had to argue with this one ;)

Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index c1e441857226..1e38e8449f9e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -344,8 +344,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	struct tsl2x7x_lux *p;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	int i, ret;
> -	u32 ch0lux = 0;
> -	u32 ch1lux = 0;
>  
>  	mutex_lock(&chip->als_mutex);
>  
> @@ -416,15 +414,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  				   tsl2x7x_als_gain[chip->settings.als_gain]);
>  	}
>  
> -	/* note: lux is 31 bit max at this point */
> -	if (ch1lux > ch0lux) {
> -		dev_dbg(&chip->client->dev,
> -			"%s: ch1lux > ch0lux; returning last value\n",
> -			__func__);
> -		ret = chip->als_cur_info.lux;
> -		goto out_unlock;
> -	}
> -
>  	/* adjust for active time scale */
>  	if (chip->als_time_scale == 0)
>  		lux = 0;

