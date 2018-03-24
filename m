Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeCXOP2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 10:15:28 -0400
Date: Sat, 24 Mar 2018 14:15:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com
Subject: Re: [PATCH 1/4] Staging: iio: accel: adis16201: Remove unused
 headers
Message-ID: <20180324141522.497c96dc@archlinux>
In-Reply-To: <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
        <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 00:42:42 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Remove few unused headers files since the adis core handles the buffer and
> sysfs support.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16201.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 97e25a3..b04dbb3 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -6,7 +6,6 @@
>   * Licensed under the GPL-2 or later.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -16,8 +15,6 @@
>  #include <linux/sysfs.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
>  #define ADIS16201_STARTUP_DELAY_MS			220

