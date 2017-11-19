Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:38436 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdKSUnK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Nov 2017 15:43:10 -0500
Received: by mail-io0-f195.google.com with SMTP id h205so13009580iof.5
        for <linux-iio@vger.kernel.org>; Sun, 19 Nov 2017 12:43:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509133543-4597-6-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net> <1509133543-4597-6-git-send-email-pmeerw@pmeerw.net>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Sun, 19 Nov 2017 12:43:09 -0800
Message-ID: <CAJCx=gn5WgkOujfr3aMgUpK_kpSc9mBZGV=AcF4a0i8+jLtuNw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] iio: health: max30102: Check retval of powermode function
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/health/max30102.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 13d5312..389a483 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -423,7 +423,10 @@ static int max30102_probe(struct i2c_client *client,
>                 dev_err(&client->dev, "regmap initialization failed\n");
>                 return PTR_ERR(data->regmap);
>         }
> -       max30102_set_powermode(data, false);
> +
> +       ret = max30102_set_powermode(data, false);
> +       if (ret)
> +               return ret;
>
>         ret = max30102_chip_init(data);
>         if (ret)
> --
> 2.7.4
>
