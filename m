Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeBRMFD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Feb 2018 07:05:03 -0500
Date: Sun, 18 Feb 2018 12:04:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@nxp.com
Subject: Re: [PATCH 1/3] Staging: iio: adis16209: Use SPDX identifier
Message-ID: <20180218120459.5b1fd348@archlinux>
In-Reply-To: <6771b95bbfb8301724086dba4d92df6a6b11d6f7.1518883035.git.shreeya.patel23498@gmail.com>
References: <cover.1518883035.git.shreeya.patel23498@gmail.com>
        <6771b95bbfb8301724086dba4d92df6a6b11d6f7.1518883035.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Feb 2018 21:34:56 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Use SPDX identifier format instead of GPLv2. Also rearrange the
> headers in alphabetical order.

As Dan pointed out for the Himanshu Jha's patches, the moment
we see the word 'also' in a patch it pretty much makes it obvious
that the author knows it is doing two things.

Two patches please.  This is all about making the changes
trivial to review.  Sometimes it may seem silly where we have
two small changes like here, but when you are reviewing hundreds
of patches it really does help.

Jonathan

> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16209.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 7fcef9a..e3d9f80 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -1,19 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
>   *
>   * Copyright 2010 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.
>   */
>  
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

