Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbeETKwJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 06:52:09 -0400
Date: Sun, 20 May 2018 11:52:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/12] staging: iio: ad2s1200: Remove unneeded
 newline in license
Message-ID: <20180520115203.56c54d22@archlinux>
In-Reply-To: <41ab35e221dd530c8caab5b1063d86e35c7e9544.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <41ab35e221dd530c8caab5b1063d86e35c7e9544.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:21:06 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> Remove unneeded newline in license, as it does not improve readability.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Applied, thanks

Jonathan

> ---
> Changes in v4:
>  - Introduced in this version.
> 
>  drivers/staging/iio/resolver/ad2s1200.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index ea7336645116..df3b34200a89 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -7,7 +7,6 @@
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> - *
>   */
>  
>  #include <linux/bitops.h>

