Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:57473 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750771AbeA2COP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jan 2018 21:14:15 -0500
Subject: Re: [PATCH v2 2/2] iio: ad5272: Add support for Analog Devices
 digital potentiometers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, knaack.h@gmx.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, alexandru.ardelean@analog.com
References: <1516096140-88161-1-git-send-email-preid@electromag.com.au>
 <1516096140-88161-3-git-send-email-preid@electromag.com.au>
 <da493367-8156-792f-5d3c-3cfd9a910271@metafoo.de>
 <c05bc74f-dd6e-39ec-a316-5aa3436f36cf@electromag.com.au>
 <20180121121119.234e7192@archlinux>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <0ed10342-bd24-919a-e346-edc59f976a4d@electromag.com.au>
Date: Mon, 29 Jan 2018 10:14:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180121121119.234e7192@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/2018 20:11, Jonathan Cameron wrote:
> On Wed, 17 Jan 2018 09:46:23 +0800
> Phil Reid <preid@electromag.com.au> wrote:
> 
>> G'day Lars-Peter,
>>
>> On 17/01/2018 01:01, Lars-Peter Clausen wrote:
>>> On 01/16/2018 10:49 AM, Phil Reid wrote:
>>>> Add implementation for Analog Devices AD5272 and AD5274 digital
>>>> potentiometer devices.
>>>>
>>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>>>
>>> Hi,
>>>
>>> Thanks for the patch. Looks mostly good.
>>>    
>>>> diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
>>>> new file mode 100644
>>>> index 0000000..a04b018
>>>> --- /dev/null
>>>> +++ b/drivers/iio/potentiometer/ad5272.c
>>>> @@ -0,0 +1,227 @@
>>>> +/*
>>>> + * Analog Devices AD5372 digital potentiometer driver
>>>> + * Copyright (C) 2018 Phil Reid <preid@electromag.com.au>
>>>> + *
>>>> + * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/AD5272_5274.pdf
>>>> + *
>>>> + * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
>>>> + * ad5272	1	1024		20, 50, 100		01011xx
>>>> + * ad5274	1	256		20, 100			01011xx
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0+
>>>
>>> People will probably complain about this, there are some weired rules where
>>> and how the SPDX identifier should be.
>>>    
>> Jonathan suggested this in his review of v1. Forgot to mention that in the change list.
> Lars is referring to the 'where' element of using SPDX tags.  They go
> on as a c++ style comment right at the top of the file.
> 
> Good think he noticed as I missed this when reviewing v3!
> 
fair enough.

I did grep the kernel and found a mixture of placements so just picked the wrong one.
I also didn't find anything in the Documentation folder about it.
But my tree isn't at the bleeding edge.

-- 
Regards
Phil Reid

