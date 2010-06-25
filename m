Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C24E4CC.6020508@cam.ac.uk>
Date: Fri, 25 Jun 2010 18:18:04 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
 jic23@hermes.cam.ac.uk
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com> 	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com> 	<4C065AE1.9090302@cam.ac.uk> <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com>
In-Reply-To: <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Barry,

I've dropped back to the original patch for a close analysis of what is
going on.  Sorry for the delay in getting to this!

> Just RFC for discussion. It is not the last patch To keep the change
> lest, i extract the common factor for most iio devices to a common
> ring trigger module. Most devices can use the interfaces in this
> module directly. So copy-paste for ring and trigger is not necessary
> now.
This time I'm going to concentrate of specific issues.

Note I'm reading the code as being directed at the vast majority
of cases.  What you do here fairly radically changes the job of
the device driver. What I don't want to do is end up with
cases where a tiny difference in hardware results in two completely
different approaches being needed to write the driver.

In a fairly illogical process I wrote this from the bottom :)

> 
> For iio core changes:
> 1. extract xxx_state to iio_state and add a private data to contain
> chip-specific data
> 2. extract all xxx_ring/xxx_trigger api to common api
> 
> Index: drivers/staging/iio/iio.h
> ===================================================================
> --- drivers/staging/iio/iio.h	(revision 8893)
> +++ drivers/staging/iio/iio.h	(working copy)
> @@ -447,4 +447,46 @@
> 
>  int iio_get_new_idr_val(struct idr *this_idr);
>  void iio_free_idr_val(struct idr *this_idr, int id);
> +
> +/**
> + * struct iio_state - hardware level hooks for iio device
> + * @work_trigger_to_ring: bh for triggered event handling
> + * @inter:		used to check if new interrupt has been triggered
> + * @last_timestamp:	passing timestamp from th to bh of interrupt handler
> + * @indio_dev:		industrial I/O device structure
> + * @trig:		data ready trigger registered with iio
> + * @tx:			transmit buffer
> + * @rx:			recieve buffer
> + * @buf_lock:		mutex to protect tx and rx
> + * @irq:                interrupt number
> + * @set_irq:            control the disable/enable of external interrupt
> + * @hw_read_ring:       read ring data from hardware by spi/i2c.
> + **/
> +struct iio_state {
> +	struct device		        *parent_dev;
> +	struct work_struct		work_trigger_to_ring;
> +	s64				last_timestamp;
> +	struct iio_dev			*indio_dev;
> +	struct iio_trigger		*trig;

Not all drivers will want shared centralized buffers.  Simple
devices might use the various spi and i2c functions that allocate
data storage as needed within the functions.
> +	u8				*tx;
> +	u8				*rx;
> +	struct mutex			buf_lock;

Assumes single irq (lot of adis devices can have several) and makes
a copy of it to get round deliberate hiding of bus info.
> +	int                             irq;
> +	int (*set_irq)(struct iio_state *st, bool enable);

My issues with this are given where it is used.
> +	int (*hw_read_ring)(struct iio_state *st, u8 *rx);

(as uncommented above) This is used to hide the bus specific info.
> +	void *priv;
> +};
> +
> +static inline void iio_state_set_privdata(struct iio_state *st, void *data)
> +{
> +	st->priv = data;
> +}
> +
> +static inline void * iio_state_get_privdata(struct iio_state *st)
> +{
> +	return st->priv;
> +}
> +
>  #endif /* _INDUSTRIAL_IO_H_ */
> Index: drivers/staging/iio/common-ring-trigger.c
> ===================================================================
> --- drivers/staging/iio/common-ring-trigger.c	(revision 0)
> +++ drivers/staging/iio/common-ring-trigger.c	(revision 0)
> @@ -0,0 +1,277 @@
> +/* The software ring with trigger which can be used by most drivers
> + *
> + * Copyright (c) 2010 Barry Song
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/fs.h>
> +#include <linux/poll.h>
> +#include <linux/module.h>
> +#include <linux/cdev.h>
> +#include <linux/slab.h>
> +
> +#include "iio.h"
> +#include "ring_generic.h"
> +#include "trigger.h"
> +#include "ring_sw.h"
> +
> +/*
> + * combine_8_to_16(): utility function to munge to u8s into u16
> + */
> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
> +{
> +	u16 _lower = lower;
> +	u16 _upper = upper;
> +	return _lower | (_upper << 8);
> +}
> +
> +static void iio_common_ring_poll_func_th(struct iio_dev *indio_dev)
> +{
> +	struct iio_state *st = iio_dev_get_devdata(indio_dev);
> +	st->last_timestamp = indio_dev->trig->timestamp;
> +	schedule_work(&st->work_trigger_to_ring);
> +}
> +
We discussed various options for this, but I'm personally yet to be
convinced that we aren't making the driver code much harder to follow
for the sake of saving lines of code.

I'm also not sure that the approach currently used here is the right
way to do it in any driver which doesn't help.  One thing I would
like to do is to loose the additional data copy required by the current
approach of building a local record by copying form the raw data, then
copying this record into the buffer.

Preallocating space is easy enough with kfifo so I will probably do
a rework of those patches shortly. For my sw_ring buffer I'm not sure
if it can be easily done, but I'll look into it.

> +static void iio_common_trigger_bh_to_ring(struct work_struct *work_s)
> +{
> +	struct iio_state *st
> +		= container_of(work_s, struct iio_state,
> +				work_trigger_to_ring);
> +
> +	int i = 0;
> +	s16 *data;
> +	size_t datasize = st->indio_dev
> +		->ring->access.get_bpd(st->indio_dev->ring);
> +
> +	data = kmalloc(datasize , GFP_KERNEL);
> +        if (data == NULL) {
> +                dev_err(st->parent_dev, "memory alloc failed in ring bh");
> +                return;
> +        }
> +
> +	if (st->indio_dev->scan_count)
> +		if (st->hw_read_ring(st, st->rx) >= 0)
> +			for (; i < st->indio_dev->scan_count; i++) {
> +				data[i] = combine_8_to_16(st->rx[i*2+1],
> +						st->rx[i*2]);
> +			}
> +
> +        /* Guaranteed to be aligned with 8 byte boundary */
> +        if (st->indio_dev->scan_timestamp)
> +                *((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
> +
> +        st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> +                                            (u8 *)data,
> +                                            st->last_timestamp);
> +
> +        iio_trigger_notify_done(st->indio_dev->trig);
> +        kfree(data);
> +
> +        return;
> +}
> +

This one is pretty specific, though only in the central
section working out the size. Can we come up with an easy way to
share the rest of the code?

The previous discussion including some possible solutions.
I'm yet to be convinced that there is a clean way to do the equivalent
of this given the large amount of knowledge your shared code would have
to have about the underlying data.
> +static int iio_common_ring_preenable(struct iio_dev *indio_dev)
> +{
> +	size_t size;
> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
> +	/* Check if there are any scan elements enabled, if not fail*/
> +	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
> +		return -EINVAL;
> +
> +	if (indio_dev->ring->access.set_bpd) {
> +		if (indio_dev->scan_timestamp)
> +			if (indio_dev->scan_count)
> +				/* Timestamp (aligned to s64) and data */
> +				size = (((indio_dev->scan_count * sizeof(s16))
> +							+ sizeof(s64) - 1)
> +						& ~(sizeof(s64) - 1))
> +					+ sizeof(s64);
> +			else /* Timestamp only  */
> +				size = sizeof(s64);
> +		else /* Data only */
> +			size = indio_dev->scan_count*sizeof(s16);
> +		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
> +	}
> +
> +	return 0;
> +}
> +

Agree entirely with the next two.  Have moved to industrialio-trigger
in todays first patch set.  They apply in all current cases and
for that matter in any I have yet thought up.
> +static int iio_common_ring_postenable(struct iio_dev *indio_dev)
> +{
> +        return indio_dev->trig
> +                ? iio_trigger_attach_poll_func(indio_dev->trig,
> +                                               indio_dev->pollfunc)
> +                : 0;
> +}
> +
> +static int iio_common_ring_predisable(struct iio_dev *indio_dev)
> +{
> +        return indio_dev->trig
> +                ? iio_trigger_dettach_poll_func(indio_dev->trig,
> +                                                indio_dev->pollfunc)
> +                : 0;
> +}


> +
> +int iio_configure_common_ring(struct iio_dev *indio_dev)
> +{
> +	int ret = 0;
> +	struct iio_state *st = indio_dev->dev_data;
> +	struct iio_ring_buffer *ring;
> +	INIT_WORK(&st->work_trigger_to_ring, iio_common_trigger_bh_to_ring);
> +
One reason I'm not keen on this as is, is that it means that all
drivers using this code have to use the same buffer implementation.
I'm very keen to make this selectable on a per driver basis.
Obviously we could add hooks to make that work, but then we begin
to destroy the point of your patch.

> +	ring = iio_sw_rb_allocate(indio_dev);
> +	if (!ring) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +	indio_dev->ring = ring;
> +
> +	iio_ring_sw_register_funcs(&ring->access);

As discussed above. This one is actually a bit of a pain.
> +	ring->preenable = &iio_common_ring_preenable;
These last two are the same for all triggered software ring buffers,
so I've moved the code into industrialio-trigger.c for now.
> +	ring->postenable = &iio_common_ring_postenable;
> +	ring->predisable = &iio_common_ring_predisable;
> +	ring->owner = THIS_MODULE;
> +

This makes it clear that it is sensible to have an alloc_pollfunc function
as the next 8 or so lines occur every single time.  That was in my first
patch set today.
> +	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
> +	if (indio_dev->pollfunc == NULL) {
> +		ret = -ENOMEM;
> +		goto error_iio_sw_rb_free;;
> +	}
> +	indio_dev->pollfunc->poll_func_main = &iio_common_ring_poll_func_th;
> +	indio_dev->pollfunc->private_data = indio_dev;
> +	indio_dev->modes |= INDIO_RING_TRIGGERED;
> +	return 0;
> +
> +error_iio_sw_rb_free:
> +	iio_sw_rb_free(indio_dev->ring);
> +	return ret;
> +}
> +EXPORT_SYMBOL(iio_configure_common_ring);
> +
Small save, but worth having if we can sort the configure function so
everyone is happy.
> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev)
> +{
> +	kfree(indio_dev->pollfunc);
> +	iio_sw_rb_free(indio_dev->ring);
> +}
> +EXPORT_SYMBOL(iio_unconfigure_common_ring);
> +

Only purpose of these wrapping functions is to allow for clean
Kconfig selection of whether ring is enable or not.  I have just
sent out a patch that adds relevant stubs to the core allowing these
to go from all drivers anyway.  Glad to get those out of the way!
Thanks for making the waste apparent.
> +int iio_initialize_common_ring(struct iio_ring_buffer *ring)
> +{
> +	return iio_ring_buffer_register(ring, 0);
> +}
> +EXPORT_SYMBOL(iio_initialize_common_ring);
> +
> +void iio_uninitialize_common_ring(struct iio_ring_buffer *ring)
> +{
> +	iio_ring_buffer_unregister(ring);
> +}
> +EXPORT_SYMBOL(iio_uninitialize_common_ring);
> +
> +static int iio_common_trigger_poll(struct iio_dev *dev_info,
> +				       int index,
> +				       s64 timestamp,
> +				       int no_test)
> +{
> +	struct iio_state *st = iio_dev_get_devdata(dev_info);
> +	struct iio_trigger *trig = st->trig;
> +
> +	trig->timestamp = timestamp;
> +	iio_trigger_poll(trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +IIO_EVENT_SH(common_trig, &iio_common_trigger_poll);
You already know from previous emails that there is an issue with
this one given in creates a couple of structures.  Would have
to be a separate instance per driver.
> +
> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> +
> +static struct attribute *iio_trigger_attrs[] = {
> +	&dev_attr_name.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group iio_trigger_attr_group = {
> +	.attrs = iio_trigger_attrs,
> +};
> +

Hiding away the bus type requires a copy of the irq already available.
> +static int iio_common_trigger_try_reen(struct iio_trigger *trig)
> +{
> +	struct iio_state *st = trig->private_data;
> +	enable_irq(st->irq);
> +	return 0;
> +}
> +

This is far too specific for my liking.  It only even applies to
the majority of your drivers due to their current simple nature.
If you are going to do this unification I'd like to see it post
addition of full hardware event handling (I'm intending to do
this at somepoint but am low on time currently and only have an
adis16350 to play with)  

Assumptions:
1) Interrupt line is used for dataready and other events.
	If this isn't true then the driver should be using the event
	list system at all.  Adds overhead to this path for no gain.
	With some of the adis sensors you have 2 interrupt lines.
	A sensible option would be to setup one line for dataready
	and the other for all other events.
2) Assumes that we have data ready on the first interrupt line.
	Perhaps this makes sense but it isn't a current requirement
	or even a suggested option.  
> +static int iio_common_trigger_set_state(struct iio_trigger *trig,
> +		bool state)
> +{
> +	struct iio_state *st = trig->private_data;
> +	struct iio_dev *indio_dev = st->indio_dev;
> +	int ret = 0;
> +
> +	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
> +	ret = st->set_irq(st, state);
> +	if (state == false) {
> +		iio_remove_event_from_list(&iio_event_common_trig,
> +				&indio_dev->interrupts[0]
> +				->ev_list);
> +		flush_scheduled_work();
> +	} else {
> +		iio_add_event_to_list(&iio_event_common_trig,
> +				&indio_dev->interrupts[0]->ev_list);
> +	}
> +	return ret;
> +}
> +

The rest of your factoring out obviously requires the shared driver
state structure.  This all makes sense if we think that is a desirable
thing to do.
> +int iio_probe_common_trigger(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct iio_state *st = indio_dev->dev_data;
> +
> +	st->trig = iio_allocate_trigger();
> +	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
> +	if (!st->trig->name) {
> +		ret = -ENOMEM;
> +		goto error_free_trig;
> +	}
> +	snprintf((char *)st->trig->name,
> +			IIO_TRIGGER_NAME_LENGTH,
> +			"iio-dev%d", indio_dev->id);
> +	st->trig->dev.parent = st->parent_dev;
> +	st->trig->owner = THIS_MODULE;
> +	st->trig->private_data = st;
> +	st->trig->set_trigger_state = &iio_common_trigger_set_state;
> +	st->trig->try_reenable = &iio_common_trigger_try_reen;
> +	st->trig->control_attrs = &iio_trigger_attr_group;
> +	ret = iio_trigger_register(st->trig);
> +
> +	/* select default trigger */
> +	indio_dev->trig = st->trig;
> +	if (ret)
> +		goto error_free_trig_name;
> +
> +	return 0;
> +
> +error_free_trig_name:
> +	kfree(st->trig->name);
> +error_free_trig:
> +	iio_free_trigger(st->trig);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(iio_probe_common_trigger);
> +


> +void iio_remove_common_trigger(struct iio_dev *indio_dev)
> +{
> +	struct iio_state *state = indio_dev->dev_data;
> +
> +	iio_trigger_unregister(state->trig);
> +	kfree(state->trig->name);
> +	iio_free_trigger(state->trig);
> +}
> +EXPORT_SYMBOL(iio_remove_common_trigger);

snipped rest as it is obvious boiler pate.

As an aside. There is an awful lot of repeated code relating to low level
device access in the adis drivers. Perhaps that is a good opportunity for
unifying code?  Maybe we want and adis_library module? Or perhaps a number
of the devices can be combined into a single driver? Just a thought
that came up whilst looking at that code again.

Thanks,

Jonathan
