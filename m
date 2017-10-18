Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:3871 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934469AbdJRIwH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2017 04:52:07 -0400
Subject: Re: [PATCH v2 5/5] iio: adc: at91-sama5d2_adc: use max sample rate
To: Jonathan Cameron <jic23@kernel.org>
CC: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
 <1507703732-29175-6-git-send-email-eugen.hristev@microchip.com>
 <20171015112847.5c035e7a@archlinux>
From: Eugen Hristev <eugen.hristev@microchip.com>
Message-ID: <14117d77-00b8-66eb-922c-e56f624633f5@microchip.com>
Date: Wed, 18 Oct 2017 11:49:46 +0300
MIME-Version: 1.0
In-Reply-To: <20171015112847.5c035e7a@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 15.10.2017 13:28, Jonathan Cameron wrote:
> On Wed, 11 Oct 2017 09:35:32 +0300
> Eugen Hristev <eugen.hristev@microchip.com> wrote:
> 
>> Change driver settings to use maximum sample rate clock.
>> This is useful to achieve best possible sampling rate
>> if we use DMA.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> 
> I would normally expect this to have some bearing on the
> noise levels on the measured signals.  All I can find
> is a reference to the track time being 15*a single
> clock cycle.  We could change this so that it is appropriate
> for the currently samping frequency rather than leaving it
> as a fixed value.

Actually this is the startup (default) value. The sampling frequency
can be changed from sysfs.
I will drop this change to let the ADC work with minimum frequency
at startup and user can change it from sysfs if greater speed is
required (as with the watermark).

Thanks !
Eugen
> 
> Jonathan
> 
>> ---
>>   drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index 7e51ecb..b76f88f 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -934,7 +934,7 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
>>   	at91_adc_writel(st, AT91_SAMA5D2_MR,
>>   			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
>>   
>> -	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
>> +	at91_adc_setup_samp_freq(st, st->soc_info.max_sample_rate);
>>   }
>>   
>>   static ssize_t at91_adc_get_fifo_state(struct device *dev,
> 
