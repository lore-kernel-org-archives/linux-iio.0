Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbdHTJRo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 05:17:44 -0400
Date: Sun, 20 Aug 2017 10:17:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: light: apds9300: constify i2c_device_id
Message-ID: <20170820101702.6cd1242e@archlinux>
In-Reply-To: <1503168458-17676-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
        <1503168458-17676-3-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 20 Aug 2017 00:17:37 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> i2c_device_id are not supposed to change at runtime. All functions
> working with i2c_device_id provided by <linux/i2c.h> work with
> const i2c_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/light/apds9300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
> index 649b26f..05eacd1 100644
> --- a/drivers/iio/light/apds9300.c
> +++ b/drivers/iio/light/apds9300.c
> @@ -505,7 +505,7 @@ static SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend, apds9300_resume);
>  #define APDS9300_PM_OPS NULL
>  #endif
>  
> -static struct i2c_device_id apds9300_id[] = {
> +static const struct i2c_device_id apds9300_id[] = {
>  	{ APDS9300_DRV_NAME, 0 },
>  	{ }
>  };

