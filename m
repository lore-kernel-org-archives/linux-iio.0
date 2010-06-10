Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com>
	<4C065AE1.9090302@cam.ac.uk> <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 10 Jun 2010 12:51:13 +0800
Message-ID: <AANLkTim40W-n4npSSjLHgwlIy--Wa2PYXXOr0OAKQXla@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
	jic23@hermes.cam.ac.uk
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

An example(adis16209) to use the new ring/trigger:
1. adis16209_ring.c and adis16209_trigger.c are not necessary and use commo=
n api
2. provide callback for set_irq and hw_read_ring to common ring/trigger mod=
ule

Index: drivers/staging/iio/accel/adis16209_ring.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/accel/adis16209_ring.c	(revision 8893)
+++ drivers/staging/iio/accel/adis16209_ring.c	(working copy)
@@ -1,267 +0,0 @@
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../ring_sw.h"
-#include "accel.h"
-#include "../trigger.h"
-#include "adis16209.h"
-
-/**
- * combine_8_to_16() utility function to munge to u8s into u16
- **/
-static inline u16 combine_8_to_16(u8 lower, u8 upper)
-{
-	u16 _lower =3D lower;
-	u16 _upper =3D upper;
-	return _lower | (_upper << 8);
-}
-
-static IIO_SCAN_EL_C(supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
-		     ADIS16209_SUPPLY_OUT, NULL);
-static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
-		     ADIS16209_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, IIO_SIGNED(14),
-		     ADIS16209_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(aux_adc, ADIS16209_SCAN_AUX_ADC, IIO_UNSIGNED(12),
-		     ADIS16209_AUX_ADC, NULL);
-static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, IIO_UNSIGNED(12),
-		     ADIS16209_TEMP_OUT, NULL);
-static IIO_SCAN_EL_C(incli_x, ADIS16209_SCAN_INCLI_X, IIO_SIGNED(14),
-		     ADIS16209_XINCL_OUT, NULL);
-static IIO_SCAN_EL_C(incli_y, ADIS16209_SCAN_INCLI_Y, IIO_SIGNED(14),
-		     ADIS16209_YINCL_OUT, NULL);
-static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, IIO_SIGNED(14),
-		     ADIS16209_ROT_OUT, NULL);
-
-static IIO_SCAN_EL_TIMESTAMP(8);
-
-static struct attribute *adis16209_scan_el_attrs[] =3D {
-	&iio_scan_el_supply.dev_attr.attr,
-	&iio_scan_el_accel_x.dev_attr.attr,
-	&iio_scan_el_accel_y.dev_attr.attr,
-	&iio_scan_el_aux_adc.dev_attr.attr,
-	&iio_scan_el_temp.dev_attr.attr,
-	&iio_scan_el_incli_x.dev_attr.attr,
-	&iio_scan_el_incli_y.dev_attr.attr,
-	&iio_scan_el_rot.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group adis16209_scan_el_group =3D {
-	.attrs =3D adis16209_scan_el_attrs,
-	.name =3D "scan_elements",
-};
-
-/**
- * adis16209_poll_func_th() top half interrupt handler called by trigger
- * @private_data:	iio_dev
- **/
-static void adis16209_poll_func_th(struct iio_dev *indio_dev)
-{
-	struct adis16209_state *st =3D iio_dev_get_devdata(indio_dev);
-	st->last_timestamp =3D indio_dev->trig->timestamp;
-	schedule_work(&st->work_trigger_to_ring);
-}
-
-/**
- * adis16209_read_ring_data() read data registers which will be
placed into ring
- * @dev: device associated with child of actual device (iio_dev or iio_tri=
g)
- * @rx: somewhere to pass back the value read
- **/
-static int adis16209_read_ring_data(struct device *dev, u8 *rx)
-{
-	struct spi_message msg;
-	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
-	struct adis16209_state *st =3D iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[ADIS16209_OUTPUTS + 1];
-	int ret;
-	int i;
-
-	mutex_lock(&st->buf_lock);
-
-	spi_message_init(&msg);
-
-	memset(xfers, 0, sizeof(xfers));
-	for (i =3D 0; i <=3D ADIS16209_OUTPUTS; i++) {
-		xfers[i].bits_per_word =3D 8;
-		xfers[i].cs_change =3D 1;
-		xfers[i].len =3D 2;
-		xfers[i].delay_usecs =3D 30;
-		xfers[i].tx_buf =3D st->tx + 2 * i;
-		st->tx[2 * i]
-			=3D ADIS16209_READ_REG(ADIS16209_SUPPLY_OUT + 2 * i);
-		st->tx[2 * i + 1] =3D 0;
-		if (i >=3D 1)
-			xfers[i].rx_buf =3D rx + 2 * (i - 1);
-		spi_message_add_tail(&xfers[i], &msg);
-	}
-
-	ret =3D spi_sync(st->us, &msg);
-	if (ret)
-		dev_err(&st->us->dev, "problem when burst reading");
-
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to de=
vice
- * specific to be rolled into the core.
- */
-static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
-{
-	struct adis16209_state *st
-		=3D container_of(work_s, struct adis16209_state,
-			       work_trigger_to_ring);
-
-	int i =3D 0;
-	s16 *data;
-	size_t datasize =3D st->indio_dev
-		->ring->access.get_bpd(st->indio_dev->ring);
-
-	data =3D kmalloc(datasize , GFP_KERNEL);
-	if (data =3D=3D NULL) {
-		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
-	}
-
-	if (st->indio_dev->scan_count)
-		if (adis16209_read_ring_data(&st->indio_dev->dev, st->rx) >=3D 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] =3D combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
-
-	/* Guaranteed to be aligned with 8 byte boundary */
-	if (st->indio_dev->scan_timestamp)
-		*((s64 *)(data + ((i + 3)/4)*4)) =3D st->last_timestamp;
-
-	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
-					    (u8 *)data,
-					    st->last_timestamp);
-
-	iio_trigger_notify_done(st->indio_dev->trig);
-	kfree(data);
-
-	return;
-}
-
-/* in these circumstances is it better to go with unaligned packing and
- * deal with the cost?*/
-static int adis16209_data_rdy_ring_preenable(struct iio_dev *indio_dev)
-{
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
-		return -EINVAL;
-
-	if (indio_dev->ring->access.set_bpd) {
-		if (indio_dev->scan_timestamp)
-			if (indio_dev->scan_count)
-				/* Timestamp (aligned to s64) and data */
-				size =3D (((indio_dev->scan_count * sizeof(s16))
-					 + sizeof(s64) - 1)
-					& ~(sizeof(s64) - 1))
-					+ sizeof(s64);
-			else /* Timestamp only  */
-				size =3D sizeof(s64);
-		else /* Data only */
-			size =3D indio_dev->scan_count*sizeof(s16);
-		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
-	}
-
-	return 0;
-}
-
-static int adis16209_data_rdy_ring_postenable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_attach_poll_func(indio_dev->trig,
-					       indio_dev->pollfunc)
-		: 0;
-}
-
-static int adis16209_data_rdy_ring_predisable(struct iio_dev *indio_dev)
-{
-	return indio_dev->trig
-		? iio_trigger_dettach_poll_func(indio_dev->trig,
-						indio_dev->pollfunc)
-		: 0;
-}
-
-void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
-{
-	kfree(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
-}
-
-int adis16209_configure_ring(struct iio_dev *indio_dev)
-{
-	int ret =3D 0;
-	struct adis16209_state *st =3D indio_dev->dev_data;
-	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, adis16209_trigger_bh_to_ring);
-	/* Set default scan mode */
-
-	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
-	iio_scan_mask_set(indio_dev, iio_scan_el_rot.number);
-	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
-	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
-	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
-	iio_scan_mask_set(indio_dev, iio_scan_el_aux_adc.number);
-	iio_scan_mask_set(indio_dev, iio_scan_el_incli_x.number);
-	iio_scan_mask_set(indio_dev, iio_scan_el_incli_y.number);
-	indio_dev->scan_timestamp =3D true;
-
-	indio_dev->scan_el_attrs =3D &adis16209_scan_el_group;
-
-	ring =3D iio_sw_rb_allocate(indio_dev);
-	if (!ring) {
-		ret =3D -ENOMEM;
-		return ret;
-	}
-	indio_dev->ring =3D ring;
-	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
-	ring->preenable =3D &adis16209_data_rdy_ring_preenable;
-	ring->postenable =3D &adis16209_data_rdy_ring_postenable;
-	ring->predisable =3D &adis16209_data_rdy_ring_predisable;
-	ring->owner =3D THIS_MODULE;
-
-	indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL)=
;
-	if (indio_dev->pollfunc =3D=3D NULL) {
-		ret =3D -ENOMEM;
-		goto error_iio_sw_rb_free;;
-	}
-	indio_dev->pollfunc->poll_func_main =3D &adis16209_poll_func_th;
-	indio_dev->pollfunc->private_data =3D indio_dev;
-	indio_dev->modes |=3D INDIO_RING_TRIGGERED;
-	return 0;
-
-error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
-	return ret;
-}
-
-int adis16209_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return iio_ring_buffer_register(ring, 0);
-}
-
-void adis16209_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-	iio_ring_buffer_unregister(ring);
-}
Index: drivers/staging/iio/accel/adis16209_trigger.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/accel/adis16209_trigger.c	(revision 8893)
+++ drivers/staging/iio/accel/adis16209_trigger.c	(working copy)
@@ -1,124 +0,0 @@
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/spi/spi.h>
-
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../trigger.h"
-#include "adis16209.h"
-
-/**
- * adis16209_data_rdy_trig_poll() the event handler for the data rdy trig
- **/
-static int adis16209_data_rdy_trig_poll(struct iio_dev *dev_info,
-				       int index,
-				       s64 timestamp,
-				       int no_test)
-{
-	struct adis16209_state *st =3D iio_dev_get_devdata(dev_info);
-	struct iio_trigger *trig =3D st->trig;
-
-	trig->timestamp =3D timestamp;
-	iio_trigger_poll(trig);
-
-	return IRQ_HANDLED;
-}
-
-IIO_EVENT_SH(data_rdy_trig, &adis16209_data_rdy_trig_poll);
-
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
-
-static struct attribute *adis16209_trigger_attrs[] =3D {
-	&dev_attr_name.attr,
-	NULL,
-};
-
-static const struct attribute_group adis16209_trigger_attr_group =3D {
-	.attrs =3D adis16209_trigger_attrs,
-};
-
-/**
- * adis16209_data_rdy_trigger_set_state() set datardy interrupt state
- **/
-static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
-						bool state)
-{
-	struct adis16209_state *st =3D trig->private_data;
-	struct iio_dev *indio_dev =3D st->indio_dev;
-	int ret =3D 0;
-
-	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
-	ret =3D adis16209_set_irq(&st->indio_dev->dev, state);
-	if (state =3D=3D false) {
-		iio_remove_event_from_list(&iio_event_data_rdy_trig,
-					   &indio_dev->interrupts[0]
-					   ->ev_list);
-		flush_scheduled_work();
-	} else {
-		iio_add_event_to_list(&iio_event_data_rdy_trig,
-				      &indio_dev->interrupts[0]->ev_list);
-	}
-	return ret;
-}
-
-/**
- * adis16209_trig_try_reen() try renabling irq for data rdy trigger
- * @trig:	the datardy trigger
- **/
-static int adis16209_trig_try_reen(struct iio_trigger *trig)
-{
-	struct adis16209_state *st =3D trig->private_data;
-	enable_irq(st->us->irq);
-	return 0;
-}
-
-int adis16209_probe_trigger(struct iio_dev *indio_dev)
-{
-	int ret;
-	struct adis16209_state *st =3D indio_dev->dev_data;
-
-	st->trig =3D iio_allocate_trigger();
-	st->trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
-	if (!st->trig->name) {
-		ret =3D -ENOMEM;
-		goto error_free_trig;
-	}
-	snprintf((char *)st->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "adis16209-dev%d", indio_dev->id);
-	st->trig->dev.parent =3D &st->us->dev;
-	st->trig->owner =3D THIS_MODULE;
-	st->trig->private_data =3D st;
-	st->trig->set_trigger_state =3D &adis16209_data_rdy_trigger_set_state;
-	st->trig->try_reenable =3D &adis16209_trig_try_reen;
-	st->trig->control_attrs =3D &adis16209_trigger_attr_group;
-	ret =3D iio_trigger_register(st->trig);
-
-	/* select default trigger */
-	indio_dev->trig =3D st->trig;
-	if (ret)
-		goto error_free_trig_name;
-
-	return 0;
-
-error_free_trig_name:
-	kfree(st->trig->name);
-error_free_trig:
-	iio_free_trigger(st->trig);
-
-	return ret;
-}
-
-void adis16209_remove_trigger(struct iio_dev *indio_dev)
-{
-	struct adis16209_state *state =3D indio_dev->dev_data;
-
-	iio_trigger_unregister(state->trig);
-	kfree(state->trig->name);
-	iio_free_trigger(state->trig);
-}
Index: drivers/staging/iio/accel/adis16209.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/accel/adis16209.h	(revision 8893)
+++ drivers/staging/iio/accel/adis16209.h	(working copy)
@@ -101,33 +101,6 @@

 #define ADIS16209_ERROR_ACTIVE          (1<<14)

-/**
- * struct adis16209_state - device instance specific data
- * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
- * @indio_dev:		industrial I/O device structure
- * @trig:		data ready trigger registered with iio
- * @tx:			transmit buffer
- * @rx:			recieve buffer
- * @buf_lock:		mutex to protect tx and rx
- **/
-struct adis16209_state {
-	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_thresh;
-	s64				last_timestamp;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
-};
-
-int adis16209_set_irq(struct device *dev, bool enable);
-
 #ifdef CONFIG_IIO_RING_BUFFER
 enum adis16209_scan {
 	ADIS16209_SCAN_SUPPLY,
@@ -139,55 +112,5 @@
 	ADIS16209_SCAN_INCLI_Y,
 	ADIS16209_SCAN_ROT,
 };
-
-void adis16209_remove_trigger(struct iio_dev *indio_dev);
-int adis16209_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t adis16209_read_data_from_ring(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf);
-
-int adis16209_configure_ring(struct iio_dev *indio_dev);
-void adis16209_unconfigure_ring(struct iio_dev *indio_dev);
-
-int adis16209_initialize_ring(struct iio_ring_buffer *ring);
-void adis16209_uninitialize_ring(struct iio_ring_buffer *ring);
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void adis16209_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16209_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-adis16209_read_data_from_ring(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return 0;
-}
-
-static int adis16209_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16209_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16209_uninitialize_ring(struct iio_ring_buffer *rin=
g)
-{
-}
-
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16209_H_ */
Index: drivers/staging/iio/accel/adis16209_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/accel/adis16209_core.c	(revision 8893)
+++ drivers/staging/iio/accel/adis16209_core.c	(working copy)
@@ -22,6 +22,9 @@
 #include "../sysfs.h"
 #include "accel.h"
 #include "inclinometer.h"
+#include "../trigger.h"
+#include "../ring_generic.h"
+#include "../common-ring-trigger.h"
 #include "../gyro/gyro.h"
 #include "../adc/adc.h"

@@ -43,13 +46,14 @@
 {
 	int ret;
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
-	struct adis16209_state *st =3D iio_dev_get_devdata(indio_dev);
+	struct iio_state *st =3D iio_dev_get_devdata(indio_dev);
+	struct spi_device *spi =3D iio_state_get_privdata(st);

 	mutex_lock(&st->buf_lock);
 	st->tx[0] =3D ADIS16209_WRITE_REG(reg_address);
 	st->tx[1] =3D val;

-	ret =3D spi_write(st->us, st->tx, 2);
+	ret =3D spi_write(spi, st->tx, 2);
 	mutex_unlock(&st->buf_lock);

 	return ret;
@@ -69,7 +73,8 @@
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
-	struct adis16209_state *st =3D iio_dev_get_devdata(indio_dev);
+	struct iio_state *st =3D iio_dev_get_devdata(indio_dev);
+	struct spi_device *spi =3D iio_state_get_privdata(st);
 	struct spi_transfer xfers[] =3D {
 		{
 			.tx_buf =3D st->tx,
@@ -95,7 +100,7 @@
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
 	spi_message_add_tail(&xfers[1], &msg);
-	ret =3D spi_sync(st->us, &msg);
+	ret =3D spi_sync(spi, &msg);
 	mutex_unlock(&st->buf_lock);

 	return ret;
@@ -114,7 +119,8 @@
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
-	struct adis16209_state *st =3D iio_dev_get_devdata(indio_dev);
+	struct iio_state *st =3D iio_dev_get_devdata(indio_dev);
+	struct spi_device *spi =3D iio_state_get_privdata(st);
 	int ret;
 	struct spi_transfer xfers[] =3D {
 		{
@@ -139,9 +145,9 @@
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
 	spi_message_add_tail(&xfers[1], &msg);
-	ret =3D spi_sync(st->us, &msg);
+	ret =3D spi_sync(spi, &msg);
 	if (ret) {
-		dev_err(&st->us->dev,
+		dev_err(&spi->dev,
 			"problem when reading 16 bit register 0x%02X",
 			lower_reg_address);
 		goto error_ret;
@@ -285,12 +291,12 @@
 	return -EINVAL;
 }

-int adis16209_set_irq(struct device *dev, bool enable)
+static int adis16209_set_irq(struct iio_state *st, bool enable)
 {
 	int ret =3D 0;
 	u16 msc;

-	ret =3D adis16209_spi_read_reg_16(dev, ADIS16209_MSC_CTRL, &msc);
+	ret =3D adis16209_spi_read_reg_16(&st->indio_dev->dev,
ADIS16209_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;

@@ -301,7 +307,7 @@
 	else
 		msc &=3D ~ADIS16209_MSC_CTRL_DATA_RDY_EN;

-	ret =3D adis16209_spi_write_reg_16(dev, ADIS16209_MSC_CTRL, msc);
+	ret =3D adis16209_spi_write_reg_16(&st->indio_dev->dev,
ADIS16209_MSC_CTRL, msc);

 error_ret:
 	return ret;
@@ -351,13 +357,55 @@
 	return ret;
 }

-static int adis16209_initial_setup(struct adis16209_state *st)
+/**
+ * adis16209_read_ring_data() read data registers which will be
placed into ring
+ * @dev: device associated with child of actual device (iio_dev or iio_tri=
g)
+ * @rx: somewhere to pass back the value read
+ **/
+static int adis16209_read_ring_data(struct iio_state *st, u8 *rx)
 {
+	struct spi_device *spi =3D iio_state_get_privdata(st);
+	struct spi_message msg;
+	struct spi_transfer xfers[ADIS16209_OUTPUTS + 1];
 	int ret;
+	int i;
+
+	mutex_lock(&st->buf_lock);
+
+	spi_message_init(&msg);
+
+	memset(xfers, 0, sizeof(xfers));
+	for (i =3D 0; i <=3D ADIS16209_OUTPUTS; i++) {
+		xfers[i].bits_per_word =3D 8;
+		xfers[i].cs_change =3D 1;
+		xfers[i].len =3D 2;
+		xfers[i].delay_usecs =3D 30;
+		xfers[i].tx_buf =3D st->tx + 2 * i;
+		st->tx[2 * i]
+			=3D ADIS16209_READ_REG(ADIS16209_SUPPLY_OUT + 2 * i);
+		st->tx[2 * i + 1] =3D 0;
+		if (i >=3D 1)
+			xfers[i].rx_buf =3D rx + 2 * (i - 1);
+		spi_message_add_tail(&xfers[i], &msg);
+	}
+
+	ret =3D spi_sync(spi, &msg);
+	if (ret)
+		dev_err(&spi->dev, "problem when burst reading");
+
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static int adis16209_initial_setup(struct iio_state *st)
+{
+	int ret;
+	struct spi_device *spi =3D iio_state_get_privdata(st);
 	struct device *dev =3D &st->indio_dev->dev;

 	/* Disable IRQ */
-	ret =3D adis16209_set_irq(dev, false);
+	ret =3D adis16209_set_irq(st, false);
 	if (ret) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
@@ -384,7 +432,7 @@
 	}

 	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
-			st->us->chip_select, st->us->irq);
+			spi->chip_select, spi->irq);

 err_ret:
 	return ret;
@@ -472,16 +520,54 @@
 	.attrs =3D adis16209_attributes,
 };

+static IIO_SCAN_EL_C(supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
+		     ADIS16209_SUPPLY_OUT, NULL);
+static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
+		     ADIS16209_XACCL_OUT, NULL);
+static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, IIO_SIGNED(14),
+		     ADIS16209_YACCL_OUT, NULL);
+static IIO_SCAN_EL_C(aux_adc, ADIS16209_SCAN_AUX_ADC, IIO_UNSIGNED(12),
+		     ADIS16209_AUX_ADC, NULL);
+static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, IIO_UNSIGNED(12),
+		     ADIS16209_TEMP_OUT, NULL);
+static IIO_SCAN_EL_C(incli_x, ADIS16209_SCAN_INCLI_X, IIO_SIGNED(14),
+		     ADIS16209_XINCL_OUT, NULL);
+static IIO_SCAN_EL_C(incli_y, ADIS16209_SCAN_INCLI_Y, IIO_SIGNED(14),
+		     ADIS16209_YINCL_OUT, NULL);
+static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, IIO_SIGNED(14),
+		     ADIS16209_ROT_OUT, NULL);
+
+static IIO_SCAN_EL_TIMESTAMP(8);
+
+static struct attribute *adis16209_scan_el_attrs[] =3D {
+	&iio_scan_el_supply.dev_attr.attr,
+	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_scan_el_aux_adc.dev_attr.attr,
+	&iio_scan_el_temp.dev_attr.attr,
+	&iio_scan_el_incli_x.dev_attr.attr,
+	&iio_scan_el_incli_y.dev_attr.attr,
+	&iio_scan_el_rot.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group adis16209_scan_el_group =3D {
+	.attrs =3D adis16209_scan_el_attrs,
+	.name =3D "scan_elements",
+};
+
 static int __devinit adis16209_probe(struct spi_device *spi)
 {
 	int ret, regdone =3D 0;
-	struct adis16209_state *st =3D kzalloc(sizeof *st, GFP_KERNEL);
+	struct iio_state *st =3D kzalloc(sizeof *st, GFP_KERNEL);
 	if (!st) {
 		ret =3D  -ENOMEM;
 		goto error_ret;
 	}
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, st);
+	iio_state_set_privdata(st, spi);

 	/* Allocate the comms buffers */
 	st->rx =3D kzalloc(sizeof(*st->rx)*ADIS16209_MAX_RX, GFP_KERNEL);
@@ -494,7 +580,12 @@
 		ret =3D -ENOMEM;
 		goto error_free_rx;
 	}
-	st->us =3D spi;
+
+	st->irq =3D spi->irq;
+	st->set_irq =3D adis16209_set_irq;
+	st->hw_read_ring =3D adis16209_read_ring_data;
+	st->parent_dev =3D &spi->dev;
+
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
 	st->indio_dev =3D iio_allocate_device();
@@ -511,7 +602,18 @@
 	st->indio_dev->driver_module =3D THIS_MODULE;
 	st->indio_dev->modes =3D INDIO_DIRECT_MODE;

-	ret =3D adis16209_configure_ring(st->indio_dev);
+	iio_scan_mask_set(st->indio_dev, iio_scan_el_supply.number);
+	iio_scan_mask_set(st->indio_dev, iio_scan_el_rot.number);
+	iio_scan_mask_set(st->indio_dev, iio_scan_el_accel_x.number);
+	iio_scan_mask_set(st->indio_dev, iio_scan_el_accel_y.number);
+	iio_scan_mask_set(st->indio_dev, iio_scan_el_temp.number);
+	iio_scan_mask_set(st->indio_dev, iio_scan_el_aux_adc.number);
+	iio_scan_mask_set(st->indio_dev, iio_scan_el_incli_x.number);
+	iio_scan_mask_set(st->indio_dev, iio_scan_el_incli_y.number);
+	st->indio_dev->scan_timestamp =3D true;
+	st->indio_dev->scan_el_attrs =3D &adis16209_scan_el_group;
+
+	ret =3D iio_configure_common_ring(st->indio_dev);
 	if (ret)
 		goto error_free_dev;

@@ -520,7 +622,7 @@
 		goto error_unreg_ring_funcs;
 	regdone =3D 1;

-	ret =3D adis16209_initialize_ring(st->indio_dev->ring);
+	ret =3D iio_initialize_common_ring(st->indio_dev->ring);
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -533,9 +635,9 @@
 				IRQF_TRIGGER_RISING,
 				"adis16209");
 		if (ret)
-			goto error_uninitialize_ring;
+			goto error_uninitialize_common_ring;

-		ret =3D adis16209_probe_trigger(st->indio_dev);
+		ret =3D iio_probe_common_trigger(st->indio_dev);
 		if (ret)
 			goto error_unregister_line;
 	}
@@ -543,18 +645,18 @@
 	/* Get the device into a sane initial state */
 	ret =3D adis16209_initial_setup(st);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_remove_common_trigger;
 	return 0;

-error_remove_trigger:
-	adis16209_remove_trigger(st->indio_dev);
+error_remove_common_trigger:
+	iio_remove_common_trigger(st->indio_dev);
 error_unregister_line:
 	if (spi->irq)
 		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	adis16209_uninitialize_ring(st->indio_dev->ring);
+error_uninitialize_common_ring:
+	iio_uninitialize_common_ring(st->indio_dev->ring);
 error_unreg_ring_funcs:
-	adis16209_unconfigure_ring(st->indio_dev);
+	iio_unconfigure_common_ring(st->indio_dev);
 error_free_dev:
 	if (regdone)
 		iio_device_unregister(st->indio_dev);
@@ -572,18 +674,18 @@

 static int adis16209_remove(struct spi_device *spi)
 {
-	struct adis16209_state *st =3D spi_get_drvdata(spi);
+	struct iio_state *st =3D spi_get_drvdata(spi);
 	struct iio_dev *indio_dev =3D st->indio_dev;

 	flush_scheduled_work();

-	adis16209_remove_trigger(indio_dev);
+	iio_remove_common_trigger(indio_dev);
 	if (spi->irq)
 		iio_unregister_interrupt_line(indio_dev, 0);

-	adis16209_uninitialize_ring(indio_dev->ring);
+	iio_uninitialize_common_ring(indio_dev->ring);
 	iio_device_unregister(indio_dev);
-	adis16209_unconfigure_ring(indio_dev);
+	iio_unconfigure_common_ring(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
 	kfree(st);
Index: drivers/staging/iio/accel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/accel/Makefile	(revision 8893)
+++ drivers/staging/iio/accel/Makefile	(working copy)
@@ -15,7 +15,6 @@
 obj-$(CONFIG_ADIS16204) +=3D adis16204.o

 adis16209-y             :=3D adis16209_core.o
-adis16209-$(CONFIG_IIO_RING_BUFFER) +=3D adis16209_ring.o adis16209_trigge=
r.o
 obj-$(CONFIG_ADIS16209) +=3D adis16209.o

 adis16220-y             :=3D adis16220_core.o


On Thu, Jun 10, 2010 at 12:48 PM, Barry Song <21cnbao@gmail.com> wrote:
> Just RFC for discussion. It is not the last patch To keep the change
> lest, i extract the common factor for most iio devices to a common
> ring trigger module. Most devices can use the interfaces in this
> module directly. So copy-paste for ring and trigger is not necessary
> now.
>
> For iio core changes:
> 1. extract xxx_state to iio_state and add a private data to contain
> chip-specific data
> 2. extract all xxx_ring/xxx_trigger api to common api
>
> Index: drivers/staging/iio/iio.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/iio.h =C2=A0 (revision 8893)
> +++ drivers/staging/iio/iio.h =C2=A0 (working copy)
> @@ -447,4 +447,46 @@
>
> =C2=A0int iio_get_new_idr_val(struct idr *this_idr);
> =C2=A0void iio_free_idr_val(struct idr *this_idr, int id);
> +
> +/**
> + * struct iio_state - hardware level hooks for iio device
> + * @work_trigger_to_ring: bh for triggered event handling
> + * @work_cont_thresh: CLEAN
> + * @inter: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 used to check if ne=
w interrupt has been triggered
> + * @last_timestamp: =C2=A0 =C2=A0passing timestamp from th to bh of inte=
rrupt handler
> + * @indio_dev: =C2=A0 =C2=A0 =C2=A0 =C2=A0 industrial I/O device structu=
re
> + * @trig: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data ready tri=
gger registered with iio
> + * @tx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0transmit buffer
> + * @rx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0recieve buffer
> + * @buf_lock: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex to protect tx and =
rx
> + * @irq: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrup=
t number
> + * @set_irq: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0control the disabl=
e/enable of external interrupt
> + * @hw_read_ring: =C2=A0 =C2=A0 =C2=A0 read ring data from hardware by s=
pi/i2c.
> + **/
> +struct iio_state {
> + =C2=A0 =C2=A0 =C2=A0 struct device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *parent_dev;
> + =C2=A0 =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0work_trigger_to_ring;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_work_cont =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0work_cont_thresh;
> + =C2=A0 =C2=A0 =C2=A0 s64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_timestamp;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_trigger =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*trig;
> + =C2=A0 =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*tx;
> + =C2=A0 =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*rx;
> + =C2=A0 =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_lock;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq;
> + =C2=A0 =C2=A0 =C2=A0 int (*set_irq)(struct iio_state *st, bool enable);
> + =C2=A0 =C2=A0 =C2=A0 int (*hw_read_ring)(struct iio_state *st, u8 *rx);
> + =C2=A0 =C2=A0 =C2=A0 void *priv;
> +};
> +
> +static inline void iio_state_set_privdata(struct iio_state *st, void *da=
ta)
> +{
> + =C2=A0 =C2=A0 =C2=A0 st->priv =3D data;
> +}
> +
> +static inline void * iio_state_get_privdata(struct iio_state *st)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return st->priv;
> +}
> +
> =C2=A0#endif /* _INDUSTRIAL_IO_H_ */
> Index: drivers/staging/iio/common-ring-trigger.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/common-ring-trigger.c =C2=A0 (revision 0)
> +++ drivers/staging/iio/common-ring-trigger.c =C2=A0 (revision 0)
> @@ -0,0 +1,277 @@
> +/* The software ring with trigger which can be used by most drivers
> + *
> + * Copyright (c) 2010 Barry Song
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
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
> + =C2=A0 =C2=A0 =C2=A0 u16 _lower =3D lower;
> + =C2=A0 =C2=A0 =C2=A0 u16 _upper =3D upper;
> + =C2=A0 =C2=A0 =C2=A0 return _lower | (_upper << 8);
> +}
> +
> +static void iio_common_ring_poll_func_th(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_state *st =3D iio_dev_get_devdata(indio=
_dev);
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
> + =C2=A0 =C2=A0 =C2=A0 schedule_work(&st->work_trigger_to_ring);
> +}
> +
> +static void iio_common_trigger_bh_to_ring(struct work_struct *work_s)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_state *st
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D container_of(work_=
s, struct iio_state,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 work_trigger_to_ring);
> +
> + =C2=A0 =C2=A0 =C2=A0 int i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 s16 *data;
> + =C2=A0 =C2=A0 =C2=A0 size_t datasize =3D st->indio_dev
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ring->access.get_bpd=
(st->indio_dev->ring);
> +
> + =C2=A0 =C2=A0 =C2=A0 data =3D kmalloc(datasize , GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(st->pare=
nt_dev, "memory alloc failed in ring bh");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev->scan_count)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (st->hw_read_ring(s=
t, st->rx) >=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1=
],
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 st->rx[i*2]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Guaranteed to be aligned with 8 byte boun=
dary */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->scan_timestamp)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*((s64 *)(data +=
 ((i + 3)/4)*4)) =3D st->last_timestamp;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0st->indio_dev->ring->access.store_to(st->ind=
io_dev->ring,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(u8 *)data,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0st->last_timestamp);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_trigger_notify_done(st->indio_dev->trig)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(data);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> +}
> +
> +static int iio_common_ring_preenable(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 size_t size;
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
> + =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, i=
f not fail*/
> + =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_tim=
estamp))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_ti=
mestamp)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (indio_dev->scan_count)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timestamp (aligned to s64) and data *=
/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (((indio_dev->scan_count * size=
of(s16))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64) - 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 & ~(sizeof(s64) - 1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeof(s64=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else /* Timestamp only =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->acces=
s.set_bpd(indio_dev->ring, size);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int iio_common_ring_postenable(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return indio_dev->trig
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? iio_trigger_at=
tach_poll_func(indio_dev->trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0;
> +}
> +
> +static int iio_common_ring_predisable(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return indio_dev->trig
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? iio_trigger_de=
ttach_poll_func(indio_dev->trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->pollfunc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0;
> +}
> +
> +int iio_configure_common_ring(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_state *st =3D indio_dev->dev_data;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_ring_buffer *ring;
> + =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&st->work_trigger_to_ring, iio_common_tr=
igger_bh_to_ring);
> +
> + =C2=A0 =C2=A0 =C2=A0 ring =3D iio_sw_rb_allocate(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 if (!ring) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->ring =3D ring;
> +
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_sw_register_funcs(&ring->access);
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &iio_common_ring_preenable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &iio_common_ring_postenable;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &iio_common_ring_predisable;
> + =C2=A0 =C2=A0 =C2=A0 ring->owner =3D THIS_MODULE;
> +
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev-=
>pollfunc), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_f=
ree;;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &iio_commo=
n_ring_poll_func_th;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +error_iio_sw_rb_free:
> + =C2=A0 =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +EXPORT_SYMBOL(iio_configure_common_ring);
> +
> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 kfree(indio_dev->pollfunc);
> + =C2=A0 =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
> +}
> +EXPORT_SYMBOL(iio_unconfigure_common_ring);
> +
> +int iio_initialize_common_ring(struct iio_ring_buffer *ring)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> +}
> +EXPORT_SYMBOL(iio_initialize_common_ring);
> +
> +void iio_uninitialize_common_ring(struct iio_ring_buffer *ring)
> +{
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> +}
> +EXPORT_SYMBOL(iio_uninitialize_common_ring);
> +
> +static int iio_common_trigger_poll(struct iio_dev *dev_info,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int index,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s64 timestamp=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int no_test)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_state *st =3D iio_dev_get_devdata(dev_i=
nfo);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_trigger *trig =3D st->trig;
> +
> + =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> +
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}
> +
> +IIO_EVENT_SH(common_trig, &iio_common_trigger_poll);
> +
> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> +
> +static struct attribute *iio_trigger_attrs[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 &dev_attr_name.attr,
> + =C2=A0 =C2=A0 =C2=A0 NULL,
> +};
> +
> +static const struct attribute_group iio_trigger_attr_group =3D {
> + =C2=A0 =C2=A0 =C2=A0 .attrs =3D iio_trigger_attrs,
> +};
> +
> +static int iio_common_trigger_try_reen(struct iio_trigger *trig)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_state *st =3D trig->private_data;
> + =C2=A0 =C2=A0 =C2=A0 enable_irq(st->irq);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int iio_common_trigger_set_state(struct iio_trigger *trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool state)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_state *st =3D trig->private_data;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, st=
ate);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D st->set_irq(st, state);
> + =C2=A0 =C2=A0 =C2=A0 if (state =3D=3D false) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_remove_event_from_=
list(&iio_event_common_trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &indio_dev->interrupts[0]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ev_list);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_scheduled_work()=
;
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_add_event_to_list(=
&iio_event_common_trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &indio_dev->interrupts[0]->ev_list);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +int iio_probe_common_trigger(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_state *st =3D indio_dev->dev_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 st->trig =3D iio_allocate_trigger();
> + =C2=A0 =C2=A0 =C2=A0 st->trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH=
, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!st->trig->name) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_trig;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 snprintf((char *)st->trig->name,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 IIO_TRIGGER_NAME_LENGTH,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "iio-dev%d", indio_dev->id);
> + =C2=A0 =C2=A0 =C2=A0 st->trig->dev.parent =3D st->parent_dev;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->owner =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->private_data =3D st;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->set_trigger_state =3D &iio_common_trigge=
r_set_state;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->try_reenable =3D &iio_common_trigger_try=
_reen;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->control_attrs =3D &iio_trigger_attr_grou=
p;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_trigger_register(st->trig);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* select default trigger */
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->trig =3D st->trig;
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_trig_n=
ame;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +error_free_trig_name:
> + =C2=A0 =C2=A0 =C2=A0 kfree(st->trig->name);
> +error_free_trig:
> + =C2=A0 =C2=A0 =C2=A0 iio_free_trigger(st->trig);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +EXPORT_SYMBOL(iio_probe_common_trigger);
> +
> +void iio_remove_common_trigger(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_state *state =3D indio_dev->dev_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_unregister(state->trig);
> + =C2=A0 =C2=A0 =C2=A0 kfree(state->trig->name);
> + =C2=A0 =C2=A0 =C2=A0 iio_free_trigger(state->trig);
> +}
> +EXPORT_SYMBOL(iio_remove_common_trigger);
> Index: drivers/staging/iio/common-ring-trigger.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/common-ring-trigger.h =C2=A0 (revision 0)
> +++ drivers/staging/iio/common-ring-trigger.h =C2=A0 (revision 0)
> @@ -0,0 +1,24 @@
> +/* The industrial I/O frequently used ring with trigger
> + *
> + * Copyright (c) 2010 Barry Song
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
> + *
> + */
> +
> +#ifndef _IIO_COMMON_RING_TRIGGER_H_
> +#define _IIO_COMMON_RING_TRIGGER_H_
> +
> +#include "iio.h"
> +#include "ring_generic.h"
> +
> +int iio_configure_common_ring(struct iio_dev *indio_dev);
> +void iio_unconfigure_common_ring(struct iio_dev *indio_dev);
> +int iio_initialize_common_ring(struct iio_ring_buffer *ring);
> +void iio_uninitialize_common_ring(struct iio_ring_buffer *ring);
> +
> +int iio_probe_common_trigger(struct iio_dev *indio_dev);
> +void iio_remove_common_trigger(struct iio_dev *indio_dev);
> +#endif /* _IIO_COMMON_RING_TRIGGER_H_ */
> Index: drivers/staging/iio/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/Kconfig (revision 8893)
> +++ drivers/staging/iio/Kconfig (working copy)
> @@ -38,6 +38,12 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring buffers. =C2=A0The triggers are ef=
fectively a 'capture
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data now' interrupt.
>
> +config IIO_COMMON_RING_TRIGGER
> + =C2=A0 =C2=A0 =C2=A0 boolean "Enable frequently used ring with trigger"
> + =C2=A0 =C2=A0 =C2=A0 depends on IIO_SW_RING && IIO_TRIGGER
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Provides a generic ring with trigger. I can=
 be used by most
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 IIO devices.
>
> =C2=A0source "drivers/staging/iio/accel/Kconfig"
> =C2=A0source "drivers/staging/iio/adc/Kconfig"
> Index: drivers/staging/iio/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0(revision 889=
3)
> +++ drivers/staging/iio/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0(working copy=
)
> @@ -9,6 +9,8 @@
>
> =C2=A0obj-$(CONFIG_IIO_SW_RING) +=3D ring_sw.o
>
> +obj-$(CONFIG_IIO_COMMON_RING_TRIGGER) +=3D common-ring-trigger.o
> +
> =C2=A0obj-y +=3D accel/
> =C2=A0obj-y +=3D adc/
> =C2=A0obj-y +=3D addac/
>
>
>
> On Wed, Jun 2, 2010 at 9:21 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> On 06/02/10 09:01, Barry Song wrote:
>>> On Mon, Feb 22, 2010 at 7:16 PM, Jonathan Cameron <jic23@cam.ac.uk> wro=
te:
>>>> Hi All,
>>>>
>>>> Just for reference as I'll be doing a proper announcement later.
>>>> We now have linux-iio@vger.kernel.org as a mailing list for the projec=
t.
>>>> Unless others have tracked it down it currently only has me as a membe=
r
>>>> though and I'm waiting for confirmation from marc.info of an archive.
>>>>
>>>>> Hi Jonathan,
>>>>> Now users depend on iio ring events(IIO_EVENT_CODE_RING_50/75/100_FUL=
L)
>>>>> to read data:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_size =3D=
 fread(&dat, 1, sizeof(struct
>>>>> iio_event_data),
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp_ev);
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (dat.i=
d) {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVEN=
T_CODE_RING_100_FULL:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 toread =3D RingLength;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 break;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVEN=
T_CODE_RING_75_FULL:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 toread =3D RingLength*3/4;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 break;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVEN=
T_CODE_RING_50_FULL:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 toread =3D RingLength/2;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 break;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 printf("Unexpecteded event code\n");
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 continue;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_size =3D=
 read(fp,
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data,
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0toread*size_from_scanmode(=
NumVals,
>>>>> scan_ts));
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (read_size=
 =3D=3D -EAGAIN) {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 printf("nothing available \n");
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 continue;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>> And iio ring access node doesn't support blocking io too. =C2=A0It se=
ems we
>>>>> lost to let users read data once ring is not empty. And some users ma=
ybe
>>>>> not care about iio ring events at all, but just want to read data lik=
e a
>>>>> input or audio driver. So how about adding the following support in i=
io
>>>>> ring:
>>>>> 1. add NOT EMPTY event in IIO event nodes
>>>> Not keen. =C2=A0It might lead to a storm of events (at least it might =
in a
>>>> cleverer ring buffer implementation or during a blocking read). =C2=A0=
Actually
>>>> in this particular case it probably wouldn't do any harm.
>>>>> 2. add blocking io support in read function of IIO access nodes
>>>> That I agree would be a good idea. =C2=A0If we support poll/select on =
the buffer access
>>>> chrdev then we will get the same effect per having a not empty event a=
nd cleaner
>>>> semantics for anyone not interested in the other events. Not to mentio=
n I expect
>>>> we will soon have alternative ring buffer implementations that don't s=
upply any
>>>> events at all and hence don't event have the relevant chrdev.
>>>>
>>>> As things are, you can quite happily read whenever you like. =C2=A0Now=
 you mention it,
>>>> that example code is somewhat missleading! The issue with
>>>> this ring buffer implementation is the handling of a true blocking rea=
d is complex
>>>> as at any given time you aren't guaranteed to get what you asked for e=
ven if it was
>>>> there when you started the read. It should be possible to work around =
that though.
>>>>
>>>> It's possible this functionality might be better added to an alternati=
ve ring buffer
>>>> implementation. Be vary wary of that ring implementation in general! I=
 am and I wrote it.
>>>>> If you agree with that, I can begin to add these and send you a patch=
.
>>>>> And a problem I don't know is what you and other people have changed =
to
>>>>> Greg's staging tree, and I am not sure what tree the patch should be
>>>>> againest.
>>>> Nothing has changed in this region of the code. =C2=A0In fact I think =
all that
>>>> has gone into Greg's tree is a clean up patch form Mark Brown making a=
 few
>>>> functions static. Right now I'm still getting the max1363 driver into
>>>> a state where it will be possible to do the ABI changes.
>>>>>
>>>>> For long term plan, is it possible for ring common level to handle mo=
re
>>>>> common work to avoid code repeating in different drivers?
>>>> I'm certainly happy for that to be the case if it becomes apparent whi=
ch functionality
>>>> is shared. =C2=A0I haven't seen any substantial cases as yet, but then=
 I may well be missing
>>>> things so feel free to submit suggestions (or as ever the better optio=
n of patches).
>>>
>>> Now we have many drivers using SW ring with same
>>> preenable(),postenable(),predisable(),
>>> initialize_ring(),uninitialize_ring(),poll_func(),probe_trigger(),
>>> remove_trigger(). Can we move them to IIO common layer as a base class
>>> methods. And the derived class can overload them if they have special
>>> implement? Most devices just use the common layer and don't need to
>>> copy codes.
>> Sounds sensible. Please propose a patch.
>>
>> Jonathan
>>
>
