Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:56120 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab3HVJyV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 05:54:21 -0400
Message-ID: <5215DFC8.8090607@atmel.com>
Date: Thu, 22 Aug 2013 17:54:16 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: <jic23@cam.ac.uk>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <thomas.petazzoni@free-electrons.com>,
	<mark.rutland@arm.com>, <b.brezillon@overkiz.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 3/4] iio: at91: ADC start-up time calculation changed
 since at91sam9x5
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com> <1376219071-29946-4-git-send-email-josh.wu@atmel.com> <20130815192711.GE12162@lukather>
In-Reply-To: <20130815192711.GE12162@lukather>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi, Maxime

On 8/16/2013 3:27 AM, Maxime Ripard wrote:
> Hi Josh,
>
> On Sun, Aug 11, 2013 at 07:04:30PM +0800, Josh Wu wrote:
>> Since in at91sam9x5, sama5d3x chip. the start up time calucation is
>> changed.  This patch can choose different start up time calculation
>> formula for different chips.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>> v1 --> v2:
>>    add a new variable for different start_time calculation.
>>
>>   drivers/iio/adc/at91_adc.c |   42 +++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index b41eb60..9b0ffff 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -40,6 +40,7 @@
>>   	(writel_relaxed(val, st->reg_base + reg))
>>   
>>   struct at91_adc_caps {
>> +	bool	start_time_use_lookup_tab;
>>   	u32	mr_prescal_mask;
>>   	u32	mr_startup_mask;
>>   };
>> @@ -700,13 +701,39 @@ static int at91_adc_probe(struct platform_device *pdev)
>>   		goto error_disable_adc_clk;
>>   	}
>>   
>> -	/*
>> -	 * Number of ticks needed to cover the startup time of the ADC as
>> -	 * defined in the electrical characteristics of the board, divided by 8.
>> -	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
>> -	 */
>> -	ticks = round_up((st->startup_time * adc_clk_khz /
>> -			  1000) - 1, 8) / 8;
>> +	if (!st->caps->start_time_use_lookup_tab) {
>> +		/*
>> +		 * Number of ticks needed to cover the startup time of the ADC
>> +		 * as defined in the electrical characteristics of the board,
>> +		 * divided by 8. The formula thus is :
>> +		 *   Startup Time = (ticks + 1) * 8 / ADC Clock
>> +		 */
>> +		ticks = round_up((st->startup_time * adc_clk_khz /
>> +				  1000) - 1, 8) / 8;
>> +	} else {
>> +		/*
>> +		 * For sama5d3x and at91sam9x5, the formula changes to:
>> +		 * Startup Time = <lookup_table_value> / ADC Clock
>> +		 */
>> +		const int startup_lookup[] = {
>> +			0  , 8  , 16 , 24 ,
>> +			64 , 80 , 96 , 112,
>> +			512, 576, 640, 704,
>> +			768, 832, 896, 960
>> +			};
>> +
>> +		int i, size = ARRAY_SIZE(startup_lookup);
>> +		ticks = st->startup_time * adc_clk_khz / 1000;
>> +		for (i = 0; i < size; i++)
>> +			if (ticks < startup_lookup[i])
>> +				break;
>> +
>> +		ticks = i;
>> +		if (ticks == size)
>> +			/* Reach the end of lookup table */
>> +			ticks = size - 1;
>> +	}
>> +
> Maybe just declaring two different functions here to calculate the
> number of ticks, and just holding the function pointer in your structure
> would make things more readable and future-proof?

I'll do this in next version. thanks.

>
> Maxime
>
Best Regards,
Josh Wu
