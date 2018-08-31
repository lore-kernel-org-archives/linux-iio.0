Return-Path: <SRS0=ftCP=LO=bootlin.com=maxime.ripard@kernel.org>
Date: Fri, 31 Aug 2018 10:50:00 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
	wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	eugen.hristev@microchip.com, rdunlap@infradead.org,
	vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
	quentin.schulz@bootlin.com, geert+renesas@glider.be,
	lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de, broonie@kernel.org,
	arnaud.pouliquen@st.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 16/30] iio: adc: sun4i-gpadc-iio: rework: readout
 temp_data
Message-ID: <20180831085000.xsqliawn7yl7l3ax@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-17-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jkngr6m62mzqnlxs"
In-Reply-To: <20180830154518.29507-17-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--jkngr6m62mzqnlxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:45:04PM +0200, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
>=20
> This commit reworks the code and uses regmap field to read out
> temp_data.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index d48f338af563..c278e165e161 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -63,6 +63,7 @@ struct gpadc_data {
>  	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
>  	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
>  	bool		support_irq;
> +	u32		temp_data_base;
>  };
> =20
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> @@ -77,6 +78,7 @@ static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.adc_channel =3D true,
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
> +	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
>  };
> =20
>  static const struct gpadc_data sun5i_gpadc_data =3D {
> @@ -89,6 +91,7 @@ static const struct gpadc_data sun5i_gpadc_data =3D {
>  	.adc_channel =3D true,
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
> +	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
>  };
> =20
>  static const struct gpadc_data sun6i_gpadc_data =3D {
> @@ -101,12 +104,14 @@ static const struct gpadc_data sun6i_gpadc_data =3D=
 {
>  	.adc_channel =3D true,
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
> +	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
>  };
> =20
>  static const struct gpadc_data sun8i_a33_gpadc_data =3D {
>  	.temp_offset =3D -1662,
>  	.temp_scale =3D 162,
>  	.tp_mode_en =3D SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
> +	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
>  };
> =20
>  struct sun4i_gpadc_iio {
> @@ -271,18 +276,18 @@ static int sun4i_gpadc_temp_read(struct iio_dev *in=
dio_dev, int *val)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(indio_dev);
> =20
> -	if (!info->data->support_irq) {
> -		pm_runtime_get_sync(indio_dev->dev.parent);
> +	if (info->data->adc_channel)
> +		return sun4i_gpadc_read(indio_dev, 0, val,
> +				SUN4I_GPADC_IRQ_TEMP_DATA);
> =20
> -		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
> +	pm_runtime_get_sync(indio_dev->dev.parent);
> =20
> -		pm_runtime_mark_last_busy(indio_dev->dev.parent);
> -		pm_runtime_put_autosuspend(indio_dev->dev.parent);
> +	regmap_read(info->regmap, info->data->temp_data_base, val);
> =20
> -		return 0;
> -	}
> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
> =20
> -	return sun4i_gpadc_read(indio_dev, 0, val, SUN4I_GPADC_IRQ_TEMP_DATA);
> +	return 0;

You should make this patch as small as possible. If you want to add a
variable and to invert a condition, please make two patches.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jkngr6m62mzqnlxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJATcACgkQ0rTAlCFN
r3TmRA/7BZRdqW1fuuJcCTNnN4ULk4kjeGI7qXkXKcLpPupSpn1sZLFvFpAI+7xB
OJ/fU/9/SjA4CVHy97yxSFv6MM9d56y4wJnA1vCJ/J9ujizaDq1comvWRDjVLm1Z
Sfh6cfz32zclCU/G5c19Cioy+sbACNBf/De+yuVJUMxbzIjN0ZsHz0mt5zww99eN
fvB7j4P5soQ07KH0YMavQ52dkqr7tKjFhGbzc+P8Rohq9hkmbfOn3MKzmYJ9vtSj
Uwmn0u3Rw97YVkmD9JSC9YeLuwdMGVAfmFKgQebi1icv2pCaX70x0V3Aij8dlGUw
z5m+lZMEQ9RiI0l3//BupsYZlHZ3USI4OsxNnZ9BrHVrEFlD8MF5/RruyxXEHE5b
DVyDS+y/yYcR1CAfn0MqGHymQjHSL6ptN6ASmqqXbXu2hY9eOJJdjmYti5U+iheD
Pzwn6qkeHs4XQZpqtvOXTV0KhbwlHDEfA9ocg+IUuG3onvByj2eqKAgNB7SwlCir
Gwf9SogT6OYZxJJPxPytgQylYq7j+6Ky6Kp6Z4iA9/ddIeoEsOe5RYwTvp9+yw1A
RYJONkP6+2NJmCWwxJBIJJzwBt0s/ZGgIXbtprwplrUWnQjPKSpSLy0FmJmLJJX9
B59ljIBuIGbGfc/U9nIXbMt03ZsspjmeMGGxQTBz35i6WHmCPKA=
=h3FO
-----END PGP SIGNATURE-----

--jkngr6m62mzqnlxs--
