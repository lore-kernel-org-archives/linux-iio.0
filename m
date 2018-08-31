Return-Path: <SRS0=ftCP=LO=bootlin.com=maxime.ripard@kernel.org>
Date: Fri, 31 Aug 2018 11:09:15 +0200
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
Subject: Re: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device
 specific suspend & resume
Message-ID: <20180831090915.agbldint76ngj5jf@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-21-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z37k4t7jsyhjydbp"
In-Reply-To: <20180830154518.29507-21-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--z37k4t7jsyhjydbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:45:08PM +0200, Philipp Rossak wrote:
> Different sensors will have different suspend and resume functions. So
> we are modularize the suspend and resume functions.
>=20
> The resume function configures and initializes the thermal sensor and
> the suspend function disables the sensors.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 2fd73d143815..c7b46c82e3e5 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -76,6 +76,9 @@ struct gpadc_data {
> =20
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> =20
> +static int sun4i_ths_resume(struct sun4i_gpadc_iio *info);
> +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info);
> +
>  static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.temp_offset =3D -1932,
>  	.temp_scale =3D 133,
> @@ -87,6 +90,8 @@ static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
>  	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
> +	.ths_resume =3D sun4i_ths_resume,
> +	.ths_suspend =3D sun4i_ths_suspend,
>  	.sensor_count =3D 1,
>  };
> =20
> @@ -101,6 +106,8 @@ static const struct gpadc_data sun5i_gpadc_data =3D {
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
>  	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
> +	.ths_resume =3D sun4i_ths_resume,
> +	.ths_suspend =3D sun4i_ths_suspend,
>  	.sensor_count =3D 1,
>  };
> =20
> @@ -115,6 +122,8 @@ static const struct gpadc_data sun6i_gpadc_data =3D {
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
>  	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
> +	.ths_resume =3D sun4i_ths_resume,
> +	.ths_suspend =3D sun4i_ths_suspend,
>  	.sensor_count =3D 1,
>  };
> =20
> @@ -123,6 +132,8 @@ static const struct gpadc_data sun8i_a33_gpadc_data =
=3D {
>  	.temp_scale =3D 162,
>  	.tp_mode_en =3D SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
>  	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
> +	.ths_resume =3D sun4i_ths_resume,
> +	.ths_suspend =3D sun4i_ths_suspend,
>  	.sensor_count =3D 1,
>  };
> =20
> @@ -401,6 +412,11 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int =
irq, void *dev_id)
>  static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(dev_get_drvdata(dev));
> +	return info->data->ths_suspend(info);
> +}
> +
> +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)

suspend is already a hook in the kernel, which hasn't the same meaning
than runtime_suspend (and the same applies to resume), so we'd rather
pick a better name. And all the functions (and the driver) use gpadc,
please continue to use that prefix.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--z37k4t7jsyhjydbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJBboACgkQ0rTAlCFN
r3RzUA//UXRWu6QAJniE4rnihCbGG3G3Ko/GuCYAHX2FXDoCBFJgG3jeK1vIKeNX
eqqnkFTrBvFjDejRgF8pulukNP+M3v14FNOYYalLIjoGw/pSQvqo61/2jHqnbZmx
jNT2JOubyzjRvszALoCCQd9szOc/UKugK9aAk3HQ1iD2Jamfd5Xy694BjJJHb4pl
tOuMoUncpAZo4Lda0/VqXKF7HUNFAGzlX3x2PceA9/D9Xo4lw5MKO+az6d4/I9wV
Ntm5lVVoeZkaFeKFOTZ4+vFp2xXFlxDhpRwsuTvz51edNf0FG2nQSQYOMdo3BPQc
9gQZ/OoJJk2wKDop+AMjuUE0mLqQTHKL8mp18bMrpBOXl6P5tSIT06MdH/zG/xSs
YtjTrzjOsnEsGjzAL/rRMGpL+9kZCENVX/ulAVyDH/Dd5VOWKfANRpCHbYWIJ9oz
DyeY3Pxdwhv0djZUWFLMhOtR3xF89BmMawq2lv/us3l+LnF/72vRFw/rFyLfQ2hW
aFcK3jZfpRXjE2iEr7SF3X+hu/PA40hEAG62zgx48mGv+z67hnw1Me6viht4PApX
1iOEBNQWfuADV940EJWSVDFiI+r1O3pAlHci+KU7D7s9gltp6+3tQcOJMlFKLsNS
OvvpOjA99HuKjTSWPe5j2/auZyCnq55veWdYjO4XhdRASoUiDcg=
=KOJG
-----END PGP SIGNATURE-----

--z37k4t7jsyhjydbp--
