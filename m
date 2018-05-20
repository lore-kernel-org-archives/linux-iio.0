Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeETKTz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 06:19:55 -0400
Date: Sun, 20 May 2018 11:19:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Silvan Murer <silvan.murer@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: fix missing of_match_table assignment in
 LTC2632 device
Message-ID: <20180520111948.3e14329f@archlinux>
In-Reply-To: <1526394782.32235.3.camel@gmail.com>
References: <1526394782.32235.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 15 May 2018 16:33:02 +0200
Silvan Murer <silvan.murer@gmail.com> wrote:

> This patch fix a missing og_match_table assignment in the LTC2632 device
>=20
> Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
Hi Silvan

It is useful, until you have your work flow sorted out if you try applying
the patches locally as by saving them out from your email.  It just
sanity checks that nothing has gone wrong.

Something very odd has gone on here.  Firstly I'm seeing some unusual
replacements for leading spaces and secondly some of the patch
offsets etc seem to be wrong.

Please have another go but definitely test you can save out your email
and successfully apply it to a clean tree.

Thanks,

Jonathan


> ---
> =C2=A0drivers/iio/dac/ltc2632.c | 19 ++++++++++---------
> =C2=A01 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index ac5e05f..d322b78 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -276,15 +276,6 @@ static const struct spi_device_id ltc2632_id[] =3D {
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(spi, ltc2632_id);
> =C2=A0
> -static struct spi_driver ltc2632_driver =3D {
> -	.driver		=3D {
> -		.name	=3D "ltc2632",
> -	},
> -	.probe		=3D ltc2632_probe,
> -	.id_table	=3D ltc2632_id,
> -};
> -module_spi_driver(ltc2632_driver);
> -
> =C2=A0static const struct of_device_id ltc2632_of_match[] =3D {
> =C2=A0	{
> =C2=A0		.compatible =3D "lltc,ltc2632-l12",
> @@ -309,6 +300,16 @@ static const struct of_device_id ltc2632_of_match[] =
=3D {
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, ltc2632_of_match);
> =C2=A0
> +static struct spi_driver ltc2632_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "ltc2632",
> +		.of_match_table =3D of_match_ptr(ltc2632_of_match),
> +	},
> +	.probe		=3D ltc2632_probe,
> +	.id_table	=3D ltc2632_id,
> +};
> +module_spi_driver(ltc2632_driver);
> +
> =C2=A0MODULE_AUTHOR("Maxime Roussin-Belanger <maxime.roussinbelanger@gmai=
l.com>");
> =C2=A0MODULE_DESCRIPTION("LTC2632 DAC SPI driver");
> =C2=A0MODULE_LICENSE("GPL v2");
> --=C2=A0
> 2.7.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

