Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4C065AE1.9090302@cam.ac.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com>
	<4C065AE1.9090302@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 10 Jun 2010 12:48:34 +0800
Message-ID: <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
	jic23@hermes.cam.ac.uk
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Just RFC for discussion. It is not the last patch To keep the change
lest, i extract the common factor for most iio devices to a common
ring trigger module. Most devices can use the interfaces in this
module directly. So copy-paste for ring and trigger is not necessary
now.

For iio core changes:
1. extract xxx_state to iio_state and add a private data to contain
chip-specific data
2. extract all xxx_ring/xxx_trigger api to common api

Index: drivers/staging/iio/iio.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/iio.h	(revision 8893)
+++ drivers/staging/iio/iio.h	(working copy)
@@ -447,4 +447,46 @@

 int iio_get_new_idr_val(struct idr *this_idr);
 void iio_free_idr_val(struct idr *this_idr, int id);
+
+/**
+ * struct iio_state - hardware level hooks for iio device
+ * @work_trigger_to_ring: bh for triggered event handling
+ * @work_cont_thresh: CLEAN
+ * @inter:		used to check if new interrupt has been triggered
+ * @last_timestamp:	passing timestamp from th to bh of interrupt handler
+ * @indio_dev:		industrial I/O device structure
+ * @trig:		data ready trigger registered with iio
+ * @tx:			transmit buffer
+ * @rx:			recieve buffer
+ * @buf_lock:		mutex to protect tx and rx
+ * @irq:                interrupt number
+ * @set_irq:            control the disable/enable of external interrupt
+ * @hw_read_ring:       read ring data from hardware by spi/i2c.
+ **/
+struct iio_state {
+	struct device		        *parent_dev;
+	struct work_struct		work_trigger_to_ring;
+	struct iio_work_cont		work_cont_thresh;
+	s64				last_timestamp;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	u8				*tx;
+	u8				*rx;
+	struct mutex			buf_lock;
+	int                             irq;
+	int (*set_irq)(struct iio_state *st, bool enable);
+	int (*hw_read_ring)(struct iio_state *st, u8 *rx);
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
Index: drivers/staging/iio/common-ring-trigger.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/common-ring-trigger.c	(revision 0)
+++ drivers/staging/iio/common-ring-trigger.c	(revision 0)
@@ -0,0 +1,277 @@
+/* The software ring with trigger which can be used by most drivers
+ *
+ * Copyright (c) 2010 Barry Song
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d by
+ * the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/module.h>
+#include <linux/cdev.h>
+#include <linux/slab.h>
+
+#include "iio.h"
+#include "ring_generic.h"
+#include "trigger.h"
+#include "ring_sw.h"
+
+/*
+ * combine_8_to_16(): utility function to munge to u8s into u16
+ */
+static inline u16 combine_8_to_16(u8 lower, u8 upper)
+{
+	u16 _lower =3D lower;
+	u16 _upper =3D upper;
+	return _lower | (_upper << 8);
+}
+
+static void iio_common_ring_poll_func_th(struct iio_dev *indio_dev)
+{
+	struct iio_state *st =3D iio_dev_get_devdata(indio_dev);
+	st->last_timestamp =3D indio_dev->trig->timestamp;
+	schedule_work(&st->work_trigger_to_ring);
+}
+
+static void iio_common_trigger_bh_to_ring(struct work_struct *work_s)
+{
+	struct iio_state *st
+		=3D container_of(work_s, struct iio_state,
+				work_trigger_to_ring);
+
+	int i =3D 0;
+	s16 *data;
+	size_t datasize =3D st->indio_dev
+		->ring->access.get_bpd(st->indio_dev->ring);
+
+	data =3D kmalloc(datasize , GFP_KERNEL);
+        if (data =3D=3D NULL) {
+                dev_err(st->parent_dev, "memory alloc failed in ring bh");
+                return;
+        }
+
+	if (st->indio_dev->scan_count)
+		if (st->hw_read_ring(st, st->rx) >=3D 0)
+			for (; i < st->indio_dev->scan_count; i++) {
+				data[i] =3D combine_8_to_16(st->rx[i*2+1],
+						st->rx[i*2]);
+			}
+
+        /* Guaranteed to be aligned with 8 byte boundary */
+        if (st->indio_dev->scan_timestamp)
+                *((s64 *)(data + ((i + 3)/4)*4)) =3D st->last_timestamp;
+
+        st->indio_dev->ring->access.store_to(st->indio_dev->ring,
+                                            (u8 *)data,
+                                            st->last_timestamp);
+
+        iio_trigger_notify_done(st->indio_dev->trig);
+        kfree(data);
+
+        return;
+}
+
+static int iio_common_ring_preenable(struct iio_dev *indio_dev)
+{
+	size_t size;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+	/* Check if there are any scan elements enabled, if not fail*/
+	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
+		return -EINVAL;
+
+	if (indio_dev->ring->access.set_bpd) {
+		if (indio_dev->scan_timestamp)
+			if (indio_dev->scan_count)
+				/* Timestamp (aligned to s64) and data */
+				size =3D (((indio_dev->scan_count * sizeof(s16))
+							+ sizeof(s64) - 1)
+						& ~(sizeof(s64) - 1))
+					+ sizeof(s64);
+			else /* Timestamp only  */
+				size =3D sizeof(s64);
+		else /* Data only */
+			size =3D indio_dev->scan_count*sizeof(s16);
+		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
+	}
+
+	return 0;
+}
+
+static int iio_common_ring_postenable(struct iio_dev *indio_dev)
+{
+        return indio_dev->trig
+                ? iio_trigger_attach_poll_func(indio_dev->trig,
+                                               indio_dev->pollfunc)
+                : 0;
+}
+
+static int iio_common_ring_predisable(struct iio_dev *indio_dev)
+{
+        return indio_dev->trig
+                ? iio_trigger_dettach_poll_func(indio_dev->trig,
+                                                indio_dev->pollfunc)
+                : 0;
+}
+
+int iio_configure_common_ring(struct iio_dev *indio_dev)
+{
+	int ret =3D 0;
+	struct iio_state *st =3D indio_dev->dev_data;
+	struct iio_ring_buffer *ring;
+	INIT_WORK(&st->work_trigger_to_ring, iio_common_trigger_bh_to_ring);
+
+	ring =3D iio_sw_rb_allocate(indio_dev);
+	if (!ring) {
+		ret =3D -ENOMEM;
+		return ret;
+	}
+	indio_dev->ring =3D ring;
+
+	iio_ring_sw_register_funcs(&ring->access);
+	ring->preenable =3D &iio_common_ring_preenable;
+	ring->postenable =3D &iio_common_ring_postenable;
+	ring->predisable =3D &iio_common_ring_predisable;
+	ring->owner =3D THIS_MODULE;
+
+	indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL)=
;
+	if (indio_dev->pollfunc =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		goto error_iio_sw_rb_free;;
+	}
+	indio_dev->pollfunc->poll_func_main =3D &iio_common_ring_poll_func_th;
+	indio_dev->pollfunc->private_data =3D indio_dev;
+	indio_dev->modes |=3D INDIO_RING_TRIGGERED;
+	return 0;
+
+error_iio_sw_rb_free:
+	iio_sw_rb_free(indio_dev->ring);
+	return ret;
+}
+EXPORT_SYMBOL(iio_configure_common_ring);
+
+void iio_unconfigure_common_ring(struct iio_dev *indio_dev)
+{
+	kfree(indio_dev->pollfunc);
+	iio_sw_rb_free(indio_dev->ring);
+}
+EXPORT_SYMBOL(iio_unconfigure_common_ring);
+
+int iio_initialize_common_ring(struct iio_ring_buffer *ring)
+{
+	return iio_ring_buffer_register(ring, 0);
+}
+EXPORT_SYMBOL(iio_initialize_common_ring);
+
+void iio_uninitialize_common_ring(struct iio_ring_buffer *ring)
+{
+	iio_ring_buffer_unregister(ring);
+}
+EXPORT_SYMBOL(iio_uninitialize_common_ring);
+
+static int iio_common_trigger_poll(struct iio_dev *dev_info,
+				       int index,
+				       s64 timestamp,
+				       int no_test)
+{
+	struct iio_state *st =3D iio_dev_get_devdata(dev_info);
+	struct iio_trigger *trig =3D st->trig;
+
+	trig->timestamp =3D timestamp;
+	iio_trigger_poll(trig);
+
+	return IRQ_HANDLED;
+}
+
+IIO_EVENT_SH(common_trig, &iio_common_trigger_poll);
+
+static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+
+static struct attribute *iio_trigger_attrs[] =3D {
+	&dev_attr_name.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_trigger_attr_group =3D {
+	.attrs =3D iio_trigger_attrs,
+};
+
+static int iio_common_trigger_try_reen(struct iio_trigger *trig)
+{
+	struct iio_state *st =3D trig->private_data;
+	enable_irq(st->irq);
+	return 0;
+}
+
+static int iio_common_trigger_set_state(struct iio_trigger *trig,
+		bool state)
+{
+	struct iio_state *st =3D trig->private_data;
+	struct iio_dev *indio_dev =3D st->indio_dev;
+	int ret =3D 0;
+
+	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+	ret =3D st->set_irq(st, state);
+	if (state =3D=3D false) {
+		iio_remove_event_from_list(&iio_event_common_trig,
+				&indio_dev->interrupts[0]
+				->ev_list);
+		flush_scheduled_work();
+	} else {
+		iio_add_event_to_list(&iio_event_common_trig,
+				&indio_dev->interrupts[0]->ev_list);
+	}
+	return ret;
+}
+
+int iio_probe_common_trigger(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct iio_state *st =3D indio_dev->dev_data;
+
+	st->trig =3D iio_allocate_trigger();
+	st->trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	if (!st->trig->name) {
+		ret =3D -ENOMEM;
+		goto error_free_trig;
+	}
+	snprintf((char *)st->trig->name,
+			IIO_TRIGGER_NAME_LENGTH,
+			"iio-dev%d", indio_dev->id);
+	st->trig->dev.parent =3D st->parent_dev;
+	st->trig->owner =3D THIS_MODULE;
+	st->trig->private_data =3D st;
+	st->trig->set_trigger_state =3D &iio_common_trigger_set_state;
+	st->trig->try_reenable =3D &iio_common_trigger_try_reen;
+	st->trig->control_attrs =3D &iio_trigger_attr_group;
+	ret =3D iio_trigger_register(st->trig);
+
+	/* select default trigger */
+	indio_dev->trig =3D st->trig;
+	if (ret)
+		goto error_free_trig_name;
+
+	return 0;
+
+error_free_trig_name:
+	kfree(st->trig->name);
+error_free_trig:
+	iio_free_trigger(st->trig);
+
+	return ret;
+}
+EXPORT_SYMBOL(iio_probe_common_trigger);
+
+void iio_remove_common_trigger(struct iio_dev *indio_dev)
+{
+	struct iio_state *state =3D indio_dev->dev_data;
+
+	iio_trigger_unregister(state->trig);
+	kfree(state->trig->name);
+	iio_free_trigger(state->trig);
+}
+EXPORT_SYMBOL(iio_remove_common_trigger);
Index: drivers/staging/iio/common-ring-trigger.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/common-ring-trigger.h	(revision 0)
+++ drivers/staging/iio/common-ring-trigger.h	(revision 0)
@@ -0,0 +1,24 @@
+/* The industrial I/O frequently used ring with trigger
+ *
+ * Copyright (c) 2010 Barry Song
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d by
+ * the Free Software Foundation.
+ *
+ */
+
+#ifndef _IIO_COMMON_RING_TRIGGER_H_
+#define _IIO_COMMON_RING_TRIGGER_H_
+
+#include "iio.h"
+#include "ring_generic.h"
+
+int iio_configure_common_ring(struct iio_dev *indio_dev);
+void iio_unconfigure_common_ring(struct iio_dev *indio_dev);
+int iio_initialize_common_ring(struct iio_ring_buffer *ring);
+void iio_uninitialize_common_ring(struct iio_ring_buffer *ring);
+
+int iio_probe_common_trigger(struct iio_dev *indio_dev);
+void iio_remove_common_trigger(struct iio_dev *indio_dev);
+#endif /* _IIO_COMMON_RING_TRIGGER_H_ */
Index: drivers/staging/iio/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/Kconfig	(revision 8893)
+++ drivers/staging/iio/Kconfig	(working copy)
@@ -38,6 +38,12 @@
 	  ring buffers.  The triggers are effectively a 'capture
 	  data now' interrupt.

+config IIO_COMMON_RING_TRIGGER
+	boolean "Enable frequently used ring with trigger"
+	depends on IIO_SW_RING && IIO_TRIGGER
+	help
+	  Provides a generic ring with trigger. I can be used by most
+	  IIO devices.

 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
Index: drivers/staging/iio/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/Makefile	(revision 8893)
+++ drivers/staging/iio/Makefile	(working copy)
@@ -9,6 +9,8 @@

 obj-$(CONFIG_IIO_SW_RING) +=3D ring_sw.o

+obj-$(CONFIG_IIO_COMMON_RING_TRIGGER) +=3D common-ring-trigger.o
+
 obj-y +=3D accel/
 obj-y +=3D adc/
 obj-y +=3D addac/



On Wed, Jun 2, 2010 at 9:21 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 06/02/10 09:01, Barry Song wrote:
>> On Mon, Feb 22, 2010 at 7:16 PM, Jonathan Cameron <jic23@cam.ac.uk> wrot=
e:
>>> Hi All,
>>>
>>> Just for reference as I'll be doing a proper announcement later.
>>> We now have linux-iio@vger.kernel.org as a mailing list for the project=
.
>>> Unless others have tracked it down it currently only has me as a member
>>> though and I'm waiting for confirmation from marc.info of an archive.
>>>
>>>> Hi Jonathan,
>>>> Now users depend on iio ring events(IIO_EVENT_CODE_RING_50/75/100_FULL=
)
>>>> to read data:
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_size =3D =
fread(&dat, 1, sizeof(struct
>>>> iio_event_data),
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp_ev);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (dat.id=
) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVENT=
_CODE_RING_100_FULL:
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 toread =3D RingLength;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 break;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVENT=
_CODE_RING_75_FULL:
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 toread =3D RingLength*3/4;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 break;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVENT=
_CODE_RING_50_FULL:
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 toread =3D RingLength/2;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 break;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 printf("Unexpecteded event code\n");
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 continue;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_size =3D =
read(fp,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0toread*size_from_scanmode(N=
umVals,
>>>> scan_ts));
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (read_size =
=3D=3D -EAGAIN) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 printf("nothing available \n");
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 continue;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> And iio ring access node doesn't support blocking io too. =C2=A0It see=
ms we
>>>> lost to let users read data once ring is not empty. And some users may=
be
>>>> not care about iio ring events at all, but just want to read data like=
 a
>>>> input or audio driver. So how about adding the following support in ii=
o
>>>> ring:
>>>> 1. add NOT EMPTY event in IIO event nodes
>>> Not keen. =C2=A0It might lead to a storm of events (at least it might i=
n a
>>> cleverer ring buffer implementation or during a blocking read). =C2=A0A=
ctually
>>> in this particular case it probably wouldn't do any harm.
>>>> 2. add blocking io support in read function of IIO access nodes
>>> That I agree would be a good idea. =C2=A0If we support poll/select on t=
he buffer access
>>> chrdev then we will get the same effect per having a not empty event an=
d cleaner
>>> semantics for anyone not interested in the other events. Not to mention=
 I expect
>>> we will soon have alternative ring buffer implementations that don't su=
pply any
>>> events at all and hence don't event have the relevant chrdev.
>>>
>>> As things are, you can quite happily read whenever you like. =C2=A0Now =
you mention it,
>>> that example code is somewhat missleading! The issue with
>>> this ring buffer implementation is the handling of a true blocking read=
 is complex
>>> as at any given time you aren't guaranteed to get what you asked for ev=
en if it was
>>> there when you started the read. It should be possible to work around t=
hat though.
>>>
>>> It's possible this functionality might be better added to an alternativ=
e ring buffer
>>> implementation. Be vary wary of that ring implementation in general! I =
am and I wrote it.
>>>> If you agree with that, I can begin to add these and send you a patch.
>>>> And a problem I don't know is what you and other people have changed t=
o
>>>> Greg's staging tree, and I am not sure what tree the patch should be
>>>> againest.
>>> Nothing has changed in this region of the code. =C2=A0In fact I think a=
ll that
>>> has gone into Greg's tree is a clean up patch form Mark Brown making a =
few
>>> functions static. Right now I'm still getting the max1363 driver into
>>> a state where it will be possible to do the ABI changes.
>>>>
>>>> For long term plan, is it possible for ring common level to handle mor=
e
>>>> common work to avoid code repeating in different drivers?
>>> I'm certainly happy for that to be the case if it becomes apparent whic=
h functionality
>>> is shared. =C2=A0I haven't seen any substantial cases as yet, but then =
I may well be missing
>>> things so feel free to submit suggestions (or as ever the better option=
 of patches).
>>
>> Now we have many drivers using SW ring with same
>> preenable(),postenable(),predisable(),
>> initialize_ring(),uninitialize_ring(),poll_func(),probe_trigger(),
>> remove_trigger(). Can we move them to IIO common layer as a base class
>> methods. And the derived class can overload them if they have special
>> implement? Most devices just use the common layer and don't need to
>> copy codes.
> Sounds sensible. Please propose a patch.
>
> Jonathan
>
