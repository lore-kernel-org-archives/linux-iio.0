Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4C2878DC.7040908@cam.ac.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com>
	<4C065AE1.9090302@cam.ac.uk> <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com>
	<4C24E4CC.6020508@cam.ac.uk> <AANLkTimTJyE4o0TwWshAaJyIS2lx_nLwdKS31Sw6jAMf@mail.gmail.com>
	<4C2878DC.7040908@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 30 Jun 2010 15:51:55 +0800
Message-ID: <AANLkTinwyLM-aInMNp8Z7haVER5-eYceIbrK1kq8vQZq@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
	jic23@hermes.cam.ac.uk
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

For the moment, these should be common for sw ring:

Index: drivers/staging/iio/ring_generic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/ring_generic.h	(revision 8933)
+++ drivers/staging/iio/ring_generic.h	(working copy)
@@ -98,6 +98,7 @@
  * @access_id:		device id number
  * @length:		[DEVICE] number of datums in ring
  * @bpd:		[DEVICE] size of individual datum including timestamp
+ * @bpe:		[DEVICE] size of individual attribution value
  * @loopcount:		[INTERN] number of times the ring has looped
  * @access_handler:	[INTERN] chrdev access handling
  * @ev_int:		[INTERN] chrdev interface for the event chrdev
@@ -119,6 +120,7 @@
 	int				access_id;
 	int				length;
 	int				bpd;
+	int 				bpe;
 	int				loopcount;
 	struct iio_handler		access_handler;
 	struct iio_event_interface	ev_int;
Index: drivers/staging/iio/ring_sw.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/ring_sw.c	(revision 8933)
+++ drivers/staging/iio/ring_sw.c	(working copy)
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 #include "ring_sw.h"
+#include "trigger.h"

 static inline int __iio_allocate_sw_ring_buffer(struct
iio_sw_ring_buffer *ring,
 						int bytes_per_datum, int length)
@@ -431,5 +432,74 @@
 		iio_put_ring_buffer(r);
 }
 EXPORT_SYMBOL(iio_sw_rb_free);
+
+void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
+{
+	struct iio_state *st
+		=3D container_of(work_s, struct iio_state,
+				work_trigger_to_ring);
+	int len =3D 0;
+	size_t datasize =3D st->indio_dev
+		->ring->access.get_bpd(st->indio_dev->ring);
+	char *data =3D kmalloc(datasize , GFP_KERNEL);
+
+	if (data =3D=3D NULL) {
+		dev_err(st->parent_dev, "memory alloc failed in ring bh");
+		return;
+	}
+
+	if (st->indio_dev->scan_count)
+		len =3D st->get_ring_element(st, data);
+
+	/* Guaranteed to be aligned with 8 byte boundary */
+	if (st->indio_dev->scan_timestamp)
+		*(s64 *)(((u32)data + len + sizeof(s64) - 1) & ~(sizeof(s64) - 1))
+			=3D st->last_timestamp;
+
+	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
+			(u8 *)data,
+			st->last_timestamp);
+
+	iio_trigger_notify_done(st->indio_dev->trig);
+	kfree(data);
+
+	return;
+}
+EXPORT_SYMBOL(iio_sw_trigger_bh_to_ring);
+
+int iio_sw_ring_preenable(struct iio_dev *indio_dev)
+{
+	size_t size;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+	/* Check if there are any scan elements enabled, if not fail*/
+	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
+		return -EINVAL;
+	if (indio_dev->ring->access.set_bpd) {
+		if (indio_dev->scan_timestamp)
+			if (indio_dev->scan_count)
+				/* Timestamp (aligned to s64) and data */
+				size =3D (((indio_dev->scan_count * indio_dev->ring->bpe)
+							+ sizeof(s64) - 1)
+						& ~(sizeof(s64) - 1))
+					+ sizeof(s64);
+			else /* Timestamp only  */
+				size =3D sizeof(s64);
+		else /* Data only */
+			size =3D indio_dev->scan_count * indio_dev->ring->bpe;
+		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_sw_ring_preenable);
+
+void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time)
+{
+	struct iio_state *st =3D iio_dev_get_devdata(indio_dev);
+	st->last_timestamp =3D time;
+	schedule_work(&st->work_trigger_to_ring);
+}
+EXPORT_SYMBOL(iio_sw_poll_func_th);
+
 MODULE_DESCRIPTION("Industrialio I/O software ring buffer");
 MODULE_LICENSE("GPL");
Index: drivers/staging/iio/iio.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/iio.h	(revision 8933)
+++ drivers/staging/iio/iio.h	(working copy)
@@ -447,4 +447,34 @@

 int iio_get_new_idr_val(struct idr *this_idr);
 void iio_free_idr_val(struct idr *this_idr, int id);
+
+/**
+ * struct iio_state - hardware level hooks for iio device
+ * @work_trigger_to_ring: bh for triggered event handling
+ * @indio_dev:		industrial I/O device structure
+ * @trig:		data ready trigger registered with iio
+ * @get_ring_element:   read ring data from hardware by spi/i2c and
fill buffer.
+ * @last_timestamp:     time stamp the last data for ring is read
+ * @priv:               hold private data special to chips
+ **/
+struct iio_state {
+	struct device		        *parent_dev;
+	struct work_struct		work_trigger_to_ring;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	int (*get_ring_element)(struct iio_state *st, u8 *buf);
+	s64 				last_timestamp;
+	void *priv;
+};
+
+static inline void iio_state_set_privdata(struct iio_state *st, void *data=
)
+{
+	st->priv =3D data;
+}
+
+static inline void * iio_state_get_privdata(struct iio_state *st)
+{
+	return st->priv;
+}
+
 #endif /* _INDUSTRIAL_IO_H_ */



On Mon, Jun 28, 2010 at 6:26 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 06/28/10 08:59, Barry Song wrote:
>> On Sat, Jun 26, 2010 at 1:18 AM, Jonathan Cameron <jic23@cam.ac.uk> wrot=
e:
>>> Hi Barry,
>>>
>>> I've dropped back to the original patch for a close analysis of what is
>>> going on. =C2=A0Sorry for the delay in getting to this!
>>>
>>>> Just RFC for discussion. It is not the last patch To keep the change
>>>> lest, i extract the common factor for most iio devices to a common
>>>> ring trigger module. Most devices can use the interfaces in this
>>>> module directly. So copy-paste for ring and trigger is not necessary
>>>> now.
>>> This time I'm going to concentrate of specific issues.
>>>
>>> Note I'm reading the code as being directed at the vast majority
>>> of cases. =C2=A0What you do here fairly radically changes the job of
>>> the device driver. What I don't want to do is end up with
>>> cases where a tiny difference in hardware results in two completely
>>> different approaches being needed to write the driver.
>>>
>>> In a fairly illogical process I wrote this from the bottom :)
>>>
>>>>
>>>> For iio core changes:
>>>> 1. extract xxx_state to iio_state and add a private data to contain
>>>> chip-specific data
>>>> 2. extract all xxx_ring/xxx_trigger api to common api
>>>>
>>>> Index: drivers/staging/iio/iio.h
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- drivers/staging/iio/iio.h (revision 8893)
>>>> +++ drivers/staging/iio/iio.h (working copy)
>>>> @@ -447,4 +447,46 @@
>>>>
>>>> =C2=A0int iio_get_new_idr_val(struct idr *this_idr);
>>>> =C2=A0void iio_free_idr_val(struct idr *this_idr, int id);
>>>> +
>>>> +/**
>>>> + * struct iio_state - hardware level hooks for iio device
>>>> + * @work_trigger_to_ring: bh for triggered event handling
>>>> + * @inter: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 used to check if new in=
terrupt has been triggered
>>>> + * @last_timestamp: =C2=A0passing timestamp from th to bh of interrup=
t handler
>>>> + * @indio_dev: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indus=
trial I/O device structure
>>>> + * @trig: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data ready trigger=
 registered with iio
>>>> + * @tx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0transmit buffer
>>>> + * @rx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0recieve buffer
>>>> + * @buf_lock: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
mutex to protect tx and rx
>>>> + * @irq: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inter=
rupt number
>>>> + * @set_irq: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0control the dis=
able/enable of external interrupt
>>>> + * @hw_read_ring: =C2=A0 =C2=A0 =C2=A0 read ring data from hardware b=
y spi/i2c.
>>>> + **/
>>>> +struct iio_state {
>>>> + =C2=A0 =C2=A0 struct device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 *parent_dev;
>>>> + =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0work_trigger_to_ring;
>>>> + =C2=A0 =C2=A0 s64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_timestamp;
>>>> + =C2=A0 =C2=A0 struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*indio_dev;
>>>> + =C2=A0 =C2=A0 struct iio_trigger =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*trig;
>>>
>>> Not all drivers will want shared centralized buffers. =C2=A0Simple
>>> devices might use the various spi and i2c functions that allocate
>>> data storage as needed within the functions.
>>>> + =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*tx;
>>>> + =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*rx;
>>>> + =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_lock;
>>>
>>> Assumes single irq (lot of adis devices can have several) and makes
>>> a copy of it to get round deliberate hiding of bus info.
>>>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq;
>>>> + =C2=A0 =C2=A0 int (*set_irq)(struct iio_state *st, bool enable);
>>>
>>> My issues with this are given where it is used.
>>>> + =C2=A0 =C2=A0 int (*hw_read_ring)(struct iio_state *st, u8 *rx);
>>>
>>> (as uncommented above) This is used to hide the bus specific info.
>>>> + =C2=A0 =C2=A0 void *priv;
>>>> +};
>>>> +
>>>> +static inline void iio_state_set_privdata(struct iio_state *st, void =
*data)
>>>> +{
>>>> + =C2=A0 =C2=A0 st->priv =3D data;
>>>> +}
>>>> +
>>>> +static inline void * iio_state_get_privdata(struct iio_state *st)
>>>> +{
>>>> + =C2=A0 =C2=A0 return st->priv;
>>>> +}
>>>> +
>>>> =C2=A0#endif /* _INDUSTRIAL_IO_H_ */
>>>> Index: drivers/staging/iio/common-ring-trigger.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- drivers/staging/iio/common-ring-trigger.c (revision 0)
>>>> +++ drivers/staging/iio/common-ring-trigger.c (revision 0)
>>>> @@ -0,0 +1,277 @@
>>>> +/* The software ring with trigger which can be used by most drivers
>>>> + *
>>>> + * Copyright (c) 2010 Barry Song
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modi=
fy it
>>>> + * under the terms of the GNU General Public License version 2 as pub=
lished by
>>>> + * the Free Software Foundation.
>>>> + *
>>>> + */
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/fs.h>
>>>> +#include <linux/poll.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/cdev.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#include "iio.h"
>>>> +#include "ring_generic.h"
>>>> +#include "trigger.h"
>>>> +#include "ring_sw.h"
>>>> +
>>>> +/*
>>>> + * combine_8_to_16(): utility function to munge to u8s into u16
>>>> + */
>>>> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
>>>> +{
>>>> + =C2=A0 =C2=A0 u16 _lower =3D lower;
>>>> + =C2=A0 =C2=A0 u16 _upper =3D upper;
>>>> + =C2=A0 =C2=A0 return _lower | (_upper << 8);
>>>> +}
>>>> +
>>>> +static void iio_common_ring_poll_func_th(struct iio_dev *indio_dev)
>>>> +{
>>>> + =C2=A0 =C2=A0 struct iio_state *st =3D iio_dev_get_devdata(indio_dev=
);
>>>> + =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
>>>> + =C2=A0 =C2=A0 schedule_work(&st->work_trigger_to_ring);
>>>> +}
>>>> +
>>> We discussed various options for this, but I'm personally yet to be
>>> convinced that we aren't making the driver code much harder to follow
>>> for the sake of saving lines of code.
>>>
>>> I'm also not sure that the approach currently used here is the right
>>> way to do it in any driver which doesn't help. =C2=A0One thing I would
>>> like to do is to loose the additional data copy required by the current
>>> approach of building a local record by copying form the raw data, then
>>> copying this record into the buffer.
>>>
>>> Preallocating space is easy enough with kfifo so I will probably do
>>> a rework of those patches shortly. For my sw_ring buffer I'm not sure
>>> if it can be easily done, but I'll look into it.
>> That main problem here is that the data layout is not coincident for
>> kinds of chips. But the SW ring procedure is needed by all drivers. My
>> idea is letting all the following done in bottom level driver:
>>
>> if (st->indio_dev->scan_count)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (st->hw_read_ring(st, st->rx) >=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (; i <=
 st->indio_dev->scan_count; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((s64 *)=
(data + ((i + 3)/4)*4)) =3D st->last_timestamp;
>>
>> Then the flow will be:
>> 1. allocate buffer to hold data
> Yes. =C2=A0Ideally that will change to be a call to a routine supplied by=
 the
> buffer implementation as part of a move towards multiple buffer implement=
ations.
> Note this one would need a hook to have the driver tell it how much space=
 the
> next step will be needing. =C2=A0This hook would also clean up the buffer=
 allocation
> code in preenable.
>
>> 2. fill the buffer according to special data layout
>> 3. store_to ring
> Yup, this will become a paired operation with step 1. =C2=A0(more of a 'd=
one
> with buffer so it can no be read from the ring, or pushed onto the ring
> depending on implementation'.)
>> 4. notify the event
>>
>> The procedure is common for all chips using SW ring, only step 2 need
>> be instantized. Then adding hook named get_ring_elemants(), which read
>> HW and organize data layout, =C2=A0is ok in fact.
> Agreed. =C2=A0This way the driver still maintains control of what is goin=
g on
> and is still easy to read, but some of the complexity (error checking etc=
)
> is moved to a standard function. =C2=A0My next question is where to put t=
his function.
> Perhaps within the sw ring implementation?
>
>>
>>>
>>>> +static void iio_common_trigger_bh_to_ring(struct work_struct *work_s)
>>>> +{
>>>> + =C2=A0 =C2=A0 struct iio_state *st
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D container_of(work_s, s=
truct iio_state,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 work_trigger_to_ring);
>>>> +
>>>> + =C2=A0 =C2=A0 int i =3D 0;
>>>> + =C2=A0 =C2=A0 s16 *data;
>>>> + =C2=A0 =C2=A0 size_t datasize =3D st->indio_dev
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ring->access.get_bpd(st-=
>indio_dev->ring);
>>>> +
>>>> + =C2=A0 =C2=A0 data =3D kmalloc(datasize , GFP_KERNEL);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data =3D=3D NULL) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(st->p=
arent_dev, "memory alloc failed in ring bh");
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>> +
>>>> + =C2=A0 =C2=A0 if (st->indio_dev->scan_count)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (st->hw_read_ring(st, s=
t->rx) >=3D 0)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 for (; i < st->indio_dev->scan_count; i++) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1],
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 st->rx[i*2]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte b=
oundary */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*((s64 *)(dat=
a + ((i + 3)/4)*4)) =3D st->last_timestamp;
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->ring->access.store_to(st->=
indio_dev->ring,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(u8 *)data,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0st->last_timestamp);
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_trigger_notify_done(st->indio_dev->tr=
ig);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(data);
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>>>> +}
>>>> +
>>>
>>> This one is pretty specific, though only in the central
>>> section working out the size. Can we come up with an easy way to
>>> share the rest of the code?
>>>
>>> The previous discussion including some possible solutions.
>>> I'm yet to be convinced that there is a clean way to do the equivalent
>>> of this given the large amount of knowledge your shared code would have
>>> to have about the underlying data.
>>
>> Here the main problem is sizeof(16) is thinked suitable for all chips.
> True for a lot of chips, but not all. =C2=A0I'd rather not have that rest=
riction
> in there.
>> Could we add a size_per_element field, then we calucate the total bpd
>> according to the size_per_element and scan_count?
> That would work, but is going to be non trivial as we would also want to
> generate the userspace interface (attributes currently handled by drivers=
)
> from these values.
>
> As I said above, I'd be more inclined (for now anyway) to let the driver =
provide
> a 'get_bpd' call back. =C2=A0It would be handy both here, and in the buff=
er
> fill code.
>
> With either approach, we then have a nice general form of this function t=
hat
> can be used with all sw buffers, so perhaps this belongs in the ring_sw
> module as well?
>>
>>>> +static int iio_common_ring_preenable(struct iio_dev *indio_dev)
>>>> +{
>>>> + =C2=A0 =C2=A0 size_t size;
>>>> + =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
>>>> + =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, if no=
t fail*/
>>>> + =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_timesta=
mp))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>>> +
>>>> + =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_timest=
amp)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (indio_dev->scan_count)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timestamp (aligned to s64) and data */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (((indio_dev->scan_count * sizeof(=
s16))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64) - 1)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 & ~(sizeof(s64) - 1))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else /* Timestamp only =C2=A0*/
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 size =3D indio_dev->scan_count*sizeof(s16);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->access.se=
t_bpd(indio_dev->ring, size);
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 return 0;
>>>> +}
>>>> +
>>>
>>> Agree entirely with the next two. =C2=A0Have moved to industrialio-trig=
ger
>>> in todays first patch set. =C2=A0They apply in all current cases and
>>> for that matter in any I have yet thought up.
>>
>> Acked.
>>
>>>> +static int iio_common_ring_postenable(struct iio_dev *indio_dev)
>>>> +{
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return indio_dev->trig
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? iio_trigger=
_attach_poll_func(indio_dev->trig,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0;
>>>> +}
>>>> +
>>>> +static int iio_common_ring_predisable(struct iio_dev *indio_dev)
>>>> +{
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return indio_dev->trig
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? iio_trigger=
_dettach_poll_func(indio_dev->trig,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0;
>>>> +}
>>>
>>>
>>>> +
>>>> +int iio_configure_common_ring(struct iio_dev *indio_dev)
>>>> +{
>>>> + =C2=A0 =C2=A0 int ret =3D 0;
>>>> + =C2=A0 =C2=A0 struct iio_state *st =3D indio_dev->dev_data;
>>>> + =C2=A0 =C2=A0 struct iio_ring_buffer *ring;
>>>> + =C2=A0 =C2=A0 INIT_WORK(&st->work_trigger_to_ring, iio_common_trigge=
r_bh_to_ring);
>>>> +
>>> One reason I'm not keen on this as is, is that it means that all
>>> drivers using this code have to use the same buffer implementation.
>>> I'm very keen to make this selectable on a per driver basis.
>>
>> Why can't all devices by SW rings use the same buffer implementation?
>> Why do they want a different SW ring?
> Although we aren't using it much at the moment, the ability to do this lo=
oks
> to be crucial for the future of IIO. =C2=A0A non exhaustive list of why i=
ncludes:
>
> 1) ring_sw is terrible. =C2=A0I wrote it late one night. No one has ever =
taken
> =C2=A0 on reviewing it and I for one am far from convinced it is correct.=
 It was only
> =C2=A0 meant to be a proof of concept (though we have been using it for a=
 while in
> =C2=A0 'production' data capture systems).
>
> 2) ring_sw is unsuprisingly a ring buffer. =C2=A0In many applications fif=
o behaviour
> =C2=A0 is preferable.
>
> 3) ring_sw has maximum size of one page. =C2=A0Not good for devices at hi=
gh rates.
>
> 4) lots of interesting work is going on in the area of lockless ring buff=
ers in
> =C2=A0 the kernel at the moment. =C2=A0Whilst then tend to be complex, th=
ey have much better
> =C2=A0 scalablity than mine.
>
> 5) the buffer hooks are probably the best way to interface to input which=
 people
> =C2=A0 keep requesting.
>
> 6) in slow applications a simple locked buffer would be more appropriate =
unless we
> =C2=A0 are sure there are no downsides to the lockless case.
>
> So in the medium term (or short if someone else does it ;) =C2=A0we shoul=
d have
>
> * Something equivalent to ring_sw with all of the hooks for events to use=
rspace etc.
> * kfifo based fifo. =C2=A0It's simple, but may require excessive locking.=
 (also with this
> =C2=A0I'm interested in whether I can mess around within spi / i2c subsys=
tems to get
> =C2=A0some controllers to do scatter gather dma directly into the buffer)
> * input hooked buffer.
> * high performance large ring buffer. =C2=A0(I'm waiting to see what come=
s out of the tracing
> =C2=A0discussions to see if it is relevant to us).
>
>
>>
>>> Obviously we could add hooks to make that work, but then we begin
>>> to destroy the point of your patch.
>>>
>>>> + =C2=A0 =C2=A0 ring =3D iio_sw_rb_allocate(indio_dev);
>>>> + =C2=A0 =C2=A0 if (!ring) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>>>> + =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 indio_dev->ring =3D ring;
>>>> +
>>>> + =C2=A0 =C2=A0 iio_ring_sw_register_funcs(&ring->access);
>>>
>>> As discussed above. This one is actually a bit of a pain.
>>>> + =C2=A0 =C2=A0 ring->preenable =3D &iio_common_ring_preenable;
>>> These last two are the same for all triggered software ring buffers,
>>> so I've moved the code into industrialio-trigger.c for now.
>>>> + =C2=A0 =C2=A0 ring->postenable =3D &iio_common_ring_postenable;
>>>> + =C2=A0 =C2=A0 ring->predisable =3D &iio_common_ring_predisable;
>>>> + =C2=A0 =C2=A0 ring->owner =3D THIS_MODULE;
>>>> +
>>>
>>> This makes it clear that it is sensible to have an alloc_pollfunc funct=
ion
>>> as the next 8 or so lines occur every single time. =C2=A0That was in my=
 first
>>> patch set today.
>>
>> Acked.
>>
>>>> + =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev->pol=
lfunc), GFP_KERNEL);
>>>> + =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_free;=
;
>>>> + =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &iio_common_ri=
ng_poll_func_th;
>>>> + =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
>>>> + =C2=A0 =C2=A0 indio_dev->modes |=3D INDIO_RING_TRIGGERED;
>>>> + =C2=A0 =C2=A0 return 0;
>>>> +
>>>> +error_iio_sw_rb_free:
>>>> + =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
>>>> + =C2=A0 =C2=A0 return ret;
>>>> +}
>>>> +EXPORT_SYMBOL(iio_configure_common_ring);
>>>> +
>>> Small save, but worth having if we can sort the configure function so
>>> everyone is happy.
>>>> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev)
>>>> +{
>>>> + =C2=A0 =C2=A0 kfree(indio_dev->pollfunc);
>>>> + =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
>>>> +}
>>>> +EXPORT_SYMBOL(iio_unconfigure_common_ring);
>>>> +
>>>
>>> Only purpose of these wrapping functions is to allow for clean
>>> Kconfig selection of whether ring is enable or not. =C2=A0I have just
>>> sent out a patch that adds relevant stubs to the core allowing these
>>> to go from all drivers anyway. =C2=A0Glad to get those out of the way!
>>> Thanks for making the waste apparent.
>>
>> Acked.
>>
>>>> +int iio_initialize_common_ring(struct iio_ring_buffer *ring)
>>>> +{
>>>> + =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
>>>> +}
>>>> +EXPORT_SYMBOL(iio_initialize_common_ring);
>>>> +
>>>> +void iio_uninitialize_common_ring(struct iio_ring_buffer *ring)
>>>> +{
>>>> + =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
>>>> +}
>>>> +EXPORT_SYMBOL(iio_uninitialize_common_ring);
>>>> +
>>>> +static int iio_common_trigger_poll(struct iio_dev *dev_info,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int index,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s64 timestamp,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int no_test)
>>>> +{
>>>> + =C2=A0 =C2=A0 struct iio_state *st =3D iio_dev_get_devdata(dev_info)=
;
>>>> + =C2=A0 =C2=A0 struct iio_trigger *trig =3D st->trig;
>>>> +
>>>> + =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
>>>> + =C2=A0 =C2=A0 iio_trigger_poll(trig);
>>>> +
>>>> + =C2=A0 =C2=A0 return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +IIO_EVENT_SH(common_trig, &iio_common_trigger_poll);
>>> You already know from previous emails that there is an issue with
>>> this one given in creates a couple of structures. =C2=A0Would have
>>> to be a separate instance per driver.
>>
>> Yes. Here i will give a seperate instance per driver.
>>
>>>> +
>>>> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>>>> +
>>>> +static struct attribute *iio_trigger_attrs[] =3D {
>>>> + =C2=A0 =C2=A0 &dev_attr_name.attr,
>>>> + =C2=A0 =C2=A0 NULL,
>>>> +};
>>>> +
>>>> +static const struct attribute_group iio_trigger_attr_group =3D {
>>>> + =C2=A0 =C2=A0 .attrs =3D iio_trigger_attrs,
>>>> +};
>>>> +
>>>
>>> Hiding away the bus type requires a copy of the irq already available.
>>>> +static int iio_common_trigger_try_reen(struct iio_trigger *trig)
>>>> +{
>>>> + =C2=A0 =C2=A0 struct iio_state *st =3D trig->private_data;
>>>> + =C2=A0 =C2=A0 enable_irq(st->irq);
>>>> + =C2=A0 =C2=A0 return 0;
>>>> +}
>>>> +
>>>
>>> This is far too specific for my liking. =C2=A0It only even applies to
>>> the majority of your drivers due to their current simple nature.
>>> If you are going to do this unification I'd like to see it post
>>> addition of full hardware event handling (I'm intending to do
>>> this at somepoint but am low on time currently and only have an
>>> adis16350 to play with)
>>>
>>> Assumptions:
>>> 1) Interrupt line is used for dataready and other events.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0If this isn't true then the driver should be=
 using the event
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0list system at all. =C2=A0Adds overhead to t=
his path for no gain.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0With some of the adis sensors you have 2 int=
errupt lines.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0A sensible option would be to setup one line=
 for dataready
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0and the other for all other events.
>>> 2) Assumes that we have data ready on the first interrupt line.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Perhaps this makes sense but it isn't a curr=
ent requirement
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0or even a suggested option.
>>
>> Here we can build the matched pair for interrupt index =C2=A0and trigger
>> name, then we can check the interrupt index by trigger name with the
>> pair.
> The complexity is not that we might have multiple triggers, its that
> the physical lines may be doing other things as well such as threshold
> interrupts etc. =C2=A0Can we hold this chunk of the patch until we have a=
 few
> more devices implementing events and see where we are at that stage?
>
> It certainly looks like there are some savings in code to be made
> here, but I'm not yet of the best way to do it!
>
>> If one device has more than one trigger and one interrupt, we transfer
>> the param of interrupt index to set_irq(), then the process flow can
>> be shared too.
> True.
>> Anyway, bottom drivers don't want to implement the trigger_set_state
>> per trigger if the flow is same.
> I don't follow what you mean here.
>>
>>>> +static int iio_common_trigger_set_state(struct iio_trigger *trig,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool state)
>>>> +{
>>>> + =C2=A0 =C2=A0 struct iio_state *st =3D trig->private_data;
>>>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
>>>> + =C2=A0 =C2=A0 int ret =3D 0;
>>>> +
>>>> + =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state)=
;
>>>> + =C2=A0 =C2=A0 ret =3D st->set_irq(st, state);
>>>> + =C2=A0 =C2=A0 if (state =3D=3D false) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_remove_event_from_list=
(&iio_event_common_trig,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &indio_dev->interrupts[0]
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ev_list);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_scheduled_work();
>>>> + =C2=A0 =C2=A0 } else {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_add_event_to_list(&iio=
_event_common_trig,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &indio_dev->interrupts[0]->ev_list);
>>>> + =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 return ret;
>>>> +}
>>>> +
>>>
>>> The rest of your factoring out obviously requires the shared driver
>>> state structure. =C2=A0This all makes sense if we think that is a desir=
able
>>> thing to do.
>>>> +int iio_probe_common_trigger(struct iio_dev *indio_dev)
>>>> +{
>>>> + =C2=A0 =C2=A0 int ret;
>>>> + =C2=A0 =C2=A0 struct iio_state *st =3D indio_dev->dev_data;
>>>> +
>>>> + =C2=A0 =C2=A0 st->trig =3D iio_allocate_trigger();
>>>> + =C2=A0 =C2=A0 st->trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GF=
P_KERNEL);
>>>> + =C2=A0 =C2=A0 if (!st->trig->name) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_trig;
>>>> + =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 snprintf((char *)st->trig->name,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 IIO_TRIGGER_NAME_LENGTH,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "iio-dev%d", indio_dev->id);
>>>> + =C2=A0 =C2=A0 st->trig->dev.parent =3D st->parent_dev;
>>>> + =C2=A0 =C2=A0 st->trig->owner =3D THIS_MODULE;
>>>> + =C2=A0 =C2=A0 st->trig->private_data =3D st;
>>>> + =C2=A0 =C2=A0 st->trig->set_trigger_state =3D &iio_common_trigger_se=
t_state;
>>>> + =C2=A0 =C2=A0 st->trig->try_reenable =3D &iio_common_trigger_try_ree=
n;
>>>> + =C2=A0 =C2=A0 st->trig->control_attrs =3D &iio_trigger_attr_group;
>>>> + =C2=A0 =C2=A0 ret =3D iio_trigger_register(st->trig);
>>>> +
>>>> + =C2=A0 =C2=A0 /* select default trigger */
>>>> + =C2=A0 =C2=A0 indio_dev->trig =3D st->trig;
>>>> + =C2=A0 =C2=A0 if (ret)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_trig_name;
>>>> +
>>>> + =C2=A0 =C2=A0 return 0;
>>>> +
>>>> +error_free_trig_name:
>>>> + =C2=A0 =C2=A0 kfree(st->trig->name);
>>>> +error_free_trig:
>>>> + =C2=A0 =C2=A0 iio_free_trigger(st->trig);
>>>> +
>>>> + =C2=A0 =C2=A0 return ret;
>>>> +}
>>>> +EXPORT_SYMBOL(iio_probe_common_trigger);
>>>> +
>>>
>>>
>>>> +void iio_remove_common_trigger(struct iio_dev *indio_dev)
>>>> +{
>>>> + =C2=A0 =C2=A0 struct iio_state *state =3D indio_dev->dev_data;
>>>> +
>>>> + =C2=A0 =C2=A0 iio_trigger_unregister(state->trig);
>>>> + =C2=A0 =C2=A0 kfree(state->trig->name);
>>>> + =C2=A0 =C2=A0 iio_free_trigger(state->trig);
>>>> +}
>>>> +EXPORT_SYMBOL(iio_remove_common_trigger);
>>>
>>> snipped rest as it is obvious boiler pate.
>>>
>>> As an aside. There is an awful lot of repeated code relating to low lev=
el
>>> device access in the adis drivers. Perhaps that is a good opportunity f=
or
>>> unifying code? =C2=A0Maybe we want and adis_library module? Or perhaps =
a number
>>> of the devices can be combined into a single driver? Just a thought
>>> that came up whilst looking at that code again.
>>
>> Good idea in fact. Many codes are same, for example spi read. But it
>> is really difficult to find the orderliness to build a library for the
>> moment.
> One for a later round of clean ups! =C2=A0Perhaps I'll take a look at how
> easy this would be to do.
>
> Jonathan
>
