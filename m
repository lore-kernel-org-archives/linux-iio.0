Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdASKfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 05:35:33 -0500
Subject: Re: [PATCH] iio:adc:qcom-spmi-vadc: use div64_s64 instead of direct
 64 bit division.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20170108210629.17725-1-jic23@kernel.org>
 <68e5dad4-366b-fc4a-e808-975953251b66@kernel.org>
From: "Phani A, Rama Krishna" <rphani@codeaurora.org>
Message-ID: <6619ef49-ddf7-373a-1db7-2465fa4018b9@codeaurora.org>
Date: Thu, 19 Jan 2017 15:55:48 +0530
MIME-Version: 1.0
In-Reply-To: <68e5dad4-366b-fc4a-e808-975953251b66@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Sorry for delayed response.
Verified the patches and are working fine.
Thanks for posting the changes .

Thanks,
Ramakrishna

On 11-Jan-17 11:08 PM, Jonathan Cameron wrote:
> On 08/01/17 21:06, Jonathan Cameron wrote:
>> Another one of these that we missed previously which prevents test builds
>> of this driver on 32 bit platforms as it gives an undefined __divdi3 warning.
>>
> I'm going to apply (well actually I already did by accident) this
> one and send a pull request to Greg.
>
> We are far enough into the cycle that I want to start getting stuff
> into linux-next.
>
> Rama, if you get a chance, please do test the 3 patches I've added
> to fix up build issues for this driver.
>
> Thanks,
>
> Jonathan
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
>> index faaf711325b5..0a19761d656c 100644
>> --- a/drivers/iio/adc/qcom-spmi-vadc.c
>> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
>> @@ -641,7 +641,7 @@ static int vadc_scale_therm(struct vadc_priv *vadc,
>>  	vadc_scale_calib(vadc, adc_code, prop, &voltage);
>>
>>  	if (prop->calibration == VADC_CALIB_ABSOLUTE)
>> -		voltage /= 1000;
>> +		voltage = div64_s64(voltage, 1000);
>>
>>  	vadc_map_voltage_temp(adcmap_100k_104ef_104fb,
>>  			      ARRAY_SIZE(adcmap_100k_104ef_104fb),
>>
>
