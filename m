Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11937 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbcJTQEm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 12:04:42 -0400
Message-ID: <5808E78B.4060109@nvidia.com>
Date: Thu, 20 Oct 2016 21:19:31 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: =?UTF-8?B?UGF3ZcWCIEphcm9zeg==?= <paweljarosz3691@gmail.com>
CC: <linux-iio@vger.kernel.org>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: generic-adc: Fix linear temperature approximation
References: <20161018193147.GA14745@vaio-ubuntu> <5808BB3D.2020201@nvidia.com> <8d2a5917-30b4-d9eb-304a-b96780de9f4c@gmail.com>
In-Reply-To: <8d2a5917-30b4-d9eb-304a-b96780de9f4c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Thursday 20 October 2016 08:26 PM, Paweł Jarosz wrote:
>
>
> W dniu 20.10.2016 o 14:40, Laxman Dewangan pisze:
>>
>> On Wednesday 19 October 2016 01:01 AM, Paweł Jarosz wrote:
>>> In current version of the driver there is error in temperature
>>> calculation.
>>>
>>> So lets fix it using proper linear function.
>>>
>>> Signed-off-by: Paweł Jarosz <paweljarosz3691@gmail.com>
>>
>> Per my calculation, existing and your equation is same as both are 
>> doing linear interpolation.
>>
>> Only think I have seen is that I have used 1000 for two consecutive 
>> temp difference and you used (t2 - t1), so your is better in this 
>> case but still the equation is same.
>>
>> The equation from you is
>>
>>     t1 + (hi -val) * factor.
>>
>> and existing one is
>>      t2 - (val -lo) * factor
>>
>>
>> factor is abs((t2-t1)/(hi-lo))
>>
>> If my analysis is not correct then can you please provide the example 
>> with calculation for better understansing?
>
> Hi
>
> For example if we try to calculate temp for val = 8, i = 1 and table:
>
> <0 9
>  2 7>
>
>     adc_hi = gti->lookup_table[2 * i - 1];
>     adc_lo = gti->lookup_table[2 * i + 1];
>     temp = gti->lookup_table[2 * i];
>     temp -= ((val - adc_lo) * 1000) / (adc_hi - adc_lo);
>
> Your method gives temp =  -498
>
>


The temp should be in the milli-centigrade in the table so it should be
<0 9
   2000 7>;

and if you relplace 1000 with the t2 -t1 where

t1  = gti->lookup_table[2*i -2]
t2 = gti->lookup_table[2 *i]

then it will work perfectly.

So your change for replacing 1000 is correct as what I said but need not 
to change whole equation altogether.

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
