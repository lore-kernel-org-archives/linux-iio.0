Return-Path: <SRS0=65gC=LC=gmail.com=marcus.folkesson@kernel.org>
Date: Sun, 19 Aug 2018 21:38:46 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kent Gustavsson <kent@minoris.se>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: add support for mcp3911
Message-ID: <20180819193846.GC5217@gmail.com>
References: <20180808080917.2427-1-marcus.folkesson@gmail.com>
 <20180819200257.3e465759@archlinux>
 <20180819191751.GB5217@gmail.com>
 <20180819202943.66ac0a72@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
In-Reply-To: <20180819202943.66ac0a72@archlinux>
List-ID: <linux-iio@vger.kernel.org>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2018 at 08:29:43PM +0100, Jonathan Cameron wrote:
> On Sun, 19 Aug 2018 21:17:51 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > On Sun, Aug 19, 2018 at 08:02:57PM +0100, Jonathan Cameron wrote:
> > > On Wed,  8 Aug 2018 10:09:15 +0200
> > > Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
> > >  =20
> > > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> > > >=20
> > > > Co-Developed-by: Kent Gustavsson <kent@minoris.se> =20
> > > checkpatch points out..
> > > Co-developed-by is the 'official' form of the tag. I'll fixup.
> > > (first time I've seen one of these ;) =20
> >=20
> > Yep, I also noticed that checkpatch is not Co-developed-by-aware yet.
> > I tried to fix it, but Perl is just such a terrible language that I
> > considered it impossible.
>=20
> The version in mainline seems to be aware, it just wants
> Co-developed-by not Co-Developed-by!
>=20
> (lower case d)

I just noticed that the tag was renamed from Co-Developed-by to
Co-developed-by in e474785a12b46230ecf9f3663166b0de1175bcdc.

I must have been reading the documentation from an older tree...

/Marcus

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt5x0EACgkQiIBOb1ld
UjKiHBAAioQitq9+jKw66ybaJ+6b9ra5ZEJ/Qpvi6/rWdqeq7WkENXltwhZoXy7p
Uf0H2iJJ328XfNNZ+l5Q9eVPq8qcJzBQhwN+pKB31ISWf+4SCMYO/u+q7VliKL8j
peANbHBexsQUsvXsnKEEIr0HklmzDAXnhKk0cGeVkXMMRvhx5ymy1bxfWPHW5WZD
gDEwgUl5mMYqkoNpEN2UZWL2XSToO42zel7c9AOFrBxfxNTy3fpkr2DXW9iRjkUI
XSQcfVQCzcn9rzggS9V3EozsqAmtHV4AkJkQpLbmTYOCfC5kW/HLJ+oAm1D31nO5
l8tFKu8HznsuGDAu6zS6F1ApLxCUVTy1WP2TwjIHxr/VJ+Ms3qnyiFNI3L6Qu84a
DW6q8Z0t1dKjpdH+z4S2jeH0in09Gxgb66pl/qno4wxZipgCrYZ1WJhAr31lHdA3
kIPnA4j9D60u5iXJb0pqf5ATbGfLtLSQ2feupXkV90XvOouTxeDYFq3wYt+wiRjw
LvNq85W6WJD9D3KEUff+IDdpeJbrkpkYNBiLKu+E2t/XNw+K5SVvTSbZuar1VjIW
PJFzCIhcSNDMFLS9VBXrJBSOPSMeywfBZtQzNzsscuaEjGCqaKKIMH8OjbvHALLi
MmoXiL5WH7gIyiiJIjSzdKDxJfah56hEqIUcL29ZspPfpC6OsVc=
=fUli
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
