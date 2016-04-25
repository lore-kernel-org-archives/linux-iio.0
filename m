Return-Path: <GGao@invensense.com>
From: Ge Gao <GGao@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>, Crestez Dan Leonard
	<leonard.crestez@intel.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hartmut
 Knaack" <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, "Peter
 Meerwald-Stadler" <pmeerw@pmeerw.net>, Daniel Baluta
	<daniel.baluta@intel.com>
Subject: RE: [PATCH 5/5] iio: inv_mpu6050: Add explicit support for MPU9150
Date: Mon, 25 Apr 2016 17:56:07 +0000
Message-ID: <DM3PR1201MB107242867FAACB76EF80ED45AF620@DM3PR1201MB1072.namprd12.prod.outlook.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
 <cb9b1ec69032c501a4c74d6554c25d336d65ac8e.1461156671.git.leonard.crestez@intel.com>
 <76645673-6d2c-3d51-a689-1c9310cbc765@kernel.org>
In-Reply-To: <76645673-6d2c-3d51-a689-1c9310cbc765@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This looks good to me.

Acked-by: Ge Gao <ggao@invensense.com >



-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org]=20
Sent: Sunday, April 24, 2016 4:16 AM
To: Crestez Dan Leonard; linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org; Hartmut Knaack; Lars-Peter Clausen; Peter=
 Meerwald-Stadler; Daniel Baluta; Ge Gao
Subject: Re: [PATCH 5/5] iio: inv_mpu6050: Add explicit support for MPU9150

On 20/04/16 14:15, Crestez Dan Leonard wrote:
> This device is a package containing a MPU6050-like sensor and an=20
> AK8975 magnetometer. The magnetometer component is supported by the=20
> existing
> ak8975 driver.
>=20
> This patch also rephrases the Kconfig descriptions.
>=20
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Looks good.  Will just wait for Ge to hopefully have time to take a look at=
 the whole series.  For future reference, it's always worth making sure you=
 have cc'd the original author of a driver unless you know someone else is =
definitely maintaining it.

Ge was reply to emails recently so I guess he is still very much active!

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig        | 10 ++++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  6 ++++++ =20
> drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  1 + =20
> drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++ =20
> drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  1 +
>  5 files changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig=20
> b/drivers/iio/imu/inv_mpu6050/Kconfig
> index a7f557a..c05d474 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -14,10 +14,8 @@ config INV_MPU6050_I2C
>  	select I2C_MUX
>  	select REGMAP_I2C
>  	help
> -	  This driver supports the Invensense MPU6050 devices.
> -	  This driver can also support MPU6500 in MPU6050 compatibility mode
> -	  and also in MPU6500 mode with some limitations.
> -	  It is a gyroscope/accelerometer combo device.
> +	  This driver supports the Invensense MPU6050/6500/9150 motion tracking
> +	  devices over I2C.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
> =20
> @@ -27,7 +25,7 @@ config INV_MPU6050_SPI
>  	select INV_MPU6050_IIO
>  	select REGMAP_SPI
>  	help
> -	  This driver supports the Invensense MPU6050 devices.
> -	  It is a gyroscope/accelerometer combo device.
> +	  This driver supports the Invensense MPU6000/6500/9150 motion tracking
> +	  devices over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=20
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 273b7fa7..3a82a49 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -108,6 +108,12 @@ static const struct inv_mpu6050_hw hw_info[] =3D {
>  		.reg =3D &reg_set_6050,
>  		.config =3D &chip_config_6050,
>  	},
> +	{
> +		.whoami =3D INV_MPU9150_WHOAMI_VALUE,
> +		.name =3D "MPU9150",
> +		.reg =3D &reg_set_6050,
> +		.config =3D &chip_config_6050,
> +	},
>  };
> =20
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,=20
> u32 mask) diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=20
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index bb1a7b1..1a424a6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -202,6 +202,7 @@ static int inv_mpu_remove(struct i2c_client=20
> *client)  static const struct i2c_device_id inv_mpu_id[] =3D {
>  	{"mpu6050", INV_MPU6050},
>  	{"mpu6500", INV_MPU6500},
> +	{"mpu9150", INV_MPU9150},
>  	{}
>  };
> =20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=20
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 564cabd..38d6a09 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -68,6 +68,7 @@ enum inv_devices {
>  	INV_MPU6050,
>  	INV_MPU6500,
>  	INV_MPU6000,
> +	INV_MPU9150,
>  	INV_NUM_PARTS
>  };
> =20
> @@ -220,6 +221,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6000_WHOAMI_VALUE		0x68
>  #define INV_MPU6050_WHOAMI_VALUE		0x68
>  #define INV_MPU6500_WHOAMI_VALUE		0x70
> +#define INV_MPU9150_WHOAMI_VALUE		0x68
> =20
>  /* scan element definition */
>  enum inv_mpu6050_scan {
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=20
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index a0f8df2..190a4a5 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -81,6 +81,7 @@ static int inv_mpu_remove(struct spi_device *spi) =20
> static const struct spi_device_id inv_mpu_id[] =3D {
>  	{"mpu6000", INV_MPU6000},
>  	{"mpu6500", INV_MPU6500},
> +	{"mpu9150", INV_MPU9150},
>  	{}
>  };
> =20
>=20
