Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50553 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbbHQHYH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 03:24:07 -0400
Date: Mon, 17 Aug 2015 09:24:03 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 16/20] iio: bmc150: Fix irq checks
Message-ID: <20150817072403.GI19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-17-git-send-email-mpa@pengutronix.de>
 <55CF3AEA.2070508@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKe3pS/mJXs3y/nh"
In-Reply-To: <55CF3AEA.2070508@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--jKe3pS/mJXs3y/nh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 02:13:14PM +0100, Jonathan Cameron wrote:
> On 12/08/15 11:12, Markus Pargmann wrote:
> > Valid irqs are > 0. This patch fixes the check which fails for the new
> > spi driver part if no interrupt was given.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> This one crossed with Octavian's patch that cleaned up all cases of this.
> c176becd81843 iio: fix drivers that consider 0 as a valid IRQ in client->=
irq
>=20
> Hence you can drop this one from the v2 of this series.

Thanks, didn't notice this. Will drop it.

Best regards,

Markus

>=20
> (Its amazing how many times we get multiple patches for the same issue th=
at
> has been there for ages in the same week or so!)
>=20
> Jonathan
> > ---
> >  drivers/iio/accel/bmc150-accel.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc15=
0-accel.c
> > index 4e70f51c2370..fe2d2316158f 100644
> > --- a/drivers/iio/accel/bmc150-accel.c
> > +++ b/drivers/iio/accel/bmc150-accel.c
> > @@ -1660,10 +1660,10 @@ static int bmc150_accel_probe(struct i2c_client=
 *client,
> >  		return ret;
> >  	}
> > =20
> > -	if (client->irq < 0)
> > +	if (client->irq <=3D 0)
> >  		client->irq =3D bmc150_accel_gpio_probe(client, data);
> > =20
> > -	if (client->irq >=3D 0) {
> > +	if (client->irq > 0) {
> >  		ret =3D devm_request_threaded_irq(
> >  						&client->dev, client->irq,
> >  						bmc150_accel_irq_handler,
> >=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--jKe3pS/mJXs3y/nh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0YwSAAoJEEpcgKtcEGQQ0FYP/iVeaxHuLK84JbRUAq0Mqvio
EqhuQXW+LNouRBI65C77z+luKDZy/9STInuEYc43yUtWDhvq3c0sslDyLoZnsVNM
PEgnMNpiIpG/pvFEyJmhZXmAnzAuW2kW1KBgqZOWJMACUpa/xHJvaipRCaMMCte8
dAzXeGRTkD7riiXFWqyyH4/mhNe8plmK+FW40eXc1qienjmG9ZMeAlNazYKu8kcR
qYlpLsG5gz1z8wAzdh+zrDGS6zQkMBTGD+sDX0D4EpNi5DXDRP9HbKoyjr2vtUQs
XX6xPRd0h7NL2wuDT783xmgLGxhPULNzEPe9zWKXe1YZhjXeb3x2Rku5I5C0KmYj
+lWoHXV8QoSfY0KyKwQ2CEVAQqYWy8Z7eES/dQo029QaZ8IOWgQ5fF+bqrLWGlZu
oq8NWzjNVxMevGA27ocENCjgMavJm1yBW4BNmPPlOo9c7W3CmMgGA5DoHUUKIuBH
9Y0T6gzHQTxfkXgSSU031R8xSXrW7KvAxEZ8YT1cpinGq3Dk1Iqje9b5qHCy+Wxz
lIixXdEoCgmRkuIEjER0u7EZpQ+V4jHadALrHTW+WZg2nOu2yOJFVn4fQgDnzDdD
QkzcPN4ytKJUUJFu3GqgoLL5wHGnIgU2YG3gnVrTHzt1jNvi1KfdN43B+w82gC5Q
GhaEGBy8a1c0sIp5u5DX
=nFov
-----END PGP SIGNATURE-----

--jKe3pS/mJXs3y/nh--
