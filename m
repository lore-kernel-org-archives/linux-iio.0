Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "greg@kroah.com" <greg@kroah.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 7 Oct 2010 13:08:43 +0100
Subject: RE: [PATCH 2/3] staging:iio:sca3000 fix bug due to scan_element
 directory move.
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F35A0FFE9@LIMKCMBX1.ad.analog.com>
References: <1286453421-7584-1-git-send-email-jic23@cam.ac.uk>
 <1286453421-7584-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286453421-7584-3-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-10-07:
> The device found passed to the attr functions is that of the ring
> buffer, not the the iio_dev so we need to bounce through one more hop
> to get the right address.
>
> Reported-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/accel/sca3000_ring.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c
> b/drivers/staging/iio/accel/sca3000_ring.c index 8186d2b..c872fdd 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c +++
> b/drivers/staging/iio/accel/sca3000_ring.c @@ -138,7 +138,8 @@ static
> ssize_t sca3000_show_ring_bpse(struct device *dev,  {
>       int len =3D 0, ret;
>       u8 *rx;
> -     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +     struct iio_ring_buffer *ring =3D dev_get_drvdata(dev);
> +     struct iio_dev *indio_dev =3D ring->indio_dev;
>       struct sca3000_state *st =3D indio_dev->dev_data;
>
>       mutex_lock(&st->lock);
> @@ -168,7 +169,8 @@ static ssize_t sca3000_store_ring_bpse(struct
> device *dev,
>                                     const char *buf,
>                                     size_t len)
>  {
> -     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +     struct iio_ring_buffer *ring =3D dev_get_drvdata(dev);
> +     struct iio_dev *indio_dev =3D ring->indio_dev;
>       struct sca3000_state *st =3D indio_dev->dev_data;
>       int ret;
>       u8 *rx;

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
