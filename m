Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35870 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965364AbcKLQbK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 11:31:10 -0500
Subject: Re: [PATCH v3 05/28] staging: iio: tsl2583: remove unnecessary chip
 status checks in suspend/resume
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-6-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <616ef02f-691f-aafd-b317-4170d5b2a4e0@kernel.org>
Date: Sat, 12 Nov 2016 16:31:06 +0000
MIME-Version: 1.0
In-Reply-To: <1478769964-7065-6-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/16 09:25, Brian Masney wrote:
> The device probing and the suspend/resume code checks a flag internal to
> the driver that determines whether or not the chip is in a working
> state. These checks are not needed. This patch removes the unnecessary
> checks. It will do no harm to the hardware if the chip is
> reinitialized if it is already powered on.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Looks sensible to me.
> ---
>  drivers/staging/iio/light/tsl2583.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 170b8e9..29dd072 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -412,13 +412,6 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
>  	int ret;
>  
> -	/* and make sure we're not already on */
> -	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
> -		/* if forcing a register update - turn off, then on */
> -		dev_info(&chip->client->dev, "device is already enabled\n");
> -		return -EINVAL;
> -	}
> -
>  	/* Power on the device; ADC off. */
>  	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_ON);
>  	if (ret < 0)
> @@ -841,10 +834,8 @@ static int __maybe_unused taos_suspend(struct device *dev)
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
> -		ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
> -		chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
> -	}
> +	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
> +	chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
>  
>  	mutex_unlock(&chip->als_mutex);
>  	return ret;
> @@ -858,8 +849,7 @@ static int __maybe_unused taos_resume(struct device *dev)
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status == TSL258X_CHIP_SUSPENDED)
> -		ret = tsl2583_chip_init_and_power_on(indio_dev);
> +	ret = tsl2583_chip_init_and_power_on(indio_dev);
>  
>  	mutex_unlock(&chip->als_mutex);
>  	return ret;
> 

