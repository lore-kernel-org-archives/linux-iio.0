Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTVoD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Aug 2018 17:44:03 -0400
Date: Mon, 20 Aug 2018 19:27:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: envelope-detector: switch to SPDX license
 identifier
Message-ID: <20180820192717.6dcd1979@archlinux>
In-Reply-To: <20180820100114.22966-4-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
        <20180820100114.22966-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Aug 2018 12:01:12 +0200
Peter Rosin <peda@axentia.se> wrote:

> Drop the boilerplate license text.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied, thanks.
> ---
>  drivers/iio/adc/envelope-detector.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
> index 4ebda8ab54fe..2f2b563c1162 100644
> --- a/drivers/iio/adc/envelope-detector.c
> +++ b/drivers/iio/adc/envelope-detector.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for an envelope detector using a DAC and a comparator
>   *
>   * Copyright (C) 2016 Axentia Technologies AB
>   *
>   * Author: Peter Rosin <peda@axentia.se>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  /*
