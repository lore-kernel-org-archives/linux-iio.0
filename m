Return-Path: <nicolas.ferre@atmel.com>
Message-ID: <4ECBB551.4@atmel.com>
Date: Tue, 22 Nov 2011 15:44:33 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: Re: [PATCH v8] AT91: Add a driver for the ADC
References: <1321611160-3685-1-git-send-email-maxime.ripard@free-electrons.com> <4ECBB226.4080404@free-electrons.com>
In-Reply-To: <4ECBB226.4080404@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/22/2011 03:31 PM, Maxime Ripard :
> Hi,
> 
> So, I guess that we have a pretty good driver with that version. What
> can we do for the inclusion in the kernel now ?

I propose that:

1/ We take the patch #1/3 for inclusion through arm-soc during 3.2
2/ Jonathan takes the #2/3 in his IIO subsystem
3/ We take board related patch #3/3 for inclusion during 3.3 (next)
4/ And we may add other boards support if we are quick for 3.3...

Does is sound good to all of you?

Bye,

> 
> Maxime
> 
> On 18/11/2011 11:12, Maxime Ripard wrote:
>> Hi all,
>>
>> This patchset adds the driver for the ADC in the AT91 SoC. It has been tested on
>> the at91sam9g20ek and should work on sam9g45 as well.
>>
>> For now, it only reads values when asked for by sysfs, but eventually will
>> support hardware triggers and more boards.
>>
>> This patchset is based on the "[PATCH 0/6 V2] IIO: Out of staging step 1: The
>> core" patchset from Jonathan Cameron, applied on top of 3.1
>>
>> Improvements from v7:
>>   - Fix the channels mask bug
>>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 


-- 
Nicolas Ferre
