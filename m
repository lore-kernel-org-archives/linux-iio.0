Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1273098346-4184-7-git-send-email-jic23@cam.ac.uk>
References: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
	<1273098346-4184-7-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 6 May 2010 11:27:28 +0800
Message-ID: <t2z3c17e3571005052027i5d79afb3of2d16e49e47583fd@mail.gmail.com>
Subject: Re: [PATCH 6/6] staging:iio:imu remove unecessary empty defs for
	event attributes.
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Does this patch work in the newest tree? In our current tree, it will
cause kernel panic in iio_register_interrupt_line() due to NULL
pointer.
-barry

On Thu, May 6, 2010 at 6:25 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
> =C2=A0drivers/staging/iio/imu/adis16300_core.c | =C2=A0 10 ----------
> =C2=A0drivers/staging/iio/imu/adis16400_core.c | =C2=A0 10 ----------
> =C2=A02 files changed, 0 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/i=
io/imu/adis16300_core.c
> index 5a7e5ef..54e3e51 100644
> --- a/drivers/staging/iio/imu/adis16300_core.c
> +++ b/drivers/staging/iio/imu/adis16300_core.c
> @@ -566,14 +566,6 @@ static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1=
638");
>
> =C2=A0static IIO_CONST_ATTR(name, "adis16300");
>
> -static struct attribute *adis16300_event_attributes[] =3D {
> - =C2=A0 =C2=A0 =C2=A0 NULL
> -};
> -
> -static struct attribute_group adis16300_event_attribute_group =3D {
> - =C2=A0 =C2=A0 =C2=A0 .attrs =3D adis16300_event_attributes,
> -};
> -
> =C2=A0static struct attribute *adis16300_attributes[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_dev_attr_accel_x_offset.dev_attr.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_dev_attr_accel_y_offset.dev_attr.attr,
> @@ -637,8 +629,6 @@ static int __devinit adis16300_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->dev.parent =3D &spi->dev;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->num_interrupt_lines =3D 1;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->event_attrs =3D &adis16300_event_at=
tribute_group;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->attrs =3D &adis16300_attribute_=
group;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->dev_data =3D (void *)(st);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->driver_module =3D THIS_MODULE;
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/i=
io/imu/adis16400_core.c
> index 2c10072..34c0ee5 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -595,14 +595,6 @@ static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1=
638");
>
> =C2=A0static IIO_CONST_ATTR(name, "adis16400");
>
> -static struct attribute *adis16400_event_attributes[] =3D {
> - =C2=A0 =C2=A0 =C2=A0 NULL
> -};
> -
> -static struct attribute_group adis16400_event_attribute_group =3D {
> - =C2=A0 =C2=A0 =C2=A0 .attrs =3D adis16400_event_attributes,
> -};
> -
> =C2=A0static struct attribute *adis16400_attributes[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_dev_attr_accel_x_offset.dev_attr.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_dev_attr_accel_y_offset.dev_attr.attr,
> @@ -669,8 +661,6 @@ static int __devinit adis16400_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->dev.parent =3D &spi->dev;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->num_interrupt_lines =3D 1;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->event_attrs =3D &adis16400_event_at=
tribute_group;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->attrs =3D &adis16400_attribute_=
group;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->dev_data =3D (void *)(st);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->driver_module =3D THIS_MODULE;
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
