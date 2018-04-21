Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeDUQpb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:45:31 -0400
Date: Sat, 21 Apr 2018 17:45:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/13] staging: iio: ad2s1200: Remove unneeded
 include
Message-ID: <20180421174525.6acdec02@archlinux>
In-Reply-To: <08612b1148da933e8ac8ca190250db4c58f6a682.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
        <08612b1148da933e8ac8ca190250db4c58f6a682.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 21:28:32 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> This patches removes unneeded slab.h header.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
This one surprised me, but indeed there are no direct
users of any memory allocation in this file.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Introduced in this version.
> 
> drivers/staging/iio/resolver/ad2s1200.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index aa62c64e9bc4..5d7ed0034422 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -13,7 +13,6 @@
>  #include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>

