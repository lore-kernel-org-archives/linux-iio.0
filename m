Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>, "arnd@arndb.de" <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 4 Sep 2013 22:17:50 +0200
Subject: Re: [PATCH 08/11] iio: pressure-core: st: Allow for number of
 channels to vary
Message-ID: <5227956E.2050607@st.com>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-9-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378287103-21765-9-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Acked-by: Denis Ciocca <denis.ciocca@st.com>
> At the moment the number of channels specified is dictated by the first
> sensor supported by the driver. As we add support for more sensors this
> is likely to vary. Instead of using the ARRAY_SIZE() of the LPS331AP's
> channel specifier we'll use a new adaptable 'struct st_sensors' element
> instead.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/iio/pressure/st_pressure_core.c | 3 ++-
>   include/linux/iio/common/st_sensors.h   | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressu=
re/st_pressure_core.c
> index 423ed6a..3cf54ed 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -101,6 +101,7 @@ static const struct st_sensors st_press_sensors[] =3D=
 {
>   			[0] =3D LPS331AP_PRESS_DEV_NAME,
>   		},
>   		.ch =3D (struct iio_chan_spec *)st_press_lsp331ap_channels,
> +		.num_ch =3D ARRAY_SIZE(st_press_lsp331ap_channels),
>   		.odr =3D {
>   			.addr =3D ST_PRESS_LPS331AP_ODR_ADDR,
>   			.mask =3D ST_PRESS_LPS331AP_ODR_MASK,
> @@ -237,7 +238,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>   	pdata->num_data_channels =3D ST_PRESS_NUMBER_DATA_CHANNELS;
>   	pdata->multiread_bit =3D pdata->sensor->multi_read_bit;
>   	indio_dev->channels =3D pdata->sensor->ch;
> -	indio_dev->num_channels =3D ARRAY_SIZE(st_press_lsp331ap_channels);
> +	indio_dev->num_channels =3D pdata->sensor->num_ch;
>  =20
>   	if (pdata->sensor->fs.addr !=3D 0)
>   		pdata->current_fullscale =3D (struct st_sensor_fullscale_avl *)
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/co=
mmon/st_sensors.h
> index 72b2694..4aef925 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -180,6 +180,7 @@ struct st_sensors {
>   	u8 wai;
>   	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
>   	struct iio_chan_spec *ch;
> +	int num_ch;
>   	struct st_sensor_odr odr;
>   	struct st_sensor_power pw;
>   	struct st_sensor_axis enable_axis;
