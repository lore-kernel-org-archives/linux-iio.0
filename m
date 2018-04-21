Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbeDUQqN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:46:13 -0400
Date: Sat, 21 Apr 2018 17:46:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/13] staging: iio: ad2s1200: Sort includes
 alphabetically
Message-ID: <20180421174606.7d17f2b1@archlinux>
In-Reply-To: <37b5b04518480fc1dbc273c84082b648d55eeecc.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
        <37b5b04518480fc1dbc273c84082b648d55eeecc.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 21:28:52 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> This patches sorts all the includes in alphabetic order.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Applied,

Thanks

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1200.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 5d7ed0034422..ffcdf4e8eb92 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -9,15 +9,15 @@
>   * published by the Free Software Foundation.
>   *
>   */
> -#include <linux/types.h>
> -#include <linux/mutex.h>
> -#include <linux/device.h>
> -#include <linux/spi/spi.h>
> -#include <linux/sysfs.h>
> +#include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>
>  #include <linux/gpio.h>
>  #include <linux/module.h>
> -#include <linux/bitops.h>
> +#include <linux/mutex.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

