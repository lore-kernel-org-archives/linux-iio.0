Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeJ1Umm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 16:42:42 -0400
Date: Sun, 28 Oct 2018 11:58:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan O'Donovan <dan@emutex.com>
Cc: linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v3 3/3] iio: adc128s052: use SPDX-License-Identifier
Message-ID: <20181028115810.1bcdaa5a@archlinux>
In-Reply-To: <1540481742-23596-4-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
        <1540481742-23596-1-git-send-email-dan@emutex.com>
        <1540481742-23596-4-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Oct 2018 16:35:42 +0100
Dan O'Donovan <dan@emutex.com> wrote:

> This updates the ti-adc128s052.c file to use SPDX-License-Identifier
> instead of more verbose license text.
> 
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
Applied, 

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-adc128s052.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index c2d1453..7d2861f 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2014 Angelo Compagnucci <angelo.compagnucci@gmail.com>
>   *
> @@ -6,10 +7,6 @@
>   * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   * http://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   * http://www.ti.com/lit/ds/symlink/adc124s021.pdf
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #include <linux/acpi.h>
