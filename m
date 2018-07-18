Return-Path: <SRS0=tHw2=KC=sirena.org.uk=broonie@kernel.org>
Date: Wed, 18 Jul 2018 18:19:21 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: add new SPI_CS_WORD flag
Message-ID: <20180718171921.GB20360@sirena.org.uk>
References: <20180717032052.12273-1-david@lechnology.com>
 <20180717032052.12273-3-david@lechnology.com>
 <20180718150450.GO5700@sirena.org.uk>
 <a183973d-e648-c7e6-d65b-1479f7e32bb5@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
In-Reply-To: <a183973d-e648-c7e6-d65b-1479f7e32bb5@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2018 at 11:47:30AM -0500, David Lechner wrote:
> On 7/18/18 10:04 AM, Mark Brown wrote:

> > This feels like it should have a soft implementation if it is going to
> > be truly usable, the vast majority of SPI controllers don't do this and

> This occurred to me as well. Another possibility, though, would be to leave
> it up to the client device drivers to support both cases, e.g.:

> 	if (master has SPI_CS_WORD support)
> 		setup message as single transfer
> 	else
> 		setup message as multiple one-word transfers

> This seems like that would be more efficient than having a generic
> implementation for masters that says:

That then requires every single user to open code this which immediately
suggests that there should be a helper which is going to look a lot like
any generic implementation.

> 	if (master does not have SPI_CS_WORD support)
> 		allocate enough transfers for each word of each
> 			each transfer of the message
> 		allocate and setup a new message for these transfers
> 		loop through the original transfers of the original
> 			message and copy them to the new transfers
> 		send the new message
> 		free allocated message and transfers

I'd imagine that the much bigger problem is that you end up with
enormous numbers of operations for any non-trivial transfers which is
going to happen anyway.  It's really only the copying bit that's at all
an overhead here.

> > I can only think of a few that have the hardware feature.  I'd also
> > expect to see some validation added to the core spi_setup() since at
> > present a client driver could set the mode option but then have it
> > ignored by the controller which would presumably break things, we
> > currently only have checks for specific modes and nothing that'd catch
> > an unknown flag like this.

> There is already a generic mode flags check in spi_setup() that will catch
> this and return an error if the device has the SPI_CS_WORD flag set and the
> controller does not. (I know this works because I ran into it during
> development.)

Ah, good - I'd forgotten it was there and didn't spot it when I went to
check.

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPdpgACgkQJNaLcl1U
h9CCEwf/fjzvKt8d7Z/SHssIQdPcKePzdpYKRSJfq4cYuvxI1kjE7xLV5K+fmMoV
yAE/IlrchzIeuNY4ukoGnVlo/pVQxapBOzJQhzObkiReItNBH+wkMn6RFJQdBLCz
5T3eMgRbhGoiTuDhC/fLnUj8ZTgMBxOqKVUhigyG74I/QCODzq6T1x876dzWgn/x
E1PDRe5rHqSNd3+6DtGdBTuf6l3NwqjWN4xTzPQF/fw2bBeP20rN0QLD7esvDBkF
TdhIWktx7vJP6wHq3LFSrck7K0azTIjOjhwtE0/U5Vrz/lOF7B+IvVY8wbtdXE1A
JknONrhbUTCzsMeR3TAZ0rnCmXmttA==
=S4Z6
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
