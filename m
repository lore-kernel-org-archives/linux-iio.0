Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751286AbeF3RYW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 13:24:22 -0400
Date: Sat, 30 Jun 2018 18:24:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/4] iio: accel: adxl345: add link to datasheet
Message-ID: <20180630182417.029f71e6@archlinux>
In-Reply-To: <1529940163-5149-2-git-send-email-akinobu.mita@gmail.com>
References: <1529940163-5149-1-git-send-email-akinobu.mita@gmail.com>
        <1529940163-5149-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Jun 2018 00:22:40 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Add a link to the ADXL345 datasheet
> 
> Cc: Eva Rachel Retuya <eraretuya@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Given this one stands on it's own just fine.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> * v4
> - No changes from v3
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

