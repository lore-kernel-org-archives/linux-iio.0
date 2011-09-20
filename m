Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	jonathan.kunkee@gmail.com,
	michael.hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:dummy Add event support + fake event generator
Date: Tue, 20 Sep 2011 16:58:32 +0100
Message-Id: <1316534313-20212-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316534313-20212-1-git-send-email-jic23@cam.ac.uk>
References: <1316534313-20212-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The event generator is not very pretty but does the job and
allows this driver to look a lot more like a normal driver
than it otherwise would.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig                   |   20 ++-
 drivers/staging/iio/Makefile                  |    6 +-
 drivers/staging/iio/iio_core.h                |    6 +-
 drivers/staging/iio/iio_dummy_evgen.c         |  217 +++++++++++++++++++++++++
 drivers/staging/iio/iio_dummy_evgen.h         |    2 +
 drivers/staging/iio/iio_simple_dummy.c        |   50 ++++---
 drivers/staging/iio/iio_simple_dummy.h        |   81 +++++++++
 drivers/staging/iio/iio_simple_dummy_events.c |  190 ++++++++++++++++++++++
 8 files changed, 543 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 0accc21..75128a0 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -70,12 +70,26 @@ source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
 source "drivers/staging/iio/trigger/Kconfig"
 
+config IIO_DUMMY_EVGEN
+       tristate
+
 config IIO_SIMPLE_DUMMY
        tristate "An example driver with no hardware requirements"
+       select IIO_SIMPLE_DUMMY_EVGEN if IIO_SIMPLE_DUMMY_EVENTS
        help
-	Driver intended mainly as documentation for how to write
-	a driver. May also be useful for testing userspace code
-	without hardward.
+	 Driver intended mainly as documentation for how to write
+	 a driver. May also be useful for testing userspace code
+	 without hardward.
+
+if IIO_SIMPLE_DUMMY
+
+config IIO_SIMPLE_DUMMY_EVENTS
+       boolean "Event generation support"
+       select IIO_DUMMY_EVGEN
+       help
+         Add some dummy events to the simple dummy driver.
+
 
+endif # IIO_SIMPLE_DUMMY
 
 endif # IIO
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 014d8f1..75aacfd 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -10,7 +10,11 @@ industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
 obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 
-obj-$(CONFIG_IIO_SIMPLE_DUMMY) += iio_simple_dummy.o
+obj-$(CONFIG_IIO_SIMPLE_DUMMY) += iio_dummy.o
+iio_dummy-y := iio_simple_dummy.o
+iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_EVENTS) += iio_simple_dummy_events.o
+
+obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
 
 obj-y += accel/
 obj-y += adc/
diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index dde9e3e..0743f39 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -33,7 +33,7 @@ int __iio_add_chan_devattr(const char *postfix,
 #ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
 
-void iio_chrdev_buffer_open(struct iio_dev *indio_dev);
+int iio_chrdev_buffer_open(struct iio_dev *indio_dev);
 void iio_chrdev_buffer_release(struct iio_dev *indio_dev);
 
 unsigned int iio_buffer_poll(struct file *filp,
@@ -47,8 +47,8 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 
 #else
 
-static inline void iio_chrdev_buffer_open(struct iio_dev *indio_dev)
-{}
+static inline int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
+{ return -EINVAL; }
 static inline void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 {}
 
diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
new file mode 100644
index 0000000..da657d1
--- /dev/null
+++ b/drivers/staging/iio/iio_dummy_evgen.c
@@ -0,0 +1,217 @@
+/**
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Companion module to the iio simple dummy example driver.
+ * The purpose of this is to generate 'fake' event interrupts thus
+ * allowing that driver's code to be as close as possible to that of
+ * a normal driver talking to hardware.  The approach used here
+ * is not intended to be general and just happens to work for this
+ * particular use case.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+
+#include "iio_dummy_evgen.h"
+#include "iio.h"
+#include "sysfs.h"
+
+/* Fiddly bit of faking and irq without hardware */
+#define IIO_EVENTGEN_NO 10
+/**
+ * struct iio_dummy_evgen - evgen state
+ * @chip: irq chip we are faking
+ * @base: base of irq range
+ * @enabled: mask of which irqs are enabled
+ * @inuse: mask of which irqs actually have anyone connected
+ * @lock: protect the evgen state
+ */
+struct iio_dummy_eventgen {
+	struct irq_chip chip;
+	int base;
+	bool enabled[IIO_EVENTGEN_NO];
+	bool inuse[IIO_EVENTGEN_NO];
+	struct mutex lock;
+};
+
+/* We can only ever have one instance of this 'device' */
+static struct iio_dummy_eventgen *iio_evgen;
+static const char *iio_evgen_name = "iio_dummy_evgen";
+
+static void iio_dummy_event_irqmask(struct irq_data *d)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+	struct iio_dummy_eventgen *evgen =
+		container_of(chip, struct iio_dummy_eventgen, chip);
+
+	evgen->enabled[d->irq - evgen->base] = false;
+}
+
+static void iio_dummy_event_irqunmask(struct irq_data *d)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+	struct iio_dummy_eventgen *evgen =
+		container_of(chip, struct iio_dummy_eventgen, chip);
+
+	evgen->enabled[d->irq - evgen->base] = true;
+}
+
+static int iio_dummy_evgen_create(void)
+{
+	int ret, i;
+
+	iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
+	if (iio_evgen == NULL)
+		return -ENOMEM;
+
+	iio_evgen->base = irq_alloc_descs(-1, 0, IIO_EVENTGEN_NO, 0);
+	if (iio_evgen->base < 0) {
+		ret = iio_evgen->base;
+		kfree(iio_evgen);
+		return ret;
+	}
+	iio_evgen->chip.name = iio_evgen_name;
+	iio_evgen->chip.irq_mask = &iio_dummy_event_irqmask;
+	iio_evgen->chip.irq_unmask = &iio_dummy_event_irqunmask;
+	for (i = 0; i < IIO_EVENTGEN_NO; i++) {
+		irq_set_chip(iio_evgen->base + i, &iio_evgen->chip);
+		irq_set_handler(iio_evgen->base + i, &handle_simple_irq);
+		irq_modify_status(iio_evgen->base + i,
+				  IRQ_NOREQUEST | IRQ_NOAUTOEN,
+				  IRQ_NOPROBE);
+	}
+	mutex_init(&iio_evgen->lock);
+	return 0;
+}
+
+/**
+ * iio_dummy_evgen_get_irq() - get an evgen provided irq for a device
+ *
+ * This function will give a free allocated irq to a client device.
+ * That irq can then be caused to 'fire' by using the associated sysfs file.
+ */
+int iio_dummy_evgen_get_irq(void)
+{
+	int i, ret = 0;
+	mutex_lock(&iio_evgen->lock);
+	for (i = 0; i < IIO_EVENTGEN_NO; i++)
+		if (iio_evgen->inuse[i] == false) {
+			ret = iio_evgen->base + i;
+			iio_evgen->inuse[i] = true;
+			break;
+		}
+	mutex_unlock(&iio_evgen->lock);
+	if (i == IIO_EVENTGEN_NO)
+		return -ENOMEM;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_irq);
+
+/**
+ * iio_dummy_evgen_release_irq() - give the irq back.
+ * @irq: irq being returned to the pool
+ *
+ * Used by client driver instances to give the irqs back when they disconnect
+ */
+int iio_dummy_evgen_release_irq(int irq)
+{
+	mutex_lock(&iio_evgen->lock);
+	iio_evgen->inuse[irq - iio_evgen->base] = false;
+	mutex_unlock(&iio_evgen->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_dummy_evgen_release_irq);
+
+static void iio_dummy_evgen_free(void)
+{
+	irq_free_descs(iio_evgen->base, IIO_EVENTGEN_NO);
+	kfree(iio_evgen);
+}
+
+static void iio_evgen_release(struct device *dev)
+{
+	iio_dummy_evgen_free();
+}
+
+static ssize_t iio_evgen_poke(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	if (iio_evgen->enabled[this_attr->address])
+		handle_nested_irq(iio_evgen->base + this_attr->address);
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(poke_ev0, S_IWUSR, NULL, &iio_evgen_poke, 0);
+static IIO_DEVICE_ATTR(poke_ev1, S_IWUSR, NULL, &iio_evgen_poke, 1);
+static IIO_DEVICE_ATTR(poke_ev2, S_IWUSR, NULL, &iio_evgen_poke, 2);
+static IIO_DEVICE_ATTR(poke_ev3, S_IWUSR, NULL, &iio_evgen_poke, 3);
+static IIO_DEVICE_ATTR(poke_ev4, S_IWUSR, NULL, &iio_evgen_poke, 4);
+static IIO_DEVICE_ATTR(poke_ev5, S_IWUSR, NULL, &iio_evgen_poke, 5);
+static IIO_DEVICE_ATTR(poke_ev6, S_IWUSR, NULL, &iio_evgen_poke, 6);
+static IIO_DEVICE_ATTR(poke_ev7, S_IWUSR, NULL, &iio_evgen_poke, 7);
+static IIO_DEVICE_ATTR(poke_ev8, S_IWUSR, NULL, &iio_evgen_poke, 8);
+static IIO_DEVICE_ATTR(poke_ev9, S_IWUSR, NULL, &iio_evgen_poke, 9);
+
+static struct attribute *iio_evgen_attrs[] = {
+	&iio_dev_attr_poke_ev0.dev_attr.attr,
+	&iio_dev_attr_poke_ev1.dev_attr.attr,
+	&iio_dev_attr_poke_ev2.dev_attr.attr,
+	&iio_dev_attr_poke_ev3.dev_attr.attr,
+	&iio_dev_attr_poke_ev4.dev_attr.attr,
+	&iio_dev_attr_poke_ev5.dev_attr.attr,
+	&iio_dev_attr_poke_ev6.dev_attr.attr,
+	&iio_dev_attr_poke_ev7.dev_attr.attr,
+	&iio_dev_attr_poke_ev8.dev_attr.attr,
+	&iio_dev_attr_poke_ev9.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_evgen_group = {
+	.attrs = iio_evgen_attrs,
+};
+
+static const struct attribute_group *iio_evgen_groups[] = {
+	&iio_evgen_group,
+	NULL
+};
+
+static struct device iio_evgen_dev = {
+	.bus = &iio_bus_type,
+	.groups = iio_evgen_groups,
+	.release = &iio_evgen_release,
+};
+static __init int iio_dummy_evgen_init(void)
+{
+	int ret = iio_dummy_evgen_create();
+	if (ret < 0)
+		return ret;
+	device_initialize(&iio_evgen_dev);
+	dev_set_name(&iio_evgen_dev, "iio_evgen");
+	return device_add(&iio_evgen_dev);
+}
+module_init(iio_dummy_evgen_init);
+
+static __exit void iio_dummy_evgen_exit(void)
+{
+	device_unregister(&iio_evgen_dev);
+}
+module_exit(iio_dummy_evgen_exit);
+
+MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
+MODULE_DESCRIPTION("IIO dummy driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/iio_dummy_evgen.h b/drivers/staging/iio/iio_dummy_evgen.h
new file mode 100644
index 0000000..d8845e2
--- /dev/null
+++ b/drivers/staging/iio/iio_dummy_evgen.h
@@ -0,0 +1,2 @@
+int iio_dummy_evgen_get_irq(void);
+int iio_dummy_evgen_release_irq(int irq);
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 463043e..d16c6a8 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -20,6 +20,8 @@
 #include <linux/moduleparam.h>
 
 #include "iio.h"
+#include "sysfs.h"
+#include "iio_simple_dummy.h"
 
 /*
  * A few elements needed to fake a bus for this driver
@@ -53,26 +55,6 @@ static const struct iio_dummy_accel_calibscale dummy_scales[] = {
 	{ 733, 13, 0x9 }, /* 733.00013 */
 };
 
-/**
- * struct iio_dummy_state - device instance specific state.
- * @dac_val:			cache for dac value
- * @single_ended_adc_val:	cache for single ended adc value
- * @differential_adc_val:	cache for differential adc value
- * @accel_val:			cache for acceleration value
- * @accel_calibbias:		cache for acceleration calibbias
- * @accel_calibscale:		cache for acceleration calibscale
- * @lock:			lock to ensure state is consistent
- */
-struct iio_dummy_state {
-	int dac_val;
-	int single_ended_adc_val;
-	int differential_adc_val[2];
-	int accel_val;
-	int accel_calibbias;
-	const struct iio_dummy_accel_calibscale *accel_calibscale;
-	struct mutex lock;
-};
-
 /*
  * iio_dummy_channels - Description of available channels
  *
@@ -101,6 +83,14 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		 */
 		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 
+#ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
+		/*
+		 * simple event - triggered when value rises above
+		 * a threshold
+		 */
+		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH,
+					 IIO_EV_DIR_RISING),
+#endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
 	},
 	/* Differential ADC channel in_voltage1-voltage2_raw etc*/
 	{
@@ -296,6 +286,12 @@ static const struct iio_info iio_dummy_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &iio_dummy_read_raw,
 	.write_raw = &iio_dummy_write_raw,
+#ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
+	.read_event_config = &iio_simple_dummy_read_event_config,
+	.write_event_config = &iio_simple_dummy_write_event_config,
+	.read_event_value = &iio_simple_dummy_read_event_value,
+	.write_event_value = &iio_simple_dummy_write_event_value,
+#endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
 };
 
 /**
@@ -392,11 +388,16 @@ static int __devinit iio_dummy_probe(int index)
 	/* Specify that device provides sysfs type interfaces */
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	ret = iio_simple_dummy_events_register(indio_dev);
 	if (ret < 0)
 		goto error_free_device;
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_unregister_events;
 
 	return 0;
+error_unregister_events:
+	iio_simple_dummy_events_unregister(indio_dev);
 error_free_device:
 	/* Note free device should only be called, before registration
 	 * has succeeded. */
@@ -413,6 +414,7 @@ error_ret:
  */
 static int iio_dummy_remove(int index)
 {
+	int ret;
 	/*
 	 * Get a pointer to the device instance iio_dev structure
 	 * from the bus subsystem. E.g.
@@ -423,10 +425,14 @@ static int iio_dummy_remove(int index)
 
 	/* Device specific code to power down etc */
 
+	ret = iio_simple_dummy_events_unregister(indio_dev);
+	if (ret)
+		goto error_ret;
 	/* Unregister the device and free all structures */
 	iio_device_unregister(indio_dev);
 
-	return 0;
+error_ret:
+	return ret;
 }
 
 /**
diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
new file mode 100644
index 0000000..998fd1f
--- /dev/null
+++ b/drivers/staging/iio/iio_simple_dummy.h
@@ -0,0 +1,81 @@
+/**
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Join together the various functionality of iio_simple_dummy driver
+ */
+
+#include <linux/kernel.h>
+
+struct iio_dummy_accel_calibscale;
+
+/**
+ * struct iio_dummy_state - device instance specific state.
+ * @dac_val:			cache for dac value
+ * @single_ended_adc_val:	cache for single ended adc value
+ * @differential_adc_val:	cache for differential adc value
+ * @accel_val:			cache for acceleration value
+ * @accel_calibbias:		cache for acceleration calibbias
+ * @accel_calibscale:		cache for acceleration calibscale
+ * @lock:			lock to ensure state is consistent
+ * @event_irq:			irq number for event line (faked)
+ * @event_val:			cache for event theshold value
+ * @event_en:			cache of whether event is enabled
+ */
+struct iio_dummy_state {
+	int dac_val;
+	int single_ended_adc_val;
+	int differential_adc_val[2];
+	int accel_val;
+	int accel_calibbias;
+	const struct iio_dummy_accel_calibscale *accel_calibscale;
+	struct mutex lock;
+#ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
+	int event_irq;
+	int event_val;
+	bool event_en;
+#endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
+};
+
+#ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
+
+struct iio_dev;
+
+int iio_simple_dummy_read_event_config(struct iio_dev *indio_dev,
+				       u64 event_code);
+
+int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
+					u64 event_code,
+					int state);
+
+int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
+				      u64 event_code,
+				      int *val);
+
+int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
+				       u64 event_code,
+				       int val);
+
+int iio_simple_dummy_events_register(struct iio_dev *indio_dev);
+int iio_simple_dummy_events_unregister(struct iio_dev *indio_dev);
+
+#else /* Stubs for when events are disabled at compile time */
+
+static inline int
+iio_simple_dummy_events_register(struct iio_dev *indio_dev)
+{
+	return 0;
+};
+
+static inline int
+iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
+{
+	return 0;
+};
+
+#endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS*/
+
+
diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
new file mode 100644
index 0000000..9f00cff
--- /dev/null
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -0,0 +1,190 @@
+/**
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Event handling elements of industrial I/O reference driver.
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include "iio.h"
+#include "sysfs.h"
+#include "iio_simple_dummy.h"
+
+/* Evgen 'fakes' interrupt events for this example */
+#include "iio_dummy_evgen.h"
+
+/**
+ * iio_simple_dummy_read_event_config() - is event enabled?
+ * @indio_dev: the device instance data
+ * @event_code: event code of the event being queried
+ *
+ * This function would normally query the relevant registers or a cache to
+ * discover if the event generation is enabled on the device.
+ */
+int iio_simple_dummy_read_event_config(struct iio_dev *indio_dev,
+				       u64 event_code)
+{
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+
+	return st->event_en;
+}
+
+/**
+ * iio_simple_dummy_write_event_config() - set whether event is enabled
+ * @indio_dev: the device instance data
+ * @event_code: event code of event being enabled/disabled
+ * @state: whether to enable or disable the device.
+ *
+ * This function would normally set the relevant registers on the devices
+ * so that it generates the specified event. Here it just sets up a cached
+ * value.
+ */
+int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
+					u64 event_code,
+					int state)
+{
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+
+	/*
+	 *  Deliberately over the top code splitting to illustrate
+	 * how this is done when multiple events exist.
+	 */
+	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	case IIO_VOLTAGE:
+		switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+		case IIO_EV_TYPE_THRESH:
+			if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			    IIO_EV_DIR_RISING)
+				st->event_en = state;
+			else
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * iio_simple_dummy_read_event_value() - get value associated with event
+ * @indio_dev: device instance specific data
+ * @event_code: event code for the event whose value is being queried
+ * @val: value for the event code.
+ *
+ * Many devices provide a large set of events of which only a subset may
+ * be enabled at a time, with value registers whose meaning changes depending
+ * on the event enabled. This often means that the driver must cache the values
+ * associated with each possible events so that the right value is in place when
+ * the enabled event is changed.
+ */
+int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
+				      u64 event_code,
+				      int *val)
+{
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+
+	*val = st->event_val;
+
+	return 0;
+}
+
+/**
+ * iio_simple_dummy_write_event_value() - set value associate with event
+ * @indio_dev: device instance specific data
+ * @event_code: event code for the event whose value is being set
+ * @val: the value to be set.
+ */
+int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
+				       u64 event_code,
+				       int val)
+{
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+
+	st->event_val = val;
+
+	return 0;
+}
+
+/**
+ * iio_simple_dummy_event_handler() - identify and pass on event
+ * @irq: irq of event line
+ * @private: pointer to device instance state.
+ *
+ * This handler is responsible for querying the device to find out what
+ * event occured and for then pushing that event towards userspace.
+ * Here only one event occurs so we push that directly on with locally
+ * grabbed timestamp.
+ */
+static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	iio_push_event(indio_dev,
+		       IIO_EVENT_CODE(IIO_VOLTAGE, 0, 0,
+				      IIO_EV_DIR_RISING,
+				      IIO_EV_TYPE_THRESH, 0, 0, 0),
+		       iio_get_time_ns());
+	return IRQ_HANDLED;
+}
+
+/**
+ * iio_simple_dummy_events_register() - setup interrupt handling for events
+ * @indio_dev: device instance data
+ *
+ * This function requests the threaded interrupt to handle the events.
+ * Normally the irq is a hardware interrupt and the number comes
+ * from board configuration files.  Here we get it from a companion
+ * module that fakes the interrupt for us. Note that module in
+ * no way forms part of this example. Just assume that events magically
+ * appear via the provided interrupt.
+ */
+int iio_simple_dummy_events_register(struct iio_dev *indio_dev)
+{
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/* Fire up event source - normally not present */
+	st->event_irq = iio_dummy_evgen_get_irq();
+	if (st->event_irq < 0) {
+		ret = st->event_irq;
+		goto error_ret;
+	}
+	ret = request_threaded_irq(st->event_irq,
+				   NULL,
+				   &iio_simple_dummy_event_handler,
+				   IRQF_ONESHOT,
+				   "iio_simple_event",
+				   indio_dev);
+	if (ret < 0)
+		goto error_free_evgen;
+	return 0;
+
+error_free_evgen:
+	iio_dummy_evgen_release_irq(st->event_irq);
+error_ret:
+	return ret;
+}
+
+/**
+ * iio_simple_dummy_events_unregister() - tidy up interrupt handling on remove
+ * @indio_dev: device instance data
+ */
+int iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
+{
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+
+	free_irq(st->event_irq, indio_dev);
+	/* Not part of normal driver */
+	iio_dummy_evgen_release_irq(st->event_irq);
+
+	return 0;
+}
-- 
1.7.3.4
