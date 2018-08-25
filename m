Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeHYMJP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Aug 2018 08:09:15 -0400
Date: Sat, 25 Aug 2018 09:30:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29501: Simplify code to kill compiler
 warning
Message-ID: <20180825093055.2cee2159@archlinux>
In-Reply-To: <20180823212436.17423-1-geert@linux-m68k.org>
References: <20180823212436.17423-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 23 Aug 2018 23:24:35 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> With gcc 4.1.2:
>=20
>     drivers/iio/proximity/isl29501.c: In function =E2=80=98isl29501_regis=
ter_write=E2=80=99:
>     drivers/iio/proximity/isl29501.c:235: warning: =E2=80=98msb=E2=80=99 =
may be used uninitialized in this function
>=20
> While this is a false positive, it can easily be avoided by removing the
> "msb" intermediate variable.
> Remove the "lsb" intermediate variable for consistency.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks sensible to me, but I'd obviously like to leave a little time for=20
Mathieu to comment as it's his driver.

Jonathan

> ---
> Compile-tested only.
> ---
>  drivers/iio/proximity/isl29501.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl=
29501.c
> index e5e94540f404dd2c..5ae549075b27c50d 100644
> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -232,7 +232,6 @@ static u32 isl29501_register_write(struct isl29501_pr=
ivate *isl29501,
>  				   u32 value)
>  {
>  	const struct isl29501_register_desc *reg =3D &isl29501_registers[name];
> -	u8 msb, lsb;
>  	int ret;
> =20
>  	if (!reg->msb && value > U8_MAX)
> @@ -241,22 +240,15 @@ static u32 isl29501_register_write(struct isl29501_=
private *isl29501,
>  	if (value > U16_MAX)
>  		return -ERANGE;
> =20
> -	if (!reg->msb) {
> -		lsb =3D value & 0xFF;
> -	} else {
> -		msb =3D (value >> 8) & 0xFF;
> -		lsb =3D value & 0xFF;
> -	}
> -
>  	mutex_lock(&isl29501->lock);
>  	if (reg->msb) {
>  		ret =3D i2c_smbus_write_byte_data(isl29501->client,
> -						reg->msb, msb);
> +						reg->msb, value >> 8);
>  		if (ret < 0)
>  			goto err;
>  	}
> =20
> -	ret =3D i2c_smbus_write_byte_data(isl29501->client, reg->lsb, lsb);
> +	ret =3D i2c_smbus_write_byte_data(isl29501->client, reg->lsb, value);
> =20
>  err:
>  	mutex_unlock(&isl29501->lock);
