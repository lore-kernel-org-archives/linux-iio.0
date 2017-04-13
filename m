Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34136 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbdDMSVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2017 14:21:34 -0400
Received: by mail-vk0-f44.google.com with SMTP id z204so31736427vkd.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2017 11:21:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170413021657.30434-1-matt.ranostay@konsulko.com>
References: <20170413021657.30434-1-matt.ranostay@konsulko.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 13 Apr 2017 11:21:32 -0700
Message-ID: <CAJCx=gkQPWNirL4JazWwVHD41Cpy3=HPDwuD_kmbf6UzzOYvPg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: apds9960: add system-wide suspend
To: "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 12, 2017 at 7:16 PM, Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
> APDS9960 can safefully force runtime suspend if the system wants

Yikes! Typo should be -> safely

> to enter system-wide suspend
>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/light/apds9960.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index a4304edc3e0f..67da1287e987 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -1112,6 +1112,8 @@ static int apds9960_runtime_resume(struct device *dev)
>  #endif
>
>  static const struct dev_pm_ops apds9960_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(apds9960_runtime_suspend,
>                            apds9960_runtime_resume, NULL)
>  };
> --
> 2.11.0
>
