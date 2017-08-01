Return-Path: <SRS0=PNad=7D=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1501602538.29303.333.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads7950: Add OF device ID table
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, David
 Lechner <david@lechnology.com>
Date: Tue, 01 Aug 2017 18:48:58 +0300
In-Reply-To: <20170728222015.43574-3-andriy.shevchenko@linux.intel.com>
References: <20170728222015.43574-1-andriy.shevchenko@linux.intel.com>
	 <20170728222015.43574-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2017-07-29 at 01:20 +0300, Andy Shevchenko wrote:
> The driver doesn't have a struct of_device_id table but supported
> devices
> are registered via Device Trees. This is working on the assumption
> that a
> SPI device registered via OF will always match a legacy SPI device ID
> and
> that the MODALIAS reported will always be of the form spi:<device>.
> 
> There is an ACPI method to enumerate such devices via specific ACPI ID
> and use of compatible strings. It will not work for the drivers which
> have no OF match ID table present.
> 
> Besides this could change in the future so the correct approach is to
> have an OF device ID table if the devices are registered via OF.
> 

Btw, this patch can be applied independently.

For ACPI case both of them are needed, and order doesn't matter.

> Tested-by: David Lechner <david@lechnology.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/ti-ads7950.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-
> ads7950.c
> index ab669af291b7..a376190914ad 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -491,9 +491,27 @@ static const struct spi_device_id ti_ads7950_id[]
> = {
>  };
>  MODULE_DEVICE_TABLE(spi, ti_ads7950_id);
>  
> +static const struct of_device_id ads7950_of_table[] = {
> +	{ .compatible = "ti,ads7950", .data =
> &ti_ads7950_chip_info[TI_ADS7950] },
> +	{ .compatible = "ti,ads7951", .data =
> &ti_ads7950_chip_info[TI_ADS7951] },
> +	{ .compatible = "ti,ads7952", .data =
> &ti_ads7950_chip_info[TI_ADS7952] },
> +	{ .compatible = "ti,ads7953", .data =
> &ti_ads7950_chip_info[TI_ADS7953] },
> +	{ .compatible = "ti,ads7954", .data =
> &ti_ads7950_chip_info[TI_ADS7954] },
> +	{ .compatible = "ti,ads7955", .data =
> &ti_ads7950_chip_info[TI_ADS7955] },
> +	{ .compatible = "ti,ads7956", .data =
> &ti_ads7950_chip_info[TI_ADS7956] },
> +	{ .compatible = "ti,ads7957", .data =
> &ti_ads7950_chip_info[TI_ADS7957] },
> +	{ .compatible = "ti,ads7958", .data =
> &ti_ads7950_chip_info[TI_ADS7958] },
> +	{ .compatible = "ti,ads7959", .data =
> &ti_ads7950_chip_info[TI_ADS7959] },
> +	{ .compatible = "ti,ads7960", .data =
> &ti_ads7950_chip_info[TI_ADS7960] },
> +	{ .compatible = "ti,ads7961", .data =
> &ti_ads7950_chip_info[TI_ADS7961] },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ads7950_of_table);
> +
>  static struct spi_driver ti_ads7950_driver = {
>  	.driver = {
>  		.name	= "ads7950",
> +		.of_match_table = ads7950_of_table,
>  	},
>  	.probe		= ti_ads7950_probe,
>  	.remove		= ti_ads7950_remove,

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
