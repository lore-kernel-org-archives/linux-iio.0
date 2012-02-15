Return-Path: <jic23@kernel.org>
Message-ID: <4F3C1EAC.9090809@kernel.org>
Date: Wed, 15 Feb 2012 21:07:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: greg@kroah.com, guenter.roeck@ericsson.com, khali@linux-fr.org,
 dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
 alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
 maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com,
 zdevai@gmail.com, w.sang@pengutronix.de, marek.vasut@gmail.com,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 6/6] stargate2: example of map configuration for iio to
 hwmon example.
References: <1329335285-31006-1-git-send-email-jic23@kernel.org> <1329335285-31006-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1329335285-31006-7-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/15/2012 07:48 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Do not commit.
Whilst this example was never meant to be committed, the obvious flaw
is that max1363 doesn't actually support these interfaces because
I left one patch out. Lets call it 5.5 and stick it before this one.
Sorry about that.
> ---
>  arch/arm/mach-pxa/stargate2.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
> index b0656e15..ce7f0a3 100644
> --- a/arch/arm/mach-pxa/stargate2.c
> +++ b/arch/arm/mach-pxa/stargate2.c
> @@ -54,6 +54,8 @@
>  #include <linux/mfd/da903x.h>
>  #include <linux/sht15.h>
>  
> +#include "../../../drivers/staging/iio/machine.h"
> +
>  #include "devices.h"
>  #include "generic.h"
>  
> @@ -406,6 +408,25 @@ static struct i2c_pxa_platform_data i2c_pdata = {
>  	.fast_mode = 1,
>  };
>  
> +static struct iio_map max1363_consumer_map[] = {
> +	{
> +		.adc_channel_label = "AIN1",
> +		.consumer_dev_name = "iio_hwmon.0",
> +		.consumer_channel = "testchan1",
> +	}, {
> +		.adc_channel_label = "AIN2",
> +		.consumer_dev_name = "iio_hwmon.0",
> +		.consumer_channel = "testchan2",
> +	},
> +	{}
> +};
> +
> +static struct platform_device iio_hwmon_test = {
> +	.name = "iio_hwmon",
> +};
> +
> +
> +
>  static void __init imote2_stargate2_init(void)
>  {
>  
> @@ -561,6 +582,7 @@ static struct i2c_board_info __initdata imote2_i2c_board_info[] = {
>  		 * pull up resistors are missing.
>  		 */
>  		.irq = PXA_GPIO_TO_IRQ(99),
> +		.platform_data = max1363_consumer_map,
>  	}, { /* ITS400 Sensor board only */
>  		.type = "tsl2561",
>  		.addr = 0x49,
> @@ -945,6 +967,7 @@ static struct i2c_board_info __initdata stargate2_i2c_board_info[] = {
>  		 * pull up resistors are missing.
>  		 */
>  		.irq = PXA_GPIO_TO_IRQ(99),
> +		.platform_data = max1363_consumer_map,
>  	}, { /* ITS400 Sensor board only */
>  		.type = "tsl2561",
>  		.addr = 0x49,
> @@ -977,6 +1000,7 @@ static struct platform_device *stargate2_devices[] = {
>  	&stargate2_sram,
>  	&smc91x_device,
>  	&sht15,
> +	&iio_hwmon_test,
>  };
>  
>  static void __init stargate2_init(void)
