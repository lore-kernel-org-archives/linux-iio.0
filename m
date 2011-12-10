Return-Path: <jic23@kernel.org>
Message-ID: <4EE39205.6030109@kernel.org>
Date: Sat, 10 Dec 2011 17:08:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-iio@vger.kernel.org, lars@metafoo.de,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/5] staging:iio:core add in kernel interface mapping
 and getting IIO channels.
References: <1323122164-32314-1-git-send-email-jic23@kernel.org> <1323122164-32314-4-git-send-email-jic23@kernel.org> <20111208194057.GA28532@kroah.com>
In-Reply-To: <20111208194057.GA28532@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

...
> 
>> --- /dev/null
>> +++ b/drivers/staging/iio/inkern.c
>> @@ -0,0 +1,21 @@
>> +/* The industrial I/O core in kernel channel mapping
>> + *
>> + * Copyright (c) 2011 Jonathan Cameron
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + */
>> +#include "inkern.h"
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +
>> +LIST_HEAD(iio_map_list);
>> +EXPORT_SYMBOL_GPL(iio_map_list);
>> +void iio_map_array_register(struct iio_map *map, int nummaps)
>> +{
>> +	int i;
>> +	for (i = 0; i < nummaps; i++)
>> +		list_add(&map[i].l, &iio_map_list);
>> +}
>> +EXPORT_SYMBOL(iio_map_array_register);
> 
> No _GPL here?
oops
> 
> If you have a register function, why do you need to export the list
> symbol as well?  Shouldn't you have accessor functions for the whole
> list?  And what is this list for?

The issue here is where the access functions reside.

The list registration stuff has to be built in (now optionally!) so that
it can be filled from board files if appropriate.

The list is then used by the iio-core in response to requests from
client drivers that want to get data from iio devices.  Short of
supplying access functions that are effectively the equivalent of
the standard list access functions I can't really see how else to
avoid exporting this.

I'd welcome any suggestions on this!

As for the other issues. I've added another kernel symbol (boolean)
as a top level for iio with the core underneath.  That means that
this bit is no longer always built in.   An additional header and
source file now contain the elements that were defined in inkern.h
and implemented in industrialio-core.c (inkern-consumer.h/.c).
Will repost for review once we've addressed this exported list question!

Jonathan
