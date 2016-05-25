Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35945 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbcEYKmb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2016 06:42:31 -0400
MIME-Version: 1.0
In-Reply-To: <2df3d20cdbc9c3294ef91b515dcdfe0ad151bd01.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
	<2df3d20cdbc9c3294ef91b515dcdfe0ad151bd01.1464115008.git.amsfield22@gmail.com>
Date: Wed, 25 May 2016 13:42:24 +0300
Message-ID: <CAEnQRZBAqO4RSZ=NtVOnVvAd08yBQzQ=mXFUxoN7eHM+xBdNjA@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: adc: ad799x: use iio helper function to
 guarantee direct mode
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 24, 2016 at 10:20 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> Replace the code that guarantees the device stays in direct mode
> with iio_device_claim_direct_mode() which does same.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>


> ---
>  drivers/iio/adc/ad799x.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index a3f5254..ec0200d 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -282,12 +282,11 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>
>         switch (m) {
>         case IIO_CHAN_INFO_RAW:
> -               mutex_lock(&indio_dev->mlock);
> -               if (iio_buffer_enabled(indio_dev))
> -                       ret = -EBUSY;
> -               else
> -                       ret = ad799x_scan_direct(st, chan->scan_index);
> -               mutex_unlock(&indio_dev->mlock);
> +               ret = iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +               ret = ad799x_scan_direct(st, chan->scan_index);
> +               iio_device_release_direct_mode(indio_dev);
>
>                 if (ret < 0)
>                         return ret;
> @@ -395,11 +394,9 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
>         struct ad799x_state *st = iio_priv(indio_dev);
>         int ret;
>
> -       mutex_lock(&indio_dev->mlock);
> -       if (iio_buffer_enabled(indio_dev)) {
> -               ret = -EBUSY;
> -               goto done;
> -       }
> +       ret = iio_device_claim_direct_mode(indio_dev);
> +       if (ret)
> +               return ret;
>
>         if (state)
>                 st->config |= BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
> @@ -412,10 +409,7 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
>                 st->config &= ~AD7998_ALERT_EN;
>
>         ret = ad799x_write_config(st, st->config);
> -
> -done:
> -       mutex_unlock(&indio_dev->mlock);
> -
> +       iio_device_release_direct_mode(indio_dev);
>         return ret;
>  }
>
> --
