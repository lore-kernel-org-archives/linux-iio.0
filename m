Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44215 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbK2PWD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 10:22:03 -0500
Subject: Re: [PATCH] Staging: iio: light: tsl2x7x_core: use dev_get_platdata()
To: Nizam Haider <nizamhaider786@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	hamohammed.sa@gmail.com, shivanib134@gmail.com,
	asaf.vertz@tandemg.com, cristina.moraru09@gmail.com
References: <1448300930-10789-1-git-send-email-nizamhaider786@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Nizam Haider <nijamh@cdac.in>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565B1819.9030807@kernel.org>
Date: Sun, 29 Nov 2015 15:22:01 +0000
MIME-Version: 1.0
In-Reply-To: <1448300930-10789-1-git-send-email-nizamhaider786@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/11/15 17:48, Nizam Haider wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>
Applied to the togreg branch of iio.git - initially pushed out as testing.
Note that branch will get rebased shortly to catch up with Greg's staging-next.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index 9dfd048..5b1c165 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -1898,7 +1898,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	mutex_init(&chip->prox_mutex);
>  
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_UNKNOWN;
> -	chip->pdata = clientp->dev.platform_data;
> +	chip->pdata = dev_get_platdata(&clientp->dev);
>  	chip->id = id->driver_data;
>  	chip->chip_info =
>  		&tsl2x7x_chip_info_tbl[device_channel_config[id->driver_data]];
> 

