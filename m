Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277481314-31717-7-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-2-git-send-email-jic23@cam.ac.uk> <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-4-git-send-email-jic23@cam.ac.uk> <1277481314-31717-5-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-6-git-send-email-jic23@cam.ac.uk> <1277481314-31717-7-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 30 Jun 2010 12:18:52 +0800
Message-ID: <AANLkTilI13JvPViGEo6XkVqECcLltLz-bGZ4NNTgW-jb@mail.gmail.com>
Subject: Re: [PATCH 6/6] staging:iio: replace combine_8_to_16 with
	be16_to_cpup where possible.
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry.Song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 25, 2010 at 11:55 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
> ---
>
> =C2=A0In think I have this one the right way round, but please can someon=
e check!
> =C2=A0The combine_8_to_16 does more complex things in lis3l02dq but copy
> =C2=A0and paste has led to it turning up in lots of places where it isn't
> =C2=A0needed.
>
> =C2=A0Barry Song's RFC made this obvious.
>
> =C2=A0drivers/staging/iio/accel/adis16209_ring.c | =C2=A0 16 ++----------=
----
> =C2=A0drivers/staging/iio/accel/adis16240_ring.c | =C2=A0 16 ++----------=
----
> =C2=A0drivers/staging/iio/gyro/adis16260_ring.c =C2=A0| =C2=A0 16 ++-----=
---------
> =C2=A0drivers/staging/iio/imu/adis16300_ring.c =C2=A0 | =C2=A0 16 ++-----=
---------
> =C2=A0drivers/staging/iio/imu/adis16350_ring.c =C2=A0 | =C2=A0 16 ++-----=
---------
> =C2=A0drivers/staging/iio/imu/adis16400_ring.c =C2=A0 | =C2=A0 16 ++-----=
---------
> =C2=A06 files changed, 12 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging=
/iio/accel/adis16209_ring.c
> index ad71538..53a7677 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -17,16 +17,6 @@
> =C2=A0#include "../trigger.h"
> =C2=A0#include "adis16209.h"
>
> -/**
> - * combine_8_to_16() utility function to munge to u8s into u16
> - **/
> -static inline u16 combine_8_to_16(u8 lower, u8 upper)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 _lower =3D lower;
> - =C2=A0 =C2=A0 =C2=A0 u16 _upper =3D upper;
> - =C2=A0 =C2=A0 =C2=A0 return _lower | (_upper << 8);
> -}
> -
> =C2=A0static IIO_SCAN_EL_C(supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14=
),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADI=
S16209_SUPPLY_OUT, NULL);
> =C2=A0static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
> @@ -139,10 +129,8 @@ static void adis16209_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_count)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adis16209_read=
_ring_data(&st->indio_dev->dev, st->rx) >=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1=
],
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->rx[i*2]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D be16_to_cpup((__be16 *)&(st-=
>rx[i*2]));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte bounda=
ry */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging=
/iio/accel/adis16240_ring.c
> index 5cced2e..88269a0 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -17,16 +17,6 @@
> =C2=A0#include "../trigger.h"
> =C2=A0#include "adis16240.h"
>
> -/**
> - * combine_8_to_16() utility function to munge to u8s into u16
> - **/
> -static inline u16 combine_8_to_16(u8 lower, u8 upper)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 _lower =3D lower;
> - =C2=A0 =C2=A0 =C2=A0 u16 _upper =3D upper;
> - =C2=A0 =C2=A0 =C2=A0 return _lower | (_upper << 8);
> -}
> -
> =C2=A0static IIO_SCAN_EL_C(supply, ADIS16240_SCAN_SUPPLY, IIO_UNSIGNED(10=
),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16240_SUPPLY_O=
UT, NULL);
> =C2=A0static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, IIO_SIGNED(10),
> @@ -131,10 +121,8 @@ static void adis16240_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_count)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adis16240_read=
_ring_data(&st->indio_dev->dev, st->rx) >=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1=
],
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 st->rx[i*2]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D be16_to_cpup((__be16 *)&(st-=
>rx[i*2]));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte bounda=
ry */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/=
iio/gyro/adis16260_ring.c
> index 97d7660..59f1beb 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -17,16 +17,6 @@
> =C2=A0#include "../trigger.h"
> =C2=A0#include "adis16260.h"
>
> -/**
> - * combine_8_to_16() utility function to munge to u8s into u16
> - **/
> -static inline u16 combine_8_to_16(u8 lower, u8 upper)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 _lower =3D lower;
> - =C2=A0 =C2=A0 =C2=A0 u16 _upper =3D upper;
> - =C2=A0 =C2=A0 =C2=A0 return _lower | (_upper << 8);
> -}
> -
> =C2=A0static IIO_SCAN_EL_C(supply, ADIS16260_SCAN_SUPPLY, IIO_UNSIGNED(12=
),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16260_SUPPLY_O=
UT, NULL);
> =C2=A0static IIO_SCAN_EL_C(gyro, ADIS16260_SCAN_GYRO, IIO_SIGNED(14),
> @@ -134,10 +124,8 @@ static void adis16260_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_count)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adis16260_read=
_ring_data(&st->indio_dev->dev, st->rx) >=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1=
],
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 st->rx[i*2]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D be16_to_cpup((__be16 *)&(st-=
>rx[i*2]));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte bounda=
ry */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/i=
io/imu/adis16300_ring.c
> index 6b25f12..64f02f5 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -17,16 +17,6 @@
> =C2=A0#include "../trigger.h"
> =C2=A0#include "adis16300.h"
>
> -/**
> - * combine_8_to_16() utility function to munge to u8s into u16
> - **/
> -static inline u16 combine_8_to_16(u8 lower, u8 upper)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 _lower =3D lower;
> - =C2=A0 =C2=A0 =C2=A0 u16 _upper =3D upper;
> - =C2=A0 =C2=A0 =C2=A0 return _lower | (_upper << 8);
> -}
> -
> =C2=A0static IIO_SCAN_EL_C(supply, ADIS16300_SCAN_SUPPLY, IIO_UNSIGNED(14=
),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADI=
S16300_SUPPLY_OUT, NULL);
>
> @@ -158,10 +148,8 @@ static void adis16300_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_count)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adis16300_spi_=
read_burst(&st->indio_dev->dev, st->rx) >=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1=
],
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->rx[i*2]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D be16_to_cpup((__be16 *)&(st-=
>rx[i*2]));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte bounda=
ry */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/i=
io/imu/adis16350_ring.c
> index 28c13ef..f817bfd 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -17,16 +17,6 @@
> =C2=A0#include "../trigger.h"
> =C2=A0#include "adis16350.h"
>
> -/**
> - * combine_8_to_16() utility function to munge to u8s into u16
> - **/
> -static inline u16 combine_8_to_16(u8 lower, u8 upper)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 _lower =3D lower;
> - =C2=A0 =C2=A0 =C2=A0 u16 _upper =3D upper;
> - =C2=A0 =C2=A0 =C2=A0 return _lower | (_upper << 8);
> -}
> -
> =C2=A0static IIO_SCAN_EL_C(supply, ADIS16350_SCAN_SUPPLY, IIO_UNSIGNED(12=
),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16350_SUPPLY_O=
UT, NULL);
>
> @@ -158,10 +148,8 @@ static void adis16350_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_count)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adis16350_spi_=
read_burst(&st->indio_dev->dev, st->rx) >=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1=
],
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->rx[i*2]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D be16_to_cpup((__be16 *)&(st-=
>rx[i*2]));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte bounda=
ry */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/i=
io/imu/adis16400_ring.c
> index 95f53b2..e7881a0 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -17,16 +17,6 @@
> =C2=A0#include "../trigger.h"
> =C2=A0#include "adis16400.h"
>
> -/**
> - * combine_8_to_16() utility function to munge to u8s into u16
> - **/
> -static inline u16 combine_8_to_16(u8 lower, u8 upper)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 _lower =3D lower;
> - =C2=A0 =C2=A0 =C2=A0 u16 _upper =3D upper;
> - =C2=A0 =C2=A0 =C2=A0 return _lower | (_upper << 8);
> -}
> -
> =C2=A0static IIO_SCAN_EL_C(supply, ADIS16400_SCAN_SUPPLY, IIO_SIGNED(14),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADI=
S16400_SUPPLY_OUT, NULL);
>
> @@ -167,10 +157,8 @@ static void adis16400_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_count)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adis16400_spi_=
read_burst(&st->indio_dev->dev, st->rx) >=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1=
],
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->rx[i*2]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D be16_to_cpup((__be16 *)&(st-=
>rx[i*2]));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte bounda=
ry */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
