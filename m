Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <b115a245427767bd4c2fd4242b7ee04a243008b3.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
	<b115a245427767bd4c2fd4242b7ee04a243008b3.1464115008.git.amsfield22@gmail.com>
Date: Wed, 25 May 2016 13:34:57 +0300
Message-ID: <CAEnQRZAdj1fn8ibNx1pCA44=DwDGP8yfMPwGfNCeiW24g97kJg@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: adc: ad7791: claim direct mode when writing frequency
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 24, 2016 at 10:16 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> Driver was checking for direct mode and trying to lock it, but
> left a gap where mode could change before the desired operation.
> Use iio_device_claim_direct_mode() to guarantee device stays in
> direct mode.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

Looks good to me. We could use an Acked-by from Lars here.

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>

> ---
>  drivers/iio/adc/ad7791.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index cf172d58..f7edacc 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -272,24 +272,17 @@ static ssize_t ad7791_write_frequency(struct device *dev,
>         struct ad7791_state *st = iio_priv(indio_dev);
>         int i, ret;
>
> -       mutex_lock(&indio_dev->mlock);
> -       if (iio_buffer_enabled(indio_dev)) {
> -               mutex_unlock(&indio_dev->mlock);
> -               return -EBUSY;
> -       }
> -       mutex_unlock(&indio_dev->mlock);
> -
> -       ret = -EINVAL;
> -
>         for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++) {
>                 if (sysfs_streq(ad7791_sample_freq_avail[i], buf)) {
>
> -                       mutex_lock(&indio_dev->mlock);
> +                       ret = iio_device_claim_direct_mode(indio_dev);
> +                       if (ret)
> +                               return ret;
>                         st->filter &= ~AD7791_FILTER_RATE_MASK;
>                         st->filter |= i;
>                         ad_sd_write_reg(&st->sd, AD7791_REG_FILTER,
>                                          sizeof(st->filter), st->filter);
> -                       mutex_unlock(&indio_dev->mlock);
> +                       iio_device_release_direct_mode(indio_dev);
>                         ret = 0;
>                         break;
>                 }
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
