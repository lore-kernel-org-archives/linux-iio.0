Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34984 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbHLMeR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:34:17 -0400
Date: Wed, 12 Aug 2015 14:34:12 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 11/20] regmap: _regmap_raw_read: Add handling of busses
 without bus->read()
Message-ID: <20150812123412.GG19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-12-git-send-email-mpa@pengutronix.de>
 <20150812112707.GY10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9H9VVCLI5QJPfUsZ"
In-Reply-To: <20150812112707.GY10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--9H9VVCLI5QJPfUsZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:27:07PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:36PM +0200, Markus Pargmann wrote:
>=20
> > +	/*
> > +	 * There are busses that do not have a read function as it is optiona=
l.
> > +	 * Use their reg_read function instead if the requested number of byt=
es
> > +	 * is correct.
> > +	 */
> > +	if (!map->bus->read) {
> > +		/*
> > +		 * bus_reg_read() does not support reading values that are not
> > +		 * exactly the size of format.val_bytes
> > +		 */
> > +		if (val_len !=3D map->format.val_bytes)
> > +			return -EINVAL;
> > +		return _regmap_bus_reg_read(map, reg, val);
> > +	}
>=20
> No, this makes no sense - if the device doesn't have a read operation
> then it doesn't support a raw data stream and hence can't support raw
> access sensibly.  Callers that want to access a lot of registers at once
> without knowing what the wire format for the device is should be using
> the bulk or multi interfaces.

Yes okay. Then I will reduce this patch to the following and put it
into regmap_read() instead?
	if (!map->bus->read) {
		return -EINVAL;

Is -EINVAL the right thing to return or would you prefer -ENOTSUPP?

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--9H9VVCLI5QJPfUsZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyz1EAAoJEEpcgKtcEGQQE7QP/1JjLnn/eFmUcbvLzc63GhAz
bEeJgX5EpGR7fpRH+IDJ89XoUVUn2hPHKmhMqzTjXOVfNze0T8FokKiha4sUT2dR
FzG6qLI5d92iPwq7dJFnvB6URTCPc1KZfqZPdDPtuI0iegkDg9LJ/2XPVl+ExBTZ
s4LPNCwnUlB8LOJWxQfaSjB9CXt3ENk6xp8mvzGc7WEYLsDibFouMdIoywnU5AwM
FV0pZr87XRKI7w+/eVb1CpAS8eHj/nfeKQIr2FAohslKsu3Jgm4G34NLZLkaaQrJ
W7PibDxpe1u0r1HhVR4j9sI2j61eRZ6yPIriPH8MLcPeIdckrPHODkIvgznNP2J4
tKj31apdQG/LRIS9lWgqBna4D4LE2xYTryVXdijF7p0symkH3ckEj78AyZCOkeF4
diHtUfz2/mrICH9GNcLDy+8vdzYoXqHqO6/gwty5vThDNgaCwxgtMq561CVaYAxu
aQM4NPbHaELiqk5RDOokddbrHe6OWNdLND7AIuMuHe66OX6lZavAmH4JTGr170aJ
8TPsJpnng1ohGDBeJUk1lYWHUoJmDZLe2ChHOLa5NxJohz1xQmnJ+lqnCpssUg6I
igdXG6g/7G82vu9K+VwrgM120K5iqMmE5Vfw8Px8Zfd0W2DdpWHZ2lck/8Alz0W9
6onmtuOJ8+nqzyJ2dMcJ
=khYy
-----END PGP SIGNATURE-----

--9H9VVCLI5QJPfUsZ--
