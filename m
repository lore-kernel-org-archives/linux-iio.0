Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>, "manuel.stahl@iis.fraunhofer.de"
	<manuel.stahl@iis.fraunhofer.de>
Date: Wed, 13 Jul 2011 12:03:01 +0100
Subject: RE: [PATCH 3/4] staging:iio:imu:adis16400: use strtobool for reset
 sysfs and don't assign unused tx members.
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713EA0CD0E5A@LIMKCMBX1.ad.analog.com>
References: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
 <1310399887-4049-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310399887-4049-4-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-07-11:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/imu/adis16400_core.c |   23 +++++++++++-----------
>  - 1 files changed, 11 insertions(+), 12 deletions(-)
> diff --git a/drivers/staging/iio/imu/adis16400_core.c
> b/drivers/staging/iio/imu/adis16400_core.c index f034330..75d4734 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c +++
> b/drivers/staging/iio/imu/adis16400_core.c @@ -146,8 +146,6 @@ static
> int adis16400_spi_read_reg_16(struct iio_dev *indio_dev,
>       mutex_lock(&st->buf_lock);
>       st->tx[0] =3D ADIS16400_READ_REG(lower_reg_address);
>       st->tx[1] =3D 0;
> -     st->tx[2] =3D 0;
> -     st->tx[3] =3D 0;
>
>       spi_message_init(&msg);         spi_message_add_tail(&xfers[0], &ms=
g); @@
>  -236,17 +234,18 @@ static ssize_t adis16400_write_reset(struct device
>  *dev,                struct device_attribute *attr,          const char =
*buf, size_t len) {
> -     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +     bool val;
> +     int ret;
>
> -     if (len < 1)
> -             return -1;
> -     switch (buf[0]) {
> -     case '1':
> -     case 'y':
> -     case 'Y':
> -             return adis16400_reset(indio_dev);
> -     }
> -     return -1;
> +     ret =3D strtobool(buf, &val);
> +     if (ret < 0)
> +             return ret;
> +     if (val)
> +             ret =3D adis16400_reset(dev_get_drvdata(dev));
> +     if (ret < 0)
> +             return ret;
> +
> +     return len;
>  }
>
>  int adis16400_set_irq(struct iio_dev *indio_dev, bool enable)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
