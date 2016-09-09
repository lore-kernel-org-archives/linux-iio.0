Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35046 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcIIPEj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2016 11:04:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id s64so2886463lfs.2
        for <linux-iio@vger.kernel.org>; Fri, 09 Sep 2016 08:04:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160909143211.13038-1-ico@pruts.nl>
References: <20160909143211.13038-1-ico@pruts.nl>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 9 Sep 2016 18:04:36 +0300
Message-ID: <CAEnQRZDLf5p7rN6Kaaa8YapyZ8M3sdj84RDrLAgAyeQrYwXNmg@mail.gmail.com>
Subject: Re: [PATCH] Fixed superfluous indent white space in sca3000_core.c
To: Ico Doornekamp <ico@pruts.nl>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 9, 2016 at 5:32 PM, Ico Doornekamp <ico@pruts.nl> wrote:
>

Patch subject should be something like:

iio: accel: sca3000_core: Fix superfluous indent white space

> Signed-off-by: Ico Doornekamp <ico@pruts.nl>
> ---
>  drivers/staging/iio/accel/sca3000_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index b5625f5..61f3241 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -412,7 +412,7 @@ static const struct iio_event_spec sca3000_event = {
>                 },                                              \
>                 .event_spec = &sca3000_event,                   \
>                 .num_event_specs = 1,                           \
> -        }
> +       }
>
>  static const struct iio_chan_spec sca3000_channels[] = {
>         SCA3000_CHAN(0, IIO_MOD_X),
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
