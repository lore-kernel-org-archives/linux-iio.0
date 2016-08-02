Return-Path: <lars@metafoo.de>
Subject: Re: iio: WARNING at kernel/sched/core.c:7630: do not call blocking
 ops when !TASK_RUNNING
To: Brian Norris <briannorris@chromium.org>
References: <20160802011244.GA54171@google.com>
 <37ea974c-9ac6-5a40-0f0e-ee34ef605a08@metafoo.de>
 <20160802165732.GA3310@localhost>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <computersforpeace@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9a6a7f54-0343-db74-57a2-9f747ae659cc@metafoo.de>
Date: Tue, 2 Aug 2016 19:04:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160802165732.GA3310@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 08/02/2016 06:57 PM, Brian Norris wrote:
> Hi Lars,
> 
> On Tue, Aug 02, 2016 at 03:06:39PM +0200, Lars-Peter Clausen wrote:
>> On 08/02/2016 03:12 AM, Brian Norris wrote:
>>> I'm seeing the following warnings when I read from an IIO char device,
>>> with CONFIG_DEBUG_ATOMIC_SLEEP=y. I'm testing a v4.4 kernel, but AFAICT,
>>> nothing too relevant has changed between that and v4.7:
>> [...]
>>> Have any of you seen this kind of issue before (perhaps most IIO users
>>> are not using CONFIG_DEBUG_ATOMIC_SLEEP)? If the WARNING is really
>>> correct, then this problem has really been around a while. It looks like
>>> we have a wait_event_interruptible() called, with this call chain in the
>>> 'condition' path:
>>>
>>>   iio_buffer_ready()
>>>     -> iio_buffer_data_available() (i.e., iio_kfifo_buf_data_available())
>>>       -> mutex_lock()
>>>
>>> Calling mutex_lock() means we clobber the TASK_INTERRUPTIBLE state with
>>> TASK_RUNNING -- hence, the WARNING. Should this be using a spinlock
>>> instead? Or is there some way to refactor this to avoid calling these
>>> sleeping functions in the wait_event*() condition?
>>
>> Hi,
>>
>> Yes, this is an issue, thanks for pointing this out. It has been there for a
>> while, my fault, sorry for that. We need a solution like pointed out in this
>> article (https://lwn.net/Articles/628628/).
> 
> Ah, thanks for the pointer. I thought this problem seemed familiar, but
> I couldn't find a canonical solution. The wait_woken() solution looks
> like a good starting point, although it's definitely got more
> boilerplate...

Yes, the boilerplate is a bit of shame. spinlock might still be an option,
but would certainly complicate things in case where we have hardware buffers
and need to ask the hardware whether data is available rather than just
checking a flag in software. And iio_buffer_flush_hwfifo() also needs to
talk to the hardware and can block.

> It also requires a 'timeout'; I guess we'd want
> MAX_SCHEDULE_TIMEOUT for this case?

Yes. MAX_SCHEDULE_TIMEOUT is a special case and means no timeout.

> 
> Do you want to cook a patch, or should I?

Go ahead.
