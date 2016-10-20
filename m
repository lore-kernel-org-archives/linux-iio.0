Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34838 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756500AbcJTOzq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 10:55:46 -0400
Received: by mail-lf0-f47.google.com with SMTP id l131so83040947lfl.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2016 07:55:46 -0700 (PDT)
Subject: Re: [PATCH] thermal: generic-adc: Fix linear temperature
 approximation
To: Laxman Dewangan <ldewangan@nvidia.com>
References: <20161018193147.GA14745@vaio-ubuntu> <5808BB3D.2020201@nvidia.com>
Cc: linux-iio@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com
From: =?UTF-8?Q?Pawe=c5=82_Jarosz?= <paweljarosz3691@gmail.com>
Message-ID: <8d2a5917-30b4-d9eb-304a-b96780de9f4c@gmail.com>
Date: Thu, 20 Oct 2016 16:56:55 +0200
MIME-Version: 1.0
In-Reply-To: <5808BB3D.2020201@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



W dniu 20.10.2016 o 14:40, Laxman Dewangan pisze:
>
> On Wednesday 19 October 2016 01:01 AM, Paweł Jarosz wrote:
>> In current version of the driver there is error in temperature
>> calculation.
>>
>> So lets fix it using proper linear function.
>>
>> Signed-off-by: Paweł Jarosz <paweljarosz3691@gmail.com>
>
> Per my calculation, existing and your equation is same as both are 
> doing linear interpolation.
>
> Only think I have seen is that I have used 1000 for two consecutive 
> temp difference and you used (t2 - t1), so your is better in this case 
> but still the equation is same.
>
> The equation from you is
>
>     t1 + (hi -val) * factor.
>
> and existing one is
>      t2 - (val -lo) * factor
>
>
> factor is abs((t2-t1)/(hi-lo))
>
> If my analysis is not correct then can you please provide the example 
> with calculation for better understansing?

Hi

For example if we try to calculate temp for val = 8, i = 1 and table:

<0 9
  2 7>

	adc_hi = gti->lookup_table[2 * i - 1];
	adc_lo = gti->lookup_table[2 * i + 1];
	temp = gti->lookup_table[2 * i];
	temp -= ((val - adc_lo) * 1000) / (adc_hi - adc_lo);

Your method gives temp =  -498

Paweł
