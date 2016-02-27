Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: gregor.boirie@parrot.com,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH] iio:trigger: Experimental kthread tight loop trigger (thread only)
Date: Sat, 27 Feb 2016 12:05:54 +0000
Message-Id: <1456574754-23387-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1456574754-23387-1-git-send-email-jic23@kernel.org>
References: <1456574754-23387-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This patch is in response to that of
Gregor Boirie <gregor.boirie@parrot.com>
who proposed using a tight kthread within a device driver (be it with the
support factored out into a helper library) in order to basically spin as
fast as possible.

It is meant as a talking point rather than a formal proposal of the code.
Also gives people some working code to mess around with.

I proposed that this could be done with a trigger with a few constraints
and this is the proof (be it ugly) of that.

There are some constraints though, some of which we would want to relax
if this were to move forward.

* Will only run the thread part of the registered pollfunc.  This is to
  avoid the overhead of jumping in and out of interrupt context.  Is the
  overhead significant?  Not certain but feels like it should be!

* This limitation precludes any device that 'must' do some work in
  interrupt context.  However, that is true of few if any drivers and
  I suspect that any that do will be restricted to using triggers they
  provide themselves.  Usually we have a top half mainly to grab a
  timestamp as soon after the dataready type signal as possible.

Anyhow, I'm not signing this as even if we go with the approach there are
some hideous corners.

Not-Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/trigger/Kconfig         |   5 +
 drivers/iio/trigger/Makefile        |   1 +
 drivers/iio/trigger/iio-trig-loop.c | 245 ++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)

diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index 519e6772f6f5..bc6e2ec67a75 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -5,6 +5,11 @@
 
 menu "Triggers - standalone"
 
+config IIO_TIGHTLOOP_TRIGGER
+	tristate "A kthread based hammering loop trigger"
+	help
+	  A horrible bodge as an experiment.
+
 config IIO_HRTIMER_TRIGGER
 	tristate "High resolution timer trigger"
 	depends on IIO_SW_TRIGGER
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index fe06eb564367..aab4dc23303d 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
 obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
+obj-$(CONFIG_IIO_TIGHTLOOP_TRIGGER) += iio-trig-loop.o
diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
new file mode 100644
index 000000000000..deeea23df8aa
--- /dev/null
+++ b/drivers/iio/trigger/iio-trig-loop.c
@@ -0,0 +1,245 @@
+/*
+ * Copyright 2016 Jonathan Cameron <jic23@kernel.org>
+ *
+ * Licensed under the GPL-2.
+ *
+ * Based on a mashup of the sysfs trigger of 
+ * "Michael Hennerich <hennerich@blackfin.uclinux.org>"
+ * and continuous sampling proposal of
+ * Gregor Boirie <gregor.boirie@parrot.com>
+ *
+ * Not this is uggly and may eat babies.
+ * 
+ * Todo
+ * * configfs interface rather than sysfs creation - right now configfs
+ *   is broken on my dev platform (which is rather aged and not much used
+ *   so I need to chase that down)
+ * * Protect against connection of devices that 'need' the top half
+ *   handler.
+ * * Work out how to run top half handlers in this context if it is
+ *   safe to do so (timestamp grabbing for example)
+ *
+ * Tested against a max1363. Used about 33% cpu for the thread and 20%
+ * for generic_buffer piping to /dev/null. Watermark set at 64 on a 128
+ * element kfifo buffer.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/irq_work.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+struct iio_loop_trig {
+	struct iio_trigger *trig;
+	struct task_struct *task;
+	int id;
+	struct list_head l;
+};
+
+static LIST_HEAD(iio_loop_trig_list);
+static DEFINE_MUTEX(iio_loop_trig_list_mut);
+
+static int iio_loop_trigger_probe(int id);
+static ssize_t iio_loop_trig_add(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
+{
+	int ret;
+	unsigned long input;
+
+	ret = kstrtoul(buf, 10, &input);
+	if (ret)
+		return ret;
+	ret = iio_loop_trigger_probe(input);
+	if (ret)
+		return ret;
+	return len;
+}
+static DEVICE_ATTR(add_trigger, S_IWUSR, NULL, &iio_loop_trig_add);
+
+static int iio_loop_trigger_remove(int id);
+static ssize_t iio_loop_trig_remove(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t len)
+{
+	int ret;
+	unsigned long input;
+
+	ret = kstrtoul(buf, 10, &input);
+	if (ret)
+		return ret;
+	ret = iio_loop_trigger_remove(input);
+	if (ret)
+		return ret;
+	return len;
+}
+
+static DEVICE_ATTR(remove_trigger, S_IWUSR, NULL, &iio_loop_trig_remove);
+
+static struct attribute *iio_loop_trig_attrs[] = {
+	&dev_attr_add_trigger.attr,
+	&dev_attr_remove_trigger.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_loop_trig_group = {
+	.attrs = iio_loop_trig_attrs,
+};
+
+static const struct attribute_group *iio_loop_trig_groups[] = {
+	&iio_loop_trig_group,
+	NULL
+};
+
+/* Nothing to actually do upon release */
+static void iio_trigger_loop_release(struct device *dev)
+{
+}
+
+static struct device iio_loop_trig_dev = {
+	.bus = &iio_bus_type,
+	.groups = iio_loop_trig_groups,
+	.release = &iio_trigger_loop_release,
+};
+
+static int iio_loop_thread(void *data)
+{
+	struct iio_trigger *trig = data;
+
+	set_freezable();
+
+	do {
+		iio_trigger_poll_chained(trig);
+	} while (likely(!kthread_freezable_should_stop(NULL)));
+
+	return 0;
+}
+
+static int iio_loop_trigger_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_loop_trig *loop_trig = iio_trigger_get_drvdata(trig);
+
+	if (state) {
+		loop_trig->task = kthread_run(iio_loop_thread, trig, trig->name);
+		if (unlikely(IS_ERR(loop_trig->task))) {
+			dev_err(&trig->dev,
+				"failed to create trigger loop thread\n");
+			return PTR_ERR(loop_trig->task);
+		}	
+	} else {
+		kthread_stop(loop_trig->task);
+	}
+	
+	return 0;
+}
+
+static const struct iio_trigger_ops iio_loop_trigger_ops = {
+	.set_trigger_state = iio_loop_trigger_set_state,
+	.owner = THIS_MODULE,
+};
+
+static int iio_loop_trigger_probe(int id)
+{
+	struct iio_loop_trig *t;
+	int ret;
+	bool foundit = false;
+
+	mutex_lock(&iio_loop_trig_list_mut);
+	list_for_each_entry(t, &iio_loop_trig_list, l)
+		if (id == t->id) {
+			foundit = true;
+			break;
+		}
+	if (foundit) {
+		ret = -EINVAL;
+		goto out1;
+	}
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (t == NULL) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+	t->id = id;
+	t->trig = iio_trigger_alloc("looptrig%d", id);
+	if (!t->trig) {
+		ret = -ENOMEM;
+		goto free_t;
+	}
+
+	t->trig->ops = &iio_loop_trigger_ops;
+	t->trig->dev.parent = &iio_loop_trig_dev;
+	iio_trigger_set_drvdata(t->trig, t);
+
+	ret = iio_trigger_register(t->trig);
+	if (ret)
+		goto out2;
+	list_add(&t->l, &iio_loop_trig_list);
+	__module_get(THIS_MODULE);
+	mutex_unlock(&iio_loop_trig_list_mut);
+	
+
+	return 0;
+
+out2:
+	iio_trigger_put(t->trig);
+free_t:
+	kfree(t);
+out1:
+	mutex_unlock(&iio_loop_trig_list_mut);
+	return ret;
+}
+
+static int iio_loop_trigger_remove(int id)
+{
+	bool foundit = false;
+	struct iio_loop_trig *t;
+
+	mutex_lock(&iio_loop_trig_list_mut);
+	list_for_each_entry(t, &iio_loop_trig_list, l)
+		if (id == t->id) {
+			foundit = true;
+			break;
+		}
+	if (!foundit) {
+		mutex_unlock(&iio_loop_trig_list_mut);
+		return -EINVAL;
+	}
+
+	iio_trigger_unregister(t->trig);
+	iio_trigger_free(t->trig);
+
+	list_del(&t->l);
+	kfree(t);
+	module_put(THIS_MODULE);
+	mutex_unlock(&iio_loop_trig_list_mut);
+
+	return 0;
+}
+
+static int __init iio_loop_trig_init(void)
+{
+	device_initialize(&iio_loop_trig_dev);
+	dev_set_name(&iio_loop_trig_dev, "iio_loop_trigger");
+	return device_add(&iio_loop_trig_dev);
+}
+module_init(iio_loop_trig_init);
+
+static void __exit iio_loop_trig_exit(void)
+{
+	device_unregister(&iio_loop_trig_dev);
+}
+module_exit(iio_loop_trig_exit);
+
+MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
+MODULE_DESCRIPTION("Loop based trigger for the iio subsystem");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:iio-trig-loop");
-- 
2.7.1
