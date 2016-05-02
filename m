Return-Path: <broonie@sirena.org.uk>
Date: Mon, 2 May 2016 16:24:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>
Message-ID: <20160502152442.GH6292@sirena.org.uk>
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <bb7637a178248e7d5e6c139343cf97d09e6e6a2f.1461953982.git.leonard.crestez@intel.com>
 <bd07f4f4-4105-9ff8-13b5-e549030d5d4c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
In-Reply-To: <bd07f4f4-4105-9ff8-13b5-e549030d5d4c@kernel.org>
Subject: Re: [PATCH 1/7] iio: inv_mpu6050: Do burst reads using spi/i2c
 directly
List-ID: <linux-iio@vger.kernel.org>


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 01, 2016 at 06:11:50PM +0100, Jonathan Cameron wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

>  On 29/04/16 20:02, Crestez Dan Leonard wrote:
> > Using regmap_read_bulk is wrong because it assumes that a range of
> > registers is being read. In our case reading from the fifo register will
> > return multiple values but this is *not* auto-increment.

> > This currently works by accident.

> Cc'd Mark again.  He's the regmap maintainer (amongst other things) so
> a series doing slightly odd things with regmap should probably have been
> cc'd to him in the first place.

> Perhaps regmap should have a repeat read function for this sort of fifo access?
> Mark, is this something you'd consider?  Easy enough to implement after all as
> a variant on regmap_read_bulk...

> Having the below in a driver just feels wrong to me....

That doesn't sound like a crazy idea, please send patches for proposed
extensions.

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXJ3E5AAoJECTWi3JdVIfQP3gH/jMryR7cFqwBVgB46U6/92Z7
eEjIgLgSnEEO1DZYXixIaPFgFZnbAfzJyFQTKUiLV4UYpTJ1gkwtnffbXXsnfZ3/
3qEBIiVDQh9egLaHTNDpFeua+FCstfokM4oKFqqou5I51JgWM7bGEOeR3DZFkfbU
Lh5l098r/A8EN4eJOjsosDFcNgIsJwcGvOv9NLkv39N0rlUpO1C7kxEjILnG2vyt
3bpgsFIZnSoHo3iHEJ7J+Foy+cY0bJIqBntpzSP5zt2uZysEZG4wikZL/xZGhozE
1nK3enOrEQ0KZbZpX+Paopp7Eh1QbHN2euWeLocYpBu3imS1PcE7Ntq26b2gYF0=
=S3gl
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
