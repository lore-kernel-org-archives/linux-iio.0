Return-Path: <broonie@sirena.org.uk>
Date: Mon, 2 May 2016 16:23:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>, Peter Rosin <peda@axentia.se>
Message-ID: <20160502152328.GG6292@sirena.org.uk>
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <f22534df-13b5-0889-66d7-e4fb7f480f00@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
In-Reply-To: <f22534df-13b5-0889-66d7-e4fb7f480f00@kernel.org>
Subject: Re: [RFC 0/7] iio: inv_mpu6050: Support i2c master and external
 readings
List-ID: <linux-iio@vger.kernel.org>


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 01, 2016 at 06:04:08PM +0100, Jonathan Cameron wrote:

> If you were to break these registers up into regmap fields it might solve=
=20
> this..  Regmap writes always go through whatever - whether they match the
> existing state of the cache or not.  If fields are involved the write wil=
l get
> built up from whatever field you change and whatever the cache has for ot=
her
> elements.  I guess it only works if they volatile bits are contiguous tho=
ugh.
> Maybe hand rolling it is cleaner here.

> Mark, any clever thoughts on this?

I don't have enough context here to be sure what the problem you're
trying to solve is, sorry.

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXJ3DvAAoJECTWi3JdVIfQ2hgH/2ZOqXwt6HHbmq77hekk9Gqg
3sFJKUks3nhAyAQQHxDbLFd4wuTV40LqN8xKEfpODUIn8neMLtqRRlo/raG3bpA4
VumYdRr32SHIw6oZpW1GaDC3nEgAtDI8oyM4nc6TaUXDisRpgRTmwt4omax11AkD
jdGoQ6QYF2vnwS4LXjTtjHEtM31erhu5IrHul5QxArkKsMNfdJMQ6APdHrSjbEPw
iZT1AdGvF6lPp7UKba58t7lkC3IOJ3Utz8bAvMn+12JOK1SR/L3feUNNd8lOzayi
tdztCmVlh8RfK5DizICnAqRGzhRwLBuGBBm/iGUELoee7gb806FJukto/HiDsC8=
=E1gR
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
