Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60588 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbaCOQDV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Mar 2014 12:03:21 -0400
Message-ID: <53247A04.8050203@kernel.org>
Date: Sat, 15 Mar 2014 16:04:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: Enable checking of presence of device
References: <1394571854-6737-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1394571854-6737-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1394571854-6737-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/03/14 21:04, Srinivas Pandruvada wrote:
> Added logic to check presence of MPU6050 before continuing. Currently
> only i2c writes are used in the initialzation path, which don't return
> any error, if some i2c device responds. In this case it continues to
> create iio devices, which don't work.
> This can be reproduced in a PC like platform, where ACPI definition
> of this defines multiple i2c addresses.
Yuk.
> We need to check for an valid
> i2c address by checking some signature before continuing.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
This patch looks fine.  The test is a sensible, simple, debugging test
even without the ACPI fun..
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 15 ++++++++++++++-
>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++++
>   2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 6ba565a..e062acd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -62,6 +62,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
>   	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
>   	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
>   	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
> +	.who_am_i		= INV_MPU6050_REG_WHOAMI,
>   };
>
>   static const struct inv_mpu6050_chip_config chip_config_6050 = {
> @@ -617,7 +618,7 @@ static const struct iio_info mpu_info = {
>   	.validate_trigger = inv_mpu6050_validate_trigger,
>   };
>
> -int inv_set_bypass_status(struct inv_mpu6050_state *st, bool enable)
> +static int inv_set_bypass_status(struct inv_mpu6050_state *st, bool enable)
>   {
>   	int ret;
>
> @@ -650,6 +651,18 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
>   	if (result)
>   		return result;
>   	msleep(INV_MPU6050_POWER_UP_TIME);
> +
> +	result = i2c_smbus_read_byte_data(st->client, st->reg->who_am_i);
> +	if (result < 0) {
> +		dev_err(&st->client->dev, "Error reading WhoAmI\n");
> +		return result;
> +	}
> +	if (result != INV_MPU6500_UNIQUE_ID) {
> +		dev_err(&st->client->dev, "Not a valid MPU6500 device %x\n",
> +								result);
> +		return -ENOSYS;
> +	}
> +
>   	/* toggle power state. After reset, the sleep bit could be on
>   		or off depending on the OTP settings. Toggling power would
>   		make it in a definite state as well as making the hardware
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index de5aa22..87649bd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -55,6 +55,7 @@ struct inv_mpu6050_reg_map {
>   	u8 pwr_mgmt_1;
>   	u8 pwr_mgmt_2;
>   	u8 int_pin_cfg;
> +	u8 who_am_i;
>   };
>
>   /*device enum */
> @@ -189,6 +190,9 @@ struct inv_mpu6050_state {
>   #define INV_MPU6050_REG_INT_PIN_CFG		0x37
>   #define INV_MPU6050_BIT_BYPASS_EN		0x2
>
> +#define INV_MPU6050_REG_WHOAMI			0x75
> +#define INV_MPU6500_UNIQUE_ID			0x70
> +
>   /* scan element definition */
>   enum inv_mpu6050_scan {
>   	INV_MPU6050_SCAN_ACCL_X,
>

