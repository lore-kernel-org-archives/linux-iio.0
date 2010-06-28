Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4C24E4CC.6020508@cam.ac.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com>
	<4C065AE1.9090302@cam.ac.uk> <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com>
	<4C24E4CC.6020508@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Jun 2010 15:59:01 +0800
Message-ID: <AANLkTimTJyE4o0TwWshAaJyIS2lx_nLwdKS31Sw6jAMf@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
	jic23@hermes.cam.ac.uk
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 26, 2010 at 1:18 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Hi Barry,
>
> I've dropped back to the original patch for a close analysis of what is
> going on. =C2=A0Sorry for the delay in getting to this!
>
>> Just RFC for discussion. It is not the last patch To keep the change
>> lest, i extract the common factor for most iio devices to a common
>> ring trigger module. Most devices can use the interfaces in this
>> module directly. So copy-paste for ring and trigger is not necessary
>> now.
> This time I'm going to concentrate of specific issues.
>
> Note I'm reading the code as being directed at the vast majority
> of cases. =C2=A0What you do here fairly radically changes the job of
> the device driver. What I don't want to do is end up with
> cases where a tiny difference in hardware results in two completely
> different approaches being needed to write the driver.
>
> In a fairly illogical process I wrote this from the bottom :)
>
>>
>> For iio core changes:
>> 1. extract xxx_state to iio_state and add a private data to contain
>> chip-specific data
>> 2. extract all xxx_ring/xxx_trigger api to common api
>>
>> Index: drivers/staging/iio/iio.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- drivers/staging/iio/iio.h (revision 8893)
>> +++ drivers/staging/iio/iio.h (working copy)
>> @@ -447,4 +447,46 @@
>>
>> =C2=A0int iio_get_new_idr_val(struct idr *this_idr);
>> =C2=A0void iio_free_idr_val(struct idr *this_idr, int id);
>> +
>> +/**
>> + * struct iio_state - hardware level hooks for iio device
>> + * @work_trigger_to_ring: bh for triggered event handling
>> + * @inter: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 used to check if new inte=
rrupt has been triggered
>> + * @last_timestamp: =C2=A0passing timestamp from th to bh of interrupt =
handler
>> + * @indio_dev: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 industr=
ial I/O device structure
>> + * @trig: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data ready trigger r=
egistered with iio
>> + * @tx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0transmit buffer
>> + * @rx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0recieve buffer
>> + * @buf_lock: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mu=
tex to protect tx and rx
>> + * @irq: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interru=
pt number
>> + * @set_irq: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0control the disab=
le/enable of external interrupt
>> + * @hw_read_ring: =C2=A0 =C2=A0 =C2=A0 read ring data from hardware by =
spi/i2c.
>> + **/
>> +struct iio_state {
>> + =C2=A0 =C2=A0 struct device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *parent_dev;
>> + =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0work_trigger_to_ring;
>> + =C2=A0 =C2=A0 s64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_timestamp;
>> + =C2=A0 =C2=A0 struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0*indio_dev;
>> + =C2=A0 =C2=A0 struct iio_trigger =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*trig;
>
> Not all drivers will want shared centralized buffers. =C2=A0Simple
> devices might use the various spi and i2c functions that allocate
> data storage as needed within the functions.
>> + =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*tx;
>> + =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*rx;
>> + =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0buf_lock;
>
> Assumes single irq (lot of adis devices can have several) and makes
> a copy of it to get round deliberate hiding of bus info.
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq;
>> + =C2=A0 =C2=A0 int (*set_irq)(struct iio_state *st, bool enable);
>
> My issues with this are given where it is used.
>> + =C2=A0 =C2=A0 int (*hw_read_ring)(struct iio_state *st, u8 *rx);
>
> (as uncommented above) This is used to hide the bus specific info.
>> + =C2=A0 =C2=A0 void *priv;
>> +};
>> +
>> +static inline void iio_state_set_privdata(struct iio_state *st, void *d=
ata)
>> +{
>> + =C2=A0 =C2=A0 st->priv =3D data;
>> +}
>> +
>> +static inline void * iio_state_get_privdata(struct iio_state *st)
>> +{
>> + =C2=A0 =C2=A0 return st->priv;
>> +}
>> +
>> =C2=A0#endif /* _INDUSTRIAL_IO_H_ */
>> Index: drivers/staging/iio/common-ring-trigger.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- drivers/staging/iio/common-ring-trigger.c (revision 0)
>> +++ drivers/staging/iio/common-ring-trigger.c (revision 0)
>> @@ -0,0 +1,277 @@
>> +/* The software ring with trigger which can be used by most drivers
>> + *
>> + * Copyright (c) 2010 Barry Song
>> + *
>> + * This program is free software; you can redistribute it and/or modify=
 it
>> + * under the terms of the GNU General Public License version 2 as publi=
shed by
>> + * the Free Software Foundation.
>> + *
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/fs.h>
>> +#include <linux/poll.h>
>> +#include <linux/module.h>
>> +#include <linux/cdev.h>
>> +#include <linux/slab.h>
>> +
>> +#include "iio.h"
>> +#include "ring_generic.h"
>> +#include "trigger.h"
>> +#include "ring_sw.h"
>> +
>> +/*
>> + * combine_8_to_16(): utility function to munge to u8s into u16
>> + */
>> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
>> +{
>> + =C2=A0 =C2=A0 u16 _lower =3D lower;
>> + =C2=A0 =C2=A0 u16 _upper =3D upper;
>> + =C2=A0 =C2=A0 return _lower | (_upper << 8);
>> +}
>> +
>> +static void iio_common_ring_poll_func_th(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *st =3D iio_dev_get_devdata(indio_dev);
>> + =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
>> + =C2=A0 =C2=A0 schedule_work(&st->work_trigger_to_ring);
>> +}
>> +
> We discussed various options for this, but I'm personally yet to be
> convinced that we aren't making the driver code much harder to follow
> for the sake of saving lines of code.
>
> I'm also not sure that the approach currently used here is the right
> way to do it in any driver which doesn't help. =C2=A0One thing I would
> like to do is to loose the additional data copy required by the current
> approach of building a local record by copying form the raw data, then
> copying this record into the buffer.
>
> Preallocating space is easy enough with kfifo so I will probably do
> a rework of those patches shortly. For my sw_ring buffer I'm not sure
> if it can be easily done, but I'll look into it.
That main problem here is that the data layout is not coincident for
kinds of chips. But the SW ring procedure is needed by all drivers. My
idea is letting all the following done in bottom level driver:

if (st->indio_dev->scan_count)
        if (st->hw_read_ring(st, st->rx) >=3D 0)
                 for (; i < st->indio_dev->scan_count; i++) {
                        data[i] =3D combine_8_to_16(st->rx[i*2+1],
                     ...
                  *((s64 *)(data + ((i + 3)/4)*4)) =3D st->last_timestamp;

Then the flow will be:
1. allocate buffer to hold data
2. fill the buffer according to special data layout
3. store_to ring
4. notify the event

The procedure is common for all chips using SW ring, only step 2 need
be instantized. Then adding hook named get_ring_elemants(), which read
HW and organize data layout,  is ok in fact.

>
>> +static void iio_common_trigger_bh_to_ring(struct work_struct *work_s)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *st
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D container_of(work_s, str=
uct iio_state,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 work_trigger_to_ring);
>> +
>> + =C2=A0 =C2=A0 int i =3D 0;
>> + =C2=A0 =C2=A0 s16 *data;
>> + =C2=A0 =C2=A0 size_t datasize =3D st->indio_dev
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ring->access.get_bpd(st->i=
ndio_dev->ring);
>> +
>> + =C2=A0 =C2=A0 data =3D kmalloc(datasize , GFP_KERNEL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(st->par=
ent_dev, "memory alloc failed in ring bh");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> +
>> + =C2=A0 =C2=A0 if (st->indio_dev->scan_count)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (st->hw_read_ring(st, st-=
>rx) >=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
for (; i < st->indio_dev->scan_count; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 st->rx[i*2]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
}
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte bou=
ndary */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*((s64 *)(data =
+ ((i + 3)/4)*4)) =3D st->last_timestamp;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->ring->access.store_to(st->in=
dio_dev->ring,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(u8 *)data,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0st->last_timestamp);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_trigger_notify_done(st->indio_dev->trig=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(data);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>> +}
>> +
>
> This one is pretty specific, though only in the central
> section working out the size. Can we come up with an easy way to
> share the rest of the code?
>
> The previous discussion including some possible solutions.
> I'm yet to be convinced that there is a clean way to do the equivalent
> of this given the large amount of knowledge your shared code would have
> to have about the underlying data.

Here the main problem is sizeof(16) is thinked suitable for all chips.
Could we add a size_per_element field, then we calucate the total bpd
according to the size_per_element and scan_count?

>> +static int iio_common_ring_preenable(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 size_t size;
>> + =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> + =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, if not =
fail*/
>> + =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_timestamp=
))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> +
>> + =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_timestam=
p)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (indio_dev->scan_count)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timestamp (aligned to s64) and data */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (((indio_dev->scan_count * sizeof(s16)=
)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64) - 1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 & ~(sizeof(s64) - 1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
else /* Timestamp only =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
size =3D indio_dev->scan_count*sizeof(s16);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->access.set_=
bpd(indio_dev->ring, size);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>
> Agree entirely with the next two. =C2=A0Have moved to industrialio-trigge=
r
> in todays first patch set. =C2=A0They apply in all current cases and
> for that matter in any I have yet thought up.

Acked.

>> +static int iio_common_ring_postenable(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return indio_dev->trig
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? iio_trigger_a=
ttach_poll_func(indio_dev->trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0;
>> +}
>> +
>> +static int iio_common_ring_predisable(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return indio_dev->trig
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? iio_trigger_d=
ettach_poll_func(indio_dev->trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0;
>> +}
>
>
>> +
>> +int iio_configure_common_ring(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 int ret =3D 0;
>> + =C2=A0 =C2=A0 struct iio_state *st =3D indio_dev->dev_data;
>> + =C2=A0 =C2=A0 struct iio_ring_buffer *ring;
>> + =C2=A0 =C2=A0 INIT_WORK(&st->work_trigger_to_ring, iio_common_trigger_=
bh_to_ring);
>> +
> One reason I'm not keen on this as is, is that it means that all
> drivers using this code have to use the same buffer implementation.
> I'm very keen to make this selectable on a per driver basis.

Why can't all devices by SW rings use the same buffer implementation?
Why do they want a different SW ring?

> Obviously we could add hooks to make that work, but then we begin
> to destroy the point of your patch.
>
>> + =C2=A0 =C2=A0 ring =3D iio_sw_rb_allocate(indio_dev);
>> + =C2=A0 =C2=A0 if (!ring) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 indio_dev->ring =3D ring;
>> +
>> + =C2=A0 =C2=A0 iio_ring_sw_register_funcs(&ring->access);
>
> As discussed above. This one is actually a bit of a pain.
>> + =C2=A0 =C2=A0 ring->preenable =3D &iio_common_ring_preenable;
> These last two are the same for all triggered software ring buffers,
> so I've moved the code into industrialio-trigger.c for now.
>> + =C2=A0 =C2=A0 ring->postenable =3D &iio_common_ring_postenable;
>> + =C2=A0 =C2=A0 ring->predisable =3D &iio_common_ring_predisable;
>> + =C2=A0 =C2=A0 ring->owner =3D THIS_MODULE;
>> +
>
> This makes it clear that it is sensible to have an alloc_pollfunc functio=
n
> as the next 8 or so lines occur every single time. =C2=A0That was in my f=
irst
> patch set today.

Acked.

>> + =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev->pollf=
unc), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_free;;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &iio_common_ring=
_poll_func_th;
>> + =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
>> + =C2=A0 =C2=A0 indio_dev->modes |=3D INDIO_RING_TRIGGERED;
>> + =C2=A0 =C2=A0 return 0;
>> +
>> +error_iio_sw_rb_free:
>> + =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +EXPORT_SYMBOL(iio_configure_common_ring);
>> +
> Small save, but worth having if we can sort the configure function so
> everyone is happy.
>> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 kfree(indio_dev->pollfunc);
>> + =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
>> +}
>> +EXPORT_SYMBOL(iio_unconfigure_common_ring);
>> +
>
> Only purpose of these wrapping functions is to allow for clean
> Kconfig selection of whether ring is enable or not. =C2=A0I have just
> sent out a patch that adds relevant stubs to the core allowing these
> to go from all drivers anyway. =C2=A0Glad to get those out of the way!
> Thanks for making the waste apparent.

Acked.

>> +int iio_initialize_common_ring(struct iio_ring_buffer *ring)
>> +{
>> + =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
>> +}
>> +EXPORT_SYMBOL(iio_initialize_common_ring);
>> +
>> +void iio_uninitialize_common_ring(struct iio_ring_buffer *ring)
>> +{
>> + =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
>> +}
>> +EXPORT_SYMBOL(iio_uninitialize_common_ring);
>> +
>> +static int iio_common_trigger_poll(struct iio_dev *dev_info,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int index,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s64 timestamp,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int no_test)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *st =3D iio_dev_get_devdata(dev_info);
>> + =C2=A0 =C2=A0 struct iio_trigger *trig =3D st->trig;
>> +
>> + =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
>> + =C2=A0 =C2=A0 iio_trigger_poll(trig);
>> +
>> + =C2=A0 =C2=A0 return IRQ_HANDLED;
>> +}
>> +
>> +IIO_EVENT_SH(common_trig, &iio_common_trigger_poll);
> You already know from previous emails that there is an issue with
> this one given in creates a couple of structures. =C2=A0Would have
> to be a separate instance per driver.

Yes. Here i will give a seperate instance per driver.

>> +
>> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>> +
>> +static struct attribute *iio_trigger_attrs[] =3D {
>> + =C2=A0 =C2=A0 &dev_attr_name.attr,
>> + =C2=A0 =C2=A0 NULL,
>> +};
>> +
>> +static const struct attribute_group iio_trigger_attr_group =3D {
>> + =C2=A0 =C2=A0 .attrs =3D iio_trigger_attrs,
>> +};
>> +
>
> Hiding away the bus type requires a copy of the irq already available.
>> +static int iio_common_trigger_try_reen(struct iio_trigger *trig)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *st =3D trig->private_data;
>> + =C2=A0 =C2=A0 enable_irq(st->irq);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>
> This is far too specific for my liking. =C2=A0It only even applies to
> the majority of your drivers due to their current simple nature.
> If you are going to do this unification I'd like to see it post
> addition of full hardware event handling (I'm intending to do
> this at somepoint but am low on time currently and only have an
> adis16350 to play with)
>
> Assumptions:
> 1) Interrupt line is used for dataready and other events.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If this isn't true then the driver should be u=
sing the event
> =C2=A0 =C2=A0 =C2=A0 =C2=A0list system at all. =C2=A0Adds overhead to thi=
s path for no gain.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0With some of the adis sensors you have 2 inter=
rupt lines.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A sensible option would be to setup one line f=
or dataready
> =C2=A0 =C2=A0 =C2=A0 =C2=A0and the other for all other events.
> 2) Assumes that we have data ready on the first interrupt line.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Perhaps this makes sense but it isn't a curren=
t requirement
> =C2=A0 =C2=A0 =C2=A0 =C2=A0or even a suggested option.

Here we can build the matched pair for interrupt index  and trigger
name, then we can check the interrupt index by trigger name with the
pair.
If one device has more than one trigger and one interrupt, we transfer
the param of interrupt index to set_irq(), then the process flow can
be shared too.
Anyway, bottom drivers don't want to implement the trigger_set_state
per trigger if the flow is same.

>> +static int iio_common_trigger_set_state(struct iio_trigger *trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool state)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *st =3D trig->private_data;
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
>> + =C2=A0 =C2=A0 int ret =3D 0;
>> +
>> + =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
>> + =C2=A0 =C2=A0 ret =3D st->set_irq(st, state);
>> + =C2=A0 =C2=A0 if (state =3D=3D false) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_remove_event_from_list(&=
iio_event_common_trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &indio_dev->interrupts[0]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ev_list);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_scheduled_work();
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_add_event_to_list(&iio_e=
vent_common_trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &indio_dev->interrupts[0]->ev_list);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>
> The rest of your factoring out obviously requires the shared driver
> state structure. =C2=A0This all makes sense if we think that is a desirab=
le
> thing to do.
>> +int iio_probe_common_trigger(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 struct iio_state *st =3D indio_dev->dev_data;
>> +
>> + =C2=A0 =C2=A0 st->trig =3D iio_allocate_trigger();
>> + =C2=A0 =C2=A0 st->trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_=
KERNEL);
>> + =C2=A0 =C2=A0 if (!st->trig->name) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_trig;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 snprintf((char *)st->trig->name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
IIO_TRIGGER_NAME_LENGTH,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
"iio-dev%d", indio_dev->id);
>> + =C2=A0 =C2=A0 st->trig->dev.parent =3D st->parent_dev;
>> + =C2=A0 =C2=A0 st->trig->owner =3D THIS_MODULE;
>> + =C2=A0 =C2=A0 st->trig->private_data =3D st;
>> + =C2=A0 =C2=A0 st->trig->set_trigger_state =3D &iio_common_trigger_set_=
state;
>> + =C2=A0 =C2=A0 st->trig->try_reenable =3D &iio_common_trigger_try_reen;
>> + =C2=A0 =C2=A0 st->trig->control_attrs =3D &iio_trigger_attr_group;
>> + =C2=A0 =C2=A0 ret =3D iio_trigger_register(st->trig);
>> +
>> + =C2=A0 =C2=A0 /* select default trigger */
>> + =C2=A0 =C2=A0 indio_dev->trig =3D st->trig;
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_trig_name;
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +
>> +error_free_trig_name:
>> + =C2=A0 =C2=A0 kfree(st->trig->name);
>> +error_free_trig:
>> + =C2=A0 =C2=A0 iio_free_trigger(st->trig);
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +EXPORT_SYMBOL(iio_probe_common_trigger);
>> +
>
>
>> +void iio_remove_common_trigger(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *state =3D indio_dev->dev_data;
>> +
>> + =C2=A0 =C2=A0 iio_trigger_unregister(state->trig);
>> + =C2=A0 =C2=A0 kfree(state->trig->name);
>> + =C2=A0 =C2=A0 iio_free_trigger(state->trig);
>> +}
>> +EXPORT_SYMBOL(iio_remove_common_trigger);
>
> snipped rest as it is obvious boiler pate.
>
> As an aside. There is an awful lot of repeated code relating to low level
> device access in the adis drivers. Perhaps that is a good opportunity for
> unifying code? =C2=A0Maybe we want and adis_library module? Or perhaps a =
number
> of the devices can be combined into a single driver? Just a thought
> that came up whilst looking at that code again.

Good idea in fact. Many codes are same, for example spi read. But it
is really difficult to find the orderliness to build a library for the
moment.

>
> Thanks,
>
> Jonathan
>
>
