Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:51210 "EHLO bytesatwork.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932383AbbBBQTG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Feb 2015 11:19:06 -0500
Message-ID: <54CFA1E7.4020907@bytesatwork.ch>
Date: Mon, 02 Feb 2015 17:12:23 +0100
From: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
To: lars@metafoo.de
CC: urs.fassler@bytesatwork.ch, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: ad5686: fix optional reference voltage declaration
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8g9JDogEkJEhT6LnmdFNWaROUiffUjR5v"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8g9JDogEkJEhT6LnmdFNWaROUiffUjR5v
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When not using the "_optional" function, a dummy regulator is returned
and the driver fails to initialize.

Signed-off-by: Urs F=C3=A4ssler <urs.fassler@bytesatwork.ch>
---
 drivers/iio/dac/ad5686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index f57562a..15c73e2 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -322,7 +322,7 @@ static int ad5686_probe(struct spi_device *spi)
 	st =3D iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 -	st->reg =3D devm_regulator_get(&spi->dev, "vcc");
+	st->reg =3D devm_regulator_get_optional(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret =3D regulator_enable(st->reg);
 		if (ret)
--=20
2.1.4



--8g9JDogEkJEhT6LnmdFNWaROUiffUjR5v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz6HnAAoJEKKADLnESIBj570P/j2UFvf/xderobyrjqTPHEgL
8v3TE8Sjzq8VaKJNTZ80Fug5AhEOsuwhIUhzWtSKsKW3xd7J6ufzHIG6WY8uTb7u
aClRtRs/mxbVeQsyHYt6F436JPmkOno12Djs2DTWW5NZ08xL53516uXVw57fmYA+
F8YyNuJQy5oPGayOalEH9njSON7ntx2luwfz8e9QcyMHHejUKpdfa16GI2ERpZfS
tUrjmmMoVmXhzJVwecdOIeY3MDP78IJO6szsIMEMSMLzfcIERshSxqhXEbPhJJAe
cUzVN83S9gcfvqDij6e9u1m6p9s6nb/nPrDPB0Uhsr5bUm1kosGERHj+erL2T0Nh
HYlVN1kP6/6DhCFlmFcX/respeBjUT8p1XPJeBakII7tqrr3ufHgbzJlrcxz9XOm
ZkKKDxxNK4SywzNQwEg3MIYzBCGv+XBUBzDogpDZ338i56FUCI3yQ6rEmsasPL+S
KrZLE2ahaWZ+hgNXnicA1Xfb12PVKiBXj5dzYdY6cqlPC8Di1j1hJJ0x2Nr845Wj
UPqmwPVvdmWrowq6kQ73TXF+QJxI3kVxJ5YvODv+P4UetPkfVoInA4rV2wwJ32p5
uXYx3Z+cEy0wnTo7zSAhTRMTFdek5OQUzCykizV8mqAPe1MJiI9TBYRZr5KAsBg0
8aO0vJJ3Wxzug88ASc4Z
=LtsT
-----END PGP SIGNATURE-----

--8g9JDogEkJEhT6LnmdFNWaROUiffUjR5v--
