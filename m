Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54381 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbbHLMis (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:38:48 -0400
Date: Wed, 12 Aug 2015 14:38:44 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 12/20] regmap: Introduce max_raw_io for
 regmap_bulk_read/write
Message-ID: <20150812123844.GH19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-13-git-send-email-mpa@pengutronix.de>
 <20150812114931.GZ10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QeLBvw8fqdL68NWb"
In-Reply-To: <20150812114931.GZ10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--QeLBvw8fqdL68NWb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:49:31PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:37PM +0200, Markus Pargmann wrote:
>=20
> > +	/* if set, raw reads/writes are limited to this size */
> > +	size_t max_raw_io;
> > +
>=20
> Do this separately for read and write, there's doubtless going to be
> something that has asymmetry.

Okay.

>=20
> > +		if (!map->use_single_rw) {
> > +			write_count =3D total_bytes / map->max_raw_io;
> > +			write_bytes =3D map->max_raw_io;
>=20
> We may not be able to fit a whole number of values into whatever the
> constraint that the bus has is and partial values don't seem like a good
> idea.

Oh right. Will change the calculation so that there are no partial
values being written.

>=20
> > +			reg_stride *=3D write_bytes / val_bytes;
> > +		}
>=20
> This is very confusing, regmap already has a concept of stride and this
> isn't the same thing.

Okay, will rename it.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--QeLBvw8fqdL68NWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyz5TAAoJEEpcgKtcEGQQCJMQAKSta+Up5y+sjHGZSdIr0ojc
orsdKRiKBUMDnq7DnJlCC4BnMEG0JgTnzv7QpR/rpskMB8cbKNLBZyimT8Sp/zkm
B7FZAK/8Et1HvwO8D5Q/Tqo31zs3qRYDQAG/9rvA2sLJlmz1vo+L8xaDEHuVkgHK
MTVTaV3cER0T058GFKT3wWaZ+oMfM2TroxlEHBDf9js0TuPNqf9wzy3ejq5XryR5
9Pdw92jCTAXjQFpvdocMXPjtAcgFXr7pQ3rAxrUkQOXS1eErDHLpfiamaiGaQcse
AVIh+yaAsy/s8ZdMyem3RUN59iDbn31hWrHq7nyhN+XN/rX4Wj0jyXOzZWTq+fzF
fqG+fmo9KEsoqHBxjdYStUbdYLMcBEyrTkbs4sFOkN1p9SxJinE887orU+m+qfIf
79dr9Oe2ncKfQN3iid0lo+xB+URHXnSkbzvU7uq+Zhvbrbpfjch+nnTON7hfOG0x
A36gHFmM3lg/US7Dzd6sXxizFukgRy/leC6c9WEq/8utP02ll3RUz7m1n8BcYBK+
bGFYHFm0g34miq3tmVM8u3nb2u3/xqbEnOqqnMSs/SPyDdjpLgJAd5TZHZeI9uzR
QiLYNXZ4OEJ+WU8OURGIf/Gss4bV1qG5X0gKmCbJxc6aNAndKpisPKshc0HtMUiE
8Ff3BV1QPt2L1Go2jXja
=u7AH
-----END PGP SIGNATURE-----

--QeLBvw8fqdL68NWb--
