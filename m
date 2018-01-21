Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeAUMl3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jan 2018 07:41:29 -0500
Date: Sun, 21 Jan 2018 12:41:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, pombredanne@nexb.com
Subject: Re: [PATCH v3 2/2] iio: adc: change license description
Message-ID: <20180121124125.221eada8@archlinux>
In-Reply-To: <1515961960-35157-2-git-send-email-milan.o.stevanovic@gmail.com>
References: <1515961960-35157-1-git-send-email-milan.o.stevanovic@gmail.com>
        <1515961960-35157-2-git-send-email-milan.o.stevanovic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 14 Jan 2018 21:32:40 +0100
Milan Stevanovic <milan.o.stevanovic@gmail.com> wrote:

>    Using an SPDX tag. Remove a license notice to keep
>    the whole purpose of using an SPDx id.
> 
> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
> ---
>  drivers/iio/adc/ad7476.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 0ea0f90..4fe3cf1 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -1,10 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Analog Devices AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
>   * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
>   *
>   * Copyright 2010 Analog Devices Inc.
>   *
> - * Licensed under the GPL-2 or later.
But this leaves a pointless blank line so good to clean that up as well.

I've done it whilst applying.  Applied to the togreg branch of iio.git
and pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

>   */
>  
>  #include <linux/device.h>

