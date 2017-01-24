Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51971 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750847AbdAXOhu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2017 09:37:50 -0500
Subject: Re: [PATCH 2/7] iio: adc: stm32: Enable use of stm32 timer triggers
To: Jonathan Cameron <jic23@kernel.org>, <linux@armlinux.org.uk>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
 <1484832854-6314-3-git-send-email-fabrice.gasnier@st.com>
 <9826347e-d8e4-2386-cc7a-dd2c4909494b@kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <benjamin.gaignard@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <6e42a729-3513-5586-13dc-10cf5e90f6a3@st.com>
Date: Tue, 24 Jan 2017 15:37:03 +0100
MIME-Version: 1.0
In-Reply-To: <9826347e-d8e4-2386-cc7a-dd2c4909494b@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/22/2017 01:55 PM, Jonathan Cameron wrote:
> On 19/01/17 13:34, Fabrice Gasnier wrote:
>> STM32 ADC has external timer trigger sources. Use stm32 timer triggers
>> API (e.g. is_stm32_timer_trigger()) with local ADC lookup table to
>> validate a trigger can be used.
>> This also provides correct trigger selection value (e.g. extsel).
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Looks good. Observations inline.
>> ---
>>  drivers/iio/adc/Kconfig     |  2 ++
>>  drivers/iio/adc/stm32-adc.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 33341f4..9a7b090 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -447,6 +447,8 @@ config STM32_ADC_CORE
>>  	depends on OF
>>  	depends on REGULATOR
>>  	select IIO_BUFFER
>> +	select MFD_STM32_TIMERS
>> +	select IIO_STM32_TIMER_TRIGGER
>>  	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Select this option to enable the core driver for STMicroelectronics
>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>> index 8d0b74b..30708bc 100644
>> --- a/drivers/iio/adc/stm32-adc.c
>> +++ b/drivers/iio/adc/stm32-adc.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/buffer.h>
>> +#include <linux/iio/timer/stm32-timer-trigger.h>
>>  #include <linux/iio/trigger.h>
>>  #include <linux/iio/trigger_consumer.h>
>>  #include <linux/iio/triggered_buffer.h>
>> @@ -122,6 +123,35 @@ enum stm32_adc_exten {
>>  	STM32_EXTEN_HWTRIG_BOTH_EDGES,
>>  };
>>
>> +/* extsel - trigger mux selection value */
>> +enum stm32_adc_extsel {
>> +	STM32_EXT0,
>> +	STM32_EXT1,
>> +	STM32_EXT2,
>> +	STM32_EXT3,
>> +	STM32_EXT4,
>> +	STM32_EXT5,
>> +	STM32_EXT6,
>> +	STM32_EXT7,
>> +	STM32_EXT8,
>> +	STM32_EXT9,
>> +	STM32_EXT10,
>> +	STM32_EXT11,
>> +	STM32_EXT12,
>> +	STM32_EXT13,
>> +	STM32_EXT14,
>> +	STM32_EXT15,
>> +};
>> +
>> +/**
>> + * struct stm32_adc_trig_info - ADC trigger info
>> + * @name:		name of the trigger, corresponding to its source
>> + * @extsel:		trigger selection
>> + */
>> +struct stm32_adc_trig_info {
>> +	const char *name;
>> +	enum stm32_adc_extsel extsel;
>> +};
>>
>>  /**
>>   * struct stm32_adc - private data of each ADC IIO instance
>> @@ -218,6 +248,26 @@ struct stm32_adc_regs {
>>  	{ STM32F4_ADC_SQR1, STM32F4_SQ16_MASK, STM32F4_SQ16_SHIFT },
>>  };
>>
>> +/* STM32F4 external trigger sources for all instances */
>> +static struct stm32_adc_trig_info stm32f4_adc_timer_trigs[] = {
>> +	{ TIM1_CH1, STM32_EXT0 },
>> +	{ TIM1_CH2, STM32_EXT1 },
>> +	{ TIM1_CH3, STM32_EXT2 },
>> +	{ TIM2_CH2, STM32_EXT3 },
>> +	{ TIM2_CH3, STM32_EXT4 },
>> +	{ TIM2_CH4, STM32_EXT5 },
>> +	{ TIM2_TRGO, STM32_EXT6 },
>> +	{ TIM3_CH1, STM32_EXT7 },
>> +	{ TIM3_TRGO, STM32_EXT8 },
>> +	{ TIM4_CH4, STM32_EXT9 },
>> +	{ TIM5_CH1, STM32_EXT10 },
>> +	{ TIM5_CH2, STM32_EXT11 },
>> +	{ TIM5_CH3, STM32_EXT12 },
>> +	{ TIM8_CH1, STM32_EXT13 },
>> +	{ TIM8_TRGO, STM32_EXT14 },
>> +	{}, /* sentinel */
>> +};
>> +
>>  /**
>>   * STM32 ADC registers access routines
>>   * @adc: stm32 adc instance
>> @@ -362,6 +412,16 @@ static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
>>  static int stm32_adc_get_trig_extsel(struct iio_dev *indio_dev,
>>  				     struct iio_trigger *trig)
>>  {
>> +	int i;
> Ah. This makes more sense than patch 1 on it's own did.
>> +
>> +	/* lookup triggers registered by stm32 timer trigger driver */
>> +	for (i = 0; stm32f4_adc_timer_trigs[i].name; i++) {
>> +		if (is_stm32_timer_trigger(trig) &&
>> +		    !strcmp(stm32f4_adc_timer_trigs[i].name, trig->name)) {
>> +			return stm32f4_adc_timer_trigs[i].extsel;
> Good. The combination of the first check and the name match should make this safe
> against those triggers that can be assigned arbitrary names.

Do you wish I add a comment about it ?

Best Regards,
Fabrice

>> +		}
>> +	}
>> +
>>  	return -EINVAL;
>>  }
>>
>>
>
