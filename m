Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19620 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbcDYNMa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Apr 2016 09:12:30 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v2 1/3] iio: Add support for creating IIO devices via configfs
Date: Mon, 25 Apr 2016 16:15:51 +0300
Message-Id: <1461590153-22308-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
References: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is similar with support for creating triggers via configfs.
Devices will be hosted under:
	* /config/iio/devices

We allow users to register "device types" under:
	* /config/iio/devices/<device_types>/

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/Kconfig                  |   8 ++
 drivers/iio/Makefile                 |   1 +
 drivers/iio/industrialio-sw-device.c | 182 +++++++++++++++++++++++++++++++++++
 include/linux/iio/sw_device.h        |  70 ++++++++++++++
 4 files changed, 261 insertions(+)
 create mode 100644 drivers/iio/industrialio-sw-device.c
 create mode 100644 include/linux/iio/sw_device.h

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 505e921..6743b18 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -46,6 +46,14 @@ config IIO_CONSUMERS_PER_TRIGGER
 	This value controls the maximum number of consumers that a
 	given trigger may handle. Default is 2.
 
+config IIO_SW_DEVICE
+	tristate "Enable software IIO device support"
+	select IIO_CONFIGFS
+	help
+	 Provides IIO core support for software devices. A software
+	 device can be created via configfs or directly by a driver
+	 using the API provided.
+
 config IIO_SW_TRIGGER
 	tristate "Enable software triggers support"
 	select IIO_CONFIGFS
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 20f6490..87e4c43 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -8,6 +8,7 @@ industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
 obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
+obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
 obj-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
 obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
 
diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
new file mode 100644
index 0000000..81b49cf
--- /dev/null
+++ b/drivers/iio/industrialio-sw-device.c
@@ -0,0 +1,182 @@
+/*
+ * The Industrial I/O core, software IIO devices functions
+ *
+ * Copyright (c) 2016 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kmod.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include <linux/iio/sw_device.h>
+#include <linux/iio/configfs.h>
+#include <linux/configfs.h>
+
+static struct config_group *iio_devices_group;
+static struct config_item_type iio_device_type_group_type;
+
+static struct config_item_type iio_devices_group_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+static LIST_HEAD(iio_device_types_list);
+static DEFINE_MUTEX(iio_device_types_lock);
+
+static
+struct iio_sw_device_type *__iio_find_sw_device_type(const char *name,
+						     unsigned len)
+{
+	struct iio_sw_device_type *d = NULL, *iter;
+
+	list_for_each_entry(iter, &iio_device_types_list, list)
+		if (!strcmp(iter->name, name)) {
+			d = iter;
+			break;
+		}
+
+	return d;
+}
+
+int iio_register_sw_device_type(struct iio_sw_device_type *d)
+{
+	struct iio_sw_device_type *iter;
+	int ret = 0;
+
+	mutex_lock(&iio_device_types_lock);
+	iter = __iio_find_sw_device_type(d->name, strlen(d->name));
+	if (iter)
+		ret = -EBUSY;
+	else
+		list_add_tail(&d->list, &iio_device_types_list);
+	mutex_unlock(&iio_device_types_lock);
+
+	if (ret)
+		return ret;
+
+	d->group = configfs_register_default_group(iio_devices_group, d->name,
+						&iio_device_type_group_type);
+	if (IS_ERR(d->group))
+		ret = PTR_ERR(d->group);
+
+	return ret;
+}
+EXPORT_SYMBOL(iio_register_sw_device_type);
+
+void iio_unregister_sw_device_type(struct iio_sw_device_type *dt)
+{
+	struct iio_sw_device_type *iter;
+
+	mutex_lock(&iio_device_types_lock);
+	iter = __iio_find_sw_device_type(dt->name, strlen(dt->name));
+	if (iter)
+		list_del(&dt->list);
+	mutex_unlock(&iio_device_types_lock);
+
+	configfs_unregister_default_group(dt->group);
+}
+EXPORT_SYMBOL(iio_unregister_sw_device_type);
+
+static
+struct iio_sw_device_type *iio_get_sw_device_type(const char *name)
+{
+	struct iio_sw_device_type *dt;
+
+	mutex_lock(&iio_device_types_lock);
+	dt = __iio_find_sw_device_type(name, strlen(name));
+	if (dt && !try_module_get(dt->owner))
+		dt = NULL;
+	mutex_unlock(&iio_device_types_lock);
+
+	return dt;
+}
+
+struct iio_sw_device *iio_sw_device_create(const char *type, const char *name)
+{
+	struct iio_sw_device *d;
+	struct iio_sw_device_type *dt;
+
+	dt = iio_get_sw_device_type(type);
+	if (!dt) {
+		pr_err("Invalid device type: %s\n", type);
+		return ERR_PTR(-EINVAL);
+	}
+	d = dt->ops->probe(name);
+	if (IS_ERR(d))
+		goto out_module_put;
+
+	d->device_type = dt;
+
+	return d;
+out_module_put:
+	module_put(dt->owner);
+	return d;
+}
+EXPORT_SYMBOL(iio_sw_device_create);
+
+void iio_sw_device_destroy(struct iio_sw_device *d)
+{
+	struct iio_sw_device_type *dt = d->device_type;
+
+	dt->ops->remove(d);
+	module_put(dt->owner);
+}
+EXPORT_SYMBOL(iio_sw_device_destroy);
+
+static struct config_group *device_make_group(struct config_group *group,
+					      const char *name)
+{
+	struct iio_sw_device *d;
+
+	d = iio_sw_device_create(group->cg_item.ci_name, name);
+	if (IS_ERR(d))
+		return ERR_CAST(d);
+
+	config_item_set_name(&d->group.cg_item, "%s", name);
+
+	return &d->group;
+}
+
+static void device_drop_group(struct config_group *group,
+			      struct config_item *item)
+{
+	struct iio_sw_device *d = to_iio_sw_device(item);
+
+	iio_sw_device_destroy(d);
+	config_item_put(item);
+}
+
+static struct configfs_group_operations device_ops = {
+	.make_group	= &device_make_group,
+	.drop_item	= &device_drop_group,
+};
+
+static struct config_item_type iio_device_type_group_type = {
+	.ct_group_ops = &device_ops,
+	.ct_owner       = THIS_MODULE,
+};
+
+static int __init iio_sw_device_init(void)
+{
+	iio_devices_group =
+		configfs_register_default_group(&iio_configfs_subsys.su_group,
+						"devices",
+						&iio_devices_group_type);
+	return PTR_ERR_OR_ZERO(iio_devices_group);
+}
+module_init(iio_sw_device_init);
+
+static void __exit iio_sw_device_exit(void)
+{
+	configfs_unregister_default_group(iio_devices_group);
+}
+module_exit(iio_sw_device_exit);
+
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
+MODULE_DESCRIPTION("Industrial I/O software devices support");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/sw_device.h b/include/linux/iio/sw_device.h
new file mode 100644
index 0000000..23ca415
--- /dev/null
+++ b/include/linux/iio/sw_device.h
@@ -0,0 +1,70 @@
+/*
+ * Industrial I/O software device interface
+ *
+ * Copyright (c) 2016 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef __IIO_SW_DEVICE
+#define __IIO_SW_DEVICE
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/configfs.h>
+
+#define module_iio_sw_device_driver(__iio_sw_device_type) \
+	module_driver(__iio_sw_device_type, iio_register_sw_device_type, \
+		      iio_unregister_sw_device_type)
+
+struct iio_sw_device_ops;
+
+struct iio_sw_device_type {
+	const char *name;
+	struct module *owner;
+	const struct iio_sw_device_ops *ops;
+	struct list_head list;
+	struct config_group *group;
+};
+
+struct iio_sw_device {
+	struct iio_dev *device;
+	struct iio_sw_device_type *device_type;
+	struct config_group group;
+};
+
+struct iio_sw_device_ops {
+	struct iio_sw_device* (*probe)(const char *);
+	int (*remove)(struct iio_sw_device *);
+};
+
+static inline
+struct iio_sw_device *to_iio_sw_device(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct iio_sw_device,
+			    group);
+}
+
+int iio_register_sw_device_type(struct iio_sw_device_type *dt);
+void iio_unregister_sw_device_type(struct iio_sw_device_type *dt);
+
+struct iio_sw_device *iio_sw_device_create(const char *, const char *);
+void iio_sw_device_destroy(struct iio_sw_device *);
+
+int iio_sw_device_type_configfs_register(struct iio_sw_device_type *dt);
+void iio_sw_device_type_configfs_unregister(struct iio_sw_device_type *dt);
+
+static inline
+void iio_swd_group_init_type_name(struct iio_sw_device *d,
+				  const char *name,
+				  struct config_item_type *type)
+{
+#ifdef CONFIG_CONFIGFS_FS
+	config_group_init_type_name(&d->group, name, type);
+#endif
+}
+
+#endif /* __IIO_SW_DEVICE */
-- 
2.5.0

