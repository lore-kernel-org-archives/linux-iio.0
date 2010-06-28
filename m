Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277481314-31717-5-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-2-git-send-email-jic23@cam.ac.uk> <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-4-git-send-email-jic23@cam.ac.uk> <1277481314-31717-5-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Jun 2010 14:35:11 +0800
Message-ID: <AANLkTilLNC8DwbPhN5VKzjtepxcfPYaEbu7uiIyCMxuU@mail.gmail.com>
Subject: Re: [PATCH 4/6] staging:iio: Add iio_triggered_ring postenable and
	predisable + use in drivers
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry.Song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 25, 2010 at 11:55 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
> ---
>
> =C2=A0Directly lifted form Barry Song's RFC. =C2=A0This pair apply to all=
 current
> =C2=A0triggered sw ring buffer fills. =C2=A0We may want to futher unify t=
hings
> =C2=A0but to keep things easy to review lets do it in stages.
>
> =C2=A0drivers/staging/iio/accel/adis16209_ring.c | =C2=A0 20 +-----------=
---
> =C2=A0drivers/staging/iio/accel/adis16240_ring.c | =C2=A0 20 +-----------=
---
> =C2=A0drivers/staging/iio/accel/lis3l02dq_ring.c | =C2=A0 21 +-----------=
----
> =C2=A0drivers/staging/iio/adc/max1363_ring.c =C2=A0 =C2=A0 | =C2=A0 34 +-=
-------------------------
> =C2=A0drivers/staging/iio/gyro/adis16260_ring.c =C2=A0| =C2=A0 20 +------=
--------
> =C2=A0drivers/staging/iio/imu/adis16300_ring.c =C2=A0 | =C2=A0 20 +------=
--------
> =C2=A0drivers/staging/iio/imu/adis16350_ring.c =C2=A0 | =C2=A0 20 +------=
--------
> =C2=A0drivers/staging/iio/imu/adis16400_ring.c =C2=A0 | =C2=A0 20 +------=
--------
> =C2=A0drivers/staging/iio/industrialio-trigger.c | =C2=A0 18 ++++++++++++=
++
> =C2=A0drivers/staging/iio/trigger.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A07 +++++
> =C2=A010 files changed, 41 insertions(+), 159 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging=
/iio/accel/adis16209_ring.c
> index e8f7264..3b42a65 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -186,22 +186,6 @@ static int adis16209_data_rdy_ring_preenable(struct =
iio_dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int adis16209_data_rdy_ring_postenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_p=
oll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> -static int adis16209_data_rdy_ring_predisable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_=
poll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> =C2=A0void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -237,8 +221,8 @@ int adis16209_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->preenable =3D &adis16209_data_rdy_ring_p=
reenable;
> - =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &adis16209_data_rdy_ring_post=
enable;
> - =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &adis16209_data_rdy_ring_pred=
isable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &iio_triggered_ring_postenabl=
e;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &iio_triggered_ring_predisabl=
e;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_alloc_pollfunc(indio_dev, NULL, &a=
dis16209_poll_func_th);
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging=
/iio/accel/adis16240_ring.c
> index ab52bcf..08fef63 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -176,22 +176,6 @@ static int adis16240_data_rdy_ring_preenable(struct =
iio_dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int adis16240_data_rdy_ring_postenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_p=
oll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> -static int adis16240_data_rdy_ring_predisable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_=
poll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> =C2=A0void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -225,8 +209,8 @@ int adis16240_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->preenable =3D &adis16240_data_rdy_ring_p=
reenable;
> - =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &adis16240_data_rdy_ring_post=
enable;
> - =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &adis16240_data_rdy_ring_pred=
isable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &iio_triggered_ring_postenabl=
e;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &iio_triggered_ring_predisabl=
e;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_alloc_pollfunc(indio_dev, NULL, &a=
dis16240_poll_func_th);
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging=
/iio/accel/lis3l02dq_ring.c
> index 38c7340..bc0de78 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -339,23 +339,6 @@ static int lis3l02dq_data_rdy_ring_preenable(struct =
iio_dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int lis3l02dq_data_rdy_ring_postenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_p=
oll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> -static int lis3l02dq_data_rdy_ring_predisable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_=
poll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> -
> =C2=A0/* Caller responsible for locking as necessary. */
> =C2=A0static int
> =C2=A0__lis3l02dq_write_data_ready_config(struct device *dev,
> @@ -562,8 +545,8 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->preenable =3D &lis3l02dq_data_rdy_ring_p=
reenable;
> - =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &lis3l02dq_data_rdy_ring_post=
enable;
> - =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &lis3l02dq_data_rdy_ring_pred=
isable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &iio_triggered_ring_postenabl=
e;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &iio_triggered_ring_predisabl=
e;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_alloc_pollfunc(indio_dev, NULL, &l=
is3l02dq_poll_func_th);
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio=
/adc/max1363_ring.c
> index def7ffb..896973d 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -106,36 +106,6 @@ static int max1363_ring_preenable(struct iio_dev *in=
dio_dev)
> =C2=A0}
>
> =C2=A0/**
> - * max1363_ring_postenable() typical ring post enable
> - *
> - * Only not moved into the core for the hardware ring buffer cases
> - * that are more sophisticated.
> - **/
> -static int max1363_ring_postenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->trig =3D=3D NULL)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> - =C2=A0 =C2=A0 =C2=A0 return iio_trigger_attach_poll_func(indio_dev->tri=
g,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 indio_dev->pollfunc);
> -}
> -
> -/**
> - * max1363_ring_predisable() runs just prior to ring buffer being disabl=
ed
> - *
> - * Typical predisable function which ensures that no trigger events can
> - * occur before we disable the ring buffer (and hence would have no idea
> - * what to do with them)
> - **/
> -static int max1363_ring_predisable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->trig)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return iio_trigger_det=
tach_poll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->pollfunc);
> - =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> -/**
> =C2=A0* max1363_poll_func_th() th of trigger launched polling to ring buf=
fer
> =C2=A0*
> =C2=A0* As sampling only occurs on i2c comms occuring, leave timestamping=
 until
> @@ -228,9 +198,9 @@ int max1363_register_ring_funcs_and_init(struct iio_d=
ev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_dealloc=
ate_sw_rb;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ring buffer functions - here trigger setup =
related */
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->postenable =3D &max1363_ring_post=
enable;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->postenable =3D &iio_triggered_rin=
g_postenable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->ring->preenable =3D &max1363_ring_p=
reenable;
> - =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->predisable =3D &max1363_ring_pred=
isable;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->predisable =3D &iio_triggered_rin=
g_predisable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&st->poll_work, &max1363_poll_bh_to_=
ring);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Flag that polled ring buffering is possible=
 */
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/=
iio/gyro/adis16260_ring.c
> index bf3c2e8..05e7a69 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -179,22 +179,6 @@ static int adis16260_data_rdy_ring_preenable(struct =
iio_dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int adis16260_data_rdy_ring_postenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_p=
oll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> -static int adis16260_data_rdy_ring_predisable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_=
poll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> =C2=A0void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -227,8 +211,8 @@ int adis16260_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->preenable =3D &adis16260_data_rdy_ring_p=
reenable;
> - =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &adis16260_data_rdy_ring_post=
enable;
> - =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &adis16260_data_rdy_ring_pred=
isable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &iio_triggered_ring_postenabl=
e;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &iio_triggered_ring_predisabl=
e;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_alloc_pollfunc(indio_dev, NULL, &a=
dis16260_poll_func_th);
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/i=
io/imu/adis16300_ring.c
> index de39187..4dee670 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -200,22 +200,6 @@ static int adis16300_data_rdy_ring_preenable(struct =
iio_dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int adis16300_data_rdy_ring_postenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_p=
oll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> -static int adis16300_data_rdy_ring_predisable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_=
poll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> =C2=A0void adis16300_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -252,8 +236,8 @@ int adis16300_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->preenable =3D &adis16300_data_rdy_ring_p=
reenable;
> - =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &adis16300_data_rdy_ring_post=
enable;
> - =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &adis16300_data_rdy_ring_pred=
isable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &iio_triggered_ring_postenabl=
e;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &iio_triggered_ring_predisabl=
e;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_alloc_pollfunc(indio_dev, NULL, &a=
dis16300_poll_func_th);
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/i=
io/imu/adis16350_ring.c
> index be9ce31..c70816d 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -203,22 +203,6 @@ static int adis16350_data_rdy_ring_preenable(struct =
iio_dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int adis16350_data_rdy_ring_postenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_p=
oll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> -static int adis16350_data_rdy_ring_predisable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_=
poll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> =C2=A0void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -257,8 +241,8 @@ int adis16350_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->preenable =3D &adis16350_data_rdy_ring_p=
reenable;
> - =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &adis16350_data_rdy_ring_post=
enable;
> - =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &adis16350_data_rdy_ring_pred=
isable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &iio_triggered_ring_postenabl=
e;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &iio_triggered_ring_predisabl=
e;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_alloc_pollfunc(indio_dev, NULL, &a=
dis16350_poll_func_th);
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/i=
io/imu/adis16400_ring.c
> index da24384..8f7d257 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -209,22 +209,6 @@ static int adis16400_data_rdy_ring_preenable(struct =
iio_dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int adis16400_data_rdy_ring_postenable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_p=
oll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> -static int adis16400_data_rdy_ring_predisable(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_=
poll_func(indio_dev->trig,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> -}
> -
> =C2=A0void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> @@ -264,8 +248,8 @@ int adis16400_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Effectively select the ring buffer implemen=
tation */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_sw_register_funcs(&ring->access);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->preenable =3D &adis16400_data_rdy_ring_p=
reenable;
> - =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &adis16400_data_rdy_ring_post=
enable;
> - =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &adis16400_data_rdy_ring_pred=
isable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &iio_triggered_ring_postenabl=
e;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &iio_triggered_ring_predisabl=
e;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_alloc_pollfunc(indio_dev, NULL, &a=
dis16400_poll_func_th);
> diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging=
/iio/industrialio-trigger.c
> index 18ed09b..0f8ba14 100644
> --- a/drivers/staging/iio/industrialio-trigger.c
> +++ b/drivers/staging/iio/industrialio-trigger.c
> @@ -412,3 +412,21 @@ int iio_alloc_pollfunc(struct iio_dev *indio_dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(iio_alloc_pollfunc);
> +
> +int iio_triggered_ring_postenable(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_p=
oll_func(indio_dev->trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> +}
> +EXPORT_SYMBOL(iio_triggered_ring_postenable);
> +
> +int iio_triggered_ring_predisable(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_=
poll_func(indio_dev->trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> +}
> +EXPORT_SYMBOL(iio_triggered_ring_predisable);
> diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.=
h
> index 10e9732..832de15 100644
> --- a/drivers/staging/iio/trigger.h
> +++ b/drivers/staging/iio/trigger.h
> @@ -152,6 +152,13 @@ int iio_alloc_pollfunc(struct iio_dev *indio_dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void (*immediate)(struct iio_dev *indio_dev),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void (*main)(struct iio_dev =C2=A0*private_data));
>
> +/*
> + * Two functions for common case where all that happens is a pollfunc
> + * is attached and detached form a trigger
> + */
> +int iio_triggered_ring_postenable(struct iio_dev *indio_dev);
> +int iio_triggered_ring_predisable(struct iio_dev *indio_dev);
> +
> =C2=A0struct iio_trigger *iio_allocate_trigger(void);
>
> =C2=A0void iio_free_trigger(struct iio_trigger *trig);
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
