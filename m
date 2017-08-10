Return-Path: <SRS0=EIVj=7M=gmail.com=harinath922@kernel.org>
Subject: Re: [PATCH] iio: accel: Bugfix to enbale and allow different events
 to work parallely.
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amsfield22@gmail.com, martink@posteo.de
References: <1501499858-4476-1-git-send-email-harinath922@gmail.com>
 <20170809143709.0d506162@archlinux>
From: Harinath Nampally <harinath922@gmail.com>
Message-ID: <45b82e31-7147-5f0a-6cf3-f92b07ab8393@gmail.com>
Date: Wed, 9 Aug 2017 23:22:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170809143709.0d506162@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

> On Mon, 31 Jul 2017 07:17:38 -0400
> Harinath Nampally<harinath922@gmail.com>  wrote:
>
>> This driver supports multiple devices like mma8653, mma8652, mma8452, mma8453 and
>> fxls8471. Almost all these devices have more than one event. Current driver design
>> hardcodes the event specific information, so only one event can be supported by this
>> driver and current design doesn't have the flexibility to add more events.
>>
>> This patch fixes by detaching the event related information from chip_info struct,
>> and based on channel type and event direction the corresponding event configuration registers
>> are picked dynamically. Hence multiple events can be handled in read/write callbacks.
>>
>> Changes are thoroughly tested on fxls8471 device on imx6UL Eval board using iio_event_monitor user space program.
>>
>> After this fix both Freefall and Transient events are handled by the driver without any conflicts.
>>
>> Signed-off-by: Harinath Nampally<harinath922@gmail.com>
> Just a quick process point before I catch up with the rest of the thread.
> Please ensure you put the driver name in the patch title.  We have a lot
> of accelerometers these days and doing that will help draw the attention
> of people who care!
Sure, I will update it. Thanks.


On 08/09/2017 09:37 AM, Jonathan Cameron wrote:
> On Mon, 31 Jul 2017 07:17:38 -0400
> Harinath Nampally<harinath922@gmail.com>  wrote:
>
>> This driver supports multiple devices like mma8653, mma8652, mma8452, mma8453 and
>> fxls8471. Almost all these devices have more than one event. Current driver design
>> hardcodes the event specific information, so only one event can be supported by this
>> driver and current design doesn't have the flexibility to add more events.
>>
>> This patch fixes by detaching the event related information from chip_info struct,
>> and based on channel type and event direction the corresponding event configuration registers
>> are picked dynamically. Hence multiple events can be handled in read/write callbacks.
>>
>> Changes are thoroughly tested on fxls8471 device on imx6UL Eval board using iio_event_monitor user space program.
>>
>> After this fix both Freefall and Transient events are handled by the driver without any conflicts.
>>
>> Signed-off-by: Harinath Nampally<harinath922@gmail.com>
> Just a quick process point before I catch up with the rest of the thread.
> Please ensure you put the driver name in the patch title.  We have a lot
> of accelerometers these days and doing that will help draw the attention
> of people who care!
