Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdGQUsE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jul 2017 16:48:04 -0400
Date: Mon, 17 Jul 2017 21:48:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] iio: adc: ad7766: Remove unneeded gpiod NULL check
Message-ID: <20170717214800.15ce31b1@kernel.org>
In-Reply-To: <1500240363-16396-1-git-send-email-festevam@gmail.com>
References: <1500240363-16396-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 16 Jul 2017 18:26:03 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The gpiod API checks for NULL descriptors, so there is no need to
> duplicate the check in the driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ad7766.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 75cca42..ce45037 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -103,8 +103,7 @@ static int ad7766_preenable(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	if (ad7766->pd_gpio)
> -		gpiod_set_value(ad7766->pd_gpio, 0);
> +	gpiod_set_value(ad7766->pd_gpio, 0);
>  
>  	return 0;
>  }
> @@ -113,8 +112,7 @@ static int ad7766_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct ad7766 *ad7766 = iio_priv(indio_dev);
>  
> -	if (ad7766->pd_gpio)
> -		gpiod_set_value(ad7766->pd_gpio, 1);
> +	gpiod_set_value(ad7766->pd_gpio, 1);
>  
>  	/*
>  	 * The PD pin is synchronous to the clock, so give it some time to

