Return-Path: <SRS0=JnkZ=YW=sang-engineering.com=wsa-dev@kernel.org>
Date: Sun, 8 Jan 2017 11:44:16 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 10/12] i2c: i2c-mux-simple: new driver
Message-ID: <20170108104416.GA1983@katana>
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-11-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <1483532187-28494-11-git-send-email-peda@axentia.se>
List-ID: <linux-iio@vger.kernel.org>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2017 at 01:16:25PM +0100, Peter Rosin wrote:
> This is a generic simple i2c mux that uses the generic multiplexer
> subsystem to do the muxing.
>=20
> The user can select if the mux is to be mux-locked and parent-locked
> as described in Documentation/i2c/i2c-topology.
>=20
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJYchgAAAoJEBQN5MwUoCm2d20P921P3jRs7kz6hOqSBu1u/2s/
/XSJbY+ag8/zGzM970hcRDyu8t+pKkF356EPhpMka2N9elbIBeeIS0H5tUPVLPTA
Ii9Y665S19kWtxpTQ9JsK+V8Xg+CQ1RmA5pqbMe9oVScLH6li0A5zbCziQ7eigtB
GNrZCeoW3EfF1DNQXM38GPYweH2h9iMT5ysDPnSxIvr/nohO+1wM9vRnPLTuDHpS
ZF/ntBSLE0AFIRDBGJuO6hpN8qibqFiQIpmb+XPBKhwfPg8eHZq+T+9ZqNQc2DjP
Ch/LvCVL7haNJtYv6woQOrfgcrk2uCK0xupuN9beD8puaamWU5EUJWBRJuFXHJTt
eibalTmvDNTKAvkZkmgajxlh+ml5zqsUndA4W92b+4zBkVkLl1iBkHYbiyc48waV
eG97xtfSILPXPP26YmPc9rSjBbsaVB11QfhHXWNlizVO38qKSI2zrbAx4zdvwPdG
OyVzr8uBRDDWilqEhtuLnsBvNzv7Mfr2mFhuLOfdt4uNcHeYuCJ0slf+mvuyMgth
HKiflIuItSzqBFsK/KFZf/wh0rghvYKeFnq8pxkKfXsZT4TswwJbGVT25nYoK5k2
0RfJAqvGZi9UQLlKr//VpHncfQ/Mvu71bX0o8rufV3GGmZGUwZwoD2QPd2Ekpkg2
P63GtUixrJKQz2ABL0o=
=d3/+
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
