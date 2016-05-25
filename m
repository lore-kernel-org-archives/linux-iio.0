Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <3a73839d868c7dee6b19440ea1015fda3457616e.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
	<3a73839d868c7dee6b19440ea1015fda3457616e.1464115008.git.amsfield22@gmail.com>
Date: Wed, 25 May 2016 13:37:31 +0300
Message-ID: <CAEnQRZBcs7fFZt28Sw2uoFXC2wnsdTKV4jEmsK3fJ7L3qzrBHA@mail.gmail.com>
Subject: Re: [PATCH 4/7] iio: adc: ad7476: use iio helper function to
 guarantee direct mode
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 24, 2016 at 10:18 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> Replace the code that guarantees the device stays in direct mode
> with iio_device_claim_direct_mode() which does same.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>

> ---
>  drivers/iio/adc/ad7476.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index be85c2a..810c9a9 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -106,12 +106,11 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>
>         switch (m) {
>         case IIO_CHAN_INFO_RAW:
> -               mutex_lock(&indio_dev->mlock);
> -               if (iio_buffer_enabled(indio_dev))
> -                       ret = -EBUSY;
> -               else
> -                       ret = ad7476_scan_direct(st);
> -               mutex_unlock(&indio_dev->mlock);
> +               ret = iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +               ret = ad7476_scan_direct(st);
> +               iio_device_release_direct_mode(indio_dev);
>
>                 if (ret < 0)
>                         return ret;
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
