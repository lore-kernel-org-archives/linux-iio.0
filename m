Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47594 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaC2Kvf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Mar 2014 06:51:35 -0400
Message-ID: <5336A5FC.4020507@kernel.org>
Date: Sat, 29 Mar 2014 10:52:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch v1 3/4] iio: imu: Enable checking of presence of device
References: <1395248203-17027-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1395248203-17027-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1395248203-17027-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/03/14 16:56, Srinivas Pandruvada wrote:
> Added logic to check presence of MPU6050 before continuing. Currently
> only i2c writes are used in the initialzation path, which don't return
> any error, if some i2c device responds. In this case it continues to
> create iio devices, which don't work.
> This can be reproduced in a PC like platform, where ACPI definition
> of this defines multiple i2c addresses.
That's hideous.  oh well - guess we need to cope with it.
> We need to check for an valid
> i2c address by checking some id before continuing.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
This looks fine, but won't apply without patch 2.  If you want to
reorder the series to push patch 2 towards the end, then I can take
this whilst that more complex issue is being sorted out.
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 27 +++++++++++++++++++++++++++
>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  5 +++++
>   2 files changed, 32 insertions(+)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 744eba4..200163d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -54,6 +54,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
>   	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
>   	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
>   	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
> +	.who_am_i		= INV_MPU6050_REG_WHOAMI,
>   };
>
>   static const struct inv_mpu6050_chip_config chip_config_6050 = {
> @@ -74,6 +75,12 @@ static const struct inv_mpu6050_hw hw_info[INV_NUM_PARTS] = {
>   	},
>   };
>
> +static const u16 inv_mpu_unique_ids[] = {
> +	INV_MPU60X0_UNIQUE_ID,
> +	INV_MPU6500_UNIQUE_ID,
> +	0x0000,
> +};
> +
>   int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 d)
>   {
>   	return i2c_smbus_write_i2c_block_data(st->client, reg, 1, &d);
> @@ -630,6 +637,8 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
>   		const struct i2c_device_id *id)
>   {
>   	int result;
> +	bool matched = false;
> +	int i = 0;
>
>   	st->chip_type = INV_MPU6050;
>   	st->hw  = &hw_info[st->chip_type];
> @@ -641,6 +650,24 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
>   	if (result)
>   		return result;
>   	msleep(INV_MPU6050_POWER_UP_TIME);
> +
> +	result = i2c_smbus_read_byte_data(st->client, st->reg->who_am_i);
> +	if (result < 0) {
> +		dev_err(&st->client->dev, "Error reading WhoAmI\n");
> +		return result;
> +	}
> +
> +	while (inv_mpu_unique_ids[i] != 0x0000) {
> +		if (inv_mpu_unique_ids[i++] == result)
> +			matched = true;
> +	}
> +
> +	if (!matched) {
> +		dev_err(&st->client->dev, "Not a valid MPU6XXX device %x\n",
> +								result);
> +		return -ENOSYS;
> +	}
> +
>   	/* toggle power state. After reset, the sleep bit could be on
>   		or off depending on the OTP settings. Toggling power would
>   		make it in a definite state as well as making the hardware
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 591ac2e..41196c5 100644
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
> @@ -190,6 +191,10 @@ struct inv_mpu6050_state {
>   #define INV_MPU6050_REG_INT_PIN_CFG		0x37
>   #define INV_MPU6050_BIT_BYPASS_EN		0x2
>
> +#define INV_MPU6050_REG_WHOAMI			0x75
> +#define INV_MPU6500_UNIQUE_ID			0x70
> +#define INV_MPU60X0_UNIQUE_ID			0x68
> +
>   /* scan element definition */
>   enum inv_mpu6050_scan {
>   	INV_MPU6050_SCAN_ACCL_X,
>

