Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbeGVIgG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Jul 2018 04:36:06 -0400
Date: Sun, 22 Jul 2018 08:40:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7950: use
 SPDX-License-Identifier
Message-ID: <20180722084016.12e208a0@archlinux>
In-Reply-To: <20180721193734.6427-2-david@lechnology.com>
References: <20180721193734.6427-1-david@lechnology.com>
        <20180721193734.6427-2-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Jul 2018 14:37:33 -0500
David Lechner <david@lechnology.com> wrote:

> This updates the ti-ads7950.c file to use SPDX-License-Identifier
> instead of more verbose license text.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
Applied, thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 0225c1b333ab..f08c4de2bd10 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Texas Instruments ADS7950 SPI ADC driver
>   *
> @@ -10,15 +11,6 @@
>   * And also on hwmon/ads79xx.c
>   * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>   *	Nishanth Menon
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/acpi.h>

