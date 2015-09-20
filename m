Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35613 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbITQoz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 12:44:55 -0400
Received: by pacfv12 with SMTP id fv12so96223875pac.2
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2015 09:44:55 -0700 (PDT)
Date: Sun, 20 Sep 2015 22:14:41 +0530 (IST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
cc: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Julia Lawall <julia.lawall@lip6.fr>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: cdc: Remove unused macro
In-Reply-To: <55FE8DD8.10809@kernel.org>
Message-ID: <alpine.DEB.2.11.1509202212320.5075@shraddha-370R4E-370R4V-370R5E-3570RE-370R5V>
References: <1442407453-6030-1-git-send-email-shraddha.6596@gmail.com> <55FE8DD8.10809@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Sun, 20 Sep 2015, Jonathan Cameron wrote:

> On 16/09/15 13:44, Shraddha Barke wrote:
>> Remove the macro since it's not used anywhere throughout the kernel
>>
>> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> Whilst I have no objection to cleanup patches like this in general,
> I would prefer a more thorough look at the driver.  For example, the
> macro 2 lines above isn't used either.
>
> So I'm not going to take this patch as it adds unnecessary noise.
> If you want to take a good look at the whole driver and see what
> else needs cleaning up then that would be great!
>
> Speaking of which.  Lars, do you guys have any plans to get these devices
> out of staging anytime soon? (or know of anyone else who does).
> If not perhaps some guidance would help Shradda make that move if he is
> interested in doing so?

Yes I'm interested in working on this. Please provide me the necessary 
guidance so that I can start on those lines.

Thanks,

Shraddha
>
> Thanks,
>
> Jonathan
>> ---
>>  drivers/staging/iio/cdc/ad7746.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
>> index 10fa372..f5a807c 100644
>> --- a/drivers/staging/iio/cdc/ad7746.c
>> +++ b/drivers/staging/iio/cdc/ad7746.c
>> @@ -43,7 +43,6 @@
>>  #define AD7746_REG_CAP_GAINH		15
>>  #define AD7746_REG_CAP_GAINL		16
>>  #define AD7746_REG_VOLT_GAINH		17
>> -#define AD7746_REG_VOLT_GAINL		18
>>
>>  /* Status Register Bit Designations (AD7746_REG_STATUS) */
>>  #define AD7746_STATUS_EXCERR		BIT(3)
>>
>
>
