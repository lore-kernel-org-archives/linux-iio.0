Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeC3LgI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 07:36:08 -0400
Date: Fri, 30 Mar 2018 12:36:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v6 4/6] Staging: iio: adis16209: Remove unused headers
Message-ID: <20180330123602.0907c3d9@archlinux>
In-Reply-To: <52f7695224d2026d03fc5823a8a8c45ab48bbfe9.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
        <52f7695224d2026d03fc5823a8a8c45ab48bbfe9.1522306893.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Mar 2018 14:49:22 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Remove few unused header files since the adis core handles
> the sysfs and buffer support.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied,

Thanks,

Jonathan

> ---
> 
> Changes in v6
>   -Introduce this new patch in the series.
> 
>  drivers/staging/iio/accel/adis16209.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index ee7e87b..ed6d7c7 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -6,7 +6,6 @@
>   * Licensed under the GPL-2 or later.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -16,8 +15,6 @@
>  #include <linux/sysfs.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
>  #define ADIS16209_STARTUP_DELAY_MS	220

