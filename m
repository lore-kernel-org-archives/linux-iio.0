Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35516 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755136AbcH0Iv5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Aug 2016 04:51:57 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so5902002pad.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Aug 2016 01:51:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] iio: temperature: fix non static symbol warnings
From: Matt Ranostay <mranostay@gmail.com>
In-Reply-To: <1472222000-1163-1-git-send-email-weiyj.lk@gmail.com>
Date: Sat, 27 Aug 2016 01:51:53 -0700
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Message-Id: <F9B1372A-28A3-4B3B-98CA-09BDA439A97D@gmail.com>
References: <1472222000-1163-1-git-send-email-weiyj.lk@gmail.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reviewed-By: Matt Ranostay <mranostay@gmail.com>

> On Aug 26, 2016, at 07:33, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> Fixes the following sparse warnings:
>=20
> drivers/iio/temperature/maxim_thermocouple.c:35:28: warning:
> symbol 'max6675_channels' was not declared. Should it be static?
> drivers/iio/temperature/maxim_thermocouple.c:52:28: warning:
> symbol 'max31855_channels' was not declared. Should it be static?
> drivers/iio/temperature/maxim_thermocouple.c:98:38: warning:
> symbol 'maxim_thermocouple_chips' was not declared. Should it be static?
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> drivers/iio/temperature/maxim_thermocouple.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/te=
mperature/maxim_thermocouple.c
> index 030827e..39dd202 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -32,7 +32,7 @@ enum {
>    MAX31855,
> };
>=20
> -const struct iio_chan_spec max6675_channels[] =3D {
> +static const struct iio_chan_spec max6675_channels[] =3D {
>    {    /* thermocouple temperature */
>        .type =3D IIO_TEMP,
>        .info_mask_separate =3D
> @@ -49,7 +49,7 @@ const struct iio_chan_spec max6675_channels[] =3D {
>    IIO_CHAN_SOFT_TIMESTAMP(1),
> };
>=20
> -const struct iio_chan_spec max31855_channels[] =3D {
> +static const struct iio_chan_spec max31855_channels[] =3D {
>    {    /* thermocouple temperature */
>        .type =3D IIO_TEMP,
>        .address =3D 2,
> @@ -95,7 +95,7 @@ struct maxim_thermocouple_chip {
>    u32 status_bit;
> };
>=20
> -const struct maxim_thermocouple_chip maxim_thermocouple_chips[] =3D {
> +static const struct maxim_thermocouple_chip maxim_thermocouple_chips[] =3D=
 {
>    [MAX6675] =3D {
>            .channels =3D max6675_channels,
>            .num_channels =3D ARRAY_SIZE(max6675_channels),
>=20
>=20
>=20
