Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeDUQZI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:25:08 -0400
Date: Sat, 21 Apr 2018 17:25:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 06/13] staging: iio: tsl2x7x: simplify
 tsl2x7x_write_interrupt_config return
Message-ID: <20180421172502.26428794@archlinux>
In-Reply-To: <20180421004153.19073-7-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-7-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:46 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_write_interrupt_config() has an unnecessary return value check
> at the end of the function. This patch changes the function to just
> return the value from the call to tsl2x7x_invoke_change().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Nice little cleanup.

Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 8d8af0cf9768..d202bc7e1f4f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -982,18 +982,13 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
>  					  int val)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret;
>  
>  	if (chan->type == IIO_INTENSITY)
>  		chip->settings.als_interrupt_en = val ? true : false;
>  	else
>  		chip->settings.prox_interrupt_en = val ? true : false;
>  
> -	ret = tsl2x7x_invoke_change(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
>  static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,

