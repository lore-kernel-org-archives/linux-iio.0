Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36501 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752094AbcBOJ7N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2016 04:59:13 -0500
From: Markus Pargmann <mpa@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Denis Carikli <denis@eukrea.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc/imx25-gcq: move incorrect do_div
Date: Mon, 15 Feb 2016 10:59:05 +0100
Message-ID: <2144249.hzmN2uUoLT@adelgunde>
In-Reply-To: <1455275748-999115-1-git-send-email-arnd@arndb.de>
References: <1455275748-999115-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2634218.TBvbGspspU"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--nextPart2634218.TBvbGspspU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Friday, February 12, 2016 12:15:29 PM Arnd Bergmann wrote:
> The newly added driver uses do_div() to device a 32-bit number, which=
 now
> provokes a warning:
>=20
> drivers/iio/adc/fsl-imx25-gcq.c: In function 'mx25_gcq_setup_cfgs':
> include/asm-generic/div64.h:207:28: warning: comparison of distinct p=
ointer types lacks a cast
>   (void)(((typeof((n)) *)0) =3D=3D ((uint64_t *)0)); \
>=20
> This replaces the do_div() call with a straight division operator.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6df2e98c3ea5 ("iio: adc: Add imx25-gcq ADC driver")

Thanks for fixing this.

Reviewed-by: Markus Pargmann <mpa@pengutronix.de>

Best Regards,

Markus

> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-im=
x25-gcq.c
> index 2fd192735d5b..72b32c1ab257 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -233,7 +233,7 @@ static int mx25_gcq_setup_cfgs(struct platform_de=
vice *pdev,
>  =09=09=09priv->channel_vref_mv[reg] =3D
>  =09=09=09=09regulator_get_voltage(priv->vref[refp]);
>  =09=09=09/* Conversion from uV to mV */
> -=09=09=09do_div(priv->channel_vref_mv[reg], 1000);
> +=09=09=09priv->channel_vref_mv[reg] /=3D 1000;
>  =09=09=09break;
>  =09=09case MX25_ADC_REFP_INT:
>  =09=09=09priv->channel_vref_mv[reg] =3D 2500;
>=20

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart2634218.TBvbGspspU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWwaFpAAoJEEpcgKtcEGQQfRcQAIVJFI91OlArtqJKb6hDvEGu
NZj6VqSfYT1ESJ1+e7OnvSF9wqgObbqWCHeX6zfKR5DD12/1sw1eZRqOymV95dpQ
vEyGywA7RLfYL/mVaTbGgmhQfwKUELcfECpgsDT/UfddDuZPMEU0+1W6VAdt+jFB
3Lukgmld2jTg0P1ba/+ohR0+9RyFgaflwMOK84jh+H//P6z13LrYdfdB7qBrie1D
AD1UbLQaK1yGls7a6tl1bM3NDgcdSCiZnEB+fBnNC6ZxjItTnbw+KCOcbAJEaeJh
Ber9kzN4mZqfXVB93mdYzlLhjdRSaf66Z13QmGLciMiX9aQIuNIHU9m0K1q+/Ncb
N4LJmIrLpLMX8KD7AXmR4l871jwf+vCendZB9TXALVpG7cL211bXbuf9zRNIhbjv
sEAA+W+SAFbcfnrJLO4VUZibrtG0Df5WpGRTZf8VRJek6hmA7AHeUggBFVJHmQRH
DUs4LVvH5u2R5RaiYJEmjA4NbcIoQM7fICj5fx39o36dmyilByKmOxf/Y1oD/eiC
4pN2nnwsdjWlWOAY1Evr6CDWJsbXs05JsZyY4aH4FMc9QN+4DrZn5Y4h+KHZC9wd
Klw2trjFwSK2mudEiitgg5rH9QEiwDzI+Yuv8zROZT7rvvVbvT8QpLzZnogQYx60
HrxpigGTNsw5Z132PQup
=1fzT
-----END PGP SIGNATURE-----

--nextPart2634218.TBvbGspspU--

