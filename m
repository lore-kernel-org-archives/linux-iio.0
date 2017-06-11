Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbdFKM6s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 08:58:48 -0400
Date: Sun, 11 Jun 2017 13:58:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: test whoami first and against
 all known values
Message-ID: <20170611135844.7deb0c51@kernel.org>
In-Reply-To: <BLUPR12MB06572FF309979BB42C095E07C4CB0@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB06572FF309979BB42C095E07C4CB0@BLUPR12MB0657.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 6 Jun 2017 10:29:52 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> SPI bus is never generating error during transfer, so to check if
> a chip is correctly connected on a SPI bus we enforce whoami check
> to be correct. In this way we can assure SPI probe is failing if
> there is no chip connected.
> 
> Fixes: cec0154556f8 ("iio: inv_mpu6050: Check WHO_AM_I register on probe")
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Cc: <stable@vger.kernel.org>
Hi Jean-Baptiste.

I'm happy with the patch, however it's a fix for an issue with a platform
rather than the driver itself. That needs to be explained in the patch
description.  In particular do you have some examples we can list to
justify the change?

Otherwise, I'm thinking this is a 'nice to have' that wants to go via
the next merge window rather than going in as a fix.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 33 ++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..af1b536 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -770,27 +770,42 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  {
>  	int result;
>  	unsigned int regval;
> +	int i;
>  
>  	st->hw  = &hw_info[st->chip_type];
>  	st->reg = hw_info[st->chip_type].reg;
>  
> -	/* reset to make sure previous state are not there */
> -	result = regmap_write(st->map, st->reg->pwr_mgmt_1,
> -			      INV_MPU6050_BIT_H_RESET);
> -	if (result)
> -		return result;
> -	msleep(INV_MPU6050_POWER_UP_TIME);
> -
>  	/* check chip self-identification */
>  	result = regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
>  	if (result)
>  		return result;
>  	if (regval != st->hw->whoami) {
> -		dev_warn(regmap_get_device(st->map),
> -				"whoami mismatch got %#02x expected %#02hhx for %s\n",
> +		/* check whoami against all possible values */
> +		for (i = 0; i < INV_NUM_PARTS; ++i) {
> +			if (regval == hw_info[i].whoami) {
> +				dev_warn(regmap_get_device(st->map),
> +					"whoami mismatch got %#02x (%s)"
> +					"expected %#02hhx (%s)\n",
> +					regval, hw_info[i].name,
> +					st->hw->whoami, st->hw->name);
> +				break;
> +			}
> +		}
> +		if (i >= INV_NUM_PARTS) {
> +			dev_err(regmap_get_device(st->map),
> +				"invalid whoami %#02x expected %#02hhx (%s)\n",
>  				regval, st->hw->whoami, st->hw->name);
> +			return -ENODEV;
> +		}
>  	}
>  
> +	/* reset to make sure previous state are not there */
> +	result = regmap_write(st->map, st->reg->pwr_mgmt_1,
> +			      INV_MPU6050_BIT_H_RESET);
> +	if (result)
> +		return result;
> +	msleep(INV_MPU6050_POWER_UP_TIME);
> +
>  	/*
>  	 * toggle power state. After reset, the sleep bit could be on
>  	 * or off depending on the OTP settings. Toggling power would

