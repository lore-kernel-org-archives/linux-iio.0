Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH] staging:iio:trigger sysfs userspace trigger rework.
Date: Sun,  3 Apr 2011 19:39:22 +0100
Message-Id: <1301855962-8478-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Awaiting comments on using the nested_irq trick so that will almost
certainly change!

Moves away from platform device to sysfs controlled creation and
removal of these triggers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---

This is an RFC because it may not apply on any published patch set
and will need to be broken up into various stages to be usable all
the way through my recent series.  If anyone really wants to play
with this give me a yell and I'll push the slightly messy tree
I am currently working with. (note only works for now with lis3l02dq
and max1363 drivers).

The conceptual changes are pretty obvious for review purposes though,
so please do take a look.  The userspace control of creation and
deletion is (I think) what both Greg and Arnd have asked for in the past.
It's a little more involved than platform devices, but a lot more
flexible.

 drivers/staging/iio/industrialio-trigger.c   |   13 ++
 drivers/staging/iio/trigger.h                |    1 +
 drivers/staging/iio/trigger/iio-trig-sysfs.c |  171 ++++++++++++++++++++------
 3 files changed, 150 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index cf7910e..c52807f 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -174,6 +174,19 @@ void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 }
 EXPORT_SYMBOL(iio_trigger_poll);
 
+void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time)
+{
+	int i;
+	if (!trig->use_count) {
+		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
+			if (trig->subirqs[i].enabled) {
+				trig->use_count++;
+				handle_nested_irq(trig->subirq_base + i);
+			}
+	}
+}
+EXPORT_SYMBOL(iio_trigger_poll_chained);
+
 void iio_trigger_notify_done(struct iio_trigger *trig)
 {
 	trig->use_count--;
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index f4a9b54..bf50927 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -121,6 +121,7 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
  * Typically called in relevant hardware interrupt handler.
  **/
 void iio_trigger_poll(struct iio_trigger *trig, s64 time);
+void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time);
 void iio_trigger_notify_done(struct iio_trigger *trig);
 
 static inline int iio_trigger_get_irq(struct iio_trigger *trig)
diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 127a2a3..5cd55ac 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -9,15 +9,84 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/list.h>
 
 #include "../iio.h"
 #include "../trigger.h"
 
+struct iio_sysfs_trig {
+	struct iio_trigger *trig;
+	int id;
+	struct list_head l;
+};
+
+static LIST_HEAD(iio_sysfs_trig_list);
+static DEFINE_MUTEX(iio_syfs_trig_list_mut);
+
+static int iio_sysfs_trigger_probe(int id);
+static ssize_t iio_sysfs_trig_add(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
+{
+	int ret;
+	unsigned long input;
+
+	ret = strict_strtoul(buf, 10, &input);
+	if (ret)
+		return ret;
+	ret = iio_sysfs_trigger_probe(input);
+	if (ret)
+		return ret;
+	return len;
+}
+static DEVICE_ATTR(add_trigger, S_IWUSR, NULL, &iio_sysfs_trig_add);
+
+static int iio_sysfs_trigger_remove(int id);
+static ssize_t iio_sysfs_trig_remove(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t len)
+{
+	int ret;
+	unsigned long input;
+
+	ret = strict_strtoul(buf, 10, &input);
+	if (ret)
+		return ret;
+	ret = iio_sysfs_trigger_remove(input);
+	if (ret)
+		return ret;
+	return len;
+}
+
+static DEVICE_ATTR(remove_trigger, S_IWUSR, NULL, &iio_sysfs_trig_remove);
+
+static struct attribute *iio_sysfs_trig_attrs[] = {
+	&dev_attr_add_trigger.attr,
+	&dev_attr_remove_trigger.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_sysfs_trig_group = {
+	.attrs = iio_sysfs_trig_attrs,
+};
+
+static const struct attribute_group *iio_sysfs_trig_groups[] = {
+	&iio_sysfs_trig_group,
+	NULL
+};
+
+static struct device iio_sysfs_trig_dev = {
+	.bus = &iio_bus_type,
+	.groups = iio_sysfs_trig_groups,
+};
+
 static ssize_t iio_sysfs_trigger_poll(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_trigger *trig = dev_get_drvdata(dev);
-	iio_trigger_poll(trig, 0);
+	iio_trigger_poll_chained(trig, 0);
 
 	return count;
 }
@@ -35,70 +104,102 @@ static const struct attribute_group iio_sysfs_trigger_attr_group = {
 	.attrs = iio_sysfs_trigger_attrs,
 };
 
-static int __devinit iio_sysfs_trigger_probe(struct platform_device *pdev)
+static int iio_sysfs_trigger_probe(int id)
 {
-	struct iio_trigger *trig;
+	struct iio_sysfs_trig *t;
 	int ret;
+	char *name;
+	bool foundit = false;
+	mutex_lock(&iio_syfs_trig_list_mut);
+	list_for_each_entry(t, &iio_sysfs_trig_list, l)
+		if (id == t->id) {
+			foundit = true;
+			break;
+		}
+	if (foundit) {
+		ret = -EINVAL;
+		goto out1;
+	}
 
-	trig = iio_allocate_trigger();
-	if (!trig) {
+	name = kasprintf(GFP_KERNEL, "sysfstrig%d", id);
+	if (name == NULL) {
 		ret = -ENOMEM;
 		goto out1;
 	}
-
-	trig->control_attrs = &iio_sysfs_trigger_attr_group;
-	trig->owner = THIS_MODULE;
-	trig->name = kasprintf(GFP_KERNEL, "sysfstrig%d", pdev->id);
-	if (trig->name == NULL) {
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (t == NULL) {
 		ret = -ENOMEM;
-		goto out2;
+		goto free_name;
+	}
+	t->id = id;
+	t->trig = iio_allocate_trigger_named(name);
+	if (!t->trig) {
+		kfree(name);
+		ret = -ENOMEM;
+		goto free_t;
 	}
 
-	ret = iio_trigger_register(trig);
-	if (ret)
-		goto out3;
-
-	platform_set_drvdata(pdev, trig);
+	t->trig->control_attrs = &iio_sysfs_trigger_attr_group;
+	t->trig->owner = THIS_MODULE;
+	t->trig->dev.parent = &iio_sysfs_trig_dev;
 
+	ret = iio_trigger_register(t->trig);
+	if (ret)
+		goto out2;
+	list_add(&t->l, &iio_sysfs_trig_list);
+	__module_get(THIS_MODULE);
+	mutex_unlock(&iio_syfs_trig_list_mut);
 	return 0;
-out3:
-	kfree(trig->name);
+
 out2:
-	iio_put_trigger(trig);
+	iio_put_trigger(t->trig);
+free_t:
+	kfree(t);
+free_name:
+	kfree(name);
 out1:
-
+	mutex_unlock(&iio_syfs_trig_list_mut);
 	return ret;
 }
 
-static int __devexit iio_sysfs_trigger_remove(struct platform_device *pdev)
+static int iio_sysfs_trigger_remove(int id)
 {
-	struct iio_trigger *trig = platform_get_drvdata(pdev);
+	bool foundit = false;
+	struct iio_sysfs_trig *t;
+	mutex_lock(&iio_syfs_trig_list_mut);
+	list_for_each_entry(t, &iio_sysfs_trig_list, l)
+		if (id == t->id) {
+			foundit = true;
+			break;
+		}
+	if (!foundit) {
+		mutex_unlock(&iio_syfs_trig_list_mut);
+		return -EINVAL;
+	}
 
-	iio_trigger_unregister(trig);
-	kfree(trig->name);
-	iio_put_trigger(trig);
+	iio_trigger_unregister(t->trig);
+	kfree(t->trig->name);
+	iio_free_trigger(t->trig);
 
+	list_del(&t->l);
+	kfree(t);
+	module_put(THIS_MODULE);
+	mutex_unlock(&iio_syfs_trig_list_mut);
 	return 0;
 }
 
-static struct platform_driver iio_sysfs_trigger_driver = {
-	.driver = {
-		.name = "iio_sysfs_trigger",
-		.owner = THIS_MODULE,
-	},
-	.probe = iio_sysfs_trigger_probe,
-	.remove = __devexit_p(iio_sysfs_trigger_remove),
-};
 
 static int __init iio_sysfs_trig_init(void)
 {
-	return platform_driver_register(&iio_sysfs_trigger_driver);
+	device_initialize(&iio_sysfs_trig_dev);
+	dev_set_name(&iio_sysfs_trig_dev, "iio_sysfs_trigger");
+	return device_add(&iio_sysfs_trig_dev);
 }
 module_init(iio_sysfs_trig_init);
 
 static void __exit iio_sysfs_trig_exit(void)
 {
-	platform_driver_unregister(&iio_sysfs_trigger_driver);
+	device_unregister(&iio_sysfs_trig_dev);
 }
 module_exit(iio_sysfs_trig_exit);
 
-- 
1.7.3.4
