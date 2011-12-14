Return-Path: <jic23@hermes.cam.ac.uk>
Date: 14 Dec 2011 14:17:04 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: michael.hennerich@analog.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
    device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/3] iio: gyro: ADXRS450: Add missing read support for calibbias
 attribute
Message-ID: <Prayer.1.3.4.1112141417041.19575@hermes-2.csi.cam.ac.uk>
In-Reply-To: <1323864772-24051-2-git-send-email-michael.hennerich@analog.com>
References: <1323864772-24051-1-git-send-email-michael.hennerich@analog.com>
 <1323864772-24051-2-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Dec 14 2011, michael.hennerich@analog.com wrote:

>From: Michael Hennerich <michael.hennerich@analog.com>
>
>
>Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>---
> drivers/staging/iio/gyro/adxrs450_core.c |    7 +++++++
> 1 files changed, 7 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/ii=
o/gyro/adxrs450_core.c
>index 9d33628..a146d55 100644
>--- a/drivers/staging/iio/gyro/adxrs450_core.c
>+++ b/drivers/staging/iio/gyro/adxrs450_core.c
>@@ -308,6 +308,13 @@ static int adxrs450_read_raw(struct iio_dev *indio_de=
v,
> =09=09*val =3D t;
> =09=09ret =3D IIO_VAL_INT;
> =09=09break;
>+=09case IIO_CHAN_INFO_CALIBBIAS:
>+=09=09ret =3D adxrs450_spi_read_reg_16(indio_dev, ADXRS450_DNC1, &t);
>+=09=09if (ret)
>+=09=09=09break;
>+=09=09*val =3D t;
>+=09=09ret =3D IIO_VAL_INT;
>+=09=09break;
> =09default:
> =09=09ret =3D -EINVAL;
> =09=09break;
>
