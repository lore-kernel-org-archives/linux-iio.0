Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46655 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdENOtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 10:49:02 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid values
 and do it first
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <BLUPR12MB0657CCC7922C6655D88C9FB0C4E20@BLUPR12MB0657.namprd12.prod.outlook.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e90a537f-3eb8-2075-9c1d-393890ad1c3c@kernel.org>
Date: Sun, 14 May 2017 15:49:00 +0100
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB0657CCC7922C6655D88C9FB0C4E20@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/05/17 13:45, Jean-Baptiste Maneyrol wrote:
> SPI bus is never generating error during transfer, so a simple way to check
> if a chip is correctly connected on a SPI bus is to check a fixed value like
> whoami against valid values. 0x00 or 0xff can never happened. It is better
> to do this test first since if there is a problem with a DTS and an incorrect
> chip is wired instead, a write can be more damaging than a read.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hmm. I'd a little unsure on this one.  If we start getting into the
general game of protecting against every wrong DTS it may be a slippery
slope.

Is there an actual platform out there that you know of that this will
protect?  If so I can probably be persuaded.

If not I would actually prefer if we checked against the specified ID
rather than relying on a different chip producing either high or low
consistently when hit with this query.

So perhaps make the ID check a failure if it doesn't match any of the
supported parts?  Bit of a pain for new devices as they won't work
immediately but conversely protects them against issues due to incorrect
identification as well.

Jonathan

> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..42fb135 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -774,23 +774,28 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>   	st->hw  = &hw_info[st->chip_type];
>   	st->reg = hw_info[st->chip_type].reg;
>   
> -	/* reset to make sure previous state are not there */
> -	result = regmap_write(st->map, st->reg->pwr_mgmt_1,
> -			      INV_MPU6050_BIT_H_RESET);
> -	if (result)
> -		return result;
> -	msleep(INV_MPU6050_POWER_UP_TIME);
> -
>   	/* check chip self-identification */
>   	result = regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
>   	if (result)
>   		return result;
>   	if (regval != st->hw->whoami) {
> +		if (regval == 0x00 || regval == 0xff) {
> +			dev_err(regmap_get_device(st->map),
> +					"invalid whoami probably io error\n");
> +			return -EIO;
> +		}
>   		dev_warn(regmap_get_device(st->map),
>   				"whoami mismatch got %#02x expected %#02hhx for %s\n",
>   				regval, st->hw->whoami, st->hw->name);
>   	}
>   
> +	/* reset to make sure previous state are not there */
> +	result = regmap_write(st->map, st->reg->pwr_mgmt_1,
> +			      INV_MPU6050_BIT_H_RESET);
> +	if (result)
> +		return result;
> +	msleep(INV_MPU6050_POWER_UP_TIME);
> +
>   	/*
>   	 * toggle power state. After reset, the sleep bit could be on
>   	 * or off depending on the OTP settings. Toggling power would
> 

