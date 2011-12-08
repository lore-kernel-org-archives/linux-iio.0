Return-Path: <greg@kroah.com>
Date: Thu, 8 Dec 2011 11:40:57 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20111208194057.GA28532@kroah.com>
References: <1323122164-32314-1-git-send-email-jic23@kernel.org>
 <1323122164-32314-4-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323122164-32314-4-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 05, 2011 at 09:56:02PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Lifted from proposal for in kernel interface built on the out of staging
> branch.
> 
> Two elements here:
> * Map as defined in "inkern.h"
> * Matching code to actually get the iio_dev and channel
> that we want from the global list of IIO devices.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/Makefile                |    2 +-
>  drivers/staging/iio/Makefile            |    2 +-
>  drivers/staging/iio/iio.h               |    6 +-
>  drivers/staging/iio/industrialio-core.c |  268 ++++++++++++++++++++++++++++++-
>  drivers/staging/iio/inkern.c            |   21 +++
>  drivers/staging/iio/inkern.h            |   86 ++++++++++
>  6 files changed, 377 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index 6e615b6..f59ab89 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -34,7 +34,7 @@ obj-$(CONFIG_VT6656)		+= vt6656/
>  obj-$(CONFIG_HYPERV)		+= hv/
>  obj-$(CONFIG_VME_BUS)		+= vme/
>  obj-$(CONFIG_DX_SEP)            += sep/
> -obj-$(CONFIG_IIO)		+= iio/
> +obj-y				+= iio/

Hm, not good.

>  obj-$(CONFIG_ZRAM)		+= zram/
>  obj-$(CONFIG_XVMALLOC)		+= zram/
>  obj-$(CONFIG_ZCACHE)		+= zcache/
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index 1340aea..04d6ad2 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for the industrial I/O core.
>  #
> -
> +obj-y = inkern.o

Doubly not good.  You just always build this now, even if someone
doesn't want any staging drivers, or iio, right?

I can't accept this, sorry.

> --- /dev/null
> +++ b/drivers/staging/iio/inkern.c
> @@ -0,0 +1,21 @@
> +/* The industrial I/O core in kernel channel mapping
> + *
> + * Copyright (c) 2011 Jonathan Cameron
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +#include "inkern.h"
> +#include <linux/err.h>
> +#include <linux/export.h>
> +
> +LIST_HEAD(iio_map_list);
> +EXPORT_SYMBOL_GPL(iio_map_list);
> +void iio_map_array_register(struct iio_map *map, int nummaps)
> +{
> +	int i;
> +	for (i = 0; i < nummaps; i++)
> +		list_add(&map[i].l, &iio_map_list);
> +}
> +EXPORT_SYMBOL(iio_map_array_register);

No _GPL here?

If you have a register function, why do you need to export the list
symbol as well?  Shouldn't you have accessor functions for the whole
list?  And what is this list for?

What exactly are you trying to do here with the "inkern.c" file?

> --- /dev/null
> +++ b/drivers/staging/iio/inkern.h
> @@ -0,0 +1,86 @@
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include "types.h"
> +
> +#ifndef _IIO_INKERN_H_
> +#define _IIO_INKERN_H_
> +
> +struct iio_dev;
> +struct iio_chan_spec;
> +
> +struct iio_channel {
> +	struct iio_dev *indio_dev;
> +	const struct iio_chan_spec *channel;
> +};
> +
> +extern struct list_head iio_map_list;
> +
> +struct iio_map {
> +	/* iio device side */
> +	struct device *adc_dev;
> +	const char *adc_dev_name;
> +	const char *adc_channel_label;
> +	int channel_number; /*naughty starting point */
> +
> +	/* consumer side */
> +	struct device *consumer_dev;
> +	const char *consumer_dev_name;
> +	const char *consumer_channel;
> +	/* management - probably neater ways of doing this */
> +	struct list_head l;
> +};
> +
> +void iio_map_array_register(struct iio_map *map, int nummaps);
> +/**
> + * iio_channel_get() - get an opaque reference to a specified device.
> + */
> +struct iio_channel *iio_st_channel_get(const struct device *dev,
> +				    const char *name,
> +				    const char *consumer_channel);
> +void iio_st_channel_release(struct iio_channel *chan);
> +
> +/**
> + * iio_st_channel_get_all() - get all channels associated with a client
> + *
> + * returns a null terminated array of pointers to iio_channel structures.
> + */
> +struct iio_channel **iio_st_channel_get_all(const struct device *dev,
> +					const char *name);
> +
> +void iio_st_channel_release_all(struct iio_channel **chan);
> +
> +/**
> + * iio_st_read_channel_raw() - read from a given channel
> + * @channel:	the channel being queried.
> + * @val:	value read back.
> + *
> + * Note raw reads from iio channels are in adc counts and hence
> + * scale will need to be applied if standard units required.
> + *
> + * Maybe want to pass the type as a sanity check.
> + */
> +int iio_st_read_channel_raw(struct iio_channel *chan,
> +			    int *val);
> +
> +/**
> + * iio_st_get_channel_type() - get the type of a channel
> + * @channel:	the channel being queried.
> + *
> + * returns the enum iio_chan_type of the channel
> + */
> +enum iio_chan_type iio_st_get_channel_type(struct iio_channel *channel);
> +
> +/**
> + * iio_st_read_channel_scale() - read the scale value for a channel
> + * @channel:	the channel being queried.
> + * @val:	first part of value read back.
> + * @val2:	second part of value read back.
> + *
> + * Note returns a description of what is in val and val2, such
> + * as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
> + * + val2/1e6
> + */
> +int iio_st_read_channel_scale(struct iio_channel *chan, int *val,
> +			      int *val2);
> +
> +#endif

You have a bunch of functions and structures here that are not used in
the .c file, which doesn't seem to match up.

Sorry, I can't accept this.

greg k-h
