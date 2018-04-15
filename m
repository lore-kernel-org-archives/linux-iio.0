Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbeDOPJ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:09:26 -0400
Date: Sun, 15 Apr 2018 16:09:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] staging: iio: ad7746: Reorder includes
 alphabetically
Message-ID: <20180415160920.436ac606@archlinux>
In-Reply-To: <1523637411-8531-6-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-6-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:42 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 82fac76..9ef476a 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -6,15 +6,15 @@
>   * Licensed under the GPL-2.
>   */
>  
> -#include <linux/interrupt.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/i2c.h>
> -#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/sysfs.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

