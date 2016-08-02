Return-Path: <lars@metafoo.de>
Subject: Re: iio: WARNING at kernel/sched/core.c:7630: do not call blocking
 ops when !TASK_RUNNING
To: Brian Norris <briannorris@chromium.org>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160802011244.GA54171@google.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <computersforpeace@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <37ea974c-9ac6-5a40-0f0e-ee34ef605a08@metafoo.de>
Date: Tue, 2 Aug 2016 15:06:39 +0200
MIME-Version: 1.0
In-Reply-To: <20160802011244.GA54171@google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 08/02/2016 03:12 AM, Brian Norris wrote:
> Hi all,
> 
> I'm seeing the following warnings when I read from an IIO char device,
> with CONFIG_DEBUG_ATOMIC_SLEEP=y. I'm testing a v4.4 kernel, but AFAICT,
> nothing too relevant has changed between that and v4.7:
[...]
> Have any of you seen this kind of issue before (perhaps most IIO users
> are not using CONFIG_DEBUG_ATOMIC_SLEEP)? If the WARNING is really
> correct, then this problem has really been around a while. It looks like
> we have a wait_event_interruptible() called, with this call chain in the
> 'condition' path:
> 
>   iio_buffer_ready()
>     -> iio_buffer_data_available() (i.e., iio_kfifo_buf_data_available())
>       -> mutex_lock()
> 
> Calling mutex_lock() means we clobber the TASK_INTERRUPTIBLE state with
> TASK_RUNNING -- hence, the WARNING. Should this be using a spinlock
> instead? Or is there some way to refactor this to avoid calling these
> sleeping functions in the wait_event*() condition?

Hi,

Yes, this is an issue, thanks for pointing this out. It has been there for a
while, my fault, sorry for that. We need a solution like pointed out in this
article (https://lwn.net/Articles/628628/).

- Lars
