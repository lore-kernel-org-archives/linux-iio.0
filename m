Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752462AbdIFQRY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Sep 2017 12:17:24 -0400
Subject: Re: [PATCH] iio: stm32: fix adc/trigger link error
To: Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lee Jones <lee.jones@linaro.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20170906125722.2522781-1-arnd@arndb.de>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <50ec54e0-85f7-8c32-475c-9b27a4e6ebd3@st.com>
Date: Wed, 6 Sep 2017 18:16:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170906125722.2522781-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/06/2017 02:56 PM, Arnd Bergmann wrote:
> The ADC driver can trigger on either the timer or the lptim
> trigger, but it only uses a Kconfig 'select' statement
> to ensure that the first of the two is present. When the lptim
> trigger is enabled as a loadable module, and the adc driver
> is built-in, we now get a link error:
> 
> drivers/iio/adc/stm32-adc.o: In function `stm32_adc_get_trig_extsel':
> stm32-adc.c:(.text+0x4e0): undefined reference to `is_stm32_lptim_trigger'
> 
> We could use a second 'select' statement and always have both
> trigger drivers enabled when the adc driver is, but it seems that
> the lptimer trigger was intentionally left optional, so it seems
> better to keep it that way.
Hi Arnd,

This is correct, not all stm32 have this hardware.
> 
> This adds a hack to use 'IS_REACHABLE()' rather than 'IS_ENABLED()',
> which avoids the link error, but instead leads to the lptimer trigger
> not being used in the broken configuration. I've added a runtime
> warning for this case to help users figure out what they did wrong
> if this should ever be done by accident.
> 
> Fixes: f0b638a7f6db ("iio: adc: stm32: add support for lptimer triggers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Many thanks for the fix,
Best Regards,
Fabrice
> ---
>  include/linux/iio/timer/stm32-lptim-trigger.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
> index 34d59bfdce2d..464458d20b16 100644
> --- a/include/linux/iio/timer/stm32-lptim-trigger.h
> +++ b/include/linux/iio/timer/stm32-lptim-trigger.h
> @@ -16,11 +16,14 @@
>  #define LPTIM2_OUT	"lptim2_out"
>  #define LPTIM3_OUT	"lptim3_out"
>  
> -#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> +#if IS_REACHABLE(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
>  bool is_stm32_lptim_trigger(struct iio_trigger *trig);
>  #else
>  static inline bool is_stm32_lptim_trigger(struct iio_trigger *trig)
>  {
> +#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> +	pr_warn_once("stm32 lptim_trigger not linked in\n");
> +#endif
>  	return false;
>  }
>  #endif
> 
