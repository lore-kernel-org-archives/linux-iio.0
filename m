Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47580 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaC2Ks2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Mar 2014 06:48:28 -0400
Message-ID: <5336A540.7060309@kernel.org>
Date: Sat, 29 Mar 2014 10:49:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch v1 2/4] iio: imu: inv_mpu6050: Enable default bypass mode
References: <1395248203-17027-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1395248203-17027-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1395248203-17027-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/03/14 16:56, Srinivas Pandruvada wrote:
> This chip has two modes to control secondary sensor attached to it.
> One is master mode and another is bypass mode. In master mode
> MPU6500 will directly communicates to the secondary sensor device
> attached to it. This can support very few secondary devices in this
> mode.
> But when configured in bypass mode the i2c lines are directly connected
> to host i2c bus controller.
> Since in master mode it can only support few devices and they are not
> implemented in this driver, set the default mode to bypass mode.
> When some multiplexer is implemented to use MPU6050 master mode,
> this mode can be enabled when requested.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To my understanding this still doesn't deal with the fact that devices
on the slave bus are not connected if this driver is not loaded or has
gone to sleep.  Hence this needs as previously discussed to be done as
a single input, single output i2c mux.  That way the kernel 'knows'
there is something inbetween that needs to be in the correct state.

Jonathan
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 ++++++++++++++++++-
>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++++
>   2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 52d688b..744eba4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -53,6 +53,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
>   	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
>   	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
>   	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
> +	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
>   };
>
>   static const struct inv_mpu6050_chip_config chip_config_6050 = {
> @@ -608,6 +609,20 @@ static const struct iio_info mpu_info = {
>   	.validate_trigger = inv_mpu6050_validate_trigger,
>   };
>
> +static int inv_set_bypass_status(struct inv_mpu6050_state *st, bool enable)
> +{
> +	int ret;
> +
> +	if (enable)
> +		ret = inv_mpu6050_write_reg(st, st->reg->int_pin_cfg,
> +					st->client->irq |
> +						INV_MPU6050_BIT_BYPASS_EN);
> +	else
> +		ret = inv_mpu6050_write_reg(st, st->reg->int_pin_cfg,
> +					st->client->irq);
> +	return ret;
> +}
> +
>   /**
>    *  inv_check_and_setup_chip() - check and setup chip.
>    */
> @@ -646,7 +661,9 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
>   	if (result)
>   		return result;
>
> -	return 0;
> +	result = inv_set_bypass_status(st, true);
> +
> +	return result;
>   }
>
>   /**
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 4ddfd03..591ac2e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -54,6 +54,7 @@ struct inv_mpu6050_reg_map {
>   	u8 int_enable;
>   	u8 pwr_mgmt_1;
>   	u8 pwr_mgmt_2;
> +	u8 int_pin_cfg;
>   };
>
>   /*device enum */
> @@ -186,6 +187,9 @@ struct inv_mpu6050_state {
>   #define INV_MPU6050_MIN_FIFO_RATE                         4
>   #define INV_MPU6050_ONE_K_HZ                              1000
>
> +#define INV_MPU6050_REG_INT_PIN_CFG		0x37
> +#define INV_MPU6050_BIT_BYPASS_EN		0x2
> +
>   /* scan element definition */
>   enum inv_mpu6050_scan {
>   	INV_MPU6050_SCAN_ACCL_X,
>

