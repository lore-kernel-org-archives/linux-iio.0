Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33411 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbcEYKiV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2016 06:38:21 -0400
MIME-Version: 1.0
In-Reply-To: <cce4f683cecf19937334b4f139aa6419e3bda967.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
	<cce4f683cecf19937334b4f139aa6419e3bda967.1464115008.git.amsfield22@gmail.com>
Date: Wed, 25 May 2016 13:38:19 +0300
Message-ID: <CAEnQRZALyfvrE1RWe7hOz0quF9iHa+tJwH0dmg2=s39UnyPEsg@mail.gmail.com>
Subject: Re: [PATCH 5/7] iio: adc: ad7887: use iio helper function to
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

On Tue, May 24, 2016 at 10:18 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> Replace the code that guarantees the device stays in direct mode
> with iio_device_claim_direct_mode() which does same.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>

> ---
>  drivers/iio/adc/ad7887.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 2d3c397..ee2ccc1 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -156,12 +156,11 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
>
>         switch (m) {
>         case IIO_CHAN_INFO_RAW:
> -               mutex_lock(&indio_dev->mlock);
> -               if (iio_buffer_enabled(indio_dev))
> -                       ret = -EBUSY;
> -               else
> -                       ret = ad7887_scan_direct(st, chan->address);
> -               mutex_unlock(&indio_dev->mlock);
> +               ret = iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +               ret = ad7887_scan_direct(st, chan->address);
> +               iio_device_release_direct_mode(indio_dev);
>
>                 if (ret < 0)
>                         return ret;
> --
