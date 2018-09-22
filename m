Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway36.websitewelcome.com ([50.116.126.2]:24929 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726153AbeIVXth (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2018 19:49:37 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 9DDCA400CAAE6
        for <linux-iio@vger.kernel.org>; Sat, 22 Sep 2018 11:37:54 -0500 (CDT)
Subject: Re: [PATCH] iio: adc: Fix potential integer overflow
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180918125314.GA12752@embeddedor.com>
 <20180922144230.7d5e6c80@archlinux>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8be2f082-eb0d-24db-305a-a917e67ab371@embeddedor.com>
Date: Sat, 22 Sep 2018 12:31:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180922144230.7d5e6c80@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 9/22/18 8:42 AM, Jonathan Cameron wrote:
> On Tue, 18 Sep 2018 07:53:14 -0500
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> 
>> Cast factor to s64 in order to give the compiler complete information
>> about the proper arithmetic to use and avoid a potential integer
>> overflow. Notice that such variable is being used in a context
>> that expects an expression of type s64 (64 bits, signed).
>>
>> Addresses-Coverity-ID: 1324146 ("Unintentional integer overflow")
>> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/iio/adc/qcom-vadc-common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
>> index dcd7fb5..e360e27 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.c
>> +++ b/drivers/iio/adc/qcom-vadc-common.c
>> @@ -282,7 +282,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
>>  	voltage = div64_s64(voltage, data->full_scale_code_volt);
>>  	if (voltage > 0) {
>>  		voltage *= prescale->den;
>> -		temp = prescale->num * factor;
>> +		temp = prescale->num * (s64)factor;
> So factor is an unsigned int so could be 32 bits.  In reality it only
> takes a small set of values between 1 and 1000
> 
> Maximum numerator is 10 so a maximum of 10,000.
> 
> Hence this is a false positive, be it one that would be very hard
> for a static checker to identify.
> 
> So that moves it from a fix to a warning suppression change.
> I have no problem with those, but description needs to reflect that.
> 
> Let me know if I've missed something, if not I'm happy to apply
> this and will put some text in the message to explain the above
> reasoning.
> 

Hi Jonathan,

I think you are right. Plase, feel free to update the commit log.

Thanks
--
Gustavo
