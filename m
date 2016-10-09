Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39056 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753276AbcJIHrQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 03:47:16 -0400
Subject: Re: [PATCH] iio: adc: ti-adc081c: Select IIO_TRIGGERED_BUFFER to
 prevent build errors
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20161005144650.50634-1-mika.westerberg@linux.intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9a919615-020e-e8e1-3e7e-fb5ab442a7f7@kernel.org>
Date: Sun, 9 Oct 2016 08:47:11 +0100
MIME-Version: 1.0
In-Reply-To: <20161005144650.50634-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/10/16 15:46, Mika Westerberg wrote:
> Commit 08e05d1fce5c ("ti-adc081c: Initial triggered buffer support") added
> triggered buffer support but that also requires CONFIG_IIO_TRIGGERED_BUFFER,
> otherwise we get errors from linker such as:
> 
>   drivers/built-in.o: In function `adc081c_remove':
>   drivers/iio/adc/ti-adc081c.c:225: undefined reference to `iio_triggered_buffer_cleanup'
> 
> Fix these by explicitly selecting both CONFIG_IIO_TRIGGERED_BUFFER and
> CONFIG_IIO_BUFFER in Kconfig for the driver.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git which I'll send
a pull request for once the merge window is closed. Strange this one
got through the autobuilders (less strange that it snuck past me
reviewing it ;(

Fengguang, any thoughts?

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 767577298ee3..375ba57bdfcd 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -400,6 +400,8 @@ config ROCKCHIP_SARADC
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for Texas Instruments ADC081C,
>  	  ADC101C and ADC121C ADC chips.
> 

