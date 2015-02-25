Return-Path: <sre@kernel.org>
Date: Wed, 25 Feb 2015 21:33:08 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
	support.opensource@diasemi.com
Subject: Re: [PATCH v7 0/7] Add initial support for DA9150 Charger &
 Fuel-Gauge IC
Message-ID: <20150225203307.GC13695@earth>
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
In-Reply-To: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
List-ID: <linux-iio@vger.kernel.org>


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 18, 2015 at 02:08:19PM +0000, Adam Thomson wrote:
> This patch set adds initial support for the Dialog DA9150 Integrated Char=
ger &
> Fuel-Gauge IC. The device also provides GPIO and GPADC functionality.
>=20
> In this patch set the following is provided:
>  - MFD Core support and DT bindings documentation.
>  - IIO GPADC support and DT bindings documentation.
>  - Power Supply Charger support and DT bindings documentation.
>  - Update to MAINTAINERS file to add DA9150 files to Dialog support list.
>=20
> To keep patch submission from being too large, support for GPIO and Fuel-=
Gauge
> will come after initial support patches are accepted.
>=20
> This patch set is baselined against the v3.19 kernel version.

I pulled in patches 3-7 into battery-2.6.git (patch 1 was already
applied by Lee in 4.0-rc1 and patch 2 can simply be pulled in by
Lee).

Jonathan: I have prepared an immutable branch "da9150-charger-fuelgauge"
based on 4.0-rc1, which contains the IIO bits, so that you can pull them
in, too:

git://git.infradead.org/battery-2.6.git da9150-charger-fuelgauge

--Sebastian

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7jF+AAoJENju1/PIO/qaTUkQAJJW69C+VlZ7+o98gR3Sb6rA
q45Nk3n7BSiPU3lqLql9JL+IKGOAd+cjRJ0QpIyPUAaqiLrdBpUQZS0TQnHRMERp
7nFJpX/oC+eHSe6l9PeeBzS9tSWK2eYQk8+rnI6XgwvfPj59kMclh3XIWIowI/ZK
Ve8vJ3Ebk6cRImCGfyvihzxwe+YS15D/8+GCifiipy3wQoWLiSuvYe9xn23SyDGw
QpJr9i6LKcwe8hGiRRLLb4PzXWSBDr0H3pf8FRYAQEHJbjMjqu24SzgFfDSCWBAz
YzQ0qNyM/ERZcqGAj7y9FA+hGeROLxKxWj95bLEMjwWcCZylWJJvAreUpQt7rUWL
zb33xO6NnH96X4NXSl2K65+ZFgfvfyP6ydBR6nuhS9zbUhe6+61vjB6uI+T49oER
PlozkGk9t74y0Uyu7Kgl1JLxGptzkWw3sO6x2jXMOm7Uw4bl3AUQRMOVv6sPqUbw
c45kk73pawQioD9oAhLRCDtFDRujkncwn3ZxgN4kCToiN6WHZrSR4RkNgWbLZDah
e3uaXv3xJxE9FiGsHcFCePPsiYEE2bMzEe434/aMR5scgFOPj30V0hqL89O4nWoF
3vlW8ADFrBt8uHlZpP0lRjzJi1okZGW2e3buXh/HoLvpJM85gvWcsNurxSNvcmd7
q72QB6MUKYDZLjyUyx7O
=NHbg
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
