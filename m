Return-Path: <SRS0=5DjC=AF=sirena.co.uk=broonie@kernel.org>
Date: Mon, 4 Sep 2017 18:22:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Adriana Reus <adi.reus@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	Rob Herring <robh@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Phil Elwell <phil@raspberrypi.org>,
	Oskar Andero <oskar.andero@gmail.com>,
	Andrea Galbusera <gizero@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	Michael Welling <mwelling@ieee.org>,
	Soeren Andersen <san@rosetechnology.dk>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Abhisit Sangjan <s.abhisit@gmail.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: mcp320x: Update for
 mcp3550/1/3
Message-ID: <20170904172221.47si6swykixnb5of@sirena.org.uk>
References: <cover.1503407738.git.lukas@wunner.de>
 <87644503b0397248c06fbe0058f292955dd10f79.1503407738.git.lukas@wunner.de>
 <20170825195941.iylf4w5hitjwniio@rob-hp-laptop>
 <20170827153405.GA13399@wunner.de>
 <CABjU8GvCB61envBiR0ei3gHEPadd5VDZ7FGysDjhCrJcQrEXDg@mail.gmail.com>
 <20170903143429.749be480@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bsr3zvrgovkc3mgy"
In-Reply-To: <20170903143429.749be480@archlinux>
List-ID: <linux-iio@vger.kernel.org>


--bsr3zvrgovkc3mgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 03, 2017 at 02:37:49PM +0100, Jonathan Cameron wrote:

> +cc Mark Brown and linux-spi to address question about how to represent
> a hardwired chip select.  See below for why I think that is what we should
> be representing rather than the fact it puts it in 'continuous mode'.

There's a good chance that if you just send me mail with a not obviously
related subject line it might get discarded unread, people CC me on lots
of things that are of questionable relevance.

> > >> > +   - microchip,continuous-conversion (boolean):
> > >> > +                   Only applicable to MCP3550/1/3:  These ADCs ha=
ve long
> > >> > +                   conversion times and therefore support "contin=
uous
> > >> > +                   conversion mode" to allow retrieval of convers=
ions
> > >> > +                   at any time without observing a delay.  The mo=
de is
> > >> > +                   enabled by permanently driving CS low, e.g. by=
 wiring
> > >> > +                   it to ground. =20

> hmm.  This is odd.  We probably need to make the SPI subsystem aware of t=
his.
> It is possible to ask for exclusive use of an SPI bus and I think we shou=
ld
> be doing this here.  It may be wired low on your board, but it may be wir=
ed to

This sounds like SPI_NO_CS, though it's vanishingly rare for it to be
implemented as there's a lot of ways for it to go wrong electrically -
it's a lot simpler to just have a chip select and minimise the number of
times it gets asserted.

--bsr3zvrgovkc3mgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmti8wACgkQJNaLcl1U
h9Aq9Af/b1NCeLEaQqSlsNVHTUjtqf5yQsJq4swner+plCt02XhEkrSfHoSWFMNj
/FvMl5zXzFEcn8wS4qI5URErG7vJ4QvWdg32PljkMgEGeulU0pQyJS5aTBlOoWkV
V9X3iWwEcZ2AD8uMAUWCrlzS6WMC9dEwkvFREP7GEo4IrgQJ3n/WXtz+yIXa3EUN
jMJuho9M4MdmNxCnKviWfAYEszCEt/lSz/Eh93RekuJKs04UxxE/ol8NIDvpP7nZ
jhGiMRFSc7TVqUMcstoDfRRY+xmt98y8OMHYdu/d8nSYW3mVXV1KVcBG7OWOxFkh
GABeQ033vRkdl+2TrHISzPtxs3qkjw==
=EeAB
-----END PGP SIGNATURE-----

--bsr3zvrgovkc3mgy--
