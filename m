Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4C10ED49.2050808@cam.ac.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com>
	<4C065AE1.9090302@cam.ac.uk> <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com>
	<4C10ED49.2050808@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 11 Jun 2010 11:19:42 +0800
Message-ID: <AANLkTikM_F6MJvpsa4invZteBeu4KLDKtv2fMilJVwjJ@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
	jic23@hermes.cam.ac.uk
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 10, 2010 at 9:48 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 06/10/10 05:48, Barry Song wrote:
>> Just RFC for discussion. It is not the last patch To keep the change
>> lest, i extract the common factor for most iio devices to a common
>> ring trigger module. Most devices can use the interfaces in this
>> module directly. So copy-paste for ring and trigger is not necessary
>> now.
> Hi Barry,
>
> I'm afraid I'm not in a position to take a particularly
> close look at this right now (on a rather slow net connection)
> Thanks for taking a look at what we can unify.
>
> My immediate thought is that this patch may go a little too far,
> certainly at this stage. =C2=A0It produces generic support for a
> particular type of trigger (fine and useful) but I'm not
> sure this should be grouped with the ring buffer setup elements.
> There are plenty of devices that would benefit from parts of this
> code, but currently it is all of the take it or leave it variety.
>
> In particular I'm not sure the ring buffer filling code should
> be in here. =C2=A0It really isn't as consistent as the code implies
> and by the presense of that element you have reduces the general
> usefulness of rest. I'm very doubtful that we want to move things
> like the rx and tx buffers out of the device drivers themselves.
> The device drivers should control all access to the device,
> not a core driver like this.
Basically, rx and tx can be moved into the priv of iio_state. Or
iio_state can be moved into iio_dev? Then this structure is not
needed?
>
> Currently we don't have internal hooks to the contents
> of the 'scans '. =C2=A0These could be added, but I think that would
> add more complexity than simply allowing the drivers to handle
> this aspect, not to mention adding some unecessary time penalty
> to this path.
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
>> + * @work_cont_thresh: CLEAN
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
>
>> + =C2=A0 =C2=A0 struct iio_work_cont =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0work_cont_thresh;
>> + =C2=A0 =C2=A0 s64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_timestamp;
>> + =C2=A0 =C2=A0 struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0*indio_dev;
>> + =C2=A0 =C2=A0 struct iio_trigger =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*trig;
>> + =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*tx;
>> + =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*rx;
>> + =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0buf_lock;
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq;
>> + =C2=A0 =C2=A0 int (*set_irq)(struct iio_state *st, bool enable);
>> + =C2=A0 =C2=A0 int (*hw_read_ring)(struct iio_state *st, u8 *rx);
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
>> +/
>
> This function is the one that mainly bothers me. =C2=A0We might
> have a number of devices that do fit in here but there are
> others that would use pretty much everything else but
> this. =C2=A0I'd possibly be more inclined to leave this
> to the drivers. =C2=A0That is where the knowledge about the
> data layout in 'rx' comes from.

Here we can let the hw_read_ring() do more, not only read hw, but also
fill the last data buffer, like combine_8_to_16().

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
>> +
>> +int iio_configure_common_ring(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 int ret =3D 0;
>> + =C2=A0 =C2=A0 struct iio_state *st =3D indio_dev->dev_data;
>> + =C2=A0 =C2=A0 struct iio_ring_buffer *ring;
>> + =C2=A0 =C2=A0 INIT_WORK(&st->work_trigger_to_ring, iio_common_trigger_=
bh_to_ring);
>> +
>> + =C2=A0 =C2=A0 ring =3D iio_sw_rb_allocate(indio_dev);
>> + =C2=A0 =C2=A0 if (!ring) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 indio_dev->ring =3D ring;
>> +
>> + =C2=A0 =C2=A0 iio_ring_sw_register_funcs(&ring->access);
>> + =C2=A0 =C2=A0 ring->preenable =3D &iio_common_ring_preenable;
>> + =C2=A0 =C2=A0 ring->postenable =3D &iio_common_ring_postenable;
>> + =C2=A0 =C2=A0 ring->predisable =3D &iio_common_ring_predisable;
>> + =C2=A0 =C2=A0 ring->owner =3D THIS_MODULE;
>> +
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
>> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 kfree(indio_dev->pollfunc);
>> + =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
>> +}
>> +EXPORT_SYMBOL(iio_unconfigure_common_ring);
>> +
> This next one is pointless except possibly to unify
> some naming so why do it?
Just a copy-paste and rename for existing code. Here we can let driver
call  iio_ring_buffer_register/iio_ring_buffer_unregister directly?
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
>> +static int iio_common_trigger_try_reen(struct iio_trigger *trig)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *st =3D trig->private_data;
>> + =C2=A0 =C2=A0 enable_irq(st->irq);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int iio_common_trigger_set_state(struct iio_trigger *trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool state)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *st =3D trig->private_data;
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
>> + =C2=A0 =C2=A0 int ret =3D 0;
>> +
>> + =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
>> + =C2=A0 =C2=A0 ret =3D st->set_irq(st, state);
> This again is making some nasty assumptions. Yes some drivers
> use a shared event to supply dat ready events, others do not
> and if the line isn't shared they shouldn't as it adds a fair
> bit of complexity to this fast path.
you mean we should know the right interrupt line for data ready event
if there are more than one indio_dev->interrupts elemant?

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
>> +void iio_remove_common_trigger(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 struct iio_state *state =3D indio_dev->dev_data;
>> +
>> + =C2=A0 =C2=A0 iio_trigger_unregister(state->trig);
>> + =C2=A0 =C2=A0 kfree(state->trig->name);
>> + =C2=A0 =C2=A0 iio_free_trigger(state->trig);
>> +}
>> +EXPORT_SYMBOL(iio_remove_common_trigger);
>> Index: drivers/staging/iio/common-ring-trigger.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- drivers/staging/iio/common-ring-trigger.h (revision 0)
>> +++ drivers/staging/iio/common-ring-trigger.h (revision 0)
>> @@ -0,0 +1,24 @@
>> +/* The industrial I/O frequently used ring with trigger
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
>> +
>> +#ifndef _IIO_COMMON_RING_TRIGGER_H_
>> +#define _IIO_COMMON_RING_TRIGGER_H_
>> +
>> +#include "iio.h"
>> +#include "ring_generic.h"
>> +
>> +int iio_configure_common_ring(struct iio_dev *indio_dev);
>> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev);
>> +int iio_initialize_common_ring(struct iio_ring_buffer *ring);
>> +void iio_uninitialize_common_ring(struct iio_ring_buffer *ring);
>> +
>> +int iio_probe_common_trigger(struct iio_dev *indio_dev);
>> +void iio_remove_common_trigger(struct iio_dev *indio_dev);
>> +#endif /* _IIO_COMMON_RING_TRIGGER_H_ */
>> Index: drivers/staging/iio/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- drivers/staging/iio/Kconfig =C2=A0 =C2=A0 =C2=A0 (revision 8893)
>> +++ drivers/staging/iio/Kconfig =C2=A0 =C2=A0 =C2=A0 (working copy)
>> @@ -38,6 +38,12 @@
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring buffers. =C2=A0The triggers are effecti=
vely a 'capture
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 data now' interrupt.
>>
>> +config IIO_COMMON_RING_TRIGGER
>> + =C2=A0 =C2=A0 boolean "Enable frequently used ring with trigger"
>> + =C2=A0 =C2=A0 depends on IIO_SW_RING && IIO_TRIGGER
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 Provides a generic ring with trigger. I can be us=
ed by most
>> + =C2=A0 =C2=A0 =C2=A0 IIO devices.
>>
>> =C2=A0source "drivers/staging/iio/accel/Kconfig"
>> =C2=A0source "drivers/staging/iio/adc/Kconfig"
>> Index: drivers/staging/iio/Makefile
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- drivers/staging/iio/Makefile =C2=A0 =C2=A0 =C2=A0(revision 8893)
>> +++ drivers/staging/iio/Makefile =C2=A0 =C2=A0 =C2=A0(working copy)
>> @@ -9,6 +9,8 @@
>>
>> =C2=A0obj-$(CONFIG_IIO_SW_RING) +=3D ring_sw.o
>>
>> +obj-$(CONFIG_IIO_COMMON_RING_TRIGGER) +=3D common-ring-trigger.o
>> +
>> =C2=A0obj-y +=3D accel/
>> =C2=A0obj-y +=3D adc/
>> =C2=A0obj-y +=3D addac/
>>
>>
>>
>
>
>
