Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeCXNcM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:32:12 -0400
Date: Sat, 24 Mar 2018 13:32:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 01/11] staging: iio: tsl2x7x: remove unnecessary code
Message-ID: <20180324133206.4ab7c8a0@archlinux>
In-Reply-To: <20180321102912.5130-2-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:02 -0400
Brian Masney <masneyb@onstation.org> wrote:

> As a follow up to the work in commit a0722d05a195 ("staging: iio:
> tsl2x7x: convert mutex_trylock() to mutex_lock()"), this patch removes
> the unnecessary calls to tsl2x7x_get_prox() and tsl2x7x_get_lux() in
> tsl2x7x_event_handler(). Previously, these functions were locked with
> mutex_trylock(), but that is no longer the case. This patch also removes
> a comment that is no longer relevant about returning the last sample.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 82681300e106..82cf9d853b18 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1430,7 +1430,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  
>  	/* What type of interrupt do we need to process */
>  	if (ret & TSL2X7X_STA_PRX_INTR) {
> -		tsl2x7x_get_prox(indio_dev); /* freshen data for ABI */
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
>  						    0,
> @@ -1440,7 +1439,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  	}
>  
>  	if (ret & TSL2X7X_STA_ALS_INTR) {
> -		tsl2x7x_get_lux(indio_dev); /* freshen data for ABI */
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>  						    0,
> @@ -1745,10 +1743,6 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		return ret;
>  	}
>  
> -	/*
> -	 * ALS and PROX functions can be invoked via user space poll
> -	 * or H/W interrupt. If busy return last sample.
> -	 */
>  	mutex_init(&chip->als_mutex);
>  	mutex_init(&chip->prox_mutex);
>  

