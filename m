Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>, "arnd@arndb.de" <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 4 Sep 2013 22:15:45 +0200
Subject: Re: [PATCH 06/11] iio: pressure-core: st: Expand and rename
 LPS331AP's channel descriptor
Message-ID: <522794F1.90301@st.com>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-7-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378287103-21765-7-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> Due to the MACRO used, the task of reading, understanding and maintaining
> the LPS331AP's channel descriptor is substantially difficult. This patch
> is based on the view that it's better to have easy to read, maintainable
> code than to save a few lines here and there. For that reason we're
> expanding the array so initialisation is completed in full.
Also for this one, the channel names are general and can be shared=20
between different sensors. For the channel definition it's not a problem=20
for me, but I think it's not necessary adds all that code...

Denis

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/iio/pressure/st_pressure_core.c | 45 +++++++++++++++++++++++++-=
-------
>   1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressu=
re/st_pressure_core.c
> index becfb25..7ba9299 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -58,16 +58,39 @@
>   #define ST_PRESS_LPS331AP_OUT_XL_ADDR		0x28
>   #define ST_TEMP_LPS331AP_OUT_L_ADDR		0x2b
>  =20
> -static const struct iio_chan_spec st_press_channels[] =3D {
> -	ST_SENSORS_LSM_CHANNELS(IIO_PRESSURE,
> +static const struct iio_chan_spec st_press_lsp331ap_channels[] =3D {
> +	{
> +		.type =3D IIO_PRESSURE,
> +		.channel2 =3D IIO_NO_MOD,
> +		.address =3D ST_PRESS_LPS331AP_OUT_XL_ADDR,
> +		.scan_index =3D ST_SENSORS_SCAN_X,
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 24,
> +			.storagebits =3D 24,
> +			.endianness =3D IIO_LE,
> +		},
> +		.info_mask_separate =3D
>   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> -			ST_SENSORS_SCAN_X, 0, IIO_NO_MOD, 'u', IIO_LE, 24, 24,
> -			ST_PRESS_LPS331AP_OUT_XL_ADDR),
> -	ST_SENSORS_LSM_CHANNELS(IIO_TEMP,
> -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
> -						BIT(IIO_CHAN_INFO_OFFSET),
> -			-1, 0, IIO_NO_MOD, 's', IIO_LE, 16, 16,
> -			ST_TEMP_LPS331AP_OUT_L_ADDR),
> +		.modified =3D 0,
> +	},
> +	{
> +		.type =3D IIO_TEMP,
> +		.channel2 =3D IIO_NO_MOD,
> +		.address =3D ST_TEMP_LPS331AP_OUT_L_ADDR,
> +		.scan_index =3D -1,
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 16,
> +			.storagebits =3D 16,
> +			.endianness =3D IIO_LE,
> +		},
> +		.info_mask_separate =3D
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OFFSET),
> +		.modified =3D 0,
> +	},
>   	IIO_CHAN_SOFT_TIMESTAMP(1)
>   };
>  =20
> @@ -77,7 +100,7 @@ static const struct st_sensors st_press_sensors[] =3D =
{
>   		.sensors_supported =3D {
>   			[0] =3D LPS331AP_PRESS_DEV_NAME,
>   		},
> -		.ch =3D (struct iio_chan_spec *)st_press_channels,
> +		.ch =3D (struct iio_chan_spec *)st_press_lsp331ap_channels,
>   		.odr =3D {
>   			.addr =3D ST_PRESS_LPS331AP_ODR_ADDR,
>   			.mask =3D ST_PRESS_LPS331AP_ODR_MASK,
> @@ -214,7 +237,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>   	pdata->num_data_channels =3D ST_PRESS_NUMBER_DATA_CHANNELS;
>   	pdata->multiread_bit =3D pdata->sensor->multi_read_bit;
>   	indio_dev->channels =3D pdata->sensor->ch;
> -	indio_dev->num_channels =3D ARRAY_SIZE(st_press_channels);
> +	indio_dev->num_channels =3D ARRAY_SIZE(st_press_lsp331ap_channels);
>  =20
>   	pdata->current_fullscale =3D (struct st_sensor_fullscale_avl *)
>   						&pdata->sensor->fs.fs_avl[0];
