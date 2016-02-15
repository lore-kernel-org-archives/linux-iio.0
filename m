Return-Path: <broonie@sirena.org.uk>
Date: Mon, 15 Feb 2016 15:02:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
Message-ID: <20160215150242.GM18988@sirena.org.uk>
References: <1455412842-750-1-git-send-email-mranostay@gmail.com>
 <56C096F3.9070908@kernel.org>
 <56C0BBFF.5040703@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
In-Reply-To: <56C0BBFF.5040703@metafoo.de>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: switch regmap cache
List-ID: <linux-iio@vger.kernel.org>


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 14, 2016 at 06:40:15PM +0100, Lars-Peter Clausen wrote:
> On 02/14/2016 04:02 PM, Jonathan Cameron wrote:

> > I'm lost here. Why should changing the storage of the register cache result
> > in different behaviour other than in efficiency of access to cached values?

> And if there is really a difference this should probably be addressed at the
> regmap level.

You'd need to make regcache-flat keep track of which cache values are
valid either during init (in which case it'd have to read every other
register at that time) or at runtime (which would mean extra operations
in a fast path).  Flat really is special here, there's no reason to use
it over a rbtree other than being very sensitive about performance.

Please also be aware that if you CC me on an iio patch series there's a
good chance I'll just delete it without reading it, for some reason I
keep on getting copied on lots of them which have no relevance to me
that I'm able to identify.

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWweiRAAoJECTWi3JdVIfQD3MH/2vGqg8azgWJ2U+btYTVIh0k
ExTyeY9WvP6LEVHQW3M8FYyv1QvofOBSqmiz/nqZ2T8voV5zPd8aYSV1to+ujAYq
0JHiELICs8NO1dEffaZ8EOdSRWEEZ/MiNvx+YEih4t/OaDqhXZROH28i0oZJ9jCu
+3IwA91kW5FOCvnnYSf4WS+gi6gqtzeCCqwlfyytkv+2QHsnYk4i8qcGm8LoMJ+o
n+ux0r6rITWhbKD1ZKz38qd8cFFOkWrPFzoB5dhj6nh5EqeDgwcnDIYTSOusNclX
sKoMegy/RLqDy6vc7z14LMpw3/36nLU2UfxbXhy125A7zppOIcWFIlQxH80wSaM=
=Hsgs
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
