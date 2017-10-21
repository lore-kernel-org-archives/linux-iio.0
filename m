Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbdJUQsa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 12:48:30 -0400
Date: Sat, 21 Oct 2017 17:48:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Georgiana Chelu <georgiana.chelu93@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Daniel Baluta <danielbaluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>
Subject: Re: [PATCH] Staging: iio: meter: Replace mlock with driver private
 lock
Message-ID: <20171021174825.366ffb75@archlinux>
In-Reply-To: <CALta04zSczT-ukvKBUdV8NOde=94rZ21+T7WmqN_LBY47YVjRQ@mail.gmail.com>
References: <20171015181054.15094-1-georgiana.chelu93@gmail.com>
        <CALta04zSczT-ukvKBUdV8NOde=94rZ21+T7WmqN_LBY47YVjRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 16 Oct 2017 15:28:57 +0300
Georgiana Chelu <georgiana.chelu93@gmail.com> wrote:

> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Signed-off-by: Georgiana Chelu <georgiana.chelu93@gmail.com>

Hmm. The naming as rw_lock made me wonder what was actually
being protected in this driver as there is no need to explicitly
protect read and write operations.  The spi bus is has all
the protections needed to ensure nothing clashes.

Upshot is the bit that needs protecting is that we have
a read modify write cycle going on in write_samp_frequency

Now, each element of this is protected by the buffer lock
but it is dropped between them.  A nicer approach
than you have hear would be to add some unlocked
read and write helpers thus allowing you to take
buflock around this whole modify and avoid any necessity for
an additional lock.

This is similar to what has been done in other drivers
when unwinding the missuse of mlock. 

I have no idea why we would ever need to take the lock
in the read cases.  We might if we were aiming to have
some sort of caching that needed to be in sync with the
current state - but there is none of that as far as
I can see.  So in those paths I think we would be
fine not to bother taking any additional lock at all.

Jonathan

> ---
>  drivers/staging/iio/meter/ade7758.h      |  2 ++
>  drivers/staging/iio/meter/ade7758_core.c | 11 +++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758.h
> b/drivers/staging/iio/meter/ade7758.h
> index 6ae78d8aa24f..728424a6648b 100644
> --- a/drivers/staging/iio/meter/ade7758.h
> +++ b/drivers/staging/iio/meter/ade7758.h
> @@ -112,6 +112,7 @@
>   * @tx:                        transmit buffer
>   * @rx:                        receive buffer
>   * @buf_lock:          mutex to protect tx and rx
> + * @lock:              mutex to protect raw read and write
>   **/
>  struct ade7758_state {
>         struct spi_device       *us;
> @@ -119,6 +120,7 @@ struct ade7758_state {
>         u8                      *tx;
>         u8                      *rx;
>         struct mutex            buf_lock;
> +       struct mutex            rw_lock; /* protect raw read/write */
>         struct spi_transfer     ring_xfer[4];
>         struct spi_message      ring_msg;
>         /*
> diff --git a/drivers/staging/iio/meter/ade7758_core.c
> b/drivers/staging/iio/meter/ade7758_core.c
> index 7b7ffe5ed186..6b153dd6d40d 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -523,12 +523,13 @@ static int ade7758_read_raw(struct iio_dev *indio_dev,
>                             long mask)
>  {
>         int ret;
> +       struct ade7758_state *st = iio_priv(indio_dev);
> 
>         switch (mask) {
>         case IIO_CHAN_INFO_SAMP_FREQ:
> -               mutex_lock(&indio_dev->mlock);
> +               mutex_lock(&st->rw_lock);
>                 ret = ade7758_read_samp_freq(&indio_dev->dev, val);
> -               mutex_unlock(&indio_dev->mlock);
> +               mutex_unlock(&st->rw_lock);
>                 return ret;
>         default:
>                 return -EINVAL;
> @@ -542,14 +543,15 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
>                              int val, int val2, long mask)
>  {
>         int ret;
> +       struct ade7758_state *st = iio_priv(indio_dev);
> 
>         switch (mask) {
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 if (val2)
>                         return -EINVAL;
> -               mutex_lock(&indio_dev->mlock);
> +               mutex_lock(&st->rw_lock);
>                 ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> -               mutex_unlock(&indio_dev->mlock);
> +               mutex_unlock(&st->rw_lock);
>                 return ret;
>         default:
>                 return -EINVAL;
> @@ -854,6 +856,7 @@ static int ade7758_probe(struct spi_device *spi)
>         }
>         st->us = spi;
>         mutex_init(&st->buf_lock);
> +       mutex_init(&st->rw_lock);
> 
>         indio_dev->name = spi->dev.driver->name;
>         indio_dev->dev.parent = &spi->dev;
> --
> 2.11.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

