Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40427 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbbHLMeS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:34:18 -0400
Date: Wed, 12 Aug 2015 13:34:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Message-ID: <20150812123406.GG10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
 <20150812112035.GX10748@sirena.org.uk>
 <20150812122011.GE19600@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9iFHQ9JnogSZzyzY"
In-Reply-To: <20150812122011.GE19600@pengutronix.de>
Subject: Re: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without
 write()
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--9iFHQ9JnogSZzyzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 02:20:11PM +0200, Markus Pargmann wrote:
> On Wed, Aug 12, 2015 at 12:20:35PM +0100, Mark Brown wrote:
> > On Wed, Aug 12, 2015 at 12:12:34PM +0200, Markus Pargmann wrote:
> >=20
> > > @@ -1229,6 +1229,11 @@ int _regmap_raw_write(struct regmap *map, unsi=
gned int reg,
> > >  		}
> > >  	}
> > > =20
> > > +	if (!map->bus->write && val_len =3D=3D map->format.val_bytes) {
> > > +		ret =3D _regmap_bus_reg_write(map, reg, *(unsigned int *)val);
> > > +		return ret;
> > > +	}

> > This is broken - you can't use a raw value as a register value.  The

> I am not sure what you mean here?

> The register value given to _regmap_raw_write is the real register
> value, not formatted differenty. This is given directly towards
> bus->reg_write() which should handle the rest.

I mean the value for the register, not the register address.

> At least that's how I understood the code. For example regmap_read()
> directly calls _regmap_read() which in turn calls directly
> bus->reg_read() without any formating.

You're adding this code to regmap_raw_write() which takes raw register
values for the device, not unsigned integers.

> > endianness of the device may not be the same as the endianness of the
> > system and you can't cast a value to unsigned int, the value may be of
> > any size.

> Yes right. On the other hand if bus->read() and bus->write() was not set
> in the init method (before this patch series) no formatting functions at
> all were assigned. So it was always ignored for bus->reg_read() and
> bus->reg_write()?!

I'm not sure what the "it" you're talking about here is, sorry.  There
are unsupported features in the API especially for cases that don't make
a huge amount of sense, the error handling isn't always complete.  It
sounds like you might be trying to support one of these nonsensical
cases - it's not obvious what raw I/O on a device where we don't know
the raw format of the device should mean or how anything could sensibly
use that.

--9iFHQ9JnogSZzyzY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyz09AAoJECTWi3JdVIfQ7FgH/RfVkdmwJ54moqfAiDADG4gr
ao5EOxN0w1IUK/GshfgNdDQ3ib91z4+oMUY5CmE+2gezf2pSxCQ6kjwX3xbqaKOh
1RDNiqVbIxROoTM93/xyCqpKEviBgjJmYUh7x+CficzEk0gyoyau44YNTV1E6wK8
SOWRo41hCVONU2Ekpt/NGZQeUtwPDPDlUOYCvdLrmUx+7N/DX+NB8wg6QEqZH/zV
hIEv3/Mt9gC/jCyeasBGezFEHsGifgvmfCtBxmY86qXnLrCtXM319KGuPH6S+t+p
hGHnLsSRHL5oaYijC0pZmfI/Jx44N+H/RL7cOz8xyPV0pVBxjkkpeSfCd/2FJtc=
=buHi
-----END PGP SIGNATURE-----

--9iFHQ9JnogSZzyzY--
