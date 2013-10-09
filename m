Return-Path: <lars@metafoo.de>
Message-ID: <5254F9B8.8080205@metafoo.de>
Date: Wed, 09 Oct 2013 08:37:44 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: jic23@kernel.org, gregkh@linuxfoundation.org, marex@denx.de,
 linux-iio@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>,
 Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH] iio: adc: Move mxs-lradc out of staging
References: <1381263410-29849-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1381263410-29849-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/08/2013 10:16 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There have been some discussions [1] about removing this driver out of staging,
> so let's do it now.
> 
> [1] http://www.spinics.net/lists/linux-iio/msg10091.html
> 

What about the TODO[1] entry that was recently added?

- Lars

[1] http://www.spinics.net/lists/linux-iio/msg10645.html

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  .../devicetree/bindings/{staging => }/iio/adc/mxs-lradc.txt  |  0
>  drivers/iio/adc/Kconfig                                      | 12 ++++++++++++
>  drivers/iio/adc/Makefile                                     |  1 +
>  drivers/{staging => }/iio/adc/mxs-lradc.c                    |  0
>  drivers/staging/iio/adc/Kconfig                              | 12 ------------
>  drivers/staging/iio/adc/Makefile                             |  1 -
>  6 files changed, 13 insertions(+), 13 deletions(-)
>  rename Documentation/devicetree/bindings/{staging => }/iio/adc/mxs-lradc.txt (100%)
>  rename drivers/{staging => }/iio/adc/mxs-lradc.c (100%)
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> rename to Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 2209f28..11a08b9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -155,6 +155,18 @@ config MCP3422
>  	  This driver can also be built as a module. If so, the module will be
>  	  called mcp3422.
>  
> +config MXS_LRADC
> +	tristate "Freescale i.MX23/i.MX28 LRADC"
> +	depends on ARCH_MXS
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for i.MX23/i.MX28 LRADC convertor
> +	  built into these chips.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mxs-lradc.
> +
>  config NAU7802
>  	tristate "Nuvoton NAU7802 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ba9a10a..b51d543 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
> +obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> similarity index 100%
> rename from drivers/staging/iio/adc/mxs-lradc.c
> rename to drivers/iio/adc/mxs-lradc.c
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index cabc7a3..e5af4a1 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -111,18 +111,6 @@ config LPC32XX_ADC
>  	  activate only one via device tree selection.  Provides direct access
>  	  via sysfs.
>  
> -config MXS_LRADC
> -	tristate "Freescale i.MX23/i.MX28 LRADC"
> -	depends on ARCH_MXS
> -	select IIO_BUFFER
> -	select IIO_TRIGGERED_BUFFER
> -	help
> -	  Say yes here to build support for i.MX23/i.MX28 LRADC convertor
> -	  built into these chips.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called mxs-lradc.
> -
>  config SPEAR_ADC
>  	tristate "ST SPEAr ADC"
>  	depends on PLAT_SPEAR
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index 3e9fb14..243127b 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -18,5 +18,4 @@ obj-$(CONFIG_AD7816) += ad7816.o
>  obj-$(CONFIG_AD7192) += ad7192.o
>  obj-$(CONFIG_AD7280) += ad7280a.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> -obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
> 
