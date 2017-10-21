Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbdJUReK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:34:10 -0400
Date: Sat, 21 Oct 2017 18:34:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 03/13] staging: iio: tsl2x7x: sort #includes
Message-ID: <20171021183405.2d175967@archlinux>
In-Reply-To: <20171019200632.25820-4-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:22 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Sort the #include statements for increased code readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 094ab76b5d60..d407c3ad7e2f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -15,14 +15,14 @@
>   * more details.
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/i2c.h>
> -#include <linux/errno.h>
>  #include <linux/delay.h>
> -#include <linux/mutex.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/slab.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

