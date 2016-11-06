Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55580 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbcKFLyv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 06:54:51 -0500
Subject: Re: [PATCH 6/9] staging: iio: tsl2583: remove redudant i2c call in
 taos_als_calibrate()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
 <1478177780-28699-7-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9c9da790-5347-e4f7-4c4a-0ffa3f5ab5e6@kernel.org>
Date: Sun, 6 Nov 2016 11:54:49 +0000
MIME-Version: 1.0
In-Reply-To: <1478177780-28699-7-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 12:56, Brian Masney wrote:
> taos_als_calibrate() queries the control register to determine if the
> unit is powered on and has the ADC enabled. It then queries the same
> register a second time to determine if the ADC reading is valid. This
> patch removes the redundant i2c_smbus_read_byte_data() call.
> 
> Verified that the driver still functions correctly using a TSL2581
> hooked up to a Raspberry Pi 2.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2583.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index af1cf9b..7eab17f 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -338,18 +338,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
>  		dev_err(&chip->client->dev,
>  			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
>  		return -EINVAL;
> -	}
> -
> -	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL258X_CMD_REG | TSL258X_CNTRL);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s failed to read from the CNTRL register\n",
> -			__func__);
> -		return ret;
> -	}
> -
> -	if ((ret & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
> +	} else if ((ret & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
>  		dev_err(&chip->client->dev,
>  			"taos_als_calibrate failed: STATUS - ADC not valid.\n");
>  		return -ENODATA;
> 

