Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeKKW7o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:59:44 -0500
Date: Sun, 11 Nov 2018 13:11:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max11100: convert to SPDX identifiers
Message-ID: <20181111131108.6815482f@archlinux>
In-Reply-To: <87h8gsyt8s.wl-kuninori.morimoto.gx@renesas.com>
References: <87h8gsyt8s.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 8 Nov 2018 06:41:10 +0000
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Another Renesas driver so fair enough.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max11100.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> index af59ab2..3440539 100644
> --- a/drivers/iio/adc/max11100.c
> +++ b/drivers/iio/adc/max11100.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * iio/adc/max11100.c
>   * Maxim max11100 ADC Driver with IIO interface
>   *
>   * Copyright (C) 2016-17 Renesas Electronics Corporation
>   * Copyright (C) 2016-17 Jacopo Mondi
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
