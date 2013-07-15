Return-Path: <maxime.ripard@free-electrons.com>
Date: Mon, 15 Jul 2013 15:06:10 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com
Subject: Re: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
Message-ID: <20130715130610.GD2962@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
In-Reply-To: <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
List-ID: <linux-iio@vger.kernel.org>


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Sun, Jul 14, 2013 at 04:04:28PM +0800, Josh Wu wrote:
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |    2 ++
>  drivers/iio/adc/at91_adc.c                          |    8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Docume=
ntation/devicetree/bindings/arm/atmel-adc.txt
> index 16769d9..0db2945 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -27,6 +27,8 @@ Optional properties:
>  		       resolution will be used.
>    - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
>    - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
> +  - atmel,adc-clock-rate: ADC clock rate. If not specified, use the defa=
ult
> +			  adc_op_clk.
>  =20
>  Optional trigger Nodes:
>    - Required properties:
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index e93a075..8f1386f 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -47,6 +47,7 @@ struct at91_adc_caps {
> =20
>  struct at91_adc_state {
>  	struct clk		*adc_clk;
> +	u32			adc_clk_rate;
>  	u16			*buffer;
>  	unsigned long		channels_mask;
>  	struct clk		*clk;
> @@ -448,6 +449,10 @@ static int at91_adc_probe_dt(struct at91_adc_state *=
st,
>  	if (!node)
>  		return -EINVAL;
> =20
> +	prop =3D 0;
> +	of_property_read_u32(node, "atmel,adc-clock-rate", &prop);
> +	st->adc_clk_rate =3D prop;
> +
>  	st->use_external =3D of_property_read_bool(node, "atmel,adc-use-externa=
l-triggers");
> =20
>  	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
> @@ -723,7 +728,8 @@ static int at91_adc_probe(struct platform_device *pde=
v)
>  	 * specified by the electrical characteristics of the board.
>  	 */
>  	mstrclk =3D clk_get_rate(st->clk);
> -	adc_clk =3D clk_get_rate(st->adc_clk);
> +	adc_clk =3D st->adc_clk_rate ?
> +		st->adc_clk_rate : clk_get_rate(st->adc_clk);

Why is that needed? Isn't it completely redundant with the clocks
property?

Maxime


--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR4/PCAAoJEBx+YmzsjxAgRDoQAIC6uKrDKWkO2RXBAY4P2yex
9pt4hdXxwRKcHF+jceKlTgyKYxQ7PL90fObElYHcdUtw926jZNhZ+VzHT+sYwIdm
agpd9QVN0H4Ae0+8AlTbF+Z8VBqOjgEbdzNMx4bXTHVoa5zzu3WomzCJGerofqRL
r12AoxlzQKwublN/V0P3fcCo3NR/VZETerKHRXp9BFKzh1uLDAQrbhfcIU5K+Lr+
3PalKIdUYdn1EnoWxNG8nyQIaF2/56kwu9Opx/3G0BS3hGUryGNSKqwVFKTuwxtp
/jBz6tDQqUDA2ea7Yixqvr3ZRi3Bsn21vrBpUWSonN1GqdAcoiYAZWQleTsrrh+d
CF3ZCDcyEmETx8nsd/asl6qvTaEuz47MndIctQKR7/wQXiinlEN5EHt9fvYQ4wbp
arJQTjS3u3ybp9D2AjlKmZM7oY281e+aT9nESaNLS4STR/ltw3Zf0b4cZKWR54o0
+JH6oWhJSnnHrYhrujCl6g8QQnyQkUuVCxJ6BBuuLvd6ICnNglFB9b74/YgrxwNl
xoL6gvgYDVjOEMOoY5AdIkDqRrR/h3t5/C6VCUdWZpSx8TKl+prnitCxyjleu5Pg
2p/EjPMdxt5m030Mq8tLjrADYiYZYXL6j4Cjua8UUik+avWH+jZakh2LwIMpPIl8
clzVOrUsnCkOFgSE8OSn
=FqXb
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
