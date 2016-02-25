Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57497 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933646AbcBYT4O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2016 14:56:14 -0500
Subject: Re: [PATCH 5/5] iio: imu: mpu6050: add mpu6500 register settings
To: Matt Ranostay <matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
 <1456177151-15881-6-git-send-email-matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CF5C5C.2000902@kernel.org>
Date: Thu, 25 Feb 2016 19:56:12 +0000
MIME-Version: 1.0
In-Reply-To: <1456177151-15881-6-git-send-email-matt.ranostay@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/16 21:39, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.

Thanks,
Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 32 +++++++++++++++++++++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  3 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  3 ++-
>  4 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 3acf0863e558..75d93181a16d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -39,6 +39,26 @@ static const int gyro_scale_6050[] = {133090, 266181, 532362, 1064724};
>   */
>  static const int accel_scale[] = {598, 1196, 2392, 4785};
>  
> +static const struct inv_mpu6050_reg_map reg_set_6500 = {
> +	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
> +	.lpf                    = INV_MPU6050_REG_CONFIG,
> +	.user_ctrl              = INV_MPU6050_REG_USER_CTRL,
> +	.fifo_en                = INV_MPU6050_REG_FIFO_EN,
> +	.gyro_config            = INV_MPU6050_REG_GYRO_CONFIG,
> +	.accl_config            = INV_MPU6050_REG_ACCEL_CONFIG,
> +	.fifo_count_h           = INV_MPU6050_REG_FIFO_COUNT_H,
> +	.fifo_r_w               = INV_MPU6050_REG_FIFO_R_W,
> +	.raw_gyro               = INV_MPU6050_REG_RAW_GYRO,
> +	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
> +	.temperature            = INV_MPU6050_REG_TEMPERATURE,
> +	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
> +	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
> +	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
> +	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
> +	.accl_offset		= INV_MPU6500_REG_ACCEL_OFFSET,
> +	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
> +};
> +
>  static const struct inv_mpu6050_reg_map reg_set_6050 = {
>  	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
>  	.lpf                    = INV_MPU6050_REG_CONFIG,
> @@ -68,7 +88,13 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
>  	.accl_fs = INV_MPU6050_FS_02G,
>  };
>  
> -static const struct inv_mpu6050_hw hw_info[INV_NUM_PARTS] = {
> +static const struct inv_mpu6050_hw hw_info[] = {
> +	{
> +		.num_reg = 117,
> +		.name = "MPU6500",
> +		.reg = &reg_set_6500,
> +		.config = &chip_config_6050,
> +	},
>  	{
>  		.num_reg = 117,
>  		.name = "MPU6050",
> @@ -692,7 +718,6 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  {
>  	int result;
>  
> -	st->chip_type = INV_MPU6050;
>  	st->hw  = &hw_info[st->chip_type];
>  	st->reg = hw_info[st->chip_type].reg;
>  
> @@ -726,7 +751,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  }
>  
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> -		       int (*inv_mpu_bus_setup)(struct iio_dev *))
> +		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
>  {
>  	struct inv_mpu6050_state *st;
>  	struct iio_dev *indio_dev;
> @@ -739,6 +764,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	st->chip_type = chip_type;
>  	st->powerup_count = 0;
>  	st->irq = irq;
>  	st->map = regmap;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 37cc16d3fca3..37aec63113ed 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -130,7 +130,8 @@ static int inv_mpu_probe(struct i2c_client *client,
>  		return PTR_ERR(regmap);
>  	}
>  
> -	result = inv_mpu_core_probe(regmap, client->irq, name, NULL);
> +	result = inv_mpu_core_probe(regmap, client->irq, name,
> +				    NULL, id->driver_data);
>  	if (result < 0)
>  		return result;
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index c4e24148c733..e302a49703bf 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -277,7 +277,7 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
>  void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> -		      int (*inv_mpu_bus_setup)(struct iio_dev *));
> +		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
>  int inv_mpu_core_remove(struct device *dev);
>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  extern const struct dev_pm_ops inv_mpu_pmops;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 5b552a677340..dea6c4361de0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -54,7 +54,8 @@ static int inv_mpu_probe(struct spi_device *spi)
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return inv_mpu_core_probe(regmap, spi->irq, name, inv_mpu_i2c_disable);
> +	return inv_mpu_core_probe(regmap, spi->irq, name,
> +				  inv_mpu_i2c_disable, id->driver_data);
>  }
>  
>  static int inv_mpu_remove(struct spi_device *spi)
> 

