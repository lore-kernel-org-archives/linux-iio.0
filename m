Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40285 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932513AbcKMMGh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:06:37 -0500
Subject: Re: [PATCH v4 05/26] staging: iio: tsl2583: remove redundant write to
 the control register in taos_probe()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-6-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bee2edfc-0ecf-19d7-ba74-68609c68e366@kernel.org>
Date: Sun, 13 Nov 2016 12:06:34 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-6-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> taos_probe() calls i2c_smbus_write_byte() to select the control
> register, however there are no subsequent calls to
> i2c_smbus_read_byte(). The write call is unnecessary and is removed by
> this patch.
> 
> Verified that the driver still functions correctly using a TSL2581
> hooked up to a Raspberry Pi 2.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,
> ---
>  drivers/staging/iio/light/tsl2583.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 5a32102..449506b 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -788,14 +788,6 @@ static int taos_probe(struct i2c_client *clientp,
>  		return -EINVAL;
>  	}
>  
> -	ret = i2c_smbus_write_byte(clientp, (TSL258X_CMD_REG | TSL258X_CNTRL));
> -	if (ret < 0) {
> -		dev_err(&clientp->dev,
> -			"i2c_smbus_write_byte() to cmd reg failed in taos_probe(), err = %d\n",
> -			ret);
> -		return ret;
> -	}
> -
>  	indio_dev->info = &tsl2583_info;
>  	indio_dev->channels = tsl2583_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(tsl2583_channels);
> 

