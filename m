Return-Path: <SRS0=mnfY=MN=the-dreams.de=wsa@kernel.org>
Date: Mon, 1 Oct 2018 14:17:40 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-iio@vger.kernel.org, Marek Vasut <marek.vasut+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@kernel.org>,
	Simon Horman <horms+renesas@verge.net.au>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix Renesas GyroADC MAINTAINERS entry
Message-ID: <20181001121739.GB4134@kunai>
References: <20181001105804.17802-1-marek.vasut+renesas@gmail.com>
 <20181001115559.GA4134@kunai>
 <bc65ecfa-5135-5224-bdeb-938b3025c30c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
In-Reply-To: <bc65ecfa-5135-5224-bdeb-938b3025c30c@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 01:58:26PM +0200, Marek Vasut wrote:
> On 10/01/2018 01:55 PM, Wolfram Sang wrote:
> > On Mon, Oct 01, 2018 at 12:58:04PM +0200, Marek Vasut wrote:
> >> Fix the F: entry in MAINTAINERS file, point it to the correct file.
> >=20
> > Right...
> >=20
> >> @@ -12471,7 +12471,7 @@ RENESAS R-CAR GYROADC DRIVER
> >>  M:	Marek Vasut <marek.vasut@gmail.com>
> >>  L:	linux-iio@vger.kernel.org
> >>  S:	Supported
> >> -F:	drivers/iio/adc/rcar_gyro_adc.c
> >> +F:	drivers/iio/adc/rcar-gyroadc.c
> >=20
> > Add the bindings, too?
> >=20
> > Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
> >=20
> Separate patch or V2 ?

I'd say V2, but I am not the IIO maintainer.


--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluyEGMACgkQFA3kzBSg
KbZl8w/+L6zP2tsr093R00TExehP3GPImEGwxd2FbH6LUWxctVwn9R7GhIHhHn3A
OIvaJ6A35NBDYtDbtqytKXzUWGTAV6PT+OuPqBZ9n235VBxqD50zUjHhUdc3nf4o
TCAxKFl+fSNS8CIfEgzkEetvz3W4Yt9axiTgIKyPUbsI8LjapIdsuMvM6rfuMtVi
WCChBQbGA80/PwNF5K8gj3jhZzLBpNRXQveWzREVSbwcRPxi4Kz1OvnHsdSGkyxg
+iWymo9DLR+IGJhUEah87pHW+iTv7JrGcIUcyoCgVI7rjxSqtdQVnKDO0XzMwv7Y
441RUTKQ9dJc9NFOHVM8KlkpraVoeT9pVvZHTks1T7JkyLsmC6pMXGGmQvZxHcDN
Hra9CHtjbsSPxTmbgsolVambEb82vO/3DIWJjeSzxSHcJ7eVgFdPqa0OzMI6nlhI
cGcMIyaG150BjLRRnVoCN5FCHspXrepjm8B0rBhBR3oGL0l3wAYkgBUAdO3rCAwj
qqTc8jAyOq/dLgSQaUm6UEqN/hi2ymZFBiYXeA3HRs9ihKLkTgbxJ/QyXsljRMid
HJvKmrRNZznv+9rxCd7uKyVtBv56SRTMC7S+g+sTTLJy3Fhf3CMh2S8ibC8s+iAp
94Neoqh8yC4acuva9yDK0Z1YnHZeV78xi2V3pEKZX0NR0uX/wdo=
=x/8R
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
