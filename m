Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: fix sched WARNING "do not call blocking ops when
 !TASK_RUNNING"
To: Brian Norris <briannorris@chromium.org>
References: <20160802011244.GA54171@google.com>
 <37ea974c-9ac6-5a40-0f0e-ee34ef605a08@metafoo.de>
 <20160802165732.GA3310@localhost>
 <9a6a7f54-0343-db74-57a2-9f747ae659cc@metafoo.de>
 <20160804082621.GA11331@localhost>
 <489632a0-9aaf-e63b-4b08-0fa724a06e28@metafoo.de>
 <20160804094113.GA25537@localhost>
 <8741ae27-2279-4615-7917-e3e3683e41fa@metafoo.de>
 <20160808222317.GA13805@localhost>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <computersforpeace@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <33259258-3c6d-335e-8053-01ef3c4118ec@metafoo.de>
Date: Tue, 9 Aug 2016 10:22:06 +0200
MIME-Version: 1.0
In-Reply-To: <20160808222317.GA13805@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 08/09/2016 12:23 AM, Brian Norris wrote:
> Hi Lars,
> 
> On Thu, Aug 04, 2016 at 12:21:08PM +0200, Lars-Peter Clausen wrote:
>> And then also drop the if (!indio_dev->info) at the beginning of the function.
> 
> I was poking through the usage of this ->info field, and it looks like
> it's supposed to be protected by the 'info_exist_lock' lock, but that's
> not being acquired here and in at least one other location. Is this
> another bug?

Good point. The way this was initially introduced was just to make sure to
break the loop when the device is unregistered and to prevent userspace from
grabbing new references to buffers for unregistered devices. There is no
chance of a race since the buffer is referenced counted independently from
the device. We just use the info field as a flag here. It does not matter
whether we see the change in the info field one loop earlier or later.

But over time this code has changed. E.g. iio_buffer_ready() now calls the
hwfifo_flush_to_buffer() callback of the device from within the info struct.
This can clearly race against unregistration of the device.

Any site that accesses the info field but is not synchronized against
unregistration needs to be protected by the info_exists_lock. The sysfs
read/write callbacks are not affected by this is device_del() is
synchronized against them and makes sure all callbacks have completed and no
new callbacks can be invoked after device_del() has completed. And we wait
for device_del() to complete before info is set to NULL.

The same is not true for the buffer file ops. Userspace retains a reference
to the open file handle and as long as the open file handle exists we have
to expect that the callbacks can be invoked. As long as we do not have a
revoke() [1] we need to handle this at the framework level.

As I said originally we did not access the info field at all in the fops
callbacks, so things were safe. This is has changed though with
hwfifo_flush_to_buffer().

We probably do not want to have the whole read() callback wrapped in the
lock, since that causes to much contention. But we need to wrap the
invocation of the hwfifo_flush_to_buffer() callback in combination with a
check if info is NULL wrapped in the lock.

Another issue is of course buffer implementations that do not properly
protect their callbacks internally. This was not an issue for pure software
buffers, since we simply kept their state in memory. But it might be an
issue for some hardware buffers where the hardware is already gone. Right
now each buffer implementation needs to make sure from their callbacks that
no resources are accessed after they have become unavailable. It might make
sense to move this to the core and make sure that the callbacks are no
longer called after the buffer has been removed, if there is sufficient
demand for this feature.

- Lars

[1] https://lwn.net/Articles/546537/
