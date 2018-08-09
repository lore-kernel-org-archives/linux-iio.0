Return-Path: <SRS0=1ftz=KY=sirena.org.uk=broonie@kernel.org>
Date: Thu, 9 Aug 2018 11:14:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
	davem@davemloft.net, mchehab+samsung@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	robh+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v5 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180809101453.GD6132@sirena.org.uk>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
 <1533653540-24796-4-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
In-Reply-To: <1533653540-24796-4-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 05:52:17PM +0300, Stefan Popa wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>=20
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/r=
egmap-noinc-read

for you to fetch changes up to 74fe7b551f3385fa585d92616c85b3a575b2b2cb:

  regmap: Add regmap_noinc_read API (2018-08-09 11:00:15 +0100)

----------------------------------------------------------------
regmap: Support non-incrementing registers

Some devices have individual registers that don't autoincrement the
register address during bulk reads but instead repeatedly read the same
value, for example for monitoring GPIOs or ADCs.  Add support for these.

----------------------------------------------------------------
Crestez Dan Leonard (1):
      regmap: Add regmap_noinc_read API

 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 79 ++++++++++++++++++++++++++++++++++++++=
+++-
 include/linux/regmap.h         | 19 ++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltsFBwACgkQJNaLcl1U
h9AwzAf9G5jIyT2s7YVz52yfMsuS6N1K4QWtidmqdlvpf4lsJBHl705VZC4JkFTV
tLA3Aetv8lFmxfSm5ePOmSjpYxg0N2vflgHxAbDMqcyaUQutV0vHcVAeMZ5Q0lZP
xk3BDi48esQbvjeyPxJKcPgC8WpOhVzVdrcmGBNJo+aOj6UKYQKurh2P5LVZDYL9
qJzOaPmC95DaJYAaddNTtq8G7o/bUvTpvYnaMNqicyKLLdmvjNunEDiLAXcx6h+t
TGGRs0TFJ8WFfJ+sLX24KrRR945voVIEYzETpBS3iVwe8Tz9jVfMjyWAaizBtDpo
BNB+GDHU07RlkgimF2S9huU5BfAtGg==
=Wwqu
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
