Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:39871 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965191AbeE3Aot (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 May 2018 20:44:49 -0400
Received: by mail-it0-f68.google.com with SMTP id c3-v6so21268106itj.4
        for <linux-iio@vger.kernel.org>; Tue, 29 May 2018 17:44:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180528153859.813-1-tduszyns@gmail.com>
References: <20180528153859.813-1-tduszyns@gmail.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Wed, 30 May 2018 08:44:48 +0800
Message-ID: <CAJCx=gnatQnSDFa_XqULgTibov-s=qec-Z3688xZj8dZzY-8Cw@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: fix relative humidity unit
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 28, 2018 at 11:38 PM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> According to IIO ABI relative humidity reading should be
> returned in milli percent.
>
> This patch addresses that by applying proper scaling and
> returning integer instead of fractional format type specifier.
>

*sigh* seems this is my mistake, but good catch.  Slight nitpick
below.. otherwise looks good

> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 5ec3e41b65f2..fe87d27779d9 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -415,10 +415,9 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>         }
>         comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
>
> -       *val = comp_humidity;
> -       *val2 = 1024;
> +       *val = comp_humidity * 1000 / 1024;

Minor nitpick  that it would look cleaner as:   (comp_humidity / 1024) * 1000

>
> -       return IIO_VAL_FRACTIONAL;
> +       return IIO_VAL_INT;
>  }
>
>  static int bmp280_read_raw(struct iio_dev *indio_dev,
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
