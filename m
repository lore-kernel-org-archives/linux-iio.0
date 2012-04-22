Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44798 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab2DVK5E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2012 06:57:04 -0400
Message-ID: <4F93E400.3040806@kernel.org>
Date: Sun, 22 Apr 2012 11:57:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: IIO: move out of staging plan.
References: <4F901825.6040901@kernel.org> <20120420022251.GA16771@kroah.com>
In-Reply-To: <20120420022251.GA16771@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/20/2012 03:22 AM, Greg Kroah-Hartman wrote:
> On Thu, Apr 19, 2012 at 02:50:29PM +0100, Jonathan Cameron wrote:
>> Hi All,
>>
>> A recent discussion led to Greg saying he was happy to move IIO out
>> of staging.  I observed that there were some pieces where this would
>> make sense, but a number of drivers have substantial userspace interface
>> issues so a wholesale move was not going to be a good idea.  There
>> are even a few bits of out of date documentation.
>>
>> I finished by saying I'd start another thread to discuss what to move.
>>
>> Now there are quite a few patches under review at the moment, but if
>> we wait for everything to be quiet the move will never happen!  So
>> sorry if your patch requires some adjustment as it crossed with Greg
>> moving things.  I have a few of my own in this state so I share your pain!
>>
>> Anyhow, breaking things up into bite sized parts.
>>
>> 1) Move the core headers
>> 2) Move the core code.
>> 3) Move core and abi documentation.
>> 4) Move some drivers.
>>
>> 5) Long term move rest of drivers.
>>
>>
>> 1. Is simple enough.  There are probably cleaner ways of doing it
>> but the following script does the job...
>>
>> headers='iio.h types.h buffer.h events.h sysfs.h trigger.h
>> trigger_consumer.h machine.h driver.h consumer.h kfifo_buf.h'
>>
>> for str in $headers
>> do
>>     echo updating references to $str
>>     find drivers/staging/iio -type f -exec sed -i
>> 's#"'$str'"#<linux/iio/'$str'>#' {} \;
>>     echo updating references to ../$str
>>     find drivers/staging/iio -type f -exec sed -i
>> 's#"../'$str'"#<linux/iio/'$str'>#' {} \;
>> done
>>
>> mkdir  include/linux/iio
>> for str in $headers
>> do
>>     echo moving $str
>>     git mv drivers/staging/iio/$str include/linux/iio/
>> done
> 
> Do you want me to do this?  Or do you want to send me a patch that does
> it?
> 
>> 2) Is just a case of moving some of the contents of the base
>> staging/iio/ directory and pulling the relevant bits from the Kconfig.
>> (I'm happy to do a patch for this if it helps...)
>>
>> I'd propose moving...
>>
>> iio_core.h
>> iio_core_trigger.h
>> industrialio-buffer.c
>> industrialio-core.c
>> industrialio-event.c
>> industrialio-trigger.c
>> inkern.c
>> kfifo_buf.c
>>
>> Which gives us the whole core + the simplest (and least controversial)
>> buffer implementation.
> 
> Sounds good, send me a patch :)
> 
>> 3) move sysfs-bus-iio to experimental abi directory. The other abi docs
>> at least need a close read through before the move. They typically cover
>> individual drivers or the more esoteric driver classes.
> 
> Also looks sane.
> 
>> 4) Drivers.  This mainly comes down to working out what to move.  Quite
>> a few will need minor changes to headers to pull out the bits (usually
>> highlighted by documenation) that are platform data related and hence
>> need to go into include/linux/iio rather than being local to the driver
>> directory.  The other nasty is that a lot of drivers depend on sw_ring.
>> So the question is whether we move them wholesale over to kfifo_buf or
>> pull sw_ring out of staging with the view that we'll replace it with
>> something better at a later date?  My dislike for this ring
>> implemenation is well documented!
> 
> I'll leave that decision to you, but I would suggest just picking one
> ring implementation if at all possible.  kfifo would be the recommended
> one, why would you not use it?
> 
>> 5) There lots of hideous drivers that will need work.  Hopefully the
>> sheer embarasement of being left in staging and hence labeled bad
>> will motivate people to clean them up ;)
> 
> That should happen over time, otherwise I can always threaten to delete
> them, which should cause people to wake up :)
> 
>> To my mind, the priority is moving the headers, core and main documentation.
>>
>> What do people think?  Mostly how we do this comes down to what
>> process works well for Greg.
> 
> Sending me a patch for the first 3, or if you don't want to, I can do it
> as well, which ever is easier for you is fine with me.

Turns out I'd missed one element.  Quite a few drivers select elements
that we are moving out of staging.  Thus I'll have to add a prior series
to convert all those to depends (which I would prefer anyway).
> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

