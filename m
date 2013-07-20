Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44309 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab3GTJfZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Jul 2013 05:35:25 -0400
Message-ID: <51EA59D2.4050907@kernel.org>
Date: Sat, 20 Jul 2013 10:35:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Josh Wu <josh.wu@atmel.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com
Subject: Re: [PATCH 2/5] iio: at91: Use different prescal, startup mask in
 MR for different IP
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-3-git-send-email-josh.wu@atmel.com> <51E64EBB.30700@atmel.com> <51E66D5E.1060608@atmel.com>
In-Reply-To: <51E66D5E.1060608@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/2013 11:09 AM, Josh Wu wrote:
> Hi, Nicolas
> 
> Thanks for your review.
> 
> On 7/17/2013 3:58 PM, Nicolas Ferre wrote:
>> On 14/07/2013 10:04, Josh Wu :
>>> For at91 boards, there are different IPs for adc. Different IPs has different
>>> STARTUP & PRESCAL mask in ADC_MR.
>>>
>>> This patch can change the masks according to the different IP version.
>>>
>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>> ---
>>>   arch/arm/mach-at91/include/mach/at91_adc.h |    9 ++++--
>>>   drivers/iio/adc/at91_adc.c                 |   48 ++++++++++++++++++++++++++--
>>>   2 files changed, 53 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-at91/include/mach/at91_adc.h b/arch/arm/mach-at91/include/mach/at91_adc.h
>>> index 8e7ed5c..ab273ee 100644
>>> --- a/arch/arm/mach-at91/include/mach/at91_adc.h
>>> +++ b/arch/arm/mach-at91/include/mach/at91_adc.h
>>> @@ -28,9 +28,12 @@
>>>   #define            AT91_ADC_TRGSEL_EXTERNAL    (6 << 1)
>>>   #define        AT91_ADC_LOWRES        (1 << 4)    /* Low Resolution */
>>>   #define        AT91_ADC_SLEEP        (1 << 5)    /* Sleep Mode */
>>> -#define        AT91_ADC_PRESCAL    (0x3f << 8)    /* Prescalar Rate Selection */
>>> +#define        AT91_ADC_PRESCAL    (0xff << 8)    /* Prescalar Rate Selection */
>>> +#define        AT91_ADC_PRESCAL_9260    (0x3f << 8)
>>>   #define            AT91_ADC_PRESCAL_(x)    ((x) << 8)
>>> -#define        AT91_ADC_STARTUP    (0x1f << 16)    /* Startup Up Time */
>>> +#define        AT91_ADC_STARTUP    (0xf << 16)    /* Startup Up Time */
>>
>> Which product has this kind of startup mask: 0xf? Compared with 9260 and 9g45 values, it seems strange to me: maybe a
>> little comment should be added.
> 
> From the datasheet, In at91sam9x5 and sama5d3x, the startup time mask is become 0xf. In meanwhile, the startup time
> calculation method is also changed.
> 
> Before at91sam9x5, Startup Time = (STARTUP+1) * 8/ADCCLK
> 
> Since at91sam9x5,  Startup Time = <find the following lookup table>
>         0 SUT0 0 periods of ADCClock
>         1 SUT8 8 periods of ADCClock
>         2 SUT16 16 periods of ADCClock
>         3 SUT24 24 periods of ADCClock
>         4 SUT64 64 periods of ADCClock
>         5 SUT80 80 periods of ADCClock
>         ...    ...
>         14 SUT896 896 periods of ADCClock
>         15 SUT960 960 periods of ADCClock
> 
> so only 4bits, it still can define < 960's ADC clock.
> 
> In my 3/5 patch, it implement this calculation method.
> 
>>
>>
>>> +#define        AT91_ADC_STARTUP_9260 (0x1f << 16)
>>> +#define        AT91_ADC_STARTUP_9G45    (0x7f << 16)
>>>   #define            AT91_ADC_STARTUP_(x)    ((x) << 16)
>>>   #define        AT91_ADC_SHTIM        (0xf  << 24)    /* Sample & Hold Time */
>>>   #define            AT91_ADC_SHTIM_(x)    ((x) << 24)
>>> @@ -58,4 +61,6 @@
>>>   #define AT91_ADC_CHR(n)        (0x30 + ((n) * 4))    /* Channel Data Register N */
>>>   #define        AT91_ADC_DATA        (0x3ff)
>>>
>>> +#define AT91_ADC_VERSION    0xFC
>>> +
>>>   #endif
>>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>>> index 18bd54f..14e99ba 100644
>>> --- a/drivers/iio/adc/at91_adc.c
>>> +++ b/drivers/iio/adc/at91_adc.c
>>> @@ -39,6 +39,12 @@
>>>   #define at91_adc_writel(st, reg, val) \
>>>       (writel_relaxed(val, st->reg_base + reg))
>>>
>>> +struct at91_adc_caps {
>>> +    bool    has_tsmr;    /* only at91sam9x5, sama5d3 have TSMR reg */
>>> +    u32    mr_prescal_mask;
>>> +    u32    mr_startup_mask;
>>> +};
>>> +
>>
>> If we move to DT and compatible string for these values, maybe a separate structure won't be needed....
> 
> yes, if we move the mask as DT property.
> But another way is define above structure in driver. Driver will load the correct mask by checking the compatible
> string. In this way, we don't exposure all IP details out to DT.
> I prefer the second way in the moment.
> 
> By answer this question, I just had a second thought of the ADC compatible implementation:
> For touch ADC, there should have 3 catalogs:
>   9260/9g20: not support touch.
>   9g45: support touch, but no average, no TSMR. Need a software filter
>   9x5, sama5: support touch, with average, TSMR. Sample data function changed a lot from 9g45.
> 
>>
>>
>>>   struct at91_adc_state {
>>>       struct clk        *adc_clk;
>>>       u16            *buffer;
>>> @@ -62,6 +68,7 @@ struct at91_adc_state {
>>>       u32            res;        /* resolution used for convertions */
>>>       bool            low_res;    /* the resolution corresponds to the lowest one */
>>>       wait_queue_head_t    wq_data_avail;
>>> +    struct at91_adc_caps    caps;
>>>   };
>>>
>>>   static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>>> @@ -580,6 +587,41 @@ static const struct iio_info at91_adc_info = {
>>>       .read_raw = &at91_adc_read_raw,
>>>   };
>>>
>>> +/*
>>> + * Since atmel adc support different ip for touchscreen mode. Through the
>>> + * IP check, we will know the touchscreen capbilities.
>>> + */
>>> +static void atmel_adc_get_cap(struct at91_adc_state *st)
>>> +{
>>> +    unsigned int version;
>>> +    struct iio_dev *idev = iio_priv_to_dev(st);
>>> +
>>> +    version = at91_adc_readl(st, AT91_ADC_VERSION);
>>> +    dev_dbg(&idev->dev, "version: 0x%x\n", version);
>>> +
>>> +    st->caps.mr_prescal_mask = AT91_ADC_PRESCAL_9260;
>>> +    st->caps.mr_startup_mask = AT91_ADC_STARTUP_9260;
>>> +
>>> +    /* keep only major version number */
>>> +    switch (version & 0xf00) {
>>> +    case 0x500:    /* SAMA5D3 */
>>> +    case 0x400:    /* AT91SAM9X5/9N12 */
>>> +        st->caps.has_tsmr = 1;
>>> +        st->caps.mr_startup_mask = AT91_ADC_STARTUP;
>>
>> Here is where AT91_ADC_STARTUP may need another name: what about AT91_ADC_STARTUP_9x5 to match the "compatibility" of
>> this value?
> 
> ok.
> 
>>
>>
>>> +    case 0x200:    /* AT91SAM9M10/9G45 */
>>> +        st->caps.mr_prescal_mask = AT91_ADC_PRESCAL;
>>> +
>>> +        if ((version & 0xf00) == 0x200)
>>
>> Sorry but I do not understand this test in a switch/case entry where it should always be true...
> 
> Since the switch case is fall through, that means the higher IP (at91sam9x5, sama5) will also running this check, but
> this line only for 9G45 chip.
> 
> a little bit hard to read  :)

Indeed. Write the case statements out long hand without the full throughs.
It'll take a couple more lines but be much easer to read.
> 
>>
>>
>>> +            st->caps.mr_startup_mask = AT91_ADC_STARTUP_9G45;
>>> +    case 0x100:    /* AT91SAM9260/9G20 */
>>> +        break;
>>> +    default:
>>> +        dev_warn(&idev->dev,
>>> +                "Unmanaged adc version, use minimal capabilities\n");
>>> +        break;
>>> +    };
>>> +}
>>> +
>>>   static int at91_adc_probe(struct platform_device *pdev)
>>>   {
>>>       unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
>>> @@ -645,6 +687,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>>>           goto error_free_device;
>>>       }
>>>
>>> +    atmel_adc_get_cap(st);
>>> +
>>>       st->clk = devm_clk_get(&pdev->dev, "adc_clk");
>>>       if (IS_ERR(st->clk)) {
>>>           dev_err(&pdev->dev, "Failed to get the clock.\n");
>>> @@ -704,8 +748,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>>>       shtim = round_up((st->sample_hold_time * adc_clk_khz /
>>>                 1000) - 1, 1);
>>>
>>> -    reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
>>> -    reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
>>> +    reg = AT91_ADC_PRESCAL_(prsc) & st->caps.mr_prescal_mask;
>>> +    reg |= AT91_ADC_STARTUP_(ticks) & st->caps.mr_startup_mask;
>>>       if (st->low_res)
>>>           reg |= AT91_ADC_LOWRES;
>>>       if (st->sleep_mode)
>>>
>>
>>
> 
> Thanks again.
> Best Regards,
> Josh Wu
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
