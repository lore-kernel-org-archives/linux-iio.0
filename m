Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57548 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbcGCKu7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 06:50:59 -0400
Subject: Re: [PATCH v1 1/1] iio:imu:mpu6050: icm20608 initial support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <ba6883cf2e6a280d4ff924aa761d5a7cace6412e.1467305926.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Adriana Reus <adi.reus@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <ggao@invensense.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f0ada5b0-f093-fd44-0a71-0a45cc6d08f8@kernel.org>
Date: Sun, 3 Jul 2016 11:50:55 +0100
MIME-Version: 1.0
In-Reply-To: <ba6883cf2e6a280d4ff924aa761d5a7cace6412e.1467305926.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/16 18:06, Gregor Boirie wrote:
> Introduce support for Invense ICM20608 IMU, a 6-axis motion tracking device
> that combines a 3-axis gyroscope and a 3-axis accelerometer:
> http://www.invensense.com/products/motion-tracking/6-axis/icm-20608-2
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Straight forward enough that I'm applying now without waiting for
acks etc.  If anyone spots anything wrong still time to shout!

Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Note there was a fair bit of fuzz, so Gregor, please sanity check
nothing went wrong (I doubt it did as was only a few lines on each
block).

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig        | 8 ++++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 ++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 1 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 1 +
>  5 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index c05d474..f5189e7 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -14,8 +14,8 @@ config INV_MPU6050_I2C
>  	select I2C_MUX
>  	select REGMAP_I2C
>  	help
> -	  This driver supports the Invensense MPU6050/6500/9150 motion tracking
> -	  devices over I2C.
> +	  This driver supports the Invensense MPU6050/6500/9150 and ICM20608
> +	  motion tracking devices over I2C.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
>  
> @@ -25,7 +25,7 @@ config INV_MPU6050_SPI
>  	select INV_MPU6050_IIO
>  	select REGMAP_SPI
>  	help
> -	  This driver supports the Invensense MPU6000/6500/9150 motion tracking
> -	  devices over SPI.
> +	  This driver supports the Invensense MPU6050/6500/9150 and ICM20608
> +	  motion tracking devices over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index b269b37..a27b0bc 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -114,6 +114,12 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6050,
>  		.config = &chip_config_6050,
>  	},
> +	{
> +		.whoami = INV_ICM20608_WHOAMI_VALUE,
> +		.name = "ICM20608",
> +		.reg = &reg_set_6500,
> +		.config = &chip_config_6050,
> +	},
>  };
>  
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 1a424a6..2bb9c6e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -203,6 +203,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
>  	{"mpu6050", INV_MPU6050},
>  	{"mpu6500", INV_MPU6500},
>  	{"mpu9150", INV_MPU9150},
> +	{"icm20608", INV_ICM20608},
>  	{}
>  };
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 47ca25b..6e7f267 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -69,6 +69,7 @@ enum inv_devices {
>  	INV_MPU6500,
>  	INV_MPU6000,
>  	INV_MPU9150,
> +	INV_ICM20608,
>  	INV_NUM_PARTS
>  };
>  
> @@ -224,6 +225,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_WHOAMI_VALUE		0x68
>  #define INV_MPU6500_WHOAMI_VALUE		0x70
>  #define INV_MPU9150_WHOAMI_VALUE		0x68
> +#define INV_ICM20608_WHOAMI_VALUE		0xAF
>  
>  /* scan element definition */
>  enum inv_mpu6050_scan {
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 190a4a5..6e6476d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -82,6 +82,7 @@ static const struct spi_device_id inv_mpu_id[] = {
>  	{"mpu6000", INV_MPU6000},
>  	{"mpu6500", INV_MPU6500},
>  	{"mpu9150", INV_MPU9150},
> +	{"icm20608", INV_ICM20608},
>  	{}
>  };
>  
> 

