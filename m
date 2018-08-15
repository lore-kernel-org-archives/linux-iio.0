Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42097 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUTz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 16:19:55 -0400
Date: Wed, 15 Aug 2018 19:27:00 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20180815172700.GA29039@gmail.com>
References: <20180815163852.GA4910@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
In-Reply-To: <20180815163852.GA4910@embeddedor.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 15, 2018 at 11:38:52AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Addresses-Coverity-ID: 1462408 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel=
/cros_ec_accel_legacy.c
> index 063e89e..d609654 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platfor=
m_device *pdev)
>  		switch (i) {
>  		case X:
>  			ec_accel_channels[X].scan_index =3D Y;
> +			/* fall through */
>  		case Y:
>  			ec_accel_channels[Y].scan_index =3D X;
> +			/* fall through */
>  		case Z:
>  			ec_accel_channels[Z].scan_index =3D Z;
>  		}

Hum, I'm not sure we are supposed to fall through here, even if it does
not hurt to do so.
I even think we can remove the switch and put that outside the for-loop,
e.g:

	ec_accel_channels[X].scan_index =3D Y;
	ec_accel_channels[Y].scan_index =3D X;
	ec_accel_channels[Z].scan_index =3D Z;

	for (i =3D X ; i < MAX_AXIS; i++) {
		if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID && i !=3D Y)
			state->sign[i] =3D -1;
		else
			state->sign[i] =3D 1;
	}


Best regards,
Marcus Folkesson


> --=20
> 2.7.4
>=20

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt0YmAACgkQiIBOb1ld
UjLeDw/+I5HcY7PZ8db/lQ3/nhoeswqUMgvdFBiatI0hczVsWU6XBDRRcKnXSF8v
ZAQd7otLNWIKQZWqPEIyeQmv2Nzf4Qm1vxlssrylTDOSQd/cx84XenrKqOyYk8WI
GpABy6WsNBVqnPPWdhpfdu0P9D/Tum3QCzsvNSJCNhZ5xl2bhoCCGxqUvz5s/9ZF
Um+FoXCJBS6j5/2u9127IAa7ftB2y5OIcfok9pancrfLJ8dqRCMTh+hDg2kaWYy3
BN0Fg7yYadX0OOa5AZBeA0I4FcfIrCa42yI22jiYPGMOUhzlz2G1IVcjDyDwxfXr
O9vgf2G7Gwm6Ht1dECvvYrRUPr1Mfx7KPaDket5HoFsOozZnN+YKFSk9z7yfxSfq
VeLNXB1AA+tjsDmv3C/0PCNYWloghwTFwUSKEIYF26y9Ac4r1EYeC3ddbQGGdxzd
qAdG3Paw53vUh2wL7CBkKrG3bHL1UHjvHF3mWsAMWgOY9J85VMaO8tmQ1bFiXD+j
Zf7vWQ3OnkuY3GyrZgVGd8iGD5ZTMIBfEPw//keZ98ssqhVihU0C1qCPt7lZfbQg
QmBm+kNnDwixI76imjSo/O1wMUliEwwFJDnc4I1HvZsr183ZgCdlQiTV7IM8sMAT
v5n7fxl6ybxl0qix4dmlCBvvXzpyw2H3MPjZwdf5BYPLqXFM+F4=
=NCRc
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
