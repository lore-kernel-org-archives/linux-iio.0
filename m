Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40243 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbcKML6Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 06:58:24 -0500
Subject: Re: [PATCH v4 04/26] staging: iio: tsl2583: change current chip state
 from a tristate to a bool
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-5-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3b27fd4a-91c3-d85f-e1df-419849dfb289@kernel.org>
Date: Sun, 13 Nov 2016 11:58:22 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-5-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> The current chip state is represented as a tristate (working, suspended,
> and unknown). The unknown state was not used. This patch changes the
> chip state so that it is now represented as a single boolean value
> (suspended).
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

> ---
>  drivers/staging/iio/light/tsl2583.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 40aa78e..5a32102 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -67,12 +67,6 @@
>  #define TSL2583_CHIP_ID			0x90
>  #define TSL2583_CHIP_ID_MASK		0xf0
>  
> -enum {
> -	TSL258X_CHIP_UNKNOWN = 0,
> -	TSL258X_CHIP_WORKING = 1,
> -	TSL258X_CHIP_SUSPENDED = 2
> -};
> -
>  /* Per-device data */
>  struct taos_als_info {
>  	u16 als_ch0;
> @@ -94,7 +88,7 @@ struct tsl2583_chip {
>  	struct taos_settings taos_settings;
>  	int als_time_scale;
>  	int als_saturation;
> -	int taos_chip_status;
> +	bool suspended;
>  };
>  
>  struct taos_lux {
> @@ -441,7 +435,7 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	chip->taos_chip_status = TSL258X_CHIP_WORKING;
> +	chip->suspended = false;
>  
>  	return ret;
>  }
> @@ -494,7 +488,7 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> +	if (chip->suspended) {
>  		ret = -EBUSY;
>  		goto done;
>  	}
> @@ -627,7 +621,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> +	if (chip->suspended) {
>  		ret = -EBUSY;
>  		goto read_done;
>  	}
> @@ -704,7 +698,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> +	if (chip->suspended) {
>  		ret = -EBUSY;
>  		goto write_done;
>  	}
> @@ -778,7 +772,7 @@ static int taos_probe(struct i2c_client *clientp,
>  	i2c_set_clientdata(clientp, indio_dev);
>  
>  	mutex_init(&chip->als_mutex);
> -	chip->taos_chip_status = TSL258X_CHIP_UNKNOWN;
> +	chip->suspended = true;
>  
>  	ret = i2c_smbus_read_byte_data(clientp,
>  				       TSL258X_CMD_REG | TSL258X_CHIPID);
> @@ -835,7 +829,7 @@ static int __maybe_unused taos_suspend(struct device *dev)
>  	mutex_lock(&chip->als_mutex);
>  
>  	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
> -	chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
> +	chip->suspended = true;
>  
>  	mutex_unlock(&chip->als_mutex);
>  	return ret;
> 

