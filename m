Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752596AbdGIUNy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 16:13:54 -0400
Date: Sun, 9 Jul 2017 21:13:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] iio: adc: stm32: add support for lptimer
 triggers
Message-ID: <20170709211348.17ae92f9@kernel.org>
In-Reply-To: <1499445068-7037-10-git-send-email-fabrice.gasnier@st.com>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
        <1499445068-7037-10-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 7 Jul 2017 18:31:08 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> STM32 ADC supports hardware triggers like STM32 Low-Power Timer.
> For instance, STM32H7 ADC may be triggered by instances 1, 2 or 3.
> Add hardware triggered mode so Low-Power Timer Trigger driver can
> validate device.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/stm32-adc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 5bfcc1f..1147d7e 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -25,6 +25,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/timer/stm32-lptim-trigger.h>
>  #include <linux/iio/timer/stm32-timer-trigger.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
> @@ -182,6 +183,11 @@ enum stm32_adc_extsel {
>  	STM32_EXT13,
>  	STM32_EXT14,
>  	STM32_EXT15,
> +	STM32_EXT16,
> +	STM32_EXT17,
> +	STM32_EXT18,
> +	STM32_EXT19,
> +	STM32_EXT20,
>  };
>  
>  /**
> @@ -480,6 +486,9 @@ struct stm32_adc_info {
>  	{ TIM4_TRGO, STM32_EXT12 },
>  	{ TIM6_TRGO, STM32_EXT13 },
>  	{ TIM3_CH4, STM32_EXT15 },
> +	{ LPTIM1_OUT, STM32_EXT18 },
> +	{ LPTIM2_OUT, STM32_EXT19 },
> +	{ LPTIM3_OUT, STM32_EXT20 },
>  	{},
>  };
>  
> @@ -995,7 +1004,8 @@ static int stm32_adc_get_trig_extsel(struct iio_dev *indio_dev,
>  		 * Checking both stm32 timer trigger type and trig name
>  		 * should be safe against arbitrary trigger names.
>  		 */
> -		if (is_stm32_timer_trigger(trig) &&
> +		if ((is_stm32_timer_trigger(trig) ||
> +		     is_stm32_lptim_trigger(trig)) &&
>  		    !strcmp(adc->cfg->trigs[i].name, trig->name)) {
>  			return adc->cfg->trigs[i].extsel;
>  		}
> @@ -1634,7 +1644,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->dev.of_node = pdev->dev.of_node;
>  	indio_dev->info = &stm32_adc_iio_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
>  
>  	platform_set_drvdata(pdev, adc);
>  

