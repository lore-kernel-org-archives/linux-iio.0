Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40202 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbcKMLzH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 06:55:07 -0500
Subject: Re: [PATCH v4 02/26] staging: iio: tsl2583: remove unnecessary chip
 status check in taos_get_lux
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-3-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2b3503be-ff2a-437a-6111-1c944d04db5c@kernel.org>
Date: Sun, 13 Nov 2016 11:55:05 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-3-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> taos_get_lux checks to see if the chip is in a working state. This
> check is not necessary since it is only called from tsl2583_read_raw
> and in_illuminance_calibrate_store (via taos_als_calibrate). The chip
> state is already checked by these functions.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index de54e74..a550023 100644
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

