Return-Path: <jic23@kernel.org>
Message-ID: <5246B3CE.6040200@kernel.org>
Date: Sat, 28 Sep 2013 11:47:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, zubair.lutfullah@gmail.com,
 lars@metafoo.de, fengguang.wu@intel.com, Russ.Dill@ti.com,
 kbuild-all@01.org
Subject: Re: [PATCH] iio:ti_am335x_adc ensure that IIO_KFIFO_BUF is not selected
 witout IIO_BUFFER
References: <1380141441-9133-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1380141441-9133-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/25/13 21:37, Jonathan Cameron wrote:
> This avoids build problems such iio_push_to_buffers* not being defined.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
Applied to the togreg branch of iio.git.

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8b88518..2209f28 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -177,6 +177,7 @@ config TI_ADC081C
>  config TI_AM335X_ADC
>  	tristate "TI's AM335X ADC driver"
>  	depends on MFD_TI_AM335X_TSCADC
> +	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	help
>  	  Say yes here to build support for Texas Instruments ADC
> 
