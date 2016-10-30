Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42314 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbcJ3OfH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 10:35:07 -0400
Subject: Re: [PATCH 04/10] iio: adc: stm32: add optional support for exti
 gpios
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
 <1477412722-24061-5-git-send-email-fabrice.gasnier@st.com>
Cc: linux@armlinux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e7aac741-e7c4-5680-5ef2-99b57ebba522@kernel.org>
Date: Sun, 30 Oct 2016 14:35:04 +0000
MIME-Version: 1.0
In-Reply-To: <1477412722-24061-5-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 17:25, Fabrice Gasnier wrote:
> STM32 ADC may use EXTi signals routed internally as trigger source
> for conversions. Configure them as interrupt to configure this path
> in HW to adc.
> Note: interrupt handler isn't required here, and corresponding interrupt
> can be kept masked at exti controller level.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/iio/adc/stm32/stm32-adc.c | 45 +++++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/stm32/stm32-adc.h |  3 +++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32/stm32-adc.c b/drivers/iio/adc/stm32/stm32-adc.c
> index 25d0307..1a13450 100644
> --- a/drivers/iio/adc/stm32/stm32-adc.c
> +++ b/drivers/iio/adc/stm32/stm32-adc.c
> @@ -482,6 +482,12 @@ static irqreturn_t stm32_adc_common_isr(int irq, void *data)
>  	return ret;
>  }
>  
> +static irqreturn_t stm32_adc_exti_handler(int irq, void *data)
> +{
> +	/* Exti handler should not be invoqued, and is not used */
invoked.
> +	return IRQ_HANDLED;
> +}
> +
>  /**
>   * stm32_adc_validate_trigger() - validate trigger for stm32 adc
>   * @indio_dev: IIO device
> @@ -1051,6 +1057,41 @@ static void stm32_adc_unregister(struct stm32_adc *adc)
>  	}
>  }
>  
> +static int stm32_adc_exti_probe(struct stm32_adc_common *common)
> +{
> +	int i, irq, ret;
> +
> +	common->gpios = devm_gpiod_get_array_optional(common->dev, NULL,
> +						      GPIOD_IN);
> +	if (!common->gpios)
> +		return 0;
> +
> +	for (i = 0; i < common->gpios->ndescs; i++) {
> +		irq = gpiod_to_irq(common->gpios->desc[i]);
> +		if (irq < 0) {
> +			dev_err(common->dev, "gpio %d to irq failed\n", i);
> +			return irq;
> +		}
> +
> +		ret = devm_request_irq(common->dev, irq, stm32_adc_exti_handler,
> +				       0, dev_name(common->dev), common);
> +		if (ret) {
> +			dev_err(common->dev, "request IRQ %d failed\n", irq);
> +			return ret;
> +		}
> +
> +		/*
> +		 * gpios are configured as interrupts, so exti trigger path is
> +		 * configured in HW. But getting interrupts when starting
> +		 * conversions is unused here, so mask it in on exti
> +		 * controller by default.
> +		 */
> +		disable_irq(irq);
> +	}
> +
> +	return 0;
> +}
> +
>  int stm32_adc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node, *child;
> @@ -1131,6 +1172,10 @@ int stm32_adc_probe(struct platform_device *pdev)
>  		goto err_clk_disable;
>  	}
>  
> +	ret = stm32_adc_exti_probe(common);
> +	if (ret)
> +		goto err_clk_disable;
> +
>  	/* Parse adc child nodes to retrieve master/slave instances data */
>  	for_each_available_child_of_node(np, child) {
>  		ret = stm32_adc_register(common, child);
> diff --git a/drivers/iio/adc/stm32/stm32-adc.h b/drivers/iio/adc/stm32/stm32-adc.h
> index 01a0dda..fe3568b 100644
> --- a/drivers/iio/adc/stm32/stm32-adc.h
> +++ b/drivers/iio/adc/stm32/stm32-adc.h
> @@ -23,6 +23,7 @@
>  #define __STM32_ADC_H
>  
>  #include <linux/dmaengine.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/irq_work.h>
>  
>  /*
> @@ -323,6 +324,7 @@ struct stm32_adc {
>   * @aclk:		common clock for the analog circuitry
>   * @vref:		regulator reference
>   * @vref_mv:		vref voltage (mv)
> + * @gpio_descs:		gpio descriptor used to configure EXTi triggers
>   * @lock:		mutex
>   */
>  struct stm32_adc_common {
> @@ -335,6 +337,7 @@ struct stm32_adc_common {
>  	struct clk			*aclk;
>  	struct regulator		*vref;
>  	int				vref_mv;
> +	struct gpio_descs		*gpios;
>  	struct mutex			lock;	/* read_raw lock */
>  };
>  
> 

