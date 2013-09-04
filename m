Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>, "arnd@arndb.de" <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 4 Sep 2013 22:10:17 +0200
Subject: Re: [PATCH 05/11] iio: pressure-core: st: Describe LPS331AP defines
 by name
Message-ID: <522793A9.8040300@st.com>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-6-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378287103-21765-6-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Lee,
> They're currently named *_1_*, for 'Sensor 1', but the code will be much
> more readable if we use the naming convention *_LPS331AP_* instead.
You are right, but the reason is to maintain the same structure of the=20
other sensors drivers (like accel, gyro and magn). Often some sensors=20
can use the same data and using 1,2,... I think it's more general.

Denis

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/iio/pressure/st_pressure_core.c | 90 ++++++++++++++++----------=
-------
>   1 file changed, 44 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressu=
re/st_pressure_core.c
> index 9c343b4..becfb25 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -31,92 +31,90 @@
>   #define ST_PRESS_MBAR_TO_KPASCAL(x)		(x * 10)
>   #define ST_PRESS_NUMBER_DATA_CHANNELS		1
>  =20
> -/* DEFAULT VALUE FOR SENSORS */
> -#define ST_PRESS_DEFAULT_OUT_XL_ADDR		0x28
> -#define ST_TEMP_DEFAULT_OUT_L_ADDR		0x2b
> -
>   /* FULLSCALE */
>   #define ST_PRESS_FS_AVL_1260MB			1260
>  =20
> -/* CUSTOM VALUES FOR SENSOR 1 */
> -#define ST_PRESS_1_WAI_EXP			0xbb
> -#define ST_PRESS_1_ODR_ADDR			0x20
> -#define ST_PRESS_1_ODR_MASK			0x70
> -#define ST_PRESS_1_ODR_AVL_1HZ_VAL		0x01
> -#define ST_PRESS_1_ODR_AVL_7HZ_VAL		0x05
> -#define ST_PRESS_1_ODR_AVL_13HZ_VAL		0x06
> -#define ST_PRESS_1_ODR_AVL_25HZ_VAL		0x07
> -#define ST_PRESS_1_PW_ADDR			0x20
> -#define ST_PRESS_1_PW_MASK			0x80
> -#define ST_PRESS_1_FS_ADDR			0x23
> -#define ST_PRESS_1_FS_MASK			0x30
> -#define ST_PRESS_1_FS_AVL_1260_VAL		0x00
> -#define ST_PRESS_1_FS_AVL_1260_GAIN		ST_PRESS_MBAR_TO_KPASCAL(244141)
> -#define ST_PRESS_1_FS_AVL_TEMP_GAIN		2083000
> -#define ST_PRESS_1_BDU_ADDR			0x20
> -#define ST_PRESS_1_BDU_MASK			0x04
> -#define ST_PRESS_1_DRDY_IRQ_ADDR		0x22
> -#define ST_PRESS_1_DRDY_IRQ_MASK		0x04
> -#define ST_PRESS_1_MULTIREAD_BIT		true
> -#define ST_PRESS_1_TEMP_OFFSET			42500
> +/* CUSTOM VALUES FOR LPS331AP SENSOR */
> +#define ST_PRESS_LPS331AP_WAI_EXP		0xbb
> +#define ST_PRESS_LPS331AP_ODR_ADDR		0x20
> +#define ST_PRESS_LPS331AP_ODR_MASK		0x70
> +#define ST_PRESS_LPS331AP_ODR_AVL_1HZ_VAL	0x01
> +#define ST_PRESS_LPS331AP_ODR_AVL_7HZ_VAL	0x05
> +#define ST_PRESS_LPS331AP_ODR_AVL_13HZ_VAL	0x06
> +#define ST_PRESS_LPS331AP_ODR_AVL_25HZ_VAL	0x07
> +#define ST_PRESS_LPS331AP_PW_ADDR		0x20
> +#define ST_PRESS_LPS331AP_PW_MASK		0x80
> +#define ST_PRESS_LPS331AP_FS_ADDR		0x23
> +#define ST_PRESS_LPS331AP_FS_MASK		0x30
> +#define ST_PRESS_LPS331AP_FS_AVL_1260_VAL	0x00
> +#define ST_PRESS_LPS331AP_FS_AVL_1260_GAIN	ST_PRESS_MBAR_TO_KPASCAL(2441=
41)
> +#define ST_PRESS_LPS331AP_FS_AVL_TEMP_GAIN	2083000
> +#define ST_PRESS_LPS331AP_BDU_ADDR		0x20
> +#define ST_PRESS_LPS331AP_BDU_MASK		0x04
> +#define ST_PRESS_LPS331AP_DRDY_IRQ_ADDR		0x22
> +#define ST_PRESS_LPS331AP_DRDY_IRQ_MASK		0x04
> +#define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
> +#define ST_PRESS_LPS331AP_TEMP_OFFSET		42500
> +#define ST_PRESS_LPS331AP_OUT_XL_ADDR		0x28
> +#define ST_TEMP_LPS331AP_OUT_L_ADDR		0x2b
>  =20
>   static const struct iio_chan_spec st_press_channels[] =3D {
>   	ST_SENSORS_LSM_CHANNELS(IIO_PRESSURE,
>   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>   			ST_SENSORS_SCAN_X, 0, IIO_NO_MOD, 'u', IIO_LE, 24, 24,
> -			ST_PRESS_DEFAULT_OUT_XL_ADDR),
> +			ST_PRESS_LPS331AP_OUT_XL_ADDR),
>   	ST_SENSORS_LSM_CHANNELS(IIO_TEMP,
>   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
>   						BIT(IIO_CHAN_INFO_OFFSET),
>   			-1, 0, IIO_NO_MOD, 's', IIO_LE, 16, 16,
> -			ST_TEMP_DEFAULT_OUT_L_ADDR),
> +			ST_TEMP_LPS331AP_OUT_L_ADDR),
>   	IIO_CHAN_SOFT_TIMESTAMP(1)
>   };
>  =20
>   static const struct st_sensors st_press_sensors[] =3D {
>   	{
> -		.wai =3D ST_PRESS_1_WAI_EXP,
> +		.wai =3D ST_PRESS_LPS331AP_WAI_EXP,
>   		.sensors_supported =3D {
>   			[0] =3D LPS331AP_PRESS_DEV_NAME,
>   		},
>   		.ch =3D (struct iio_chan_spec *)st_press_channels,
>   		.odr =3D {
> -			.addr =3D ST_PRESS_1_ODR_ADDR,
> -			.mask =3D ST_PRESS_1_ODR_MASK,
> +			.addr =3D ST_PRESS_LPS331AP_ODR_ADDR,
> +			.mask =3D ST_PRESS_LPS331AP_ODR_MASK,
>   			.odr_avl =3D {
> -				{ 1, ST_PRESS_1_ODR_AVL_1HZ_VAL, },
> -				{ 7, ST_PRESS_1_ODR_AVL_7HZ_VAL, },
> -				{ 13, ST_PRESS_1_ODR_AVL_13HZ_VAL, },
> -				{ 25, ST_PRESS_1_ODR_AVL_25HZ_VAL, },
> +				{ 1, ST_PRESS_LPS331AP_ODR_AVL_1HZ_VAL, },
> +				{ 7, ST_PRESS_LPS331AP_ODR_AVL_7HZ_VAL, },
> +				{ 13, ST_PRESS_LPS331AP_ODR_AVL_13HZ_VAL, },
> +				{ 25, ST_PRESS_LPS331AP_ODR_AVL_25HZ_VAL, },
>   			},
>   		},
>   		.pw =3D {
> -			.addr =3D ST_PRESS_1_PW_ADDR,
> -			.mask =3D ST_PRESS_1_PW_MASK,
> +			.addr =3D ST_PRESS_LPS331AP_PW_ADDR,
> +			.mask =3D ST_PRESS_LPS331AP_PW_MASK,
>   			.value_on =3D ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>   			.value_off =3D ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>   		},
>   		.fs =3D {
> -			.addr =3D ST_PRESS_1_FS_ADDR,
> -			.mask =3D ST_PRESS_1_FS_MASK,
> +			.addr =3D ST_PRESS_LPS331AP_FS_ADDR,
> +			.mask =3D ST_PRESS_LPS331AP_FS_MASK,
>   			.fs_avl =3D {
>   				[0] =3D {
>   					.num =3D ST_PRESS_FS_AVL_1260MB,
> -					.value =3D ST_PRESS_1_FS_AVL_1260_VAL,
> -					.gain =3D ST_PRESS_1_FS_AVL_1260_GAIN,
> -					.gain2 =3D ST_PRESS_1_FS_AVL_TEMP_GAIN,
> +					.value =3D ST_PRESS_LPS331AP_FS_AVL_1260_VAL,
> +					.gain =3D ST_PRESS_LPS331AP_FS_AVL_1260_GAIN,
> +					.gain2 =3D ST_PRESS_LPS331AP_FS_AVL_TEMP_GAIN,
>   				},
>   			},
>   		},
>   		.bdu =3D {
> -			.addr =3D ST_PRESS_1_BDU_ADDR,
> -			.mask =3D ST_PRESS_1_BDU_MASK,
> +			.addr =3D ST_PRESS_LPS331AP_BDU_ADDR,
> +			.mask =3D ST_PRESS_LPS331AP_BDU_MASK,
>   		},
>   		.drdy_irq =3D {
> -			.addr =3D ST_PRESS_1_DRDY_IRQ_ADDR,
> -			.mask =3D ST_PRESS_1_DRDY_IRQ_MASK,
> +			.addr =3D ST_PRESS_LPS331AP_DRDY_IRQ_ADDR,
> +			.mask =3D ST_PRESS_LPS331AP_DRDY_IRQ_MASK,
>   		},
> -		.multi_read_bit =3D ST_PRESS_1_MULTIREAD_BIT,
> +		.multi_read_bit =3D ST_PRESS_LPS331AP_MULTIREAD_BIT,
>   		.bootime =3D 2,
>   	},
>   };
