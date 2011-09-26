Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 26 Sep 2011 08:42:33 +0100
Subject: RE: [PATCH 13/16] staging;iio:adc:ad7606 use
 iio_sw_buffer_preenable rather than local equiv
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AE5@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-14-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Other than a few slight refactorings the local version was pretty
> standard so replace it and rework to get rid of st->d_size which it
> setup.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad7606.h      |    1 -
>  drivers/staging/iio/adc/ad7606_ring.c |   42 +++++--------------------
>  ------- 2 files changed, 7 insertions(+), 36 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad7606.h
> b/drivers/staging/iio/adc/ad7606.h index 8fc259f..bc95f09 100644 ---
> a/drivers/staging/iio/adc/ad7606.h +++
> b/drivers/staging/iio/adc/ad7606.h @@ -68,7 +68,6 @@ struct ad7606_state
> {
>       struct regulator                *reg;   struct work_struct         =
     poll_work;
>       wait_queue_head_t               wq_data_avail; -        size_t     =
                     d_size;         const struct
>  ad7606_bus_ops       *bops;  int                             irq;    uns=
igned                        id;
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c
> b/drivers/staging/iio/adc/ad7606_ring.c index f0742d6..20927fd 100644
> --- a/drivers/staging/iio/adc/ad7606_ring.c +++
> b/drivers/staging/iio/adc/ad7606_ring.c @@ -43,37 +43,6 @@ error_ret:
>  }
>
>  /**
> - * ad7606_ring_preenable() setup the parameters of the ring before
> enabling - * - * The complex nature of the setting of the nuber of bytes
> per datum is due - * to this driver currently ensuring that the
> timestamp is stored at an 8 - * byte boundary. - **/ -static int
> ad7606_ring_preenable(struct iio_dev *indio_dev) -{ - struct
> ad7606_state *st =3D iio_priv(indio_dev); -     struct iio_buffer *ring =
=3D
> indio_dev->buffer; -  size_t d_size; - -      d_size =3D
> st->chip_info->num_channels * -
> st->chip_info->channels[0].scan_type.storagebits / 8; - -     if
> (ring->scan_timestamp) { -            d_size +=3D sizeof(s64); - -       =
       if (d_size %
> sizeof(s64)) -                        d_size +=3D sizeof(s64) - (d_size %=
 sizeof(s64)); -       } -
> -     if (ring->access->set_bytes_per_datum)
> -             ring->access->set_bytes_per_datum(ring, d_size); - -    st-=
>d_size =3D
> d_size; - -   return 0; -} - -/**
>   * ad7606_trigger_handler_th() th/bh of trigger launched polling to
>   ring buffer * **/
> @@ -106,7 +75,8 @@ static void ad7606_poll_bh_to_ring(struct
> work_struct *work_s)
>       __u8 *buf;
>       int ret;
> -     buf =3D kzalloc(st->d_size, GFP_KERNEL);
> +     buf =3D kzalloc(ring->access->get_bytes_per_datum(ring),
> +                   GFP_KERNEL);
>       if (buf =3D=3D NULL)
>               return;
> @@ -137,8 +107,8 @@ static void ad7606_poll_bh_to_ring(struct
> work_struct *work_s)
>       time_ns =3D iio_get_time_ns();
>
>       if (ring->scan_timestamp)
> -             memcpy(buf + st->d_size - sizeof(s64),
> -                     &time_ns, sizeof(time_ns));
> +             *((s64 *)(buf + ring->access->get_bytes_per_datum(ring) -
> +                       sizeof(s64))) =3D time_ns;
>
>       ring->access->store_to(indio_dev->buffer, buf, time_ns); done: @@
>  -148,7 +118,7 @@ done: }
>
>  static const struct iio_buffer_setup_ops ad7606_ring_setup_ops =3D {
> -     .preenable =3D &ad7606_ring_preenable,
> +     .preenable =3D &iio_sw_buffer_preenable,
>       .postenable =3D &iio_triggered_buffer_postenable,
>       .predisable =3D &iio_triggered_buffer_predisable,
>  };
> @@ -166,6 +136,8 @@ int ad7606_register_ring_funcs_and_init(struct
> iio_dev *indio_dev)
>
>       /* Effectively select the ring buffer implementation */
>       indio_dev->buffer->access =3D &ring_sw_access_funcs;
> +     indio_dev->buffer->bpe =3D
> +             st->chip_info->channels[0].scan_type.storagebits / 8;
        indio_dev->pollfunc =3D iio_alloc_pollfunc(&ad7606_trigger_handler_=
th_bh,
                                                 &ad7606_trigger_handler_th=
_bh,                                                  0,

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
