Return-Path: <martink@posteo.de>
Subject: Re: [PATCH v1] drivers:iio:accel:mma8452: added cleanup provision in
 case of failure.
To: Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
 "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net"
 <pmeerw@pmeerw.net>,
 "christoph.muellner@theobroma-systems.com"
 <christoph.muellner@theobroma-systems.com>
References: <KL1PR04MB1205AC29D431BAF1527101F980380@KL1PR04MB1205.apcprd04.prod.outlook.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <e07d6110-9df7-ace2-ebff-dd63886ab16a@posteo.de>
Date: Mon, 4 Jul 2016 14:20:39 +0200
MIME-Version: 1.0
In-Reply-To: <KL1PR04MB1205AC29D431BAF1527101F980380@KL1PR04MB1205.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Am 2016-07-04 um 12:08 schrieb Bijosh Thykkoottathil:
> mma8452_set_freefall_mode can return -ve value in case if
> i2c_smbus_read_byte_data fails. This function is called from mma8452_probe,
> and returning -ve value from probe indicates probe failure. Need to call
> iio_triggered_buffer_cleanup & iio_trigger_cleanup in this case.

Thanks for your review, nice catch! Looks good to me. You just could
have said "Don't leak allocated buffer on error during probe().", but oh
well :)

> 
> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
Reviewed-by: Martin Kepplinger <martink@posteo.de>

> ---
>  drivers/iio/accel/mma8452.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index e225d3c..1bcf5c3 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1444,8 +1444,8 @@ static int mma8452_probe(struct i2c_client *client,
>  		goto buffer_cleanup;
>  
>  	ret = mma8452_set_freefall_mode(data, false);
> -	if (ret)
> -		return ret;
> +	if (ret < 0)
> +		goto buffer_cleanup;
>  
>  	return 0;
>  
> 
