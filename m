Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57908 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdAJVNG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 16:13:06 -0500
Subject: Re: [PATCH 3/3] iio: pc104: Mask PC/104 drivers via the PC104 Kconfig
 option
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        gregkh@linuxfoundation.org
References: <cover.1484073324.git.vilhelm.gray@gmail.com>
 <512f7f9909c9ff6964b34e0302eeb404e703f033.1484073325.git.vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        gnurou@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4236ccf5-1480-ea3c-fee6-35ea252e3756@kernel.org>
Date: Tue, 10 Jan 2017 21:13:02 +0000
MIME-Version: 1.0
In-Reply-To: <512f7f9909c9ff6964b34e0302eeb404e703f033.1484073325.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/17 18:51, William Breathitt Gray wrote:
> PC/104 drivers should be hidden on machines which do not support PC/104
> devices. This patch adds the PC104 Kconfig option as a dependency for
> the relevant PC/104 device driver Kconfig options.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>

Now the question is how to merge this one.  Let me know if you
want me to take this one via IIO after the first patch is in.
If you want to take it another route I'm fine with that.

Jonathan
> ---
>  drivers/iio/adc/Kconfig     | 2 +-
>  drivers/iio/counter/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9c8b558ba19e..dc897b443a17 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -465,7 +465,7 @@ config STM32_ADC
>  
>  config STX104
>  	tristate "Apex Embedded Systems STX104 driver"
> -	depends on X86 && ISA_BUS_API
> +	depends on PC104 && X86 && ISA_BUS_API
>  	select GPIOLIB
>  	help
>  	  Say yes here to build support for the Apex Embedded Systems STX104
> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
> index 44627f6e4861..b37e5fc03149 100644
> --- a/drivers/iio/counter/Kconfig
> +++ b/drivers/iio/counter/Kconfig
> @@ -7,7 +7,7 @@ menu "Counters"
>  
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
> -	depends on X86 && ISA_BUS_API
> +	depends on PC104 && X86 && ISA_BUS_API
>  	help
>  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
>  	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
> 

