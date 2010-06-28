Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277481314-31717-4-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-2-git-send-email-jic23@cam.ac.uk> <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-4-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Jun 2010 14:35:38 +0800
Message-ID: <AANLkTikf-vEMNrVBG6lX2IkUqj0aY56qSJkFTUHGLvJT@mail.gmail.com>
Subject: Re: [PATCH 3/6] staging:iio: Add and convert drivers to use
	iio_alloc_pollfunc
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry.Song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 25, 2010 at 11:55 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
> ---
>
> =C2=A0Simple core function removes a lot of cut an paste code.
> =C2=A0This is of general use when pollfuncs are used.
>
> =C2=A0drivers/staging/iio/accel/adis16209_ring.c | =C2=A0 11 ++++-------
> =C2=A0drivers/staging/iio/accel/adis16240_ring.c | =C2=A0 11 ++++-------
> =C2=A0drivers/staging/iio/accel/lis3l02dq_ring.c | =C2=A0 =C2=A09 +++----=
--
> =C2=A0drivers/staging/iio/adc/max1363_ring.c =C2=A0 =C2=A0 | =C2=A0 =C2=
=A09 ++-------
> =C2=A0drivers/staging/iio/gyro/adis16260_ring.c =C2=A0| =C2=A0 11 ++++---=
----
> =C2=A0drivers/staging/iio/imu/adis16300_ring.c =C2=A0 | =C2=A0 11 ++++---=
----
> =C2=A0drivers/staging/iio/imu/adis16350_ring.c =C2=A0 | =C2=A0 11 ++++---=
----
> =C2=A0drivers/staging/iio/imu/adis16400_ring.c =C2=A0 | =C2=A0 11 ++++---=
----
> =C2=A0drivers/staging/iio/industrialio-trigger.c | =C2=A0 13 ++++++++++++=
+
> =C2=A0drivers/staging/iio/trigger.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A05 ++++-
> =C2=A010 files changed, 46 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging=
/iio/accel/adis16209_ring.c
> index 8959ad8..e8f7264 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -241,13 +241,10 @@ int adis16209_configure_ring(struct iio_dev *indio_=
dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &adis16209_data_rdy_ring_=
predisable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &adis16209=
_poll_func_th;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &adis1=
6209_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging=
/iio/accel/adis16240_ring.c
> index 490d80e..ab52bcf 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -229,13 +229,10 @@ int adis16240_configure_ring(struct iio_dev *indio_=
dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &adis16240_data_rdy_ring_=
predisable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &adis16240=
_poll_func_th;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &adis1=
6240_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging=
/iio/accel/lis3l02dq_ring.c
> index a33599d..38c7340 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -566,13 +566,9 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_d=
ev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &lis3l02dq_data_rdy_ring_=
predisable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &lis3l=
02dq_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_iio_sw_=
rb_free;;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &lis3l02dq=
_poll_func_th;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> @@ -592,3 +588,4 @@ void lis3l02dq_uninitialize_ring(struct iio_ring_buff=
er *ring)
> =C2=A0}
>
>
> +
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio=
/adc/max1363_ring.c
> index a49b3d7..def7ffb 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -223,14 +223,9 @@ int max1363_register_ring_funcs_and_init(struct iio_=
dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&st->indio_dev->rin=
g->access);
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &max13=
63_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_dealloc=
ate_sw_rb;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 /* Configure the polling function called on trigge=
r interrupts */
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &max1363_p=
oll_func_th;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ring buffer functions - here trigger setup =
related */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring->postenable =3D &max1363_ring_=
postenable;
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/=
iio/gyro/adis16260_ring.c
> index 2fe7f02..bf3c2e8 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -231,13 +231,10 @@ int adis16260_configure_ring(struct iio_dev *indio_=
dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &adis16260_data_rdy_ring_=
predisable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &adis16260=
_poll_func_th;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &adis1=
6260_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/i=
io/imu/adis16300_ring.c
> index 17ceb72..de39187 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -256,13 +256,10 @@ int adis16300_configure_ring(struct iio_dev *indio_=
dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &adis16300_data_rdy_ring_=
predisable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &adis16300=
_poll_func_th;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &adis1=
6300_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/i=
io/imu/adis16350_ring.c
> index 2a0a465..be9ce31 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -261,13 +261,10 @@ int adis16350_configure_ring(struct iio_dev *indio_=
dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &adis16350_data_rdy_ring_=
predisable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &adis16350=
_poll_func_th;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &adis1=
6350_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/i=
io/imu/adis16400_ring.c
> index 5d94cdc..da24384 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -268,13 +268,10 @@ int adis16400_configure_ring(struct iio_dev *indio_=
dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &adis16400_data_rdy_ring_=
predisable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &adis16400=
_poll_func_th;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &adis1=
6400_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging=
/iio/industrialio-trigger.c
> index 3c06808..18ed09b 100644
> --- a/drivers/staging/iio/industrialio-trigger.c
> +++ b/drivers/staging/iio/industrialio-trigger.c
> @@ -399,3 +399,16 @@ int iio_device_unregister_trigger_consumer(struct ii=
o_dev *dev_info)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(iio_device_unregister_trigger_consumer);
>
> +int iio_alloc_pollfunc(struct iio_dev *indio_dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void (*immediate)(struct iio_dev *indio_dev),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void (*main)(struct iio_dev =C2=A0*private_data))
> +{
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_immediate =3D immed=
iate;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D main;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +EXPORT_SYMBOL(iio_alloc_pollfunc);
> diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.=
h
> index 89610b5..10e9732 100644
> --- a/drivers/staging/iio/trigger.h
> +++ b/drivers/staging/iio/trigger.h
> @@ -148,9 +148,12 @@ struct iio_poll_func {
>
> =C2=A0};
>
> +int iio_alloc_pollfunc(struct iio_dev *indio_dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void (*immediate)(struct iio_dev *indio_dev),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void (*main)(struct iio_dev =C2=A0*private_data));
> +
> =C2=A0struct iio_trigger *iio_allocate_trigger(void);
>
> =C2=A0void iio_free_trigger(struct iio_trigger *trig);
>
> -
> =C2=A0#endif /* _IIO_TRIGGER_H_ */
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
