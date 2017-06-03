Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdFCIrn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:47:43 -0400
Date: Sat, 3 Jun 2017 09:47:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: test whoami against invalid
 values and do it first
Message-ID: <20170603094733.545ceda2@jic23.retrosnub.co.uk>
In-Reply-To: <BLUPR12MB06575D31F4F7233ED58923E1C4F30@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB06575D31F4F7233ED58923E1C4F30@BLUPR12MB0657.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 May 2017 13:17:14 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> SPI bus is never generating error during transfer, so to check if
> a chip is correctly connected on a SPI bus we enforce whoami check
> to be correct.
> In this way we can assure SPI probe is failing if there is no chip
> connected.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hi Jean-Baptiste,

Sorry, I have just read back the previous emails and realised
I wasn't being very clear.  What I was suggesting was that we should
check against all valid ids that are known, not just the one registered.
So many of invensense's parts are 'nearly' compatible that it is
common to get different revisions of boards using different versions.
As such we are sure to break boards if we insist the code is right.
(for starters I know there are DTSs out there for the beaglebone blue
claiming it has a 9150 when it actually always has a 9250)

So what I was looking for was a check over all valid IDs. Perhaps
stick a warning in the log if the wrong one is found and fix up
which chip info we are using.

I'm afraid I thought this was what you meant when I agreed in
the v1 thread, whereas it's clear you were thinking to enforce people
getting it 'right!' (sadly something we know they don't always do).

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..57b3442 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -774,23 +774,24 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
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
> -				regval, st->hw->whoami, st->hw->name);
> +		dev_err(regmap_get_device(st->map),
> +			"invalid whoami got %#02x expected %#02hhx for %s\n",
> +			regval, st->hw->whoami, st->hw->name);
> +		return -ENODEV;
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

