Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277908076-28592-4-git-send-email-jic23@cam.ac.uk>
References: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
	<1277908076-28592-4-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 8 Jul 2010 17:28:51 +0800
Message-ID: <AANLkTil3wbhKd4JddXhZ5SzMmJDvqxrric7mwQh1YGml@mail.gmail.com>
Subject: Re: [PATCH 3/5] staging:iio: Add iio_sw_ring_helper_state and
	functions to cover common case.
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, barry.song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 30, 2010 at 10:27 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
> ---
> =C2=A0drivers/staging/iio/ring_sw.c | =C2=A0 43 +++++++++++++++++++++++++=
++++++++++++++++
> =C2=A0drivers/staging/iio/ring_sw.h | =C2=A0 10 +++++++++
> =C2=A02 files changed, 53 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.=
c
> index ca0e79e..293df5c 100644
> --- a/drivers/staging/iio/ring_sw.c
> +++ b/drivers/staging/iio/ring_sw.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/workqueue.h>
> =C2=A0#include "ring_sw.h"
> +#include "trigger.h"
>
> =C2=A0static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_=
buffer *ring,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0int bytes_per_datum, int length)
> @@ -456,5 +457,47 @@ int iio_sw_ring_preenable(struct iio_dev *indio_dev)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(iio_sw_ring_preenable);
>
> +void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_sw_ring_helper_state *st
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D container_of(work_=
s, struct iio_sw_ring_helper_state,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 work_trigger_to_ring);
> + =C2=A0 =C2=A0 =C2=A0 int len =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 size_t datasize =3D st->indio_dev
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ring->access.get_bpd=
(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 char *data =3D kmalloc(datasize, GFP_KERNEL);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (data =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(st->indio_dev-=
>dev.parent,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "memory alloc failed in ring bh");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev->scan_count)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D st->get_ring_e=
lement(st, data);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Guaranteed to be aligned with 8 byte bou=
ndary */
> + =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev->scan_timestamp)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *(s64 *)(((u32)data + =
len + sizeof(s64) - 1) & ~(sizeof(s64) - 1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D st->last_timestamp;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->indio_dev->ring->access.store_to(st->in=
dio_dev->ring,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u8 *)data,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 st->last_timestamp);
> +
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_notify_done(st->indio_dev->trig);
> + =C2=A0 =C2=A0 =C2=A0 kfree(data);
> +
> + =C2=A0 =C2=A0 =C2=A0 return;
> +}
> +EXPORT_SYMBOL(iio_sw_trigger_bh_to_ring);
> +
> +void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time)
> +{ =C2=A0 =C2=A0 =C2=A0struct iio_sw_ring_helper_state *h
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D iio_dev_get_devdat=
a(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 h->last_timestamp =3D time;
> + =C2=A0 =C2=A0 =C2=A0 schedule_work(&h->work_trigger_to_ring);
> +}
> +EXPORT_SYMBOL(iio_sw_poll_func_th);
> +
> =C2=A0MODULE_DESCRIPTION("Industrialio I/O software ring buffer");
> =C2=A0MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.=
h
> index 5c22936..59c99c0 100644
> --- a/drivers/staging/iio/ring_sw.h
> +++ b/drivers/staging/iio/ring_sw.h
> @@ -209,6 +209,16 @@ void iio_sw_rb_free(struct iio_ring_buffer *ring);
>
> =C2=A0int iio_sw_ring_preenable(struct iio_dev *indio_dev);
>
> +struct iio_sw_ring_helper_state {
> + =C2=A0 =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0work_trigger_to_ring;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 int (*get_ring_element)(struct iio_sw_ring_helper_=
state *st, u8 *buf);
> + =C2=A0 =C2=A0 =C2=A0 s64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_timestamp;
> +};
> +
> +void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time);
> +void iio_sw_trigger_bh_to_ring(struct work_struct *work_s);
> +
> =C2=A0#else /* CONFIG_IIO_RING_BUFFER*/
> =C2=A0static inline void iio_ring_sw_register_funcs(struct iio_ring_acces=
s_funcs *ra)
> =C2=A0{};
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
