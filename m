Return-Path: <ludovic.desroches@atmel.com>
Date: Wed, 2 Nov 2016 09:36:06 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Wenyou Yang <wenyou.yang@atmel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>, Wenyou Yang
	<wenyou.yang@microchip.com>, <linux-arm-kernel@lists.infradead.org>, Nicolas
 Ferre <nicolas.ferre@atmel.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: at91: add suspend and resume callback
Message-ID: <20161102083606.y53bgtfwmig63e45@rfolt0960.corp.atmel.com>
References: <1478054417-7520-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1478054417-7520-1-git-send-email-wenyou.yang@atmel.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 02, 2016 at 10:40:16AM +0800, Wenyou Yang wrote:
> Add suspend/resume callback, support the pinctrl sleep state when
> the system suspend as well.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
>  drivers/iio/adc/at91_adc.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index bbdac07..ffa81a1 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -30,6 +30,7 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  /* Registers */
>  #define AT91_ADC_CR		0x00		/* Control Register */
> @@ -1347,6 +1348,39 @@ static int at91_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM

I would use CONFIG_PM_SLEEP

> +static int at91_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
> +	struct at91_adc_state *st = iio_priv(idev);
> +
> +	pinctrl_pm_select_sleep_state(dev);
> +	clk_disable_unprepare(st->clk);
> +
> +	return 0;
> +}
> +
> +static int at91_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
> +	struct at91_adc_state *st = iio_priv(idev);
> +
> +	clk_prepare_enable(st->clk);
> +	pinctrl_pm_select_default_state(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops at91_adc_pm_ops = {
> +	.suspend = at91_adc_suspend,
> +	.resume = at91_adc_resume,
> +};
> +
> +#define AT91_ADC_PM_OPS (&at91_adc_pm_ops)
> +#else
> +#define AT91_ADC_PM_OPS NULL
> +#endif
> +

and this macro: SET_SYSTEM_SLEEP_PM_OPS

Regards

Ludovic

>  static struct at91_adc_caps at91sam9260_caps = {
>  	.calc_startup_ticks = calc_startup_ticks_9260,
>  	.num_channels = 4,
> @@ -1441,6 +1475,7 @@ static struct platform_driver at91_adc_driver = {
>  	.driver = {
>  		   .name = DRIVER_NAME,
>  		   .of_match_table = of_match_ptr(at91_adc_dt_ids),
> +		.pm = AT91_ADC_PM_OPS,
>  	},
>  };
>  
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
