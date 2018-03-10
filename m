Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44086 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932110AbeCJPTg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Mar 2018 10:19:36 -0500
Date: Sat, 10 Mar 2018 15:19:33 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: adt7316: Move symbol export to definition
Message-ID: <20180310151933.76fe3ac9@archlinux>
In-Reply-To: <20180308094729.GA11441@zenbook-arch>
References: <20180308094729.GA11441@zenbook-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 8 Mar 2018 10:47:29 +0100
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> This patch clears the following checkpatch.pl warning:
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL_GPL(adt7316_pm_ops);
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 2d33632c00e8..3f22d1088713 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2079,9 +2079,8 @@ static int adt7316_enable(struct device *dev)
>  
>  	return _adt7316_store_enabled(chip, 1);
>  }
> -
> -SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
>  EXPORT_SYMBOL_GPL(adt7316_pm_ops);
> +SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
>  #endif
>  
>  static const struct iio_info adt7316_info = {

