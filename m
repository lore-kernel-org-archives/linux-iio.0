Return-Path: <broonie@sirena.org.uk>
Date: Mon, 18 Apr 2016 13:34:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
Message-ID: <20160418123451.GB3217@sirena.org.uk>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <5dbbd82290c575f595ae0907aaf8e03117a6d017.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072142510.26969@pmeerw.net>
 <570A513A.4020106@kernel.org>
 <570BBDFC.6010601@intel.com>
 <57134AFA.3040406@kernel.org>
 <20160418103212.GQ3217@sirena.org.uk>
 <5714CFFA.2080309@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6FinHCQBQ0zFDOqT"
In-Reply-To: <5714CFFA.2080309@intel.com>
Subject: Re: [PATCH 1/5] max44000: Initial commit
List-ID: <linux-iio@vger.kernel.org>


--6FinHCQBQ0zFDOqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 03:15:54PM +0300, Crestez Dan Leonard wrote:

> As a further clarification: regmap_write will write to hardware even if
> the cache is known to be up-to-date and no matter the regcache_type. Did
> I understand this correctly?

> I'm basing this on reading the code, it seems to me that map->reg_write
> is only avoided on error paths or if map->cache_only is set to true.

> This always-write guarantee is not obvious and if it's OK for drivers to
> rely on it perhaps it should be explicitly documented on regmap_write.

Yes.  I have to say that you are the first person I've encountered who
has been confused by this, I'm not sure why you'd expect writes to be
discarded.

--6FinHCQBQ0zFDOqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFNRoAAoJECTWi3JdVIfQjpcH/1IHJUpHGDM/KGi2ZK8OFZPH
eaKM2p85//gT715AgR8tD5WcQNafJs5Cl3fxeZzX/WqPalSjza8aTXdEg+HWr2O0
FpZZpyDc9aDGgzxUs38bOxZes83x/6hxNFIxkDeBDzVZSo6Im1MTaKSiDzmHc6gx
uWNeR27UHcrCPjxa8iCx8tRD5o1A/nMO9bf1uLjLai15Vdjfc3Q5tEEWIJvKJ1v9
9y6ZTcd6ojXQC9HUueSPLQYuyHC3F/u66aD2cNNZHiqtO+dZDIuAqwM1PI8uR8BF
lrd1UEp/971wIWRlSjiWOvXVpTEAllDmBlbt7vlgdj6IJY1n4jJe8Hz775fds+M=
=zrmX
-----END PGP SIGNATURE-----

--6FinHCQBQ0zFDOqT--
