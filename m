Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55124 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbbHQHTh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 03:19:37 -0400
Date: Mon, 17 Aug 2015 09:19:32 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 01/20] regmap: Add missing comments about struct
 regmap_bus
Message-ID: <20150817071932.GH19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-2-git-send-email-mpa@pengutronix.de>
 <55CBA8A6.7020404@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A2v+mM48+eG5yNzV"
In-Reply-To: <55CBA8A6.7020404@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--A2v+mM48+eG5yNzV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 10:12:22PM +0200, Hartmut Knaack wrote:
> Markus Pargmann schrieb am 12.08.2015 um 12:12:
> > There are some fields of this struct undocumented or old. This patch
> > updates the missing comments.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  include/linux/regmap.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> > index 59c55ea0f0b5..6ff83c9ddb45 100644
> > --- a/include/linux/regmap.h
> > +++ b/include/linux/regmap.h
> > @@ -296,8 +296,11 @@ typedef void (*regmap_hw_free_context)(void *conte=
xt);
> >   *                if not implemented  on a given device.
> >   * @async_write: Write operation which completes asynchronously, optio=
nal and
> >   *               must serialise with respect to non-async I/O.
> > + * @reg_write: Write operation for a register. Writes value to registe=
r.
> >   * @read: Read operation.  Data is returned in the buffer used to tran=
smit
> >   *         data.
> > + * @reg_read: Read operation for a register. Reads a value from a regi=
ster.
> > + * @free_conetext: Free context.
>=20
> Typo: free_context

Thanks, fixed for next version.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--A2v+mM48+eG5yNzV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0YsDAAoJEEpcgKtcEGQQSgEP/1aqdht+HdsuEHBG/OgVjN+V
BY0DaKT9nDOLbNTLfwEZccWl7+jh2UAvc0aDi4l6cTSCFHUQwvePOrMSbxzUGHlu
t3Bo7+KG4oC7Ogc5u8tvSkhMOqmP9Kh2oe6CQoJ6km89/DpW9fpkESZqve+3T1x8
6D1pVRxkqC4C8hJEmxZVCwp+E54xC54W/fgCKLZsvMH0yoQ21PTyjqmifVo0Ov3l
628ASOm2WaZ/fgqGSv0kPu+VgBsK6/+Ym+0tM6NxdNhnjt45RvJStRODnYam7I/d
vhVgYyCyxd0ykFS19fJ6w/vCmgNNzhwp5IHHzpC8c+5W2/c5wA6IkgiwLkGwFJX8
4KKiC9mVUYOxpQJcKvAXr40Q3HINwvQ6LVIqlNfAD2WoPm7kfjLjYRSbghW7i+iD
Ejkp3HXiY5aXxAEW0g7CvWCzgZsLn/0JRasuJnrlKIy1FM//y/GrOR3FTnyK+NBd
yTFQAY2rWs33Zmb0tG4IK0eyhCi1YlGrPkQwO9/vsijc6CE3+1uWMoGypf0hKWKw
0OcMWk9bX0nt1lA8IRG2NXXuzAJDghVNhG26GyQ6etjHE3o3AkGicXIcqRtk6OUc
8gpI1bF1bjFc/r4Dl3XqvYKxO0m8MoVCxXemVCpdDsxClcdrjzWf0PLhXbxz7hVv
bPh+YrKoG6B7gOhuZkOe
=OKKl
-----END PGP SIGNATURE-----

--A2v+mM48+eG5yNzV--
