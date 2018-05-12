Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbeELLQ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 07:16:58 -0400
Date: Sat, 12 May 2018 12:16:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v3 3/9] staging: iio: tsl2x7x: turn chip off if IIO
 device registration fails
Message-ID: <20180512121653.06469001@archlinux>
In-Reply-To: <20180511001223.12378-4-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
        <20180511001223.12378-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 May 2018 20:12:17 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch turns the chip off if IIO device registration fails so that
> the error handling mirrors the device remove to make review easier in
> preparation for moving this driver out of staging.
> 
> This patch also adds a missing error check in the call to
> tsl2x7x_chip_on() in tsl2x7x_probe().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index c1e726fc87b7..f5ca5ada0358 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1657,10 +1657,13 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	}
>  
>  	tsl2x7x_defaults(chip);
> -	tsl2x7x_chip_on(indio_dev);
> +	ret = tsl2x7x_chip_on(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
> +		tsl2x7x_chip_off(indio_dev);
>  		dev_err(&clientp->dev,
>  			"%s: iio registration failed\n", __func__);
>  		return ret;

