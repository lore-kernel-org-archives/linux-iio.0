Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C24B8F5.1030005@cam.ac.uk>
Date: Fri, 25 Jun 2010 15:11:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
 jic23@hermes.cam.ac.uk
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com> 	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com> 	<4C065AE1.9090302@cam.ac.uk> <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com> 	<4C10ED49.2050808@cam.ac.uk> <AANLkTikM_F6MJvpsa4invZteBeu4KLDKtv2fMilJVwjJ@mail.gmail.com> 	<4C120E6B.1060702@cam.ac.uk> <AANLkTilwfZmpeCCDHI7uEYeZtBXA8foWHHmdmvg5FHd6@mail.gmail.com> 	<4C13C54E.9080804@cam.ac.uk> <AANLkTik75ywj500lN18ddCqmbomInjWE-zdEKHP_zRuk@mail.gmail.com>
In-Reply-To: <AANLkTik75ywj500lN18ddCqmbomInjWE-zdEKHP_zRuk@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 06/21/10 10:21, Barry Song wrote:
> Hi Jonathan,

Hi Barry,

I think this conversation has gotten too involved. I for one have
lost track of where we are.  I propose splitting the original patch
up into a number of subelements that we can discuss separately.
I'll post a series that pulls out some of the completely uncontroversial
bits asap.

> Thanks very much for your long description. But i am difficult to
> understand all those,  so if there are pseudo codes, that will be much
> more helpful to me.
> I think you want to say
> 1. change iio_common_trigger_bh_to_ring into 3 step:
> get_data_from_hardware()
> fill_ring_buffer()
> notify_buffer_change()
> Yes. I completely agree because that will make it suitable for more cases.
I'm still far from convinced this is a good idea at all.
The fundamental problem is that the patch moves some but not all of the ring
handling into the core (or out of the driver at least!).
This leaves a nasty disconnect between which bits
of the code know about the ring buffer.  If it all stays in the driver
(with some clean ups lifted from your patch) then all of the device dependent
elements of the ring buffer usage remain in the device driver.
Yes we end up repeating some code, though not nearly as much as currently
as a lot of your patch makes sense to me, just not this bit!

I think this is a price we have to pay to not end up with a confusing
and to my mind illogical structure to the drivers.

Anyhow, lets see how much we differ after we have lifted the bits
we agree on out of the patch into a nice incremental series.

Jonathan

> 
> 2. remove work_cont struct since it is useless.
> 
> 3.you want to say there is only one-copy for trigger , then another
> device will destory current device if using it as the trigger?
>  IIO_EVENT_SH(common_trig, &iio_common_trigger_poll);
> Here we can build one copy for every device.
I have a lot of other issues with this bit of the code, so lets
discuss that separately from the ring buffer setup elements.

Jonathan
> 
> Thanks
> Barry

> 
> On Sun, Jun 13, 2010 at 1:35 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> On 06/12/10 03:26, Barry Song wrote:
>> Hi Barry,
>>
>> I'm afraid I'm still on a useless net connection so don't have option
>> to review the code properly.
>>
>>> The driver doesn't aim to replace what has existed in iio core. Just
>>> improvement and a module which can be shared by most devices. Devices
>>> which have special path can still self-define like before.
>> Indeed, this is a good idea. I'm just disagreeing with a few of the details.
>> As things stand with this patch at the mo, its a take it or leave it
>> situation. I'd like to have it so drivers can cherry pick those elements
>> they want as that will give us the most advantages.
>>>
>>> On Fri, Jun 11, 2010 at 6:22 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>>>> On 06/11/10 04:19, Barry Song wrote:
>>>>> On Thu, Jun 10, 2010 at 9:48 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>>>>>> On 06/10/10 05:48, Barry Song wrote:
>>>>>>> Just RFC for discussion. It is not the last patch To keep the change
>>>>>>> lest, i extract the common factor for most iio devices to a common
>>>>>>> ring trigger module. Most devices can use the interfaces in this
>>>>>>> module directly. So copy-paste for ring and trigger is not necessary
>>>>>>> now.
>>>>>> Hi Barry,
>>>>>>
>>>>>> I'm afraid I'm not in a position to take a particularly
>>>>>> close look at this right now (on a rather slow net connection)
>>>>>> Thanks for taking a look at what we can unify.
>>>>>>
>>>>>> My immediate thought is that this patch may go a little too far,
>>>>>> certainly at this stage.  It produces generic support for a
>>>>>> particular type of trigger (fine and useful) but I'm not
>>>>>> sure this should be grouped with the ring buffer setup elements.
>>>>>> There are plenty of devices that would benefit from parts of this
>>>>>> code, but currently it is all of the take it or leave it variety.
>>>>>>
>>>>>> In particular I'm not sure the ring buffer filling code should
>>>>>> be in here.  It really isn't as consistent as the code implies
>>>>>> and by the presense of that element you have reduces the general
>>>>>> usefulness of rest. I'm very doubtful that we want to move things
>>>>>> like the rx and tx buffers out of the device drivers themselves.
>>>>>> The device drivers should control all access to the device,
>>>>>> not a core driver like this.
>>>>> Basically, rx and tx can be mo/ved into the priv of iio_state. Or
>>>>> iio_state can be moved into iio_dev? Then this structure is not
>>>>> needed?
>>>> They could but I still think these should be part of the locale
>>>> device driver state. I agree they don't need to be, but conceptualy
>>>> to my mind everything to do with actual communications with the chip
>>>> is not something the core (or helper modules like this one) should
>>>> touch.
>>> The bottom level hardware read/write can be part of the device driver.
>>> But the flow can be in the core.
>>> The iio_state is derived from objects like nand_chip, nand_base can
>>> handle data flow, the bottom_level nand driver just fill the last
>>> hardware access entries.
>> Exactly, but in there case they have a pretty good idea of what is coming
>> down the line. Here we don't, so i would prefer to see the separation being
>> at the level of driver gets data and pushes to the core (in this case the
>> buffer) rather than your proposal to insert another layer pulling from the
>> driver and pushing to the core. I agree there looks to be a lot of shared
>> code in various drivers and it is nice to get rid of it where possible.
>> However this should be constrained by the need to maintain readability of
>> the code. In this particular case (just the buffer filling function not the
>> rest which looks pretty good to me!) I think we loose clarity to save
>> few lines.  My proposal is that, rather than passing your low level
>> get data function to the handling code, just step up one level and pass
>> the work struct (or related function) instead.  Thus all device related
>> manipulation remains in the device driver, and we still get the benefit
>> of saving on a lot of replication.
>>
>> The principle issue here is that, even with your patch the core doesn't know
>> anywhere near enough about the incoming data from the chip. It currently
>> has access to how many channels there are and whether there is a timestamp.
>> To do the buffer fill it would need to know:
>> 1) Offsets in raw data coming off the chip (common case is to start all reads
>> with a status byte - to get rid of this in your current code involve an extra
>> copy of all data)
>> 2) The size of each element being read back.
>> 3) Packing of the data
>>
>> I can see your point that your current driver covers a number of devices
>> that we already have drivers for. My issue is that with this one element
>> removed it covers pretty much any device with a dataready trigger. That
>> seems like a bigger gain to me.
>>
>> If we divide things a little further, separating the ring buffer related
>> elements and the trigger related elements then some elements are useful
>> to every driver with a software buffer.  It is that gain that would be
>> most beneficial.
>>>>>>
>>>>>> Currently we don't have internal hooks to the contents
>>>>>> of the 'scans '.  These could be added, but I think that would
>>>>>> add more complexity than simply allowing the drivers to handle
>>>>>> this aspect, not to mention adding some unecessary time penalty
>>>>>> to this path.
>>>>>>
>>>>>>>
>>>>>>> For iio core changes:
>>>>>>> 1. extract xxx_state to iio_state and add a private data to contain
>>>>>>> chip-specific data
>>>>>>> 2. extract all xxx_ring/xxx_trigger api to common api
>>>>>>>
>>>>>>> Index: drivers/staging/iio/iio.h
>>>>>>> ===================================================================
>>>>>>> --- drivers/staging/iio/iio.h (revision 8893)
>>>>>>> +++ drivers/staging/iio/iio.h (working copy)
>>>>>>> @@ -447,4 +447,46 @@
>>>>>>>
>>>>>>>  int iio_get_new_idr_val(struct idr *this_idr);
>>>>>>>  void iio_free_idr_val(struct idr *this_idr, int id);
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * struct iio_state - hardware level hooks for iio device
>>>>>>> + * @work_trigger_to_ring: bh for triggered event handling
>>>>>>> + * @work_cont_thresh: CLEAN
>>>>>>> + * @inter:           used to check if new interrupt has been triggered
>>>>>>> + * @last_timestamp:  passing timestamp from th to bh of interrupt handler
>>>>>>> + * @indio_dev:               industrial I/O device structure
>>>>>>> + * @trig:            data ready trigger registered with iio
>>>>>>> + * @tx:                      transmit buffer
>>>>>>> + * @rx:                      recieve buffer
>>>>>>> + * @buf_lock:                mutex to protect tx and rx
>>>>>>> + * @irq:                interrupt number
>>>>>>> + * @set_irq:            control the disable/enable of external interrupt
>>>>>>> + * @hw_read_ring:       read ring data from hardware by spi/i2c.
>>>>>>> + **/
>>>>>>> +struct iio_state {
>>>>>>> +     struct device                   *parent_dev
>>>>>>> +     struct work_struct              work_trigger_to_ring;
>>>>>>
>> Whilst we are here, note the recent patch to remove work_cont structure.
>> We have nothing that currently needs it so it shouldn't be here.
>>>>>>> +     struct iio_work_cont            work_cont_thresh;
>>>>>>> +     s64                             last_timestamp;
>>>>>>> +     struct iio_dev                  *indio_dev;
>>>>>>> +     struct iio_trigger              *trig;
>>>>>>> +     u8                              *tx;
>>>>>>> +     u8                              *rx;
>>>>>>> +     struct mutex                    buf_lock;
>>>>>>> +     int                             irq;
>>>>>>> +     int (*set_irq)(struct iio_state *st, bool enable);
>>>>>>> +     int (*hw_read_ring)(struct iio_state *st, u8 *rx);
>>>>>>> +     void *priv;
>>>>>>> +};
>>>>>>> +
>>>>>>> +static inline void iio_state_set_privdata(struct iio_state *st, void *data)
>>>>>>> +{
>>>>>>> +     st->priv = data;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void * iio_state_get_privdata(struct iio_state *st)
>>>>>>> +{
>>>>>>> +     return st->priv;
>>>>>>> +}
>>>>>>> +
>>>>>>>  #endif /* _INDUSTRIAL_IO_H_ */
>>>>>>> Index: drivers/staging/iio/common-ring-trigger.c
>>>>>>> ===================================================================
>>>>>>> --- drivers/staging/iio/common-ring-trigger.c (revision 0)
>>>>>>> +++ drivers/staging/iio/common-ring-trigger.c (revision 0)
>>>>>>> @@ -0,0 +1,277 @@
>>>>>>> +/* The software ring with trigger which can be used by most drivers
>>>>>>> + *
>>>>>>> + * Copyright (c) 2010 Barry Song
>>>>>>> + *
>>>>>>> + * This program is free software; you can redistribute it and/or modify it
>>>>>>> + * under the terms of the GNU General Public License version 2 as published by
>>>>>>> + * the Free Software Foundation.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +#include <linux/kernel.h>
>>>>>>> +#include <linux/device.h>
>>>>>>> +#include <linux/interrupt.h>
>>>>>>> +#include <linux/fs.h>
>>>>>>> +#include <linux/poll.h>
>>>>>>> +#include <linux/module.h>
>>>>>>> +#include <linux/cdev.h>
>>>>>>> +#include <linux/slab.h>
>>>>>>> +
>>>>>>> +#include "iio.h"
>>>>>>> +#include "ring_generic.h"
>>>>>>> +#include "trigger.h"
>>>>>>> +#include "ring_sw.h"
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * combine_8_to_16(): utility function to munge to u8s into u16
>>>>>>> + */
>>>>>>> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
>>>>>>> +{
>>>>>>> +     u16 _lower = lower;
>>>>>>> +     u16 _upper = upper;
>>>>>>> +     return _lower | (_upper << 8);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void iio_common_ring_poll_func_th(struct iio_dev *indio_dev)
>>>>>>> +{
>>>>>>> +     struct iio_state *st = iio_dev_get_devdata(indio_dev);
>>>>>>> +     st->last_timestamp = indio_dev->trig->timestamp;
>>>>>>> +     schedule_work(&st->work_trigger_to_ring);
>>>>>>> +}
>>>>>>> +/
>>>>>>
>>>>>> This function is the one that mainly bothers me.  We might
>>>>>> have a number of devices that do fit in here but there are
>>>>>> others that would use pretty much everything else but
>>>>>> this.  I'd possibly be more inclined to leave this
>>>>>> to the drivers.  That is where the knowledge about the
>>>>>> data layout in 'rx' comes from.
>>>>>
>>>>> Here we can let the hw_read_ring() do more, not only read hw, but also
>>>>> fill the last data buffer, like combine_8_to_16().
>>>> but once it is doing that much, what is te point of the following?
>>>> You will save a few repeated lines, but at the cost of driver
>>>> readability. I'm yet to be convinced that this function should exist.
>>>> Why not pass the appropriate work struct in having initialized it
>>>> in the chip driver?  There are certainly elements of this code that
>>>> will not be ideal for every device anyway (such as the kmalloc
>>>> being in here!)
>>> not just several saved lines. But mean the bottom level driver doesn't
>>> need to care the flow of trigger_bh_to_ring().
>>> Bottom level driver doesn't need to self-define its
>>> trigger_bh_to_ring(), it only read hardware data and fill the data
>>> buffer. That's what the bottom level driver wants to do.
>> I agree that has a certain elegance, but unfortunately the bottom
>> level driver is still responsible for telling userspace what is
>> in the buffer.  Thus I am yet to be convinced it shouldn't also
>> be responsible for filling the buffer.  If we really want
>> to hide this from the device, then the following would work
>>
>> //Ask the driver for a suitably aligned pointer to the data
>> u8 *dat = iio_dev.get_data_for_buffer(u8 alignment);
>> ring.push_to_ring(dat);
>> iio_dev.notify_buffer_data_done();
>>
>> Or (and this approach is needed if a device can use the buffer
>> elements directly for dma).
>>
>> u8 *data = ring.allocate_data(sizeofdata);
>> iio_dev.get_data_for_buffer(data);
>> ring.notify_filled();
>>
>> Perhaps we should leave this element as one that need more
>> thought / debate and push on with the others.
>>
>> Also worth noting is that pretty much all these dataready
>> triggers will not currently work if 'only' another device
>> is using them as a trigger. (nothing clears the interrupt).
>> It may seem to be a fairly odd thing to do, and I'm still
>> wondering if it is better to insist this should work in
>> all drivers, or to actively prevent it. Both options are
>> non trivial.
>>
>> Looking more at the functions covered I'm not sure
>> that it wouldn't be better to just provide the useful
>> ones as 'library functions' that a driver can cherry
>> pick it they are applicable or in some cases make
>> the the default with the option to override deliberately
>> for cases they do not cover.
>>
>>
>>>>>
>>>>>>> +static void iio_common_trigger_bh_to_ring(struct work_struct *work_s)
>>>>>>> +{
>>>>>>> +     struct iio_state *st
>>>>>>> +             = container_of(work_s, struct iio_state,
>>>>>>> +                             work_trigger_to_ring);
>>>>>>> +
>>>>>>> +     int i = 0;
>>>>>>> +     s16 *data;
>>>>>>> +     size_t datasize = st->indio_dev
>>>>>>> +             ->ring->access.get_bpd(st->indio_dev->ring);
>>>>>>> +
>>>>>>> +     data = kmalloc(datasize , GFP_KERNEL);
>>>>>>> +        if (data == NULL) {
>>>>>>> +                dev_err(st->parent_dev, "memory alloc failed in ring bh");
>>>>>>> +                return;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +     if (st->indio_dev->scan_count)
>>>>>>> +             if (st->hw_read_ring(st, st->rx) >= 0)
>>>>>>> +                     for (; i < st->indio_dev->scan_count; i++) {
>>>>>>> +                             data[i] = combine_8_to_16(st->rx[i*2+1],
>>>>>>> +                                             st->rx[i*2]);
>>>>>>> +                     }
>>>>>>> +
>>>>>>> +        /* Guaranteed to be aligned with 8 byte boundary */
>>>>>>> +        if (st->indio_dev->scan_timestamp)
>>>>>>> +                *((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>>>>>>> +
>>>>>>> +        st->indio_dev->ring->access.store_to(st->indio_dev->ring,
>>>>>>> +                                            (u8 *)data,
>>>>>>> +                                            st->last_timestamp);
>>>>>>> +
>>>>>>> +        iio_trigger_notify_done(st->indio_dev->trig);
>>>>>>> +        kfree(data);
>>>>>>> +
>>>>>>> +        return;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int iio_common_ring_preenable(struct iio_dev *indio_dev)
>>>>>>> +{
>>>>>>> +     size_t size;
>>>>>>> +     dev_dbg(&indio_dev->dev, "%s\n", __func__);
>>>>>>> +     /* Check if there are any scan elements enabled, if not fail*/
>>>>>>> +     if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
>>>>>>> +             return -EINVAL;
>>>>>>> +
>>>>>>> +     if (indio_dev->ring->access.set_bpd) {
>>>>>>> +             if (indio_dev->scan_timestamp)
>>>>>>> +                     if (indio_dev->scan_count)
>>>>>>> +                             /* Timestamp (aligned to s64) and data */
>>>>>>> +                             size = (((indio_dev->scan_count * sizeof(s16))
>>>>>>> +                                                     + sizeof(s64) - 1)
>>>>>>> +                                             & ~(sizeof(s64) - 1))
>>>>>>> +                                     + sizeof(s64);
>>>>>>> +                     else /* Timestamp only  */
>>>>>>> +                             size = sizeof(s64);
>>>>>>> +             else /* Data only */
>>>>>>> +                     size = indio_dev->scan_count*sizeof(s16);
>>>>>>> +             indio_dev->ring->access.set_bpd(indio_dev->ring, size);
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int iio_common_ring_postenable(struct iio_dev *indio_dev)
>>>>>>> +{
>>>>>>> +        return indio_dev->trig
>>>>>>> +                ? iio_trigger_attach_poll_func(indio_dev->trig,
>>>>>>> +                                               indio_dev->pollfunc)
>>>>>>> +                : 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int iio_common_ring_predisable(struct iio_dev *indio_dev)
>>>>>>> +{
>>>>>>> +        return indio_dev->trig
>>>>>>> +                ? iio_trigger_dettach_poll_func(indio_dev->trig,
>>>>>>> +                                                indio_dev->pollfunc)
>>>>>>> +                : 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +int iio_configure_common_ring(struct iio_dev *indio_dev)
>>>>>>> +{
>>>>>>> +     int ret = 0;
>>>>>>> +     struct iio_state *st = indio_dev->dev_data;
>>>>>>> +     struct iio_ring_buffer *ring;
>>>>>>> +     INIT_WORK(&st->work_trigger_to_ring, iio_common_trigger_bh_to_ring);
>>>>>>> +
>>>>>>> +     ring = iio_sw_rb_allocate(indio_dev);
>>>>>>> +     if (!ring) {
>>>>>>> +             ret = -ENOMEM;
>>>>>>> +             return ret;
>>>>>>> +     }
>>>>>>> +     indio_dev->ring = ring;
>>>>>>> +
>>>>>>> +     iio_ring_sw_register_funcs(&ring->access);
>>>>>>> +     ring->preenable = &iio_common_ring_preenable;
>>>>>>> +     ring->postenable = &iio_common_ring_postenable;
>>>>>>> +     ring->predisable = &iio_common_ring_predisable;
>>>>>>> +     ring->owner = THIS_MODULE;
>>>>>>> +
>>>>>>> +     indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
>>>>>>> +     if (indio_dev->pollfunc == NULL) {
>>>>>>> +             ret = -ENOMEM;
>>>>>>> +             goto error_iio_sw_rb_free;;
>>>>>>> +     }
>>>>>>> +     indio_dev->pollfunc->poll_func_main = &iio_common_ring_poll_func_th;
>>>>>>> +     indio_dev->pollfunc->private_data = indio_dev;
>>>>>>> +     indio_dev->modes |= INDIO_RING_TRIGGERED;
>>>>>>> +     return 0;
>>>>>>> +
>>>>>>> +error_iio_sw_rb_free:
>>>>>>> +     iio_sw_rb_free(indio_dev->ring);
>>>>>>> +     return ret;
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL(iio_configure_common_ring);
>>>>>>> +
>>>>>>> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev)
>>>>>>> +{
>>>>>>> +     kfree(indio_dev->pollfunc);
>>>>>>> +     iio_sw_rb_free(indio_dev->ring);
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL(iio_unconfigure_common_ring);
>>>>>>> +
>>>>>> This next one is pointless except possibly to unify
>>>>>> some naming so why do it?
>>>>> Just a copy-paste and rename for existing code. Here we can let driver
>>>>> call  iio_ring_buffer_register/iio_ring_buffer_unregister directly?
>>>> exactly.
>>>>>>> +int iio_initialize_common_ring(struct iio_ring_buffer *ring)
>>>>>>> +{
>>>>>>> +     return iio_ring_buffer_register(ring, 0);
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL(iio_initialize_common_ring);
>>>>>>> +
>>>>>>> +void iio_uninitialize_common_ring(struct iio_ring_buffer *ring)
>>>>>>> +{
>>>>>>> +     iio_ring_buffer_unregister(ring);
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL(iio_uninitialize_common_ring);
>>>>>>> +
>>>>>>> +static int iio_common_trigger_poll(struct iio_dev *dev_info,
>>>>>>> +                                    int index,
>>>>>>> +                                    s64 timestamp,
>>>>>>> +                                    int no_test)
>>>>>>> +{
>>>>>>> +     struct iio_state *st = iio_dev_get_devdata(dev_info);
>>>>>>> +     struct iio_trigger *trig = st->trig;
>>>>>>> +
>>>>>>> +     trig->timestamp = timestamp;
>>>>>>> +     iio_trigger_poll(trig);
>>>>>>> +
>>>>>>> +     return IRQ_HANDLED;
>>>>>>> +}
>>>>>>> +
>>>>>>> +IIO_EVENT_SH(common_trig, &iio_common_trigger_poll);
>>>>>>> +
>>>>>>> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>>>>>>> +
>>>>>>> +static struct attribute *iio_trigger_attrs[] = {
>>>>>>> +     &dev_attr_name.attr,
>>>>>>> +     NULL,
>>>>>>> +};
>>>>>>> +
>>>>>>> +static const struct attribute_group iio_trigger_attr_group = {
>>>>>>> +     .attrs = iio_trigger_attrs,
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int iio_common_trigger_try_reen(struct iio_trigger *trig)
>>>>>>> +{
>>>>>>> +     struct iio_state *st = trig->private_data;
>>>>>>> +     enable_irq(st->irq);
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int iio_common_trigger_set_state(struct iio_trigger *trig,
>>>>>>> +             bool state)
>>>>>>> +{
>>>>>>> +     struct iio_state *st = trig->private_data;
>>>>>>> +     struct iio_dev *indio_dev = st->indio_dev;
>>>>>>> +     int ret = 0;
>>>>>>> +
>>>>>>> +     dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
>>>>>>> +     ret = st->set_irq(st, state);
>>>>>> This again is making some nasty assumptions. Yes some drivers
>>>>>> use a shared event to supply dat ready events, others do not
>>>>>> and if the line isn't shared they shouldn't as it adds a fair
>>>>>> bit of complexity to this fast path.
>>>>> you mean we should know the right interrupt line for data ready event
>>>>> if there are more than one indio_dev->interrupts elemant?
>>>>
>>>> no. I meant that indio_dev->interrupts is meant to be NULL in those
>>>> cases where the only interrupt (on a given line) is used for triggering.
>>>> The situation
>>>> used here is only meant to occur if the same line may indicate data
>>>> ready or say a threshold interrupt and has to check which it is.
>>>> If we only have a dataready signal this path adds considerably
>>>> complexity for no reason.  The reason I didn't comment on this in
>>>> your drivers is that I assumed that event functionality was in the
>>>> works.  As it currently stands none of them should be using this
>>>> method, they should all be using and handling the interrupt directly.
>>>> The reason this complexity exists in the lis3l02dq is that it only
>>>> has a single physical interrupt line an this is shared between data
>>>> ready and theshold events.  In my original adis16350 I dedicated
>>>> one line to the alarms and one to the data ready.  Obviously this
>>>> is a bit restrictive on possible wiring so it may make sense to go
>>>> the more complex route in software.
>>>>>
>>>>>>> +     if (state == false) {
>>>>>>> +             iio_remove_event_from_list(&iio_event_common_trig,
>>>>>>> +                             &indio_dev->interrupts[0]
>>>>>>> +                             ->ev_list);
>>>>>>> +             flush_scheduled_work();
>>>>>>> +     } else {
>>>>>>> +             iio_add_event_to_list(&iio_event_common_trig,
>>>>>>> +                             &indio_dev->interrupts[0]->ev_list);
>>>>>>> +     }
>>>>>>> +     return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +int iio_probe_common_trigger(struct iio_dev *indio_dev)
>>>>>>> +{
>>>>>>> +     int ret;
>>>>>>> +     struct iio_state *st = indio_dev->dev_data;
>>>>>>> +
>>>>>>> +     st->trig = iio_allocate_trigger();
>>>>>>> +     st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
>>>>>>> +     if (!st->trig->name) {
>>>>>>> +             ret = -ENOMEM;
>>>>>>> +             goto error_free_trig;
>>>>>>> +     }
>>>>>>> +     snprintf((char *)st->trig->name,
>>>>>>> +                     IIO_TRIGGER_NAME_LENGTH,
>>>>>>> +                     "iio-dev%d", indio_dev->id);
>>>>>>> +     st->trig->dev.parent = st->parent_dev;
>>>>>>> +     st->trig->owner = THIS_MODULE;
>>>>>>> +     st->trig->private_data = st;
>>>>>>> +     st->trig->set_trigger_state = &iio_common_trigger_set_state;
>>>>>>> +     st->trig->try_reenable = &iio_common_trigger_try_reen;
>>>>>>> +     st->trig->control_attrs = &iio_trigger_attr_group;
>>>>>>> +     ret = iio_trigger_register(st->trig);
>>>>>>> +
>>>>>>> +     /* select default trigger */
>>>>>>> +     indio_dev->trig = st->trig;
>>>>>>> +     if (ret)
>>>>>>> +             goto error_free_trig_name;
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +
>>>>>>> +error_free_trig_name:
>>>>>>> +     kfree(st->trig->name);
>>>>>>> +error_free_trig:
>>>>>>> +     iio_free_trigger(st->trig);
>>>>>>> +
>>>>>>> +     return ret;
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL(iio_probe_common_trigger);
>>>>>>> +
>>>>>>> +void iio_remove_common_trigger(struct iio_dev *indio_dev)
>>>>>>> +{
>>>>>>> +     struct iio_state *state = indio_dev->dev_data;
>>>>>>> +
>>>>>>> +     iio_trigger_unregister(state->trig);
>>>>>>> +     kfree(state->trig->name);
>>>>>>> +     iio_free_trigger(state->trig);
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL(iio_remove_common_trigger);
>>>>>>> Index: drivers/staging/iio/common-ring-trigger.h
>>>>>>> ===================================================================
>>>>>>> --- drivers/staging/iio/common-ring-trigger.h (revision 0)
>>>>>>> +++ drivers/staging/iio/common-ring-trigger.h (revision 0)
>>>>>>> @@ -0,0 +1,24 @@
>>>>>>> +/* The industrial I/O frequently used ring with trigger
>>>>>>> + *
>>>>>>> + * Copyright (c) 2010 Barry Song
>>>>>>> + *
>>>>>>> + * This program is free software; you can redistribute it and/or modify it
>>>>>>> + * under the terms of the GNU General Public License version 2 as published by
>>>>>>> + * the Free Software Foundation.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef _IIO_COMMON_RING_TRIGGER_H_
>>>>>>> +#define _IIO_COMMON_RING_TRIGGER_H_
>>>>>>> +
>>>>>>> +#include "iio.h"
>>>>>>> +#include "ring_generic.h"
>>>>>>> +
>>>>>>> +int iio_configure_common_ring(struct iio_dev *indio_dev);
>>>>>>> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev);
>>>>>>> +int iio_initialize_common_ring(struct iio_ring_buffer *ring);
>>>>>>> +void iio_uninitialize_common_ring(struct iio_ring_buffer *ring);
>>>>>>> +
>>>>>>> +int iio_probe_common_trigger(struct iio_dev *indio_dev);
>>>>>>> +void iio_remove_common_trigger(struct iio_dev *indio_dev);
>>>>>>> +#endif /* _IIO_COMMON_RING_TRIGGER_H_ */
>>>>>>> Index: drivers/staging/iio/Kconfig
>>>>>>> ===================================================================
>>>>>>> --- drivers/staging/iio/Kconfig       (revision 8893)
>>>>>>> +++ drivers/staging/iio/Kconfig       (working copy)
>>>>>>> @@ -38,6 +38,12 @@
>>>>>>>         ring buffers.  The triggers are effectively a 'capture
>>>>>>>         data now' interrupt.
>>>>>>>
>>>>>>> +config IIO_COMMON_RING_TRIGGER
>>>>>>> +     boolean "Enable frequently used ring with trigger"
>>>>>>> +     depends on IIO_SW_RING && IIO_TRIGGER
>>>>>>> +     help
>>>>>>> +       Provides a generic ring with trigger. I can be used by most
>>>>>>> +       IIO devices.
>>>>>>>
>>>>>>>  source "drivers/staging/iio/accel/Kconfig"
>>>>>>>  source "drivers/staging/iio/adc/Kconfig"
>>>>>>> Index: drivers/staging/iio/Makefile
>>>>>>> ===================================================================
>>>>>>> --- drivers/staging/iio/Makefile      (revision 8893)
>>>>>>> +++ drivers/staging/iio/Makefile      (working copy)
>>>>>>> @@ -9,6 +9,8 @@
>>>>>>>
>>>>>>>  obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
>>>>>>>
>>>>>>> +obj-$(CONFIG_IIO_COMMON_RING_TRIGGER) += common-ring-trigger.o
>>>>>>> +
>>>>>>>  obj-y += accel/
>>>>>>>  obj-y += adc/
>>>>>>>  obj-y += addac/
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
