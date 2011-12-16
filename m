Return-Path: <archive@jic23.retrosnub.co.uk>
References: <1323122164-32314-1-git-send-email-jic23@kernel.org>
            <1323122164-32314-4-git-send-email-jic23@kernel.org>
            <20111208194057.GA28532@kroah.com>
            <4EE39205.6030109@kernel.org>
            <20111210191524.GA17929@kroah.com>
In-Reply-To: <20111210191524.GA17929@kroah.com>
From: archive@jic23.retrosnub.co.uk
To: Greg KH <greg@kroah.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
  lars@metafoo.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/5] staging:iio:core add in kernel interface mapping
  and getting IIO channels.
Date: Fri, 16 Dec 2011 08:50:57 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-Id: <20111216085057.3DE4240390@saturn.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

Greg KH writes: 

> On Sat, Dec 10, 2011 at 05:08:21PM +0000, Jonathan Cameron wrote:
>> ...
>> > 
>> >> --- /dev/null
>> >> +++ b/drivers/staging/iio/inkern.c
>> >> @@ -0,0 +1,21 @@
>> >> +/* The industrial I/O core in kernel channel mapping
>> >> + *
>> >> + * Copyright (c) 2011 Jonathan Cameron
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify it
>> >> + * under the terms of the GNU General Public License version 2 as published by
>> >> + * the Free Software Foundation.
>> >> + */
>> >> +#include "inkern.h"
>> >> +#include <linux/err.h>
>> >> +#include <linux/export.h>
>> >> +
>> >> +LIST_HEAD(iio_map_list);
>> >> +EXPORT_SYMBOL_GPL(iio_map_list);
>> >> +void iio_map_array_register(struct iio_map *map, int nummaps)
>> >> +{
>> >> +	int i;
>> >> +	for (i = 0; i < nummaps; i++)
>> >> +		list_add(&map[i].l, &iio_map_list);
>> >> +}
>> >> +EXPORT_SYMBOL(iio_map_array_register);
>> > 
>> > No _GPL here?
>> oops
>> > 
>> > If you have a register function, why do you need to export the list
>> > symbol as well?  Shouldn't you have accessor functions for the whole
>> > list?  And what is this list for? 
>> 
>> The issue here is where the access functions reside. 
>> 
>> The list registration stuff has to be built in (now optionally!) so that
>> it can be filled from board files if appropriate. 
>> 
>> The list is then used by the iio-core in response to requests from
>> client drivers that want to get data from iio devices.  Short of
>> supplying access functions that are effectively the equivalent of
>> the standard list access functions I can't really see how else to
>> avoid exporting this.
> 
> So why is this separate from the iio-core code? 
> 
> And how are you guaranteing that anyone walking the list is doing so in
> a "safe" manner?  What's to keep an entry from being removed while some
> random kernel code is walking it? 
> 
> Hint, don't allow direct access to this list, if you do so, you are in
> for a world of hurt...
The entire purpose of this list is to allow a small built in chunk of
code to fill it up (typically from board files) whilst the rest of IIO can
still be built as a module.  All but one function that touches this are in
the IIO core modules.  I can wrap this up but only at considerable cost
(the wrappers will basically be the various list functions with a lock taken
 - I'll add one of those).  I can write extreme warnings around it saying
that it strictly for use by the IIO core.  Would that be acceptable?
Clearly this element should stay in the IIO directory once the rest of
the header has gone into include/linux/iio/.  I can do that division now
so the separation is more apparent. 

So in summary two options exist. 

1) Leave as is with a suitable warning and maybe rename to make it appear
less friendly.
2) Wrap it so we end up with accessors that are pretty much the standard
list accessors just with one parameter fixed and trivial locking. This isn't
too painful but seems conceptually wrong to me.
3) Move everything that uses it into the bit that gets built in even if IIO 
is a module. 

This last one will lead to an explosion in what is exported from IIO as we
will still need to have the divide between the bit that can be modular and
that which cannot somewhere! (which is why I didn't suggest it before). 

Conceptually this list is part of the core - I only have it separate to
avoid having to have the whole IIO core built-in if this functionality is
enabled. 

If list wrappers are the only acceptable option then I guess it will only
be a little bit unpleasant...
> 
>> I'd welcome any suggestions on this! 
>> 
>> As for the other issues. I've added another kernel symbol (boolean)
>> as a top level for iio with the core underneath.  That means that
>> this bit is no longer always built in.   An additional header and
>> source file now contain the elements that were defined in inkern.h
>> and implemented in industrialio-core.c (inkern-consumer.h/.c).
>> Will repost for review once we've addressed this exported list question!
> 
> Thanks for changing this. 
> 
> greg k-h
