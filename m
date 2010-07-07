Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277908076-28592-3-git-send-email-jic23@cam.ac.uk>
References: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
	<1277908076-28592-3-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Jul 2010 18:59:01 +0800
Message-ID: <AANLkTimz7SC5kI4Yn_m5UR4kMmlSeVrO1_TPjBQWup9F@mail.gmail.com>
Subject: Re: [PATCH 2/5] staging:iio: Make extensive use of
	iio_sw_ring_preenable
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, barry.song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 30, 2010 at 10:27 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
> ---
> =C2=A0drivers/staging/iio/accel/adis16209_ring.c | =C2=A0 31 +-----------=
---------------
> =C2=A0drivers/staging/iio/accel/adis16240_ring.c | =C2=A0 29 +-----------=
-------------
> =C2=A0drivers/staging/iio/accel/lis3l02dq_ring.c | =C2=A0 25 +-----------=
---------
> =C2=A0drivers/staging/iio/gyro/adis16260_ring.c =C2=A0| =C2=A0 29 +------=
------------------
> =C2=A0drivers/staging/iio/imu/adis16300_ring.c =C2=A0 | =C2=A0 26 +------=
---------------
> =C2=A0drivers/staging/iio/imu/adis16350_ring.c =C2=A0 | =C2=A0 29 +------=
------------------
> =C2=A0drivers/staging/iio/imu/adis16400_ring.c =C2=A0 | =C2=A0 26 +------=
---------------
> =C2=A07 files changed, 14 insertions(+), 181 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging=
/iio/accel/adis16209_ring.c
> index f3a9493..25fde65 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -147,34 +147,6 @@ static void adis16209_trigger_bh_to_ring(struct work=
_struct *work_s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
>
> -/* in these circumstances is it better to go with unaligned packing and
> - * deal with the cost?*/
> -static int adis16209_data_rdy_ring_preenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 size_t size;
> - =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
> - =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, i=
f not fail*/
> - =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_tim=
estamp))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> -
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_ti=
mestamp)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (indio_dev->scan_count)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timestamp (aligned to s64) and data *=
/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (((indio_dev->scan_count * size=
of(s16))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ size=
of(s64) - 1)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 & ~(sizeof(s=
64) - 1))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else /* Timestamp only =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->acces=
s.set_bpd(indio_dev->ring, size);
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> =C2=A0void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -209,7 +181,8 @@ int adis16209_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring =3D ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> - =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &adis16209_data_rdy_ring_preen=
able;
> + =C2=A0 =C2=A0 =C2=A0 ring->bpe =3D 2;
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &iio_sw_ring_preenable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->postenable =3D &iio_triggered_ring_poste=
nable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &iio_triggered_ring_predi=
sable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging=
/iio/accel/adis16240_ring.c
> index a1611bb..cd69a2e 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -139,32 +139,6 @@ static void adis16240_trigger_bh_to_ring(struct work=
_struct *work_s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
>
> -static int adis16240_data_rdy_ring_preenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 size_t size;
> - =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
> - =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, i=
f not fail*/
> - =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_tim=
estamp))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> -
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_ti=
mestamp)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (indio_dev->scan_count)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timestamp (aligned sizeof(s64) and da=
ta */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (((indio_dev->scan_count * size=
of(s16))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ size=
of(s64) - 1)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 & ~(sizeof(s=
64) - 1))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else /* Timestamp only =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->acces=
s.set_bpd(indio_dev->ring, size);
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> =C2=A0void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -197,7 +171,8 @@ int adis16240_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring =3D ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> - =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &adis16240_data_rdy_ring_preen=
able;
> + =C2=A0 =C2=A0 =C2=A0 ring->bpe =3D 2;
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &iio_sw_ring_preenable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->postenable =3D &iio_triggered_ring_poste=
nable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &iio_triggered_ring_predi=
sable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging=
/iio/accel/lis3l02dq_ring.c
> index a506dab..2c11209 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -315,28 +315,6 @@ static void lis3l02dq_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
> -/* in these circumstances is it better to go with unaligned packing and
> - * deal with the cost?*/
> -static int lis3l02dq_data_rdy_ring_preenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 size_t size;
> - =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, i=
f not fail*/
> - =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_tim=
estamp))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> -
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_ti=
mestamp)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (indio_dev->scan_count) /* Timestamp and data */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D 2*sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else /* Timestamp only =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->acces=
s.set_bpd(indio_dev->ring, size);
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
>
> =C2=A0/* Caller responsible for locking as necessary. */
> =C2=A0static int
> @@ -543,7 +521,8 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring =3D ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> - =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &lis3l02dq_data_rdy_ring_preen=
able;
> + =C2=A0 =C2=A0 =C2=A0 ring->bpe =3D 2;
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &iio_sw_ring_preenable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->postenable =3D &iio_triggered_ring_poste=
nable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &iio_triggered_ring_predi=
sable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/=
iio/gyro/adis16260_ring.c
> index 94b4515..9ef7f90 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -142,32 +142,6 @@ static void adis16260_trigger_bh_to_ring(struct work=
_struct *work_s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
>
> -static int adis16260_data_rdy_ring_preenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 size_t size;
> - =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
> - =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, i=
f not fail*/
> - =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_tim=
estamp))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> -
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_ti=
mestamp)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (indio_dev->scan_count)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timestamp (aligned s64) and data */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (((indio_dev->scan_count * size=
of(s16))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 + sizeof(s64) - 1)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 & ~(sizeof(s=
64) - 1))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else /* Timestamp only =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->acces=
s.set_bpd(indio_dev->ring, size);
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> =C2=A0void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -199,7 +173,8 @@ int adis16260_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring =3D ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> - =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &adis16260_data_rdy_ring_preen=
able;
> + =C2=A0 =C2=A0 =C2=A0 ring->bpe =3D 2;
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &iio_sw_ring_preenable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->postenable =3D &iio_triggered_ring_poste=
nable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &iio_triggered_ring_predi=
sable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/i=
io/imu/adis16300_ring.c
> index 3bf9904..fc93160 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -165,29 +165,6 @@ static void adis16300_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
> -/* in these circumstances is it better to go with unaligned packing and
> - * deal with the cost?*/
> -static int adis16300_data_rdy_ring_preenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 size_t size;
> - =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
> - =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, i=
f not fail*/
> - =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_tim=
estamp))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> -
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_ti=
mestamp)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (indio_dev->scan_count) /* Timestamp and data */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D 4*sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else /* Timestamp only =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->acces=
s.set_bpd(indio_dev->ring, size);
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
>
> =C2=A0void adis16300_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> @@ -224,7 +201,8 @@ int adis16300_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring =3D ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> - =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &adis16300_data_rdy_ring_preen=
able;
> + =C2=A0 =C2=A0 =C2=A0 ring->bpe =3D 2;
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &iio_sw_ring_preenable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->postenable =3D &iio_triggered_ring_poste=
nable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &iio_triggered_ring_predi=
sable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/i=
io/imu/adis16350_ring.c
> index 319aa34..e053e9a 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -166,32 +166,6 @@ static void adis16350_trigger_bh_to_ring(struct work=
_struct *work_s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
>
> -static int adis16350_data_rdy_ring_preenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 size_t size;
> - =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
> - =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, i=
f not fail*/
> - =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_tim=
estamp))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> -
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_ti=
mestamp)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (indio_dev->scan_count)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timestamp (aligned sizeof(s64) and da=
ta */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (((indio_dev->scan_count * size=
of(s16))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 + sizeof(s64) - 1)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 & ~(sizeof(s=
64) - 1))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else /* Timestamp only =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->acces=
s.set_bpd(indio_dev->ring, size);
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> =C2=A0void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -229,7 +203,8 @@ int adis16350_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring =3D ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> - =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &adis16350_data_rdy_ring_preen=
able;
> + =C2=A0 =C2=A0 =C2=A0 ring->bpe =3D 2;
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &iio_sw_ring_preenable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->postenable =3D &iio_triggered_ring_poste=
nable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &iio_triggered_ring_predi=
sable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/i=
io/imu/adis16400_ring.c
> index c7744ef..949db76 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -174,29 +174,6 @@ static void adis16400_trigger_bh_to_ring(struct work=
_struct *work_s)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
> -/* in these circumstances is it better to go with unaligned packing and
> - * deal with the cost?*/
> -static int adis16400_data_rdy_ring_preenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 size_t size;
> - =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
> - =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, i=
f not fail*/
> - =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_tim=
estamp))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> -
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_ti=
mestamp)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (indio_dev->scan_count) /* Timestamp and data */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D 6*sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else /* Timestamp only =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->acces=
s.set_bpd(indio_dev->ring, size);
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
>
> =C2=A0void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> @@ -236,7 +213,8 @@ int adis16400_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring =3D ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> - =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &adis16400_data_rdy_ring_preen=
able;
> + =C2=A0 =C2=A0 =C2=A0 ring->bpe =3D 2;
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &iio_sw_ring_preenable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->postenable =3D &iio_triggered_ring_poste=
nable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &iio_triggered_ring_predi=
sable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
