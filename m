Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33830 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbbLERgJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2015 12:36:09 -0500
Subject: Re: [PATCH, RESEND] staging: iio: select IRQ_WORK for IIO_DUMMY_EVGEN
To: Arnd Bergmann <arnd@arndb.de>
References: <1589979.s93Dkm5ubV@wuerfel>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56632087.20104@kernel.org>
Date: Sat, 5 Dec 2015 17:36:07 +0000
MIME-Version: 1.0
In-Reply-To: <1589979.s93Dkm5ubV@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/12/15 23:28, Arnd Bergmann wrote:
> The iio dummy code was recently changed to use irq_work_queue, but
> that code is compiled into the kernel only if IRQ_WORK is set, so
> we can get a link error here:
> 
> drivers/built-in.o: In function `iio_evgen_poke':
> (.text+0x208a04): undefined reference to `irq_work_queue'
> 
> This changes the Kconfig file to match what other drivers do.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: fd2bb310ca3d ("Staging: iio: Move evgen interrupt generation to irq_work")
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
> I submitted the patch before and it was accepted, but then it
> apparently got lost when the driver was moved out of staging,
> and the bug came back with today's linux-next
Good spot - thanks Arnd - this probably explains an odd merge conflict
that turned up around that Kconfig.  Completely missed this sorry about that!


Have applied to my togreg branch - but there is a slightly delay on this going
to Greg from another issue that needs to get sorted so might be a few days
before the fix reaches next.

Pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan


> 
> 
> diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
> index e8676aa97d62..71805ced1aae 100644
> --- a/drivers/iio/dummy/Kconfig
> +++ b/drivers/iio/dummy/Kconfig
> @@ -5,7 +5,8 @@ menu "IIO dummy driver"
>  	depends on IIO
>  
>  config IIO_DUMMY_EVGEN
> -       tristate
> +	select IRQ_WORK
> +	tristate
>  
>  config IIO_SIMPLE_DUMMY
>         tristate "An example driver with no hardware requirements"
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

