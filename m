Return-Path: <JManeyrol@invensense.com>
Subject: Re: [PATCH v3] imu: inv_mpu6050: interpolate missing timestamps
To: Martin Kelly <mkelly@xevo.com>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20180328174029.1045-1-mkelly@xevo.com>
 <20180330113606.1eba6011@archlinux>
 <6041491c-811a-8b43-96cf-b19336332ec4@xevo.com>
 <20180406161509.0000254a@huawei.com>
 <CY4PR1201MB018485BCC65BD470449FFD92C4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
 <BC52B10A-D77E-4B92-AC95-F5C2BF79A98F@jic23.retrosnub.co.uk>
 <45846c33-f8c0-4ad6-dbe0-d3d9a84ef135@xevo.com>
 <c2673b82-71af-5f92-7090-528011f21f01@xevo.com>
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Message-ID: <9e6b1a58-7322-a74a-69d3-b212e08a3e1a@invensense.com>
Date: Thu, 26 Apr 2018 09:35:49 +0200
MIME-Version: 1.0
In-Reply-To: <c2673b82-71af-5f92-7090-528011f21f01@xevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 25/04/2018 20:06, Martin Kelly wrote:
> On 04/06/2018 09:33 AM, Martin Kelly wrote:
>> On 04/06/2018 08:41 AM, Jonathan Cameron wrote:
>>>
>>>
>>> On 6 April 2018 16:21:05 BST, Jean-Baptiste Maneyrol 
>>> <JManeyrol@invensense.com> wrote:
>>>> Hello,
>>>>
>>>>
>>>> there is just a problem if I'm understanding well.
>>>>
>>>>
>>>> Reading FIFO count register under hard irq handler (when taking the
>>>> timestamp) is not possible since i2c access is using a mutex. That's
>>>> why we are using an irq thread for reading FIFO content.
>>>
>>> Good point. Need more sleep or caffeine!
>>>
>>>
>>
>> I was about to reply with the same, as I started coding it up :). Too 
>> bad, it was such a great plan!
>>
>> I have a little update: When switching to level triggered interrupts, 
>> the problem goes away for me, as do the bus errors I get at high 
>> frequencies. I'm working on a patch to support other interrupt types 
>> than rising edge, which is almost done.
>>
>> I also intend to look again at the bus errors for edge driven 
>> interrupts. Since they happen only at high frequency and go away with 
>> level driven interrupts (which must be acked and therefore prevent 
>> reentrancy), I suspect there's a concurrency bug.
>>
>> That said, I think the question remains: Since we can't get the FIFO 
>> count from the hard IRQ handler, and since it could be some time 
>> before the bottom half thread is scheduled, I don't see any way to 
>> accurately handle forward interpolation.
>>
>> Though we can't do forward interpolation, I think at least having 
>> backward interpolation is better than filling in blank timestamps, 
>> especially as we haven't seen an actual case of forward interpolation 
>> being needed, while we have real use cases that require backward 
>> interpolation (and can be easily verified in a logic analyzer).
>>
>> However, that's only my opinion. Jonathan, Jean-Baptiste, and others, 
>> what do you think?
>>
> 
> Hi,
> 
> What can I do to help get closure on this? Is there any data I could 
> gather that would help make a decision?
> 
> In cases of a troubled system, I think the interpolation is very useful, 
> and it's awkward to do in userspace, as it involves keeping a history of 
> past records, which can be inconvenient and not always accurate (e.g. if 
> userspace doesn't read fast enough and we miss records). However, I 
> certainly understand the concern about interpolation. Should we consider 
> making the interpolation configurable via sysfs or device-tree?
> 
> I'd be happy to hear other ideas too about better handling the case of 
> missed interrupts.

Hello,

I have implemented a new timestamp mechanism that do something similar 
but in a more precise way.

The main ideas are:
* check if interrupt timestamp is valid (computes interrupt timestamps 
interval and check against set period value with a margin)
* use validated interrupt timestamps to measure chip internal period 
from the system (to have more accurate computed timestamp value)
* use the interrupt timestamp for data if it is valid
* if interrupt timestamp is invalid (meaning interrupt was delayed or 
missing), computes timestamp using the measured chip period

I will send the corresponding patch series as soon as my last clean-up 
series has been accepted by Jonathan.

Regards,
JB
