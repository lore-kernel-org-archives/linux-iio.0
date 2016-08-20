Return-Path: <marek.vasut@gmail.com>
Subject: Re: [RFC v4 2/3] iio: adc: ti-adc161s626: add support for TI
 1-channel differential ADCs
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1471663024-25623-1-git-send-email-mranostay@gmail.com>
 <1471663024-25623-3-git-send-email-mranostay@gmail.com>
Cc: jic23@kernel.org
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <de1272c8-cf35-84f3-84db-eaa42525a5bc@gmail.com>
Date: Sat, 20 Aug 2016 18:47:43 +0200
MIME-Version: 1.0
In-Reply-To: <1471663024-25623-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 08/20/2016 05:17 AM, Matt Ranostay wrote:
> Add support for Texas Instruments ADC141S626, and ADC161S626 chips.

Hi,

[...]

> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
> @@ -0,0 +1,17 @@
> +* Texas Instruments ADC141S626, and ADC161S626 chip

I think you should drop the comma and use plural (chips) here.

> +Required properties:
> + - compatible: Should be "ti,adc141s626" or "ti,adc161s626"
> + - reg: spi chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,adc161s626";
> +	reg = <0>;
> +	spi-max-frequency = <4300000>;
> +};
> +
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1de31bdd4ce4..2658f2f69bad 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -426,6 +426,18 @@ config TI_ADC128S052
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc128s052.
>  
> +config TI_ADC161S626
> +	tristate "Texas Instruments ADC161S626 1-channel differential ADC"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  If you say yes here you get support for Texas Instruments ADC141S626,
> +	  and ADC161S626 chips.
> +
> +	  This driver can also be build

... be built ... :-)

> as a module. If so, the module will be
> +	  called ti-adc161s626.
> +
>  config TI_ADS1015
>  	tristate "Texas Instruments ADS1015 ADC"
>  	depends on I2C && !SENSORS_ADS1015

The code looks OK.

-- 
Best regards,
Marek Vasut
