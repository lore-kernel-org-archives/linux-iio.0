Return-Path: <SRS0=kLlw=CR=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1509133543-4597-3-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net> <1509133543-4597-3-git-send-email-pmeerw@pmeerw.net>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Sun, 19 Nov 2017 12:28:08 -0800
Message-ID: <CAJCx=gmyHMH720B2hCKpTbC4FfP0nKibM4W500mO4v3XSt+43A@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] iio: health: max30102: Fix missing newline in dev_err
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/health/max30102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 147a8c1..62b1b35 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -261,7 +261,7 @@ static int max30102_led_init(struct max30102_data *data)
>
>         ret = max30102_get_current_idx(val, &reg);
>         if (ret) {
> -               dev_err(dev, "invalid IR LED current setting %d", val);
> +               dev_err(dev, "invalid IR LED current setting %d\n", val);
>                 return ret;
>         }
>
> --
> 2.7.4
>
