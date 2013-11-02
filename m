Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35801 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3KBMJW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Nov 2013 08:09:22 -0400
Message-ID: <5274F9B0.4060601@kernel.org>
Date: Sat, 02 Nov 2013 13:10:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Josh Wu <josh.wu@atmel.com>, Wei Yongjun <weiyj.lk@gmail.com>,
	grant.likely@linaro.org, rob.herring@calxeda.com,
	maxime.ripard@free-electrons.com, lars@metafoo.de,
	ludovic.desroches@atmel.com
CC: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: at91: fix error return code in at91_adc_probe()
References: <CAPgLHd_whWvPuHTCGdQkZa2fbra=U1nRBvBCyd9azUzS8_XLNg@mail.gmail.com> <5273670D.7070705@atmel.com>
In-Reply-To: <5273670D.7070705@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/13 08:32, Josh Wu wrote:
> Hi, Yongjun
> 
> On 10/30/2013 1:20 PM, Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> Fix to return -ENODEV instead of 0 if non-TSMR adc don't
>> support, as done elsewhere in this function.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Thanks and
> Acked-by: Josh Wu <josh.wu@atmel.com>
> 
Applied to the fixes-togreg branch of iio.git
Given timing, this probably won't go upstream until 3.13-rc1 is
out.

Jonathan
> Best Regards,
> Josh Wu
> 
>> ---
>>   drivers/iio/adc/at91_adc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index 17df749..5b1aa02 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -1047,6 +1047,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>>       } else {
>>           if (!st->caps->has_tsmr) {
>>               dev_err(&pdev->dev, "We don't support non-TSMR adc\n");
>> +            ret = -ENODEV;
>>               goto error_disable_adc_clk;
>>           }
>>  
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
