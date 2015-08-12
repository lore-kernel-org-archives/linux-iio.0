Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58332 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHLNFW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 09:05:22 -0400
Date: Wed, 12 Aug 2015 15:05:18 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without
 write()
Message-ID: <20150812130518.GM19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
 <20150812112035.GX10748@sirena.org.uk>
 <20150812122011.GE19600@pengutronix.de>
 <20150812123406.GG10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m9CJymqw5zZ14Dg6"
In-Reply-To: <20150812123406.GG10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--m9CJymqw5zZ14Dg6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 01:34:06PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 02:20:11PM +0200, Markus Pargmann wrote:
> > On Wed, Aug 12, 2015 at 12:20:35PM +0100, Mark Brown wrote:
> > > On Wed, Aug 12, 2015 at 12:12:34PM +0200, Markus Pargmann wrote:
> > >=20
> > > > @@ -1229,6 +1229,11 @@ int _regmap_raw_write(struct regmap *map, un=
signed int reg,
> > > >  		}
> > > >  	}
> > > > =20
> > > > +	if (!map->bus->write && val_len =3D=3D map->format.val_bytes) {
> > > > +		ret =3D _regmap_bus_reg_write(map, reg, *(unsigned int *)val);
> > > > +		return ret;
> > > > +	}
>=20
> > > This is broken - you can't use a raw value as a register value.  The
>=20
> > I am not sure what you mean here?
>=20
> > The register value given to _regmap_raw_write is the real register
> > value, not formatted differenty. This is given directly towards
> > bus->reg_write() which should handle the rest.
>=20
> I mean the value for the register, not the register address.
>=20
> > At least that's how I understood the code. For example regmap_read()
> > directly calls _regmap_read() which in turn calls directly
> > bus->reg_read() without any formating.
>=20
> You're adding this code to regmap_raw_write() which takes raw register
> values for the device, not unsigned integers.

Ah yes, I see.

>=20
> > > endianness of the device may not be the same as the endianness of the
> > > system and you can't cast a value to unsigned int, the value may be of
> > > any size.
>=20
> > Yes right. On the other hand if bus->read() and bus->write() was not set
> > in the init method (before this patch series) no formatting functions at
> > all were assigned. So it was always ignored for bus->reg_read() and
> > bus->reg_write()?!
>=20
> I'm not sure what the "it" you're talking about here is, sorry.  There
> are unsupported features in the API especially for cases that don't make
> a huge amount of sense, the error handling isn't always complete.  It
> sounds like you might be trying to support one of these nonsensical
> cases - it's not obvious what raw I/O on a device where we don't know
> the raw format of the device should mean or how anything could sensibly
> use that.

The bus and the regmap user are separate. So as a regmap user, I am not
able to know if the bus the device is connected to actually supports raw
reads/writes. At least it should not fail with a null pointer when using
these functions anyway so yes error handling is missing a bit here.

Also the real use of this function is regmap_bulk_write() which always
uses _regmap_raw_write() regardless of a missing bus->write() function.
So regmap_bulk_write will fail for those as well and this should be
supported.

But it is probably better to handle this in regmap_bulk_write() and
add a simple check for bus->write() here.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--m9CJymqw5zZ14Dg6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy0SOAAoJEEpcgKtcEGQQ/M8QAJZFhZZuaoift3LHY/IlZ2x7
s4JWiEcaXXqSDTHUvXRyaqULWxHMdCf00iS1Dl4e76iW6Xej0yMOGU8BTwiiyMof
cmtA4V+IOxC46EPnkkCZ3ofvllfuShLHQYbbfmEDib8Ul1ym/mHB/8J2IUurFfp9
1R9xCEvTzFX6MLqMRam5qElsy6QIE9tXDT99a6rOumxhD6pqVRAWTr2fxDBc48CQ
HdQ8J593oNv9KEiH49o6cB9H2ChiWbKWiBJo5o0CwfOGRfUfnXeZCD+3Z4JgV+vA
yjTqhBq7svm6FIkWxbUujFDl0leSPALA/7pM278K7uE4QMajYQakEoD5+3oIIDVV
npqRAJ6hsPR/z5a6xEpZCf/AxOGn7Q6E0m+JnJ71+eMVSexo7SaSSYqQe5PdCPnU
QPYoIIF4ZgRmKK1Oth4sKZuoqdQX32qx74zsGjmQW1VOrbqpv+b7ahFQNZhP9QQJ
BwaMwzmk9Iscp/9OMoGkvR0mSvQLqACJjeo6A9+mUsTfVy3iWnSBaTVtvAKJLv4R
snWTWYkdSSNsL3sceMa+1CJTliW305WmT/g5b46umC2os+P/uRjtPcx0kcz89XX1
AyNmCNrmX3jATDmjTBXFFSgQP3nqtEVPgVXZz3xLSj05b1ObM7wskxitYZTejLrP
TLYZ+x1KdHtJPrIu+jbB
=xp7I
-----END PGP SIGNATURE-----

--m9CJymqw5zZ14Dg6--
