Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0086.outbound.protection.outlook.com ([104.47.38.86]:54080
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756041AbcLURTx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Dec 2016 12:19:53 -0500
From: "Cercueil, Paul" <Paul.Cercueil@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH libiio] iio-monitor: Add support for current and power
Date: Wed, 21 Dec 2016 17:04:41 +0000
Message-ID: <1482339881.2295.1.camel@analog.com>
References: <1482329419-12442-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1482329419-12442-1-git-send-email-geert@linux-m68k.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="=-loMkCzm1ts97g5XvYGa1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--=-loMkCzm1ts97g5XvYGa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Le mercredi 21 d=C3=A9cembre 2016 =C3=A0 15:10 +0100, Geert Uytterhoeven a
=C3=A9crit=C2=A0:
> Currently iio-monitor supports temperature and voltage values only.
> Everything else is treated like a voltage.
>=20
> Add support for common values like current and power.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> =C2=A0examples/iio-monitor.c | 31 +++++++++++++++++++++++++++----
> =C2=A01 file changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/examples/iio-monitor.c b/examples/iio-monitor.c
> index 558c0f33a36ef7b9..b508049fdb5dfc3f 100644
> --- a/examples/iio-monitor.c
> +++ b/examples/iio-monitor.c
> @@ -93,6 +93,29 @@ static double get_channel_value(struct iio_channel
> *chn)
> =C2=A0	return val / 1000.0;
> =C2=A0}
> =C2=A0
> +static struct {
> +	const char *id;
> +	const char *unit;
> +} map[] =3D {
> +	{ "current",	"A" },
> +	{ "power",	"W" },
> +	{ "temp",	"=C2=B0C" },
> +	{ "voltage",	"V" },
> +	{ 0, },
> +};
> +
> +static const char *id_to_unit(const char *id)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; map[i].id; i++) {
> +		if (!strncmp(id, map[i].id, strlen(map[i].id)))
> +			return map[i].unit;
> +	}
> +
> +	return "";
> +}
> +
> =C2=A0static void * read_thd(void *d)
> =C2=A0{
> =C2=A0	struct iio_context *ctx =3D d;
> @@ -131,7 +154,7 @@ static void * read_thd(void *d)
> =C2=A0		nb_channels =3D iio_device_get_channels_count(dev);
> =C2=A0		for (i =3D 0; i < nb_channels; i++) {
> =C2=A0			const char *id;
> -			bool is_temp =3D false;
> +			const char *unit;
> =C2=A0			struct iio_channel *chn =3D
> =C2=A0				iio_device_get_channel(dev, i);
> =C2=A0			if (!is_valid_channel(chn))
> @@ -142,7 +165,7 @@ static void * read_thd(void *d)
> =C2=A0			id =3D iio_channel_get_id(chn);
> =C2=A0			if (!name)
> =C2=A0				name =3D id;
> -			is_temp =3D !strncmp(id, "temp", 4);
> +			unit =3D id_to_unit(id);
> =C2=A0
> =C2=A0			sprintf(buf, "</%u></B>%s<!B><!%u>",
> =C2=A0					BLUE, name, BLUE);
> @@ -152,8 +175,8 @@ static void * read_thd(void *d)
> =C2=A0			freeChtype(str);
> =C2=A0
> =C2=A0			sprintf(buf, "</%u></B>%.3lf %s<!B><!%u>",
> -					YELLOW,
> get_channel_value(chn),
> -					is_temp ? "=C2=B0C" : "V",
> YELLOW);
> +					YELLOW,
> get_channel_value(chn), unit,
> +					YELLOW);
> =C2=A0			str =3D char2Chtype(buf, &len, &align);
> =C2=A0			writeChtype(right, col / 2, line++,
> =C2=A0					str, HORIZONTAL, 0, len);

Applied. Thanks!

-Paul
--=-loMkCzm1ts97g5XvYGa1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEGbFCOixy2Cq633QzA8i1+8SbJU4FAlhatikACgkQA8i1+8Sb
JU6DXwf8DvV801L8wwahnUWV3vgq3XK1oJLBK/kuqWvWFuV1kbIbNq9xSTTF8LWk
csgpH/iPI/gbGWsmi8tNntrOHMEx4nJKr0tQuYT5L+UVcKdil7SOH2/Ldq6Eu1Im
x4afP0Uh2TPNsNOo4FUjZ6aNQqA6GaOHVBnnYpF0mhStkz+QQRNsS8yhQ71jkrme
qHlPlMXWtZSEfKfM3zpSVmaExYm5p/XtmfXAulSxOtsRgNEFV75EnMIyUmNlMBEq
CYD6645TO08MfRT03FN0Xp8QwPUnLQ7ySWbvZoo9gNCogorGGig14apxAoGShB6P
woJ/6d4JsYc7LiF5rtAf/KCdzQ0LzA==
=kbKi
-----END PGP SIGNATURE-----

--=-loMkCzm1ts97g5XvYGa1--
