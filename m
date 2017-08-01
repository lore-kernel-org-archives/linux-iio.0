Return-Path: <SRS0=tbsy=7D=gmail.com=harinath922@kernel.org>
Subject: Re: [PATCH] iio: accel: Bugfix to enbale and allow different events
 to work parallely.
From: Harinath Nampally <harinath922@gmail.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alison Schofield <amsfield22@gmail.com>
References: <1501499858-4476-1-git-send-email-harinath922@gmail.com>
 <653B8888-D699-4B8B-93C2-6FF3308932AF@posteo.de>
 <CAAGUq_oD443x-Uq0FAZGQ8ietk9BO_Fjs7MYSNXrnR9Ogb+5tA@mail.gmail.com>
Message-ID: <a5831c2d-58de-0ce8-67f3-95886063694b@gmail.com>
Date: Mon, 31 Jul 2017 23:08:21 -0400
MIME-Version: 1.0
In-Reply-To: <CAAGUq_oD443x-Uq0FAZGQ8ietk9BO_Fjs7MYSNXrnR9Ogb+5tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

> Thanks for doing that work. I have had it on my list for a long time and you seem to fix it. Although I'd happily review and possibly test it, unfortunately I can't do so before the week of August 21st.
>
> If this might go in quick, nothing will stop me from reviewing either, so, whatever. Thanks again!
   Sure no problem, looking forward to your review comments.
   Actually I am planning to add Orientation events for FXLS8471Q, for 
that is it good idea to overload existing
   IIO_ROT channel type? Also thinking of adding 4 channel modifiers i.e 
portrait up/down, landscape left/right.
   Any suggestions are welcome. Thank you.

On 07/31/2017 10:17 PM, harinath Nampally wrote:
>> This driver supports multiple devices like mma8653, mma8652, mma8452,
>> mma8453 and
>> fxls8471. Almost all these devices have more than one event. Current
>> driver design
>> hardcodes the event specific information, so only one event can be
>> supported by this
>> driver and current design doesn't have the flexibility to add more
>> events.
>>
>> This patch fixes by detaching the event related information from
>> chip_info struct,
>> and based on channel type and event direction the corresponding event
>> configuration registers
>> are picked dynamically. Hence multiple events can be handled in
>> read/write callbacks.
>>
>> Changes are thoroughly tested on fxls8471 device on imx6UL Eval board
>> using iio_event_monitor user space program.
>>
>> After this fix both Freefall and Transient events are handled by the
>> driver without any conflicts.
> Thanks for doing that work. I have had it on my list for a long time and you seem to fix it. Although I'd happily review and possibly test it, unfortunately I can't do so before the week of August 21st.
>
> If this might go in quick, nothing will stop me from reviewing either, so, whatever. Thanks again!
