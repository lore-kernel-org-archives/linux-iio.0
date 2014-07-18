Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33425 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934490AbaGRKAw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Jul 2014 06:00:52 -0400
Message-id: <53C8F050.6060104@samsung.com>
Date: Fri, 18 Jul 2014 19:00:48 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, jic23@kernel.org,
	ch.naveen@samsung.com, mark.rutland@arm.com,
	devicetree@vger.kernel.org, kgene.kim@samsung.com,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	linux-iio@vger.kernel.org, t.figa@samsung.com,
	rdunlap@infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	kyungmin.park@samsung.com, robh+dt@kernel.org, galak@codeaurora.org
Subject: Re: [PATCHv6 2/4] iio: adc: exynos_adc: Control special clock of ADC
 to support Exynos3250 ADC
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com>
 <1405663186-26464-3-git-send-email-cw00.choi@samsung.com>
 <6485839.CnzmD0SeQj@wuerfel>
In-reply-to: <6485839.CnzmD0SeQj@wuerfel>
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Arnd,

On 07/18/2014 06:47 PM, Arnd Bergmann wrote:
> On Friday 18 July 2014 14:59:44 Chanwoo Choi wrote:
>> This patch control special clock for ADC in Exynos series's FSYS block.
>> If special clock of ADC is registerd on clock list of common clk framework,
>> Exynos ADC drvier have to control this clock.
>>
>> Exynos3250/Exynos4/Exynos5 has 'adc' clock as following:
>> - 'adc' clock: bus clock for ADC
>>
>> Exynos3250 has additional 'sclk_adc' clock as following:
>> - 'sclk_adc' clock: special clock for ADC which provide clock to internal ADC
>>
>> Exynos 4210/4212/4412 and Exynos5250/5420 has not included 'sclk_adc' clock
>> in FSYS_BLK. But, Exynos3250 based on Cortex-A7 has only included 'sclk_adc'
>> clock in FSYS_BLK.
> 
> Do you know if any of the older ADC blocks have an "sclk" input as well?

No, I didn't check older ADC blocks. I only checked it on Exynos3250,
Exynos4210/4212/4412, Exynos5250/5420.

> 
> Further, why is it called "sclk_adc" rather than just "sclk"?

The sclk means 'special clock' in Exynos TRM. Exynos SoC has varisou sclk clocks.
'sclk_adc' is only used for ADC IP.

> 
>> @@ -199,13 +262,20 @@ static void exynos_adc_v2_start_conv(struct exynos_adc *info,
>>         writel(con1 | ADC_CON_EN_START, ADC_V2_CON1(info->regs));
>>  }
>>  
>> +#define __EXYNOS_ADC_V2_DATA                           \
>> +       .num_channels   = MAX_ADC_V2_CHANNELS,          \
>> +       .init_hw        = exynos_adc_v2_init_hw,        \
>> +       .exit_hw        = exynos_adc_v2_exit_hw,        \
>> +       .clear_irq      = exynos_adc_v2_clear_irq,      \
>> +       .start_conv     = exynos_adc_v2_start_conv,     \
>> +
>>  static struct exynos_adc_data const exynos_adc_v2_data = {
>> -       .num_channels   = MAX_ADC_V2_CHANNELS,
>> +       __EXYNOS_ADC_V2_DATA
>> +};
>>  
>> -       .init_hw        = exynos_adc_v2_init_hw,
>> -       .exit_hw        = exynos_adc_v2_exit_hw,
>> -       .clear_irq      = exynos_adc_v2_clear_irq,
>> -       .start_conv     = exynos_adc_v2_start_conv,
>> +static struct exynos_adc_data const exynos3250_adc_v2_data = {
>> +       __EXYNOS_ADC_V2_DATA
>> +       .needs_sclk = true,
>>  };
> 
> I think the macro hurts readability. Please just duplicate the definition
> here.

OK, I'll fix it.

> 
>>  static const struct of_device_id exynos_adc_match[] = {
>> @@ -215,6 +285,9 @@ static const struct of_device_id exynos_adc_match[] = {
>>         }, {
>>                 .compatible = "samsung,exynos-adc-v2",
>>                 .data = (void *)&exynos_adc_v2_data,
>> +       }, {
>> +               .compatible = "samsung,exynos3250-adc-v2",
>> +               .data = (void *)&exynos3250_adc_v2_data,
>>         },
>>         {},
> 
> Remove the '(void *)' cast here and mark the structure as 'const'.
> We intentionally use a 'const void *' type here to verify that
> the driver doesn't modify the per-device type data at runtime,
> which would be bad if you ever have multiple device instances.

OK, I'll remove it.

Thanks,
Chanwoo Choi


