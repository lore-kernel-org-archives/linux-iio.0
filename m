Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36336 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcEYKgz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2016 06:36:55 -0400
MIME-Version: 1.0
In-Reply-To: <96cee774e7a4269a73b0fcd476d8af575c10ac00.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
	<96cee774e7a4269a73b0fcd476d8af575c10ac00.1464115008.git.amsfield22@gmail.com>
Date: Wed, 25 May 2016 13:36:53 +0300
Message-ID: <CAEnQRZCVdWRP60GjHJNY8=0pOisY-FcVsVjErDD=sm8QeFgzHQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: ad7793: claim direct mode when writing frequency
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

On Tue, May 24, 2016 at 10:17 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> Driver was checking for direct mode and trying to lock it, but
> left a gap where mode could change before the desired operation.
> Use iio_device_claim_direct_mode() to guarantee device stays in
> direct mode.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>

> ---
>  drivers/iio/adc/ad7793.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 7b07bb6..3f41cd8 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -369,13 +369,6 @@ static ssize_t ad7793_write_frequency(struct device *dev,
>         long lval;
>         int i, ret;
>
> -       mutex_lock(&indio_dev->mlock);
> -       if (iio_buffer_enabled(indio_dev)) {
> -               mutex_unlock(&indio_dev->mlock);
> -               return -EBUSY;
> -       }
> -       mutex_unlock(&indio_dev->mlock);
> -
>         ret = kstrtol(buf, 10, &lval);
>         if (ret)
>                 return ret;
> @@ -387,12 +380,14 @@ static ssize_t ad7793_write_frequency(struct device *dev,
>
>         for (i = 0; i < 16; i++)
>                 if (lval == st->chip_info->sample_freq_avail[i]) {
> -                       mutex_lock(&indio_dev->mlock);
> +                       ret = iio_device_claim_direct_mode(indio_dev);
> +                       if (ret)
> +                               return ret;
>                         st->mode &= ~AD7793_MODE_RATE(-1);
>                         st->mode |= AD7793_MODE_RATE(i);
>                         ad_sd_write_reg(&st->sd, AD7793_REG_MODE,
>                                          sizeof(st->mode), st->mode);
> -                       mutex_unlock(&indio_dev->mlock);
> +                       iio_device_release_direct_mode(indio_dev);
>                         ret = 0;
>                 }
>
> --
