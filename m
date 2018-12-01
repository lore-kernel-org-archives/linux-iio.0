Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCv2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 21:51:28 -0500
Date: Sat, 1 Dec 2018 15:38:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH v3 5/7] staging:iio:ad2s90: Replace license text w/ SPDX
 identifier
Message-ID: <20181201153836.35cb6318@archlinux>
In-Reply-To: <20181124002312.6923-6-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-6-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Nov 2018 22:23:10 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch removes the license boilerplate text at the top of ad2s90.c
> and, instead, adds the SPDX GPL-2.0 license identifier, which solves the
> checkpatch.pl warning:
> "WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied,

Thanks,

Jonathan

> ---
> Changes in v3:
>  - none
> 
> Changes in v2:
>  - Changed GPL-2.0-only identifier to GPL-2.0
>  - Removed license boilerplate text
>  - Rewritten patch message to reflect these modifications
> 
>  drivers/staging/iio/resolver/ad2s90.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 4721e9bbb8b0..678351dabe6b 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ad2s90.c simple support for the ADI Resolver to Digital Converters: AD2S90
>   *
>   * Copyright (c) 2010-2010 Analog Devices Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  #include <linux/types.h>
>  #include <linux/mutex.h>
