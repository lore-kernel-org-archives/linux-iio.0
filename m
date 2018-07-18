Return-Path: <SRS0=tHw2=KC=sirena.org.uk=broonie@kernel.org>
Date: Wed, 18 Jul 2018 16:04:50 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: add new SPI_CS_WORD flag
Message-ID: <20180718150450.GO5700@sirena.org.uk>
References: <20180717032052.12273-1-david@lechnology.com>
 <20180717032052.12273-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
In-Reply-To: <20180717032052.12273-3-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>


--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 16, 2018 at 10:20:50PM -0500, David Lechner wrote:
> This adds a new SPI mode flag, SPI_CS_WORD, that is used to indicate
> that a SPI device requires the chip select to be toggled after each
> word that is transferred.

This feels like it should have a soft implementation if it is going to
be truly usable, the vast majority of SPI controllers don't do this and
I can only think of a few that have the hardware feature.  I'd also
expect to see some validation added to the core spi_setup() since at
present a client driver could set the mode option but then have it
ignored by the controller which would presumably break things, we
currently only have checks for specific modes and nothing that'd catch
an unknown flag like this.

Ideally we'd also have some ability to use this as an optimization where
possible with longer sequences (I can see a regmap cache sync being able
to take advantage of this for example) but that might be more trouble
than it's worth.

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPVxIACgkQJNaLcl1U
h9C/awf/b9hscy2AJosmJUBThr9n1LpeKI6knCgJVbsOg9FUBH9JjVxAagPdRe4Z
3fEyFqiDo7kSezNOZmrxbwTKTwiLbi2eLojQfohuMpEaF6HXE7Vo3ypGvlnTwSsQ
Xaw9vlpI8rNbDXqIb98PRd3th49FEkIIdsi2g0LTKlhxZWG3nynTHprK0PyPZuro
uPg4FU4dLUtsIkrsg8awEGCCuBARNysS6TFgPAKeLhSGnMwPfMMx20f2o1KeMdWT
B2QUNwjQnPwnxlYO9ahs2BiYxTY43ap1WlYN0xqoYyUTHN0dL4bD3neCSHb1p+SG
jM2asJiLGGzjHyzrKZhF3VhQuOEp1w==
=l9Kc
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
