Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55575 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbcKFLxu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 06:53:50 -0500
Subject: Re: [PATCH 5/9] staging: iio: tsl2583: don't shutdown chip when
 updating the lux table
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
 <1478177780-28699-6-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f6406f37-18b9-8c65-e65b-69282851dd4e@kernel.org>
Date: Sun, 6 Nov 2016 11:53:48 +0000
MIME-Version: 1.0
In-Reply-To: <1478177780-28699-6-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 12:56, Brian Masney wrote:
> in_illuminance_lux_table_store() shuts down the chip, updates the
> contents of the lux table, and then turns the chip back on. The values
> in lux table are not used by the chip and are only used internally by
> the driver. It is not necessary to change the power state on the chip.
> This patch removes the calls to taos_chip_off() and taos_chip_on()
> in in_illuminance_lux_table_store().
That is rather mystifying...  Maybe a really odd way of locking?
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2583.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 7fb09c6..af1cf9b 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -564,20 +564,10 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  		goto done;
>  	}
>  
> -	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
> -		ret = taos_chip_off(indio_dev);
> -		if (ret < 0)
> -			goto done;
> -	}
> -
>  	/* Zero out the table */
>  	memset(taos_device_lux, 0, sizeof(taos_device_lux));
>  	memcpy(taos_device_lux, &value[1], (value[0] * 4));
>  
> -	ret = taos_chip_on(indio_dev);
> -	if (ret < 0)
> -		goto done;
> -
>  	ret = len;
>  
>  done:
> 

