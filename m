Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35849 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965364AbcKLQ2l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 11:28:41 -0500
Subject: Re: [PATCH v3 04/28] staging: iio: tsl2583: remove unnecessary chip
 status check in taos_get_lux
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-5-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fdb20c70-5516-f8be-e216-3a10b67a78d9@kernel.org>
Date: Sat, 12 Nov 2016 16:28:39 +0000
MIME-Version: 1.0
In-Reply-To: <1478769964-7065-5-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/16 09:25, Brian Masney wrote:
> taos_get_lux checks to see if the chip is in a working state. This
> check is not necessary since it is only called from tsl2583_read_raw
> and in_illuminance_calibrate_store (via taos_als_calibrate). The chip
> state is already checked by these functions.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Looks good. Will pick up once patch 3 is sorted.
> ---
>  drivers/staging/iio/light/tsl2583.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index eb59ea0..170b8e9 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -178,13 +178,6 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  	u32 ch0lux = 0;
>  	u32 ch1lux = 0;
>  
> -	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> -		/* device is not enabled */
> -		dev_err(&chip->client->dev, "taos_get_lux device is not enabled\n");
> -		ret = -EBUSY;
> -		goto done;
> -	}
> -
>  	ret = i2c_smbus_read_byte_data(chip->client, TSL258X_CMD_REG);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev, "taos_get_lux failed to read CMD_REG\n");
> 

