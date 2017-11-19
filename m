Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36711 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdKSU2r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Nov 2017 15:28:47 -0500
Received: by mail-it0-f68.google.com with SMTP id 187so7421982iti.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Nov 2017 12:28:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509133543-4597-4-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net> <1509133543-4597-4-git-send-email-pmeerw@pmeerw.net>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Sun, 19 Nov 2017 12:28:46 -0800
Message-ID: <CAJCx=gkGB_HUgLTKiyzcnWaEDZ-Q5QC-G_YgpxyUQELGNian5A@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] iio: health: max30102: Remove inconsistent full
 stop in error message
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
>  drivers/iio/health/max30102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 62b1b35..6ca6182 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -420,7 +420,7 @@ static int max30102_probe(struct i2c_client *client,
>
>         data->regmap = devm_regmap_init_i2c(client, &max30102_regmap_config);
>         if (IS_ERR(data->regmap)) {
> -               dev_err(&client->dev, "regmap initialization failed.\n");
> +               dev_err(&client->dev, "regmap initialization failed\n");
>                 return PTR_ERR(data->regmap);
>         }
>         max30102_set_powermode(data, false);
> --
> 2.7.4
>
