Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35303 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdAUOnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:43:39 -0500
Subject: Re: [PATCH v2 09/15] staging: iio: isl29028: remove unnecessary error
 logging in isl29028_chip_init_and_power_on()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-10-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <485ae892-a3d2-cd1a-1974-bc4ea8186c97@kernel.org>
Date: Sat, 21 Jan 2017 14:42:52 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-10-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> If the call to isl29028_chip_init_and_power_on() in isl29028_probe()
> fails, then isl29028_probe() will log an error message. All of the
> error paths in that call path already have error logging in place. This
> patch removes the unnecessary logging.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
applied.
> ---
>  drivers/staging/iio/light/isl29028.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index cffecf9..be1fc4a 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -528,10 +528,8 @@ static int isl29028_probe(struct i2c_client *client,
>  	}
>  
>  	ret = isl29028_chip_init_and_power_on(chip);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "chip initialization failed: %d\n", ret);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	indio_dev->info = &isl29028_info;
>  	indio_dev->channels = isl29028_channels;
> 

