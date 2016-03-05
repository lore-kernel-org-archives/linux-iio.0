Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34947 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbcCEHFl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 02:05:41 -0500
Received: by mail-lb0-f181.google.com with SMTP id bc4so83337906lbc.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2016 23:05:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1457160925-20254-1-git-send-email-mranostay@gmail.com>
References: <1457160925-20254-1-git-send-email-mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Fri, 4 Mar 2016 23:05:00 -0800
Message-ID: <CAKzfze9u7bOZKD9+nU5qJGN4SDaaLu+jWXPRKHx=1x7e0=BfyQ@mail.gmail.com>
Subject: Re: [PATCH] iio: potentiometer: tpl0102: change i2c functionality
 return code
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Matt Ranostay <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Bit embarrassing that I missed my new driver in the original cleanup :)

On Fri, Mar 4, 2016 at 10:55 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> Change i2c_check_functionality condition check return from ENOTSUPP to
> EOPNOTSUPP which is now the standard return code.
>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/potentiometer/tpl0102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
> index 313124b..5c304d4 100644
> --- a/drivers/iio/potentiometer/tpl0102.c
> +++ b/drivers/iio/potentiometer/tpl0102.c
> @@ -118,7 +118,7 @@ static int tpl0102_probe(struct i2c_client *client,
>
>         if (!i2c_check_functionality(client->adapter,
>                                      I2C_FUNC_SMBUS_WORD_DATA))
> -               return -ENOTSUPP;
> +               return -EOPNOTSUPP;
>
>         indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>         if (!indio_dev)
> --
> 2.7.0
>
