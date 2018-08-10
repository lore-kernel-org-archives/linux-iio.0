Return-Path: <SRS0=AV+q=KZ=sirena.org.uk=broonie@kernel.org>
Date: Fri, 10 Aug 2018 11:38:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
	davem@davemloft.net, mchehab+samsung@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	robh+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v6 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180810103856.GB20971@sirena.org.uk>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
 <1533890783-13456-4-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
In-Reply-To: <1533890783-13456-4-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 11:46:20AM +0300, Stefan Popa wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>=20
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for
> which a such a read operation will return data from an internal FIFO
> instead. Add an explicit API to support bulk read without range semantics.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttaz8ACgkQJNaLcl1U
h9AjNQf/buHO0/HMfa6dgryJ+K7ERaW4OvogB34AF9dEiXKgWwZpFggKVav9mHHp
TRt2fk5D2f0dPLwWBUGOSPEFNsfMd3BI9MeUvNHgD6mKky/AX+Fa0GntaSRC3dr2
DG+Zx1nz3Lq5EwVwvxuMGc9BkIqwcqX5G+LLwhOz030/6dvuSyGpfLUddt24ruvW
Pu10QpfpcnWPKViZqwGAUf8TCELqKmBVC0TNU9aps/PLjc46FZqtKrt4mWTsdUDG
6lR5RrwOgrJZ1/k7nZQKxnURll6hdSgVDNpEhHZHDqxdL/h4RnaY/KtR0KsEjaxN
QEEhDPHRiwZNbYLvAgYvGF/IwijfNg==
=Bhv7
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
