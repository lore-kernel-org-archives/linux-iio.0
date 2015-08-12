Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33477 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347AbbHLMvY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:51:24 -0400
Date: Wed, 12 Aug 2015 14:51:19 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 13/20] regmap: regmap max_raw_io getter function
Message-ID: <20150812125119.GJ19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-14-git-send-email-mpa@pengutronix.de>
 <20150812115136.GA10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nNefFv5r6Ea+vcVx"
In-Reply-To: <20150812115136.GA10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--nNefFv5r6Ea+vcVx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:51:36PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:38PM +0200, Markus Pargmann wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>=20
> Your changelog doesn't mention why anything would reasonably want to use
> this and...

Right, this is used later in the driver code of bmc150 to find out how
much we can read from the sensor in one run.

>=20
> > +size_t regmap_get_raw_io_max(struct regmap *map)
> > +{
> > +	return map->max_raw_io;
> > +}
> > +EXPORT_SYMBOL_GPL(regmap_get_raw_io_max);
> > +
> > +/**
> > + * regmap_get_raw_read_max - Get the maximum size we can read
> > + *
> > + * @map: Map to check.
> > + */
>=20
> ...it is adding two functions which don't seem very symmetrically named.

Oh, this is half of my previous version where raw_read_max and
raw_write_max where separate. Will fix it along with your comment that
these should be different values for read and write.

Thanks,

Markus

>=20
> > @@ -441,6 +441,8 @@ int regmap_get_max_register(struct regmap *map);
> >  int regmap_get_reg_stride(struct regmap *map);
> >  int regmap_async_complete(struct regmap *map);
> >  bool regmap_can_raw_write(struct regmap *map);
> > +size_t regmap_get_raw_write_max(struct regmap *map);
> > +size_t regmap_get_raw_io_max(struct regmap *map);
>=20
> Do we want stubs here?



--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--nNefFv5r6Ea+vcVx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy0FHAAoJEEpcgKtcEGQQe7IP/jviGKKY5gpuEg/aeiGM2tk+
8aFAMdB9wuaEBGvNEhyaBeJr+7qioL12QhS93juFJu5AvOgNFMnGYzM3elP+mhcd
7D9VRwl3SzSApfD9lylVvBBzLL81l/KF4J9rl1vdJSiysx94kq+uKOXdRvtiAnJE
d9Basa8i9prTazfkSp38PXROOHuZzW5yDQ+lTN1TbfQZq+QAtNFpejsadApv08GK
SVBveEb/V/y2gZgAFoTAf9MlFFC3uTqFqlDkvWjPHwTopQd9UhWEOhOyIeSZY+71
dKNrtNxkJ3/JpvpkBqaSQF1er0ooTVZgSNhZGFdqxaiZgikCeDJ8UrGA8uom922t
Xz8M/4ZT9fN0RyqZ+mged0dcSqm/1xDj6MQe+vBEaHzIf31LntS8rzh2Wd6ATPRu
9QjoB59ysup+cb0DZSy6rzx+t5DtNqfqR1LObclLQd/6Tiw0VpAsFuwA1oGRB5Wd
3Nkh75k+YVVFfEFym1gH3ypxpY2TP6kqfjMupt+67cjW6/93RPWAhMX2L4jNKeaM
7nXrGR99IT2to6qiRXiK1HcVIOG3NSM+KHj2NXQ3AqaE3Kse5Y2wEo74uUlnj2Ql
0/9nHEcCT6bA1jMQN3qatDdoWcQjkfS0KsoM9MSk+mV5Y8muZcbBLcrqyL+LMEtI
isfYL9KgXXx31hcTTsid
=pi2K
-----END PGP SIGNATURE-----

--nNefFv5r6Ea+vcVx--
