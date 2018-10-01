Return-Path: <SRS0=mnfY=MN=the-dreams.de=wsa@kernel.org>
Date: Mon, 1 Oct 2018 13:55:59 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-iio@vger.kernel.org, Marek Vasut <marek.vasut+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@kernel.org>,
	Simon Horman <horms+renesas@verge.net.au>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix Renesas GyroADC MAINTAINERS entry
Message-ID: <20181001115559.GA4134@kunai>
References: <20181001105804.17802-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <20181001105804.17802-1-marek.vasut+renesas@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 01, 2018 at 12:58:04PM +0200, Marek Vasut wrote:
> Fix the F: entry in MAINTAINERS file, point it to the correct file.

Right...

> @@ -12471,7 +12471,7 @@ RENESAS R-CAR GYROADC DRIVER
>  M:	Marek Vasut <marek.vasut@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -F:	drivers/iio/adc/rcar_gyro_adc.c
> +F:	drivers/iio/adc/rcar-gyroadc.c

Add the bindings, too?

Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluyC0sACgkQFA3kzBSg
KbYD2RAAodfez0vNe5CGlXE2KaGTPsceB1Zl4U//dtCPpKGPa0gc5Mpth1k4qF7L
DX2wx0x47Iw5LfV8dPj0pRcf8VAcGJ+ImsBPrsRh1+ezmYnjB+FVJqQNhxTK91Lf
HiVMFA0AA3yxhVDk05U4HN5GroPVK5Q3B289t1vg8Qi+9LwaL06NlxXfU/iYyj/Q
zh/Q4owAFnFD1DAFRN96Z7QMKZpVauibb/AVePK2bYVu3O8twdfcq6c0Z+WFWlWs
7JyNFSKQS1Za81c1s7Lf7f6Qa7hD8C+dX/3P7SzuKFqsgA5/k3NPx7gFuoxMJ9JB
hyfZ+JY3oolaDvTebygZEaWr1X9TCot7UtZwarCKAnICjITr9r5wMtnlWD/xeyAL
DR+JjnBHnBAykdn5/W17G8H/YYfhIetu+QPPZqTmPQ+8QmDcYsX2CpFUzBMCBkgq
sNyz47AOhPdJ+m44Q0KPQZFwpekPkpluvQR/KXxVByscJmnkuXuO40mtIBifoTmC
Kb7yXbqVG94w4wGX/dmi9wLgAnczJ6Jp1xS+DHG8LAHyl25cTFe/N6zlEaUg9982
xbMCaaSuagUBw8PeSkpVWAuK6wLEuEwmYC8BrfIVx5kAnjorLaI54J0P7caRENri
YCI2lJq2AB/hfZW2bXRtkqieQxql+D06AXesfmkDuD4WqPAjC0w=
=bemq
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
