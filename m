Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752125AbeCCPjN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:13 -0500
Date: Sat, 3 Mar 2018 15:39:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 1/6] Staging: iio: adis16209: Arrange headers in
 alphabetical order
Message-ID: <20180303153907.5b0616c0@archlinux>
In-Reply-To: <ebfbecaba2151b9ec9f1369f42ad43cc7e9fe758.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
        <ebfbecaba2151b9ec9f1369f42ad43cc7e9fe758.1519995673.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  2 Mar 2018 18:49:23 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Arrange the headers in alphabetical order for cleanup
> purpose.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
(mostly to test other patches as I'd be really surprised if this one
broke anything :)

Jonathan

> ---
>  drivers/staging/iio/accel/adis16209.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 7fcef9a..58f604d 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -9,11 +9,11 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

