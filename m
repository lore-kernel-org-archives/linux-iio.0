Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1417024517-7564-2-git-send-email-lars@metafoo.de>
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>
	<1417024517-7564-2-git-send-email-lars@metafoo.de>
Date: Fri, 5 Dec 2014 00:51:11 +0200
Message-ID: <CAEnQRZC=kF4J3+qSwucW3Mk_Z3JgogAzN6hY9q08JcmOC6OVVA@mail.gmail.com>
Subject: Re: [PATCH 01/11] staging:iio:ad5933: Don't enable channels by default
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 26, 2014 at 7:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> The convention for IIO devices is that all channels are disabled by default.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index b6bd609..aa6a368 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -757,10 +757,6 @@ static int ad5933_probe(struct i2c_client *client,
>         if (ret)
>                 goto error_unreg_ring;
>
> -       /* enable both REAL and IMAG channels by default */
> -       iio_scan_mask_set(indio_dev, indio_dev->buffer, 0);
> -       iio_scan_mask_set(indio_dev, indio_dev->buffer, 1);
> -
>         ret = ad5933_setup(st);
>         if (ret)
>                 goto error_uninitialize_ring;
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
