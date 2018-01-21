Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeAUMeo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jan 2018 07:34:44 -0500
Date: Sun, 21 Jan 2018 12:34:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] iio/adc: depend on SYSFS instead of selecting it
Message-ID: <20180121123440.4c03c4f6@archlinux>
In-Reply-To: <ab9e8e58-4f97-f48d-ade4-962856e5dd11@infradead.org>
References: <ab9e8e58-4f97-f48d-ade4-962856e5dd11@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 14 Jan 2018 21:11:05 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drivers should not 'select' a subsystem. Instead they should depend
> on it. If the subsystem is disabled, the user probably did that for
> a purpose and one driver shouldn't be changing that.
> 
> This also makes all IIO drivers consistent w.r.t depending on SYSFS
> instead of selecting it.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Whilst thinking on the autobuilders, I'd love to relax the constraint
that this depends on the at91 subarch and at least allow build testing.
Will greatly improve our test coverage.

Maxime, I ran a quick test and it's fine on x86_64 anyway.  Do you know of
any reason we will get build problems on other platforms?

Thanks,

Jonathan

> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/adc/Kconfig |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- lnx-415-rc8.orig/drivers/iio/adc/Kconfig
> +++ lnx-415-rc8/drivers/iio/adc/Kconfig
> @@ -144,10 +144,9 @@ config ASPEED_ADC
>  config AT91_ADC
>  	tristate "Atmel AT91 ADC"
>  	depends on ARCH_AT91
> -	depends on INPUT
> +	depends on INPUT && SYSFS
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> -	select SYSFS
>  	help
>  	  Say yes here to build support for Atmel AT91 ADC.
>  

