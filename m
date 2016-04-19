Return-Path: <broonie@sirena.org.uk>
Date: Tue, 19 Apr 2016 10:06:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
Message-ID: <20160419090654.GN3217@sirena.org.uk>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <5dbbd82290c575f595ae0907aaf8e03117a6d017.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072142510.26969@pmeerw.net>
 <570A513A.4020106@kernel.org>
 <570BBDFC.6010601@intel.com>
 <57134AFA.3040406@kernel.org>
 <20160418103212.GQ3217@sirena.org.uk>
 <5714CFFA.2080309@intel.com>
 <20160418123451.GB3217@sirena.org.uk>
 <57153733.1070605@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gkQsIeIyLzf1kMz9"
In-Reply-To: <57153733.1070605@kernel.org>
Subject: Re: [PATCH 1/5] max44000: Initial commit
List-ID: <linux-iio@vger.kernel.org>


--gkQsIeIyLzf1kMz9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 08:36:19PM +0100, Jonathan Cameron wrote:
> On 18/04/16 13:34, Mark Brown wrote:

> > Yes.  I have to say that you are the first person I've encountered who
> > has been confused by this, I'm not sure why you'd expect writes to be
> > discarded.

> It confused me too :)  To my mind a classic cache optimization would be
> to not write to the hardware if the value is already known to be as
> desired.

> Still, I guess it would add another check to identify which
> registers you really wanted to hammer whatever vs which can be assumed
> not to read the write is not worth the effort for this case that=20
> inherently won't be hit that often.

We'd also have to add another API for cases where someone explicitly
wants to write the same thing to the hardware, you get things like
latched "do it" bits in registers.

--gkQsIeIyLzf1kMz9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFfUsAAoJECTWi3JdVIfQ7t0H/2rITv0sDOvuuC1tf1C16/3G
D8+m+6iQjRi5LJsqtDW/OwkLiSjdWam83w04RNB3K/6QtkE3SjTsIUfnkMLN+fOl
Y5y8mmb35BDbSfBj6NzkX4faEVv9l8wMjMTGrEAtpiCzPRRDlDKrhMdSjn5c7GSt
l+cFvAal9E4ZrliaaGufLBbtHcwdTBjn8G7znZ1yrgFulDz000tJfCknOKaLIJom
Mblx1BwUUZ0ycUTHBHanBJqGALevrKgxowMOsA0y8wq1TUvgdYptBSw0i7qW9MXN
cll6asdAnkP13vzMi0sIYwkLDKW3L+ja6W7iYt68+tHtnb5sPWGSoOxIcQxgQnA=
=09AY
-----END PGP SIGNATURE-----

--gkQsIeIyLzf1kMz9--
