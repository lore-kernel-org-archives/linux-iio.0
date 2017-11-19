Return-Path: <SRS0=kLlw=CR=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1509133543-4597-2-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net> <1509133543-4597-2-git-send-email-pmeerw@pmeerw.net>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Sun, 19 Nov 2017 13:09:34 -0800
Message-ID: <CAJCx=gm46LQhRgAOWAeFvvU94zu9RCMH2qe6YrzB3CJYTA-TWA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] iio: health: max30102: Temperature should be in
 milli Celsius
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
> As per ABI temperature should be in milli Celsius after scaling,
> not Celsius

Good catch...Thanks

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/health/max30102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 203ffb9..147a8c1 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -371,7 +371,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
>                 mutex_unlock(&indio_dev->mlock);
>                 break;
>         case IIO_CHAN_INFO_SCALE:
> -               *val = 1;  /* 0.0625 */
> +               *val = 1000;  /* 62.5 */
>                 *val2 = 16;
>                 ret = IIO_VAL_FRACTIONAL;
>                 break;
> --
> 2.7.4
>
