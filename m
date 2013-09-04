Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>, "arnd@arndb.de" <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 4 Sep 2013 22:17:09 +0200
Subject: Re: [PATCH 07/11] iio: sensors-core: st: Allow full-scale to be an
 optional feature
Message-ID: <52279545.5070903@st.com>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-8-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378287103-21765-8-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Acked-by: Denis Ciocca <denis.ciocca@st.com>
> Some chips either don't support it or fail to provide adequate documentat=
ion,
> so sometimes it's impossible to enable the feature even if it is supporte=
d.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/iio/common/st_sensors/st_sensors_core.c | 11 +++++++----
>   drivers/iio/pressure/st_pressure_core.c         |  6 ++++--
>   2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/ii=
o/common/st_sensors/st_sensors_core.c
> index 865b178..fc9acb7 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -209,10 +209,13 @@ int st_sensors_init_sensor(struct iio_dev *indio_de=
v)
>   	if (err < 0)
>   		goto init_error;
>  =20
> -	err =3D st_sensors_set_fullscale(indio_dev,
> -						sdata->current_fullscale->num);
> -	if (err < 0)
> -		goto init_error;
> +	if (sdata->current_fullscale) {
> +		err =3D st_sensors_set_fullscale(indio_dev,
> +					       sdata->current_fullscale->num);
> +		if (err < 0)
> +			goto init_error;
> +	} else
> +		dev_info(&indio_dev->dev, "Full-scale not possible\n");
>  =20
>   	err =3D st_sensors_set_odr(indio_dev, sdata->odr);
>   	if (err < 0)
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressu=
re/st_pressure_core.c
> index 7ba9299..423ed6a 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -239,8 +239,10 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>   	indio_dev->channels =3D pdata->sensor->ch;
>   	indio_dev->num_channels =3D ARRAY_SIZE(st_press_lsp331ap_channels);
>  =20
> -	pdata->current_fullscale =3D (struct st_sensor_fullscale_avl *)
> -						&pdata->sensor->fs.fs_avl[0];
> +	if (pdata->sensor->fs.addr !=3D 0)
> +		pdata->current_fullscale =3D (struct st_sensor_fullscale_avl *)
> +			&pdata->sensor->fs.fs_avl[0];
> +
>   	pdata->odr =3D pdata->sensor->odr.odr_avl[0].hz;
>  =20
>   	err =3D st_sensors_init_sensor(indio_dev);
