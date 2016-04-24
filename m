Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35714 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcDXLOX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2016 07:14:23 -0400
Subject: Re: [PATCH 3/5] iio: inv_mpu6050: Check WHO_AM_I register on probe
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1461156671.git.leonard.crestez@intel.com>
 <de4fc83c1c049176bbea7eeb4617166df593dcee.1461156671.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <db4459f9-7cb4-ff85-658d-a21f363aee3a@kernel.org>
Date: Sun, 24 Apr 2016 12:14:18 +0100
MIME-Version: 1.0
In-Reply-To: <de4fc83c1c049176bbea7eeb4617166df593dcee.1461156671.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/04/16 14:15, Crestez Dan Leonard wrote:
> This can be used to distinguish mpu6500. This is a warning rather than
> an error because the differences are mostly irrelevant and it's nice to
> avoid breaking users with slightly incorrect ACPI/DT.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Would we be better off fixing their configuration though by using the right part
if we can identify it?  So if wrong, maybe we should search the info table to 
figure out what it is?  I'm not certain on this though as then we are trying to
deal with unknown future cases - maybe what you have here is the best balance.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 15 +++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  8 ++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index faccabafc..273b7fa7 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -91,16 +91,19 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
>  /* Indexed by enum inv_devices */
>  static const struct inv_mpu6050_hw hw_info[] = {
>  	{
> +		.whoami = INV_MPU6050_WHOAMI_VALUE,
>  		.name = "MPU6050",
>  		.reg = &reg_set_6050,
>  		.config = &chip_config_6050,
>  	},
>  	{
> +		.whoami = INV_MPU6500_WHOAMI_VALUE,
>  		.name = "MPU6500",
>  		.reg = &reg_set_6500,
>  		.config = &chip_config_6050,
>  	},
>  	{
> +		.whoami = INV_MPU6000_WHOAMI_VALUE,
>  		.name = "MPU6000",
>  		.reg = &reg_set_6050,
>  		.config = &chip_config_6050,
> @@ -730,6 +733,7 @@ static const struct iio_info mpu_info = {
>  static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  {
>  	int result;
> +	unsigned int regval;
>  
>  	st->hw  = &hw_info[st->chip_type];
>  	st->reg = hw_info[st->chip_type].reg;
> @@ -740,6 +744,17 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	if (result)
>  		return result;
>  	msleep(INV_MPU6050_POWER_UP_TIME);
> +
> +	/* check chip self-identification */
> +	result = regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
> +	if (result)
> +		return result;
> +	if (regval != st->hw->whoami) {
> +		dev_warn(regmap_get_device(st->map),
> +				"whoami mismatch got %#02x expected %#02hhx for %s\n",
> +				regval, st->hw->whoami, st->hw->name);
> +	}
> +
>  	/*
>  	 * toggle power state. After reset, the sleep bit could be on
>  	 * or off depending on the OTP settings. Toggling power would
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index c66dbfc..564cabd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -93,11 +93,13 @@ struct inv_mpu6050_chip_config {
>  
>  /**
>   *  struct inv_mpu6050_hw - Other important hardware information.
> + *  @whoami:	Self identification byte from WHO_AM_I register
>   *  @name:      name of the chip.
>   *  @reg:   register map of the chip.
>   *  @config:    configuration of the chip.
>   */
>  struct inv_mpu6050_hw {
> +	u8 whoami;
>  	u8 *name;
>  	const struct inv_mpu6050_reg_map *reg;
>  	const struct inv_mpu6050_chip_config *config;
> @@ -213,6 +215,12 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_MIN_FIFO_RATE            4
>  #define INV_MPU6050_ONE_K_HZ                 1000
>  
> +#define INV_MPU6050_REG_WHOAMI			117
> +
> +#define INV_MPU6000_WHOAMI_VALUE		0x68
> +#define INV_MPU6050_WHOAMI_VALUE		0x68
> +#define INV_MPU6500_WHOAMI_VALUE		0x70
> +
>  /* scan element definition */
>  enum inv_mpu6050_scan {
>  	INV_MPU6050_SCAN_ACCL_X,
> 

