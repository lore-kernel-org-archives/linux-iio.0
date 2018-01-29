Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:48:03 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
	wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
	rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
	krzk@kernel.org, quentin.schulz@free-electrons.com, icenowy@aosc.io,
	edu.molinas@gmail.com, singhalsimran0@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 10/16] iio: adc: sun4i-gpadc-iio: add support for A83T
 thermal sensor
Message-ID: <20180129094803.uiojqkmaeuihbe4p@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-11-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ozpu4j2zvyx5qod2"
In-Reply-To: <20180128232919.12639-11-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--ozpu4j2zvyx5qod2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 12:29:13AM +0100, Philipp Rossak wrote:
> This patch adds support for the A83T ths sensor.
>=20
> The A83T supports interrupts. The interrupt is configured to update the
> the sensor values every second.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 38 +++++++++++++++++++++++++++++++++=
+++++
>  include/linux/mfd/sun4i-gpadc.h   | 18 ++++++++++++++++++
>  2 files changed, 56 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 8196203d65fe..9f7895ba1966 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -170,6 +170,40 @@ static const struct gpadc_data sun8i_h3_ths_data =3D=
 {
>  		SUN8I_H3_THS_TEMP_PERIOD(0x7),
>  };
> =20
> +static const struct gpadc_data sun8i_a83t_ths_data =3D {
> +	.temp_offset =3D -2724,
> +	.temp_scale =3D -70,
> +	.temp_data =3D {SUN8I_H3_THS_TDATA0,
> +		SUN8I_A83T_THS_TDATA1,
> +		SUN8I_A83T_THS_TDATA2,
> +		0},
> +	.sample_start =3D sunxi_ths_sample_start,
> +	.sample_end =3D sunxi_ths_sample_end,
> +	.sensor_count =3D 3,
> +	.supports_nvmem =3D false,
> +	.support_irq =3D true,
> +	.ctrl0_map =3D SUN4I_GPADC_CTRL0_T_ACQ(0x1f3),
> +	.ctrl2_map =3D SUN8I_H3_THS_ACQ1(0x1f3),

Where are these values coming from?

> +	.sensor_en_map =3D SUN8I_H3_THS_TEMP_SENSE_EN0 |
> +		SUN8I_A83T_THS_TEMP_SENSE_EN1 |
> +		SUN8I_A83T_THS_TEMP_SENSE_EN2,
> +	.filter_map =3D SUN4I_GPADC_CTRL3_FILTER_EN |
> +		SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2),
> +	.irq_clear_map =3D SUN8I_H3_THS_INTS_ALARM_INT_0 |
> +		SUN8I_A83T_THS_INTS_ALARM_INT_1 |
> +		SUN8I_A83T_THS_INTS_ALARM_INT_2 |
> +		SUN8I_H3_THS_INTS_SHUT_INT_0  |
> +		SUN8I_A83T_THS_INTS_SHUT_INT_1  |
> +		SUN8I_A83T_THS_INTS_SHUT_INT_2  |
> +		SUN8I_H3_THS_INTS_TDATA_IRQ_0 |
> +		SUN8I_A83T_THS_INTS_TDATA_IRQ_1 |
> +		SUN8I_A83T_THS_INTS_TDATA_IRQ_2,

Do you reall need to clear all these interrupts if you're using only
one?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ozpu4j2zvyx5qod2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu7dIACgkQ0rTAlCFN
r3SzHQ//cf3j7ovwfUUDuTMyP8Xpd9isOIXAKfyEuRZb6Q6vvAHQ02QyEktfl7Iu
SGiQUWNhvVGE0oRVQz2FMm0VOKA3p08mxt3CGsb77+sN3PfuJTNagqJ94wewtPWv
hafbnU08IX2+1PfeatyE4fTtwEhVv6az8sXoC/xQ4w5bXglAAggUKmjbPbM3ovo+
sdy54elboSvHXGuNLVSnf7dMoGvspHdB83r1rd6bG92U8BYmGnmsrPXZ/DDTvKW2
tskz21RKB9gSMzqX3A10bVKS+vgNGPA611+OcqH5JYpp7KnACdTr2Oc1Mc7SmnqH
eR8GUGMfNdKEwcJbIDxzBnbaaXrPAWPs2oug2sXLqu9Rx5Qzlt3HS6WUQOa/hgdr
CEdPUJ82ht6Cz42bZX9snsYegwhw3U7OF6W4pYWb8HIDTUX6d5MdC0RaAKMXSUgd
SBWxUOWRE2BTEykfR8vbujs7kLCO7tb9fneeHVhurdmDrfW4QX0gJdOCMsfCv9iM
zK76FM02Knt8lMwm+jeKea0wA7dVx1rEW/DAuLs0hVFvC94P4ALwqGqKh24GbKps
3oS1nwXoGPmBgxoPrWrag3et2dPYyCNCz0ViJ2R3XQKQHttDtDmrBLDFa9qPZhBy
ygsFQ+mGVeBehMiBEwgALrP2R+3riuI8yPfm37mpKv1cdS1ptPc=
=vDYk
-----END PGP SIGNATURE-----

--ozpu4j2zvyx5qod2--
