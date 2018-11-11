Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeKKXA5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 18:00:57 -0500
Date: Sun, 11 Nov 2018 13:12:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: Re: [PATCH] iio: adc: rcar-gyroadc: convert to SPDX identifiers
Message-ID: <20181111131220.10154420@archlinux>
In-Reply-To: <87in18yta6.wl-kuninori.morimoto.gx@renesas.com>
References: <87in18yta6.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 8 Nov 2018 06:40:21 +0000
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it (or not given it's just a comment
change ;)

Thanks,

Jonathan
> ---
>  drivers/iio/adc/rcar-gyroadc.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index 4e982b5..2c0d031 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -1,17 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Renesas R-Car GyroADC driver
>   *
>   * Copyright 2016 Marek Vasut <marek.vasut@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/module.h>
