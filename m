Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51333 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaDKK4Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Apr 2014 06:56:25 -0400
Message-id: <5347CA51.8020003@samsung.com>
Date: Fri, 11 Apr 2014 12:56:17 +0200
From: Tomasz Figa <t.figa@samsung.com>
MIME-version: 1.0
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: jic23@kernel.org, ch.naveen@samsung.com, kgene.kim@samsung.com,
	linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH] iio: adc: exynos_adc: Control special clock of ADC to
 support Exynos3250 ADC
References: <1397181640-18513-1-git-send-email-cw00.choi@samsung.com>
 <18632148.yOYlTYattA@amdc1032>
In-reply-to: <18632148.yOYlTYattA@amdc1032>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 11.04.2014 11:41, Bartlomiej Zolnierkiewicz wrote:
>
> Hi,
>
> On Friday, April 11, 2014 11:00:40 AM Chanwoo Choi wrote:
>> This patch control special clock for ADC in Exynos series's FSYS block.
>
> s/control/controls/
>
>> If special clock of ADC is registerd on clock list of common clk framework,
>> Exynos ADC drvier have to control this clock.
>
> s/drvier/driver/
>
>> Exynos3250/Exynos4/Exynos5 has 'adc' clock as following:
>> - 'adc' clock: bus clock for ADC
>>
>> Exynos3250 has additional 'sclk_tsadc' clock as following:
>> - 'sclk_tsadc' clock: special clock for ADC which provide clock to internal ADC
>>
>> Exynos 4210/4212/4412 and Exynos5250/5420 has not included 'sclk_tsadc' clock
>> in FSYS_BLK. But, Exynos3250 based on Cortex-A7 has only included 'sclk_tsadc'
>> clock in FSYS_BLK.
>>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: linux-iio@vger.kernel.org
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>   drivers/iio/adc/exynos_adc.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)

This change alters DT bindings for Exynos ADC, so documentation must be 
modified appropriately.

>>
>> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
>> index d25b262..4cd1975 100644
>> --- a/drivers/iio/adc/exynos_adc.c
>> +++ b/drivers/iio/adc/exynos_adc.c
>> @@ -88,6 +88,7 @@ struct exynos_adc {
>>   	void __iomem		*regs;
>>   	void __iomem		*enable_reg;
>>   	struct clk		*clk;
>> +	struct clk		*sclk;
>>   	unsigned int		irq;
>>   	struct regulator	*vdd;
>>
>> @@ -308,6 +309,13 @@ static int exynos_adc_probe(struct platform_device *pdev)
>>   		goto err_irq;
>>   	}
>>
>> +	info->sclk = devm_clk_get(&pdev->dev, "sclk_tsadc");
>> +	if (IS_ERR(info->sclk)) {
>> +		dev_warn(&pdev->dev, "failed getting sclk clock, err = %ld\n",
>> +							PTR_ERR(info->sclk));
>> +		info->sclk = NULL;
>> +	}
>> +

Is there any reason why we should have a warning on SoCs which don't 
have this clock? I think this clock should be acquired only for affected 
SoCs.

Best regards,
Tomasz
