Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753949AbeGGQky (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Jul 2018 12:40:54 -0400
Date: Sat, 7 Jul 2018 17:40:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/4] iio: accel: adxl345: add link to datasheet
Message-ID: <20180707174050.0cdae59a@archlinux>
In-Reply-To: <1530376365-23946-2-git-send-email-akinobu.mita@gmail.com>
References: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
        <1530376365-23946-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  1 Jul 2018 01:32:42 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Add a link to the ADXL345 datasheet
> 
> Cc: Eva Rachel Retuya <eraretuya@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

I already applied the first few of these, no need to
send them again whilst we work on patch 4 onwards!

It doesn't really matter though as I can pick up parts
of a series just fine anyway.

Thanks,

Jonathan

> ---
> * v5
> - No changes from v4
> 
>  drivers/iio/accel/adxl345_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 7251d0e..8e0d56b 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -6,6 +6,8 @@
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License. See the file COPYING in the main
>   * directory of this archive for more details.
> + *
> + * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
>   */
>  
>  #include <linux/module.h>

