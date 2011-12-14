Return-Path: <jic23@hermes.cam.ac.uk>
Date: 14 Dec 2011 14:17:49 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: michael.hennerich@analog.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
    device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/3] iio: gyro: ADXRS450: Add missing scale attributes
Message-ID: <Prayer.1.3.4.1112141417490.19575@hermes-2.csi.cam.ac.uk>
In-Reply-To: <1323864772-24051-1-git-send-email-michael.hennerich@analog.com>
References: <1323864772-24051-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Dec 14 2011, michael.hennerich@analog.com wrote:

>From: Michael Hennerich <michael.hennerich@analog.com>
>
>Add missing scale attributes.
>Temperature data is presented as 10-bit, twos complement number.
>Therefore use singed and shift accordingly.
>
>Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>---
> drivers/staging/iio/gyro/adxrs450_core.c |   24 ++++++++++++++++++++----
> 1 files changed, 20 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/ii=
o/gyro/adxrs450_core.c
>index e832aea..9d33628 100644
>--- a/drivers/staging/iio/gyro/adxrs450_core.c
>+++ b/drivers/staging/iio/gyro/adxrs450_core.c
>@@ -263,7 +263,7 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev=
,
> {
> =09int ret;
> =09s16 t;
>-=09u16 ut;
>+
> =09switch (mask) {
> =09case 0:
> =09=09switch (chan->type) {
>@@ -276,10 +276,10 @@ static int adxrs450_read_raw(struct iio_dev *indio_d=
ev,
> =09=09=09break;
> =09=09case IIO_TEMP:
> =09=09=09ret =3D adxrs450_spi_read_reg_16(indio_dev,
>-=09=09=09=09=09=09       ADXRS450_TEMP1, &ut);
>+=09=09=09=09=09=09       ADXRS450_TEMP1, &t);
> =09=09=09if (ret)
> =09=09=09=09break;
>-=09=09=09*val =3D ut;
>+=09=09=09*val =3D (t >> 6) + 225;
> =09=09=09ret =3D IIO_VAL_INT;
> =09=09=09break;
> =09=09default:
>@@ -287,6 +287,20 @@ static int adxrs450_read_raw(struct iio_dev *indio_de=
v,
> =09=09=09break;
> =09=09}
> =09=09break;
>+=09case IIO_CHAN_INFO_SCALE:
>+=09=09switch (chan->type) {
>+=09=09case IIO_ANGL_VEL:
>+=09=09=09*val =3D 0;
>+=09=09=09*val2 =3D 218166;
>+=09=09=09return IIO_VAL_INT_PLUS_NANO;
>+=09=09case IIO_TEMP:
>+=09=09=09*val =3D 200;
>+=09=09=09*val2 =3D 0;
>+=09=09=09return IIO_VAL_INT;
>+=09=09default:
>+=09=09=09return -EINVAL;
>+=09=09}
>+=09=09break;
> =09case IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW:
> =09=09ret =3D adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
> =09=09if (ret)
>@@ -308,11 +322,13 @@ static const struct iio_chan_spec adxrs450_channels[=
] =3D {
> =09=09.modified =3D 1,
> =09=09.channel2 =3D IIO_MOD_Z,
> =09=09.info_mask =3D IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
>-=09=09IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT,
>+=09=09IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT |
>+=09=09IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> =09}, {
> =09=09.type =3D IIO_TEMP,
> =09=09.indexed =3D 1,
> =09=09.channel =3D 0,
>+=09=09.info_mask =3D IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> =09}
> };
>=20
>
