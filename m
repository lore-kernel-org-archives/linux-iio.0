Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:3500
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754398AbcLURiA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Dec 2016 12:38:00 -0500
From: "Cercueil, Paul" <Paul.Cercueil@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH libiio] iio-monitor: Set locale before parsing double
 values from sysfs
Date: Wed, 21 Dec 2016 17:04:13 +0000
Message-ID: <1482339839.2295.0.camel@analog.com>
References: <1482329388-12376-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1482329388-12376-1-git-send-email-geert@linux-m68k.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="=-JrzIUeLzoJ1rZmLWzVUo"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--=-JrzIUeLzoJ1rZmLWzVUo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Le mercredi 21 d=C3=A9cembre 2016 =C3=A0 15:09 +0100, Geert Uytterhoeven a
=C3=A9crit=C2=A0:
> strtod() uses the current locale when parsing numbers, while all
> values
> in sysfs use the "C" locale.=C2=A0=C2=A0Hence the former may expect a com=
ma as
> the
> radix character, while the latter always uses a decimal point,
> leading
> to the display of incorrect values.
>=20
> Temporarily switch to the "C" locale before parsing double numbers to
> fix this.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> =C2=A0examples/iio-monitor.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/examples/iio-monitor.c b/examples/iio-monitor.c
> index 8b632187829869ae..558c0f33a36ef7b9 100644
> --- a/examples/iio-monitor.c
> +++ b/examples/iio-monitor.c
> @@ -21,6 +21,7 @@
> =C2=A0#define _DEFAULT_SOURCE
> =C2=A0
> =C2=A0#include <cdk/cdk.h>
> +#include <locale.h>
> =C2=A0#include <pthread.h>
> =C2=A0#include <stdbool.h>
> =C2=A0#include <unistd.h>
> @@ -61,9 +62,13 @@ static bool is_valid_channel(struct iio_channel
> *chn)
> =C2=A0
> =C2=A0static double get_channel_value(struct iio_channel *chn)
> =C2=A0{
> +	char *old_locale;
> =C2=A0	char buf[1024];
> =C2=A0	double val;
> =C2=A0
> +	old_locale =3D strdup(setlocale(LC_NUMERIC, NULL));
> +	setlocale(LC_NUMERIC, "C");
> +
> =C2=A0	if (channel_has_attr(chn, "input")) {
> =C2=A0		iio_channel_attr_read(chn, "input", buf,
> sizeof(buf));
> =C2=A0		val =3D strtod(buf, NULL);
> @@ -82,6 +87,9 @@ static double get_channel_value(struct iio_channel
> *chn)
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> +	setlocale(LC_NUMERIC, old_locale);
> +	free(old_locale);
> +
> =C2=A0	return val / 1000.0;
> =C2=A0}
> =C2=A0

Applied. Thanks!

-Paul
--=-JrzIUeLzoJ1rZmLWzVUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEGbFCOixy2Cq633QzA8i1+8SbJU4FAlhatgAACgkQA8i1+8Sb
JU5/KggAvhV7Gfnd+TCgl0gT+VRp4u1iZS8QvjOu0oydFt7bEKqPQXI2/xoUIcbk
CHdBDe/aIuF3oqURHm7tfyXRm9f9y4ei2ype/nHV7rpsHBEOcVgWxB5fapq4FA58
vad8hwWcmmmSFqZ4jBQ3eY7lOizb+urZASMPcIqR7XZynJQ/e3Kw51aDKsn2+isY
rU4hfTpvcziHltLdCdwOVV2UwDxF83Bqzs45e0HSmbV/CXqCSV3Ck7pBLYFUcwmz
ft8eHxuxdI5NHOuI/izQu7TesUIHZowVhrCYYHUPoZWxdQnY3hG6+2qWvxF9euzx
sScE3m7Fd6gdKlvfZvo8l/j2rJayvw==
=UVkd
-----END PGP SIGNATURE-----

--=-JrzIUeLzoJ1rZmLWzVUo--
