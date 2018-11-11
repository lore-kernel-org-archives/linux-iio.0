Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeKKW5v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:57:51 -0500
Date: Sun, 11 Nov 2018 13:09:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-iio@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH] iio: adc: max9611: convert to SPDX identifiers
Message-ID: <20181111130915.57fa9aa0@archlinux>
In-Reply-To: <87bm70yt67.wl-kuninori.morimoto.gx@renesas.com>
References: <87bm70yt67.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 8 Nov 2018 06:42:43 +0000
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Normally I'm against anyone making SPDX replacements except the
author or someone who is otherwise doing substantial work on the driver.

As Jacopo was working for Renesas at the time I'm going to assume
this is a Renesas wide change and apply it.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max9611.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 643a4e66..917223d 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * iio/adc/max9611.c
>   *
> @@ -5,10 +6,6 @@
>   * 12-bit ADC interface.
>   *
>   * Copyright (C) 2017 Jacopo Mondi
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  /*
