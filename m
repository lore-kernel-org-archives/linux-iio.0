Return-Path: <broonie@sirena.org.uk>
Date: Wed, 12 Feb 2014 16:10:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Harald Geyer <harald@ccbib.org>, linux-iio@vger.kernel.org,
	Marek Vasut <marex@denx.de>, Liam Girdwood <lgirdwood@gmail.com>
Message-ID: <20140212161046.GC28112@sirena.org.uk>
References: <E1W895a-0000yo-Tm@stardust.g4.wien.funkfeuer.at>
 <52F61C2A.90101@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bc2iwAtkAaXP8cWF"
In-Reply-To: <52F61C2A.90101@kernel.org>
Subject: Re: [RFC] iio: mxs-lradc: Add support for current source
List-ID: <linux-iio@vger.kernel.org>


--bc2iwAtkAaXP8cWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 08, 2014 at 11:59:38AM +0000, Jonathan Cameron wrote:
> On 28/01/14 13:52, Harald Geyer wrote:

> >The LRADC can drive two of its ADC channels with a defined current
> >between 0 and 300uA to allow reading thermistors without external
> >current source. I'm not sure what the right IIO ABI in this case

> I'd be tempted to do this via the regulator framework instead of IIO.
> At somepoint we could have a bridge to allow an iio interface on a regulator
> if anyone wants it (you never know)

I'm very worried about the idea of an ABI - if IIO wants to offer
something that is implemented using the regulator API that's fine but
doing it directly from the regulator API sounds worrying.

> I guess the main advantage in doing it in IIO would be to keep stuff in
> one logical group.  Still they might just as easily be using an external
> regulator to drive thermistors so using the regulator framework would be
> more consistent...

The current that's driven seems more a property of the thermistor than
of the regulator if it is a generic regulator.

--bc2iwAtkAaXP8cWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+50DAAoJELSic+t+oim9JPgP/R8rlyAv7wVIAKUYa5dpZHOh
W7sS+H4UZezrSEo+khD4KAQxQtogXv2xBmNCMM4E+5/M77eZ0PCrfpH+uCcdMQVX
uBPRXx44GFHgCy5QHo3BpkCBlBPISZVnC2ofGA0n0iUUaIw6hpvUg+yefL1LLlY0
ImtpvhpHWlM3V+A8K9kkbNOhrWIclp/XMicvOa9bJZTOAPUx2PJ1nxuFcgyQPNd4
n/pUGVxeBZnVDfFUOsc6CbH+lEruT/9YEmQ6HgAo27E3C0fZzjCpYayX2Y+05c1M
YzCIzJRIbIDFQq23PN7W4XKvIehA2z6PM8sJZUjHBU+RaW0vnNWd+orSJZawWT/o
L7oxghNUdqP3r6buoRuLfaXhgDGlqD4xXs2QUTFC1HGDgmd6xYoG0UAjItdJEoju
k0byamnrs1L7MAc0u0M88y9DcUFmrQL4N7XnT1M+RXtoT5DuiBlF4R/5AHyDi8Op
Gf+SEzxANfK7pzYgIYR6fM6r61gNVj5HKLx4vurh22eTYZlS+aTV5iWEApgEOjJA
pLAToBLHLY0TPbNFOXLPI7gd7c/RA7geuCsU6Ok/xWCcyuVFvWaErgyQ2UPKjBke
K2s/Fnj4hgMXgPJv9lVsaIOMspuoOHQrO3asefadfq1nU/wF3IK+Y/Ws9UjH7MFC
MMrGaB8f1mbDd02H2m87
=u0zh
-----END PGP SIGNATURE-----

--bc2iwAtkAaXP8cWF--
