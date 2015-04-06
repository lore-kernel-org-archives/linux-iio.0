Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org,
	lars@metafoo.de,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	pebolle@tiscali.nl,
	patrick.porlan@intel.com,
	adriana.reus@intel.com
Subject: [PATCH v3 2/3] iio: trigger: Add support for highres timer trigger type
Date: Mon,  6 Apr 2015 17:18:08 +0300
Message-Id: <1428329889-18335-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds a new trigger type - the high resoluton timer ("hrtimer")
under /config/iio/triggers/ and also creates a module that implements hrtimer
trigger type functionality.

A new IIO trigger is allocated when a new directory is created under
/config/iio/triggers/. The name of the trigger is the same as the dir
name. Each trigger will have a "delay" attribute representing the delay
between two successive IIO trigger_poll calls.

Signed-off-by: Marten Svanfeldt <marten@intuitiveaerial.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
Changes since v2: 
	* none
Changes since v1:
	* replaced sampling_frequency with delay to make the in kernel
	processing easier
	* implemented hrtimer driver using the new API proposed in patch 1

 drivers/iio/industrialio-configfs.c      | 164 +++++++++++++++++++++++++++++++
 drivers/iio/trigger/Kconfig              |   9 ++
 drivers/iio/trigger/Makefile             |   2 +
 drivers/iio/trigger/iio-trig-hrtimer.c   | 154 +++++++++++++++++++++++++++++
 include/linux/iio/iio_configfs_trigger.h |   1 +
 5 files changed, 330 insertions(+)
 create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c

diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
index d8ffd76..a0e5d24 100644
--- a/drivers/iio/industrialio-configfs.c
+++ b/drivers/iio/industrialio-configfs.c
@@ -71,7 +71,170 @@ struct iio_configfs_trigger_type *iio_get_configfs_trigger_type(int type)
 	return t;
 }
 
+struct iio_trigger_item {
+	struct config_item item;
+	struct iio_configfs_trigger_info *trigger_info;
+};
+
+static
+inline struct iio_trigger_item *to_iio_trigger_item(struct config_item *item)
+{
+	if (!item)
+		return NULL;
+	return container_of(item, struct iio_trigger_item, item);
+}
+
+CONFIGFS_ATTR_STRUCT(iio_trigger_item);
+
+#define IIO_TRIGGER_ITEM_ATTR(_name, _mode, _show, _store) \
+struct iio_trigger_item_attribute iio_trigger_item_attr_##_name = \
+	__CONFIGFS_ATTR(_name, _mode, _show, _store)
+
+static
+ssize_t iio_trigger_item_get_delay(struct iio_trigger_item *item, char *page)
+{
+	unsigned long delay;
+	int ret;
+
+	struct iio_configfs_trigger_type *t = item->trigger_info->trigger_type;
+
+	ret = t->trigger_ops->get_delay(item->trigger_info, &delay);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(page, PAGE_SIZE, "%lu\n", delay);
+}
+
+static
+ssize_t iio_trigger_item_set_delay(struct iio_trigger_item *item,
+				   const char *page,
+				   size_t count)
+{
+	int ret;
+	unsigned long delay;
+	struct iio_configfs_trigger_type *t = item->trigger_info->trigger_type;
+
+	ret = kstrtoul(page, 10, &delay);
+	if (ret < 0)
+		return ret;
+
+	ret = t->trigger_ops->set_delay(item->trigger_info, delay);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+IIO_TRIGGER_ITEM_ATTR(delay, S_IRUGO | S_IWUSR,
+		      iio_trigger_item_get_delay,
+		      iio_trigger_item_set_delay);
+
+static struct configfs_attribute *iio_trigger_item_attrs[] = {
+	&iio_trigger_item_attr_delay.attr,
+	NULL
+};
+
+CONFIGFS_ATTR_OPS(iio_trigger_item);
+
+static struct configfs_item_operations iio_trigger_item_ops = {
+	.show_attribute = iio_trigger_item_attr_show,
+	.store_attribute = iio_trigger_item_attr_store,
+};
+
+static struct config_item_type iio_trigger_item_type;
+
+static struct config_item *iio_hrtimer_make_item(struct config_group *group,
+						 const char *name)
+{
+	struct iio_trigger_item *trigger_item;
+	struct iio_configfs_trigger_info *trigger_info;
+	struct iio_configfs_trigger_type *trigger_type;
+	int ret;
+
+	trigger_item = kzalloc(sizeof(*trigger_item), GFP_KERNEL);
+	if (!trigger_item)
+		return ERR_PTR(-ENOMEM);
+	trigger_info = kzalloc(sizeof(*trigger_info), GFP_KERNEL);
+	if (!trigger_info) {
+		ret = -ENOMEM;
+		goto out_free_trigger_item;
+	}
+
+	trigger_info->name = kstrdup(name, GFP_KERNEL);
+	if (!trigger_info->name) {
+		ret = -ENOMEM;
+		goto out_free_trigger_info;
+	}
+
+	trigger_type = iio_get_configfs_trigger_type(IIO_TRIGGER_TYPE_HRTIMER);
+	if (!trigger_type) {
+		pr_err("Unable to get hrtimer trigger!\n");
+		ret = -ENODEV;
+		goto out_free_trigger_name;
+	}
+	ret = trigger_type->trigger_ops->probe(trigger_info);
+	if (ret < 0)
+		goto out_error_module_put;
+
+	trigger_info->trigger_type = trigger_type;
+	trigger_item->trigger_info = trigger_info;
+
+	config_item_init_type_name(&trigger_item->item, name,
+				   &iio_trigger_item_type);
+
+	return &trigger_item->item;
+out_error_module_put:
+	module_put(trigger_type->owner);
+out_free_trigger_name:
+	kfree(trigger_info->name);
+out_free_trigger_info:
+	kfree(trigger_info);
+out_free_trigger_item:
+	kfree(trigger_item);
+	return ERR_PTR(ret);
+}
+
+static void iio_hrtimer_drop_item(struct config_group *group,
+				  struct config_item *item)
+{
+	struct iio_trigger_item *trigger_item;
+	struct iio_configfs_trigger_type *trigger_type;
+
+	trigger_item = container_of(item, struct iio_trigger_item, item);
+	trigger_type = trigger_item->trigger_info->trigger_type;
+
+	trigger_type->trigger_ops->remove(trigger_item->trigger_info);
+	module_put(trigger_type->owner);
+	kfree(trigger_item->trigger_info->name);
+	kfree(trigger_item->trigger_info);
+	kfree(trigger_item);
+}
+
+static struct configfs_group_operations iio_triggers_hrtimer_group_ops = {
+	.make_item = iio_hrtimer_make_item,
+	.drop_item = iio_hrtimer_drop_item,
+};
+
+static struct config_item_type iio_trigger_item_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_item_ops	= &iio_trigger_item_ops,
+	.ct_attrs	= iio_trigger_item_attrs,
+};
+
+static struct config_item_type iio_triggers_hrtimer_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_group_ops	= &iio_triggers_hrtimer_group_ops,
+};
+
+static struct config_group iio_triggers_hrtimer_group = {
+	.cg_item = {
+		.ci_namebuf = "hrtimer",
+		.ci_type = &iio_triggers_hrtimer_type,
+	},
+};
+
 static struct config_group *iio_triggers_default_groups[] = {
+	&iio_triggers_hrtimer_group,
 	NULL
 };
 
@@ -109,6 +272,7 @@ static struct configfs_subsystem iio_configfs_subsys = {
 
 static int __init iio_configfs_init(void)
 {
+	config_group_init(&iio_triggers_hrtimer_group);
 	config_group_init(&iio_triggers_group);
 	config_group_init(&iio_configfs_subsys.su_group);
 
diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index 7999612..e21688e 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -5,6 +5,15 @@
 
 menu "Triggers - standalone"
 
+config IIO_HRTIMER_TRIGGER
+	tristate "High resolution timer trigger"
+	depends on IIO_CONFIGFS
+	help
+	  Provides a frequency based IIO trigger using hrtimers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-trig-hrtimer.
+
 config IIO_INTERRUPT_TRIGGER
 	tristate "Generic interrupt trigger"
 	help
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index 0694dae..fe06eb5 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -3,5 +3,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
 obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
new file mode 100644
index 0000000..0acde8d
--- /dev/null
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -0,0 +1,154 @@
+/**
+ * The industrial I/O periodic hrtimer trigger driver
+ *
+ * Copyright (C) Intuitive Aerial AB
+ * Written by Marten Svanfeldt, marten@intuitiveaerial.com
+ * Copyright (C) 2012, Analog Device Inc.
+ *	Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/hrtimer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/iio_configfs_trigger.h>
+
+/* default delay in ns (100Hz) */
+#define HRTIMER_TRIGGER_DEFAULT_DELAY 100000000
+
+struct iio_hrtimer_trig_info {
+	struct iio_configfs_trigger_info *trigger_info;
+	struct hrtimer timer;
+	unsigned long delay;
+};
+
+static enum hrtimer_restart iio_trig_hrtimer_trig(struct hrtimer *timer)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = container_of(timer, struct iio_hrtimer_trig_info, timer);
+
+	hrtimer_forward_now(timer, ns_to_ktime(trig_info->delay));
+	iio_trigger_poll(trig_info->trigger_info->trigger);
+
+	return HRTIMER_RESTART;
+}
+
+static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(trig);
+
+	if (state)
+		hrtimer_start(&trig_info->timer, ns_to_ktime(trig_info->delay),
+			      HRTIMER_MODE_REL);
+	else
+		hrtimer_cancel(&trig_info->timer);
+
+	return 0;
+}
+
+int iio_trig_hrtimer_get_delay(struct iio_configfs_trigger_info *t,
+			       unsigned long *delay)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(t->trigger);
+	*delay = trig_info->delay;
+
+	return 0;
+}
+
+int iio_trig_hrtimer_set_delay(struct iio_configfs_trigger_info *t,
+			       unsigned long delay)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(t->trigger);
+
+	if (!delay)
+		return -EINVAL;
+
+	trig_info->delay = delay;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops iio_hrtimer_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = iio_trig_hrtimer_set_state,
+};
+
+static int iio_trig_hrtimer_probe(struct iio_configfs_trigger_info *t)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+	int ret;
+
+	trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
+	if (!trig_info)
+		return -ENOMEM;
+
+	trig_info->trigger_info = t;
+
+	t->trigger = iio_trigger_alloc("%s", t->name);
+	if (!t->trigger)
+		return -ENOMEM;
+
+	iio_trigger_set_drvdata(t->trigger, trig_info);
+	t->trigger->ops = &iio_hrtimer_trigger_ops;
+
+	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	trig_info->timer.function = iio_trig_hrtimer_trig;
+
+	trig_info->delay = HRTIMER_TRIGGER_DEFAULT_DELAY;
+
+	ret = iio_trigger_register(t->trigger);
+	if (ret)
+		goto err_free_trigger;
+
+	return 0;
+err_free_trigger:
+	iio_trigger_free(t->trigger);
+
+	return ret;
+}
+
+static int iio_trig_hrtimer_remove(struct iio_configfs_trigger_info *t)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(t->trigger);
+
+	iio_trigger_unregister(t->trigger);
+	hrtimer_cancel(&trig_info->timer);
+	iio_trigger_free(t->trigger);
+
+	return 0;
+}
+
+struct iio_configfs_trigger_ops hrtimer_trigger_ops = {
+	.get_delay	= iio_trig_hrtimer_get_delay,
+	.set_delay	= iio_trig_hrtimer_set_delay,
+	.probe		= iio_trig_hrtimer_probe,
+	.remove		= iio_trig_hrtimer_remove,
+};
+
+struct iio_configfs_trigger_type iio_configfs_hrtimer = {
+	.type = IIO_TRIGGER_TYPE_HRTIMER,
+	.owner = THIS_MODULE,
+	.trigger_ops = &hrtimer_trigger_ops,
+};
+
+module_iio_configfs_trigger_driver(iio_configfs_hrtimer);
+
+MODULE_AUTHOR("Marten Svanfeldt <marten@intuitiveaerial.com>");
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
+MODULE_DESCRIPTION("Periodic hrtimer trigger for the IIO subsystem");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/iio_configfs_trigger.h b/include/linux/iio/iio_configfs_trigger.h
index 75e76f2..6233733 100644
--- a/include/linux/iio/iio_configfs_trigger.h
+++ b/include/linux/iio/iio_configfs_trigger.h
@@ -10,6 +10,7 @@
 		      unregister_configfs_trigger)
 
 enum {
+	IIO_TRIGGER_TYPE_HRTIMER = 0,
 	IIO_TRIGGER_TYPE_MAX,
 };
 
-- 
1.9.1
