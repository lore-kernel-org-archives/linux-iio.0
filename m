Return-Path: <SRS0=C9+x=5W=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B1BC2BA17
	for <linux-iio@archiver.kernel.org>; Mon,  6 Apr 2020 00:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA5D2072A
	for <linux-iio@archiver.kernel.org>; Mon,  6 Apr 2020 00:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="LmtyroxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgDFAzC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Apr 2020 20:55:02 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44048 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgDFAzC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 20:55:02 -0400
Received: by mail-il1-f195.google.com with SMTP id j69so13060763ila.11
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2020 17:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIu8eQLKew6CMW93GG67q5NvT7KKBmzv4wvH+hizqew=;
        b=LmtyroxGcgE0GprlUsq63O2EFEd0twm8tlAC411nUqDG9OlSQWN870g2JjuqvIBjhj
         kBFxSQ0j+Xo2rp16YbjKUl9jWBZx5y5W8e0+M2cWzZUezyrJj2Ow08a0FgnPyIVdT5WB
         gIrqzTP2w4wlyRtP2QjKhqM6iQYiajnOZi0RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIu8eQLKew6CMW93GG67q5NvT7KKBmzv4wvH+hizqew=;
        b=Wbkq9PQy4QhyVO3e8dsdtqT7K+GDFEGWbI6Xvg+QpYcZur23bMradkzB1pfnakFUX3
         y/S1MafLLIrOR7FVOcPEWSVjVhZq0YRSrhBLrkNpM+iNMa4lZjp8e9kS2vOzTl/MCZF6
         QnujEvuaEyPQ5CiG0peYkXos7w+UjFRzO+v0dDrE1hanAw/JaLPa+9ZIClrUQJJh9Qmd
         Bb3CPUVkRMvwOYf61XgaFBTwioWHXJy0k2R4URk52oELBxSSAqHJaqiEFj0LvRH556Yf
         MDueNPPQCCGw2WZpMt+RZ65I3SALA0oIUycG1aR9vIJi7rIDMlnvlhxhx/iyj9N4C4Jd
         vLbQ==
X-Gm-Message-State: AGi0PuYFh6FkqPFZk71yxxrGxR9Qc5zGtreF5EGgRX7JF+4lC/f5qMm3
        0gRyNkmPHY8fm0VcHaPdE/wHxG603i/B7evk79Z+hA==
X-Google-Smtp-Source: APiQypLQNiF5AthSJxUlWuV7giy1TVW43rKOPAJdz9qF0axPWWe9mJVcvoLryHB6nNP/ylxyeQgUcT9ZxOfzDrWtAjY=
X-Received: by 2002:a92:c787:: with SMTP id c7mr19612331ilk.87.1586134499960;
 Sun, 05 Apr 2020 17:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200405180321.1737310-1-jic23@kernel.org> <20200405180321.1737310-3-jic23@kernel.org>
In-Reply-To: <20200405180321.1737310-3-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 5 Apr 2020 17:54:49 -0700
Message-ID: <CAJCx=g=1L-3-9wcufi-FqEGf0pp+wOr3AAq8A1mz9sRzGWYXKw@mail.gmail.com>
Subject: Re: [PATCH 2/6] iio:chemical:atlas-sensor: Drop unnecessary explicit
 casts in regmap_bulk_read calls
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 5, 2020 at 11:05 AM <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> regmap_bulk_read takes a void * for its val parameter. It certainly
> makes no sense to cast to a (u8 *) + no need to explicitly cast
> at all when converting another pointer type to void *.
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 82d470561ad3..973cdb4f1e83 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -426,8 +426,7 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
>         int ret;
>
>         ret = regmap_bulk_read(data->regmap, data->chip->data_reg,
> -                             (u8 *) &data->buffer,
> -                             sizeof(__be32) * channels);
> +                             &data->buffer, sizeof(__be32) * channels);
>
>         if (!ret)
>                 iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> @@ -463,7 +462,7 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
>         if (suspended)
>                 msleep(data->chip->delay);
>
> -       ret = regmap_bulk_read(data->regmap, reg, (u8 *) val, sizeof(*val));
> +       ret = regmap_bulk_read(data->regmap, reg, val, sizeof(*val));
>
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_put_autosuspend(dev);
> @@ -485,7 +484,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
>                 switch (chan->type) {
>                 case IIO_TEMP:
>                         ret = regmap_bulk_read(data->regmap, chan->address,
> -                                             (u8 *) &reg, sizeof(reg));
> +                                              &reg, sizeof(reg));
>                         break;
>                 case IIO_PH:
>                 case IIO_CONCENTRATION:
> --
> 2.26.0
>
