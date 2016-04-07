Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41777 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750963AbcDGGt5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Apr 2016 02:49:57 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/1] iio: gyro: bmg160: fix buffer read values
Date: Thu, 07 Apr 2016 08:49:34 +0200
Message-ID: <3060271.2J7W1aO51c@adelgunde>
In-Reply-To: <1459185346-18600-1-git-send-email-irina.tirdea@intel.com>
References: <1459185346-18600-1-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2882786.5W8LGWqXg4"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--nextPart2882786.5W8LGWqXg4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Monday 28 March 2016 20:15:46 Irina Tirdea wrote:
> When reading gyroscope axes using iio buffers, the values
> returned are always 0. In the interrupt handler, the return
> value of the read operation is returned to the user instead
> of the value read. Return the value read to the user.
>=20
> This is also fixed in commit 82d8e5da1a33 ("iio:
> accel: bmg160: optimize transfers in trigger handler").
>=20
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Thanks a lot for fixing all the bugs I introduced.

Best Regards,

Markus

> ---
>  drivers/iio/gyro/bmg160_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160=
_core.c
> index 295cf1d..e165ce9 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -781,7 +781,7 @@ static irqreturn_t bmg160_trigger_handler(int irq=
, void *p)
>  =09=09=09mutex_unlock(&data->mutex);
>  =09=09=09goto err;
>  =09=09}
> -=09=09data->buffer[i++] =3D ret;
> +=09=09data->buffer[i++] =3D val;
>  =09}
>  =09mutex_unlock(&data->mutex);
> =20
>=20

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart2882786.5W8LGWqXg4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXBgMMAAoJEEpcgKtcEGQQifUQALXBD1xDtJz3YAbLGWjGEg9m
a9AWm31pAi6De0rGQZfcSZvLEex4sHTHqo84P2ttXv79jPBUbTCnDLykijC3+fjb
9inGG72awp3tnckwGfgc26PnJX4/98lZvhXLXQ8SRtCp8n1ow/GgZJfHQ9rnZHTD
WTqqSaZfEaKBxIHpwpzV0AJRs7XeVG3hhpCAo6v/bVPzAzwl2mC43hclEVqKh6WF
F65NhWmLt4rl6yam++LgPSdK/5SL93tP/6xaE9/0exrEmtVKiwWwmQEXEtWbKDNU
R+1Ax48OaLO6eh+rZMaSoyTShMhph44Qu39hdtf5tRpm0EcSjJeB2lvuSUV83WnD
mZ1Z5enUVdYLXG0UznRjsxGL5uGce6cBDQFlSnsMY7O7/iESFcKwx6NfXxJUzg1F
riz8ONjKpBPr3YeS8hHpF1JXV15gxkhMl/Eb9nd5iAkJW9kP8+9+01UxPqXOUKhS
pB2W8rT0nGw/9UbcA9a4QtwLYPzLvFZIBeoXGk2kj2A1zW2dKxEWgwtbtW0qsXhZ
kUJWlEMJp3xKNbFqtpzzkTSOvhAeG9vdvsVNsgW5gSX9vuzHUrAVFV6gxVBDbMNo
h8tS72F/D+3RP60Px3stkQ45iJKAHHL5gHZtRyCZspfbI3zqUNQy8luJ+GjmR+pR
Xzp3kpyDIcp9/+pmXln0
=DdFs
-----END PGP SIGNATURE-----

--nextPart2882786.5W8LGWqXg4--

