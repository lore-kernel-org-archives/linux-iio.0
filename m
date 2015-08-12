Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47675 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbHLMUN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:20:13 -0400
Date: Wed, 12 Aug 2015 14:20:11 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, kernel@pengutronix.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without
 write()
Message-ID: <20150812122011.GE19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
 <20150812112035.GX10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gnkm4uF329L9IN0W"
In-Reply-To: <20150812112035.GX10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Gnkm4uF329L9IN0W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:20:35PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:34PM +0200, Markus Pargmann wrote:
>=20
> > @@ -1229,6 +1229,11 @@ int _regmap_raw_write(struct regmap *map, unsign=
ed int reg,
> >  		}
> >  	}
> > =20
> > +	if (!map->bus->write && val_len =3D=3D map->format.val_bytes) {
> > +		ret =3D _regmap_bus_reg_write(map, reg, *(unsigned int *)val);
> > +		return ret;
> > +	}
>=20
> This is broken - you can't use a raw value as a register value.  The

I am not sure what you mean here?

The register value given to _regmap_raw_write is the real register
value, not formatted differenty. This is given directly towards
bus->reg_write() which should handle the rest.

At least that's how I understood the code. For example regmap_read()
directly calls _regmap_read() which in turn calls directly
bus->reg_read() without any formating.

> endianness of the device may not be the same as the endianness of the
> system and you can't cast a value to unsigned int, the value may be of
> any size.

Yes right. On the other hand if bus->read() and bus->write() was not set
in the init method (before this patch series) no formatting functions at
all were assigned. So it was always ignored for bus->reg_read() and
bus->reg_write()?!

>=20
> > @@ -1340,7 +1345,7 @@ int _regmap_raw_write(struct regmap *map, unsigne=
d int reg,
> >  	 * send the work_buf directly, otherwise try to do a gather
> >  	 * write.
> >  	 */
> > -	if (val =3D=3D work_val) {
> > +	if (val =3D=3D work_val && map->bus->write) {
> >  		ret =3D map->bus->write(map->bus_context, map->work_buf,
> >  				      map->format.reg_bytes +
> >  				      map->format.pad_bytes +
>=20
> This appears to be another case of merging an unrelated change :(

Yes, will fix.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Gnkm4uF329L9IN0W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyzn7AAoJEEpcgKtcEGQQmzUP/0UupbXwQngtzhqcxcuPdJrR
LuQ1bOYWrstypXAVpDfOESynRznH6jR60zql1BAlvrFR9AFu6L2p81LwbUTkcBwN
sHwa4VsOjBFYZN5QWZwCxkZlyA2+0x4HJ0sBD7zYD69MGsdSxgbdub27Yr2PlqRe
3hzcoWu9g8wqzjVawBpI0EEUvhAL59SMR/3+SlsI/SbHG28FduQla2/cr1fKBFED
nsBdet3X/d44skvsv0z6DTIBDSS0/BFKHlIFWme6HNEzMyAHzkQZwZ3BsRkzv+St
QLdTqw/LqUjYtYFpVyxcnbgXFIoKe5J2top9Vt7W7ru1/Utllk3gEfKOqflSYctQ
dhPqKUZWU0ZqKrDTcur7h7E6T+Ys4Nb8F19QysEUf4WthNHe2fNDl0yhLQ03/+9O
bT/aYCyl+ba+IKUpzmFMJoiXLH87GSTiDhJ6v4UD4e/fWxip/5gO84qTDxQfwrPK
sqbIndh692LdOUvTse6trH2H4RQfbfW12SGB6uGV8hWhaUubfeMmQaU38R8oWFuA
CrFtT+Oiz8PhOOyv34fPY1mG3QZJixad8AtWmZhYi+lOVCOGKLFosWyeSHPgcaeY
Tcza74tkbm8TXx6md9dBgA8/VcXcap5QRZ8/QxXpa/Fynp5sglBTpfvbBd0iSbvZ
DgKwTm1Dx610sTV70jkN
=z0bo
-----END PGP SIGNATURE-----

--Gnkm4uF329L9IN0W--
