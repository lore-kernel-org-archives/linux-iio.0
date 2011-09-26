Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 26 Sep 2011 08:29:15 +0100
Subject: RE: [PATCH 06/16] staging:iio:adc:ad799x avoid bouncing back and
 forth from iio_priv space.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AC5@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-7-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad799x.h      |    4 ++--
>  drivers/staging/iio/adc/ad799x_core.c |    2 +-
>  drivers/staging/iio/adc/ad799x_ring.c |    4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad799x.h
> b/drivers/staging/iio/adc/ad799x.h index 98f06f6..eda01d5 100644 ---
> a/drivers/staging/iio/adc/ad799x.h +++
> b/drivers/staging/iio/adc/ad799x.h @@ -124,11 +124,11 @@ struct
> ad799x_platform_data {
>  int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask);
>
>  #ifdef CONFIG_AD799X_RING_BUFFER
> -int ad799x_single_channel_from_ring(struct ad799x_state *st, int
> channum); +int ad799x_single_channel_from_ring(struct iio_dev
> *indio_dev, int channum);
>  int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev);
>  void ad799x_ring_cleanup(struct iio_dev *indio_dev);
>  #else /* CONFIG_AD799X_RING_BUFFER */
> -int ad799x_single_channel_from_ring(struct ad799x_state *st, int
> channum) +int ad799x_single_channel_from_ring(struct iio_dev *indio_dev,
> int channum)
>  {
>       return -EINVAL;
>  }
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index c615188..a24d695 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -151,7 +151,7 @@ static int
> ad799x_read_raw(struct iio_dev *dev_info,
>       case 0:
>               mutex_lock(&dev_info->mlock);
>               if (iio_buffer_enabled(dev_info))
> -                     ret =3D ad799x_single_channel_from_ring(st,
> +                     ret =3D ad799x_single_channel_from_ring(dev_info,
>                                                             chan->scan_in=
dex);
>               else
>                       ret =3D ad799x_scan_direct(st, chan->address);
> diff --git a/drivers/staging/iio/adc/ad799x_ring.c
> b/drivers/staging/iio/adc/ad799x_ring.c index 1bcc168..e3f4698 100644
> --- a/drivers/staging/iio/adc/ad799x_ring.c +++
> b/drivers/staging/iio/adc/ad799x_ring.c @@ -23,9 +23,9 @@
>
>  #include "ad799x.h"
> -int ad799x_single_channel_from_ring(struct ad799x_state *st, int
> channum) +int ad799x_single_channel_from_ring(struct iio_dev *indio_dev,
> int channum)
>  {
> -     struct iio_buffer *ring =3D iio_priv_to_dev(st)->buffer;
> +     struct iio_buffer *ring =3D indio_dev->buffer;
>       int count =3D 0, ret;
>       u16 *ring_data;

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
