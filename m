Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28322 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483AbbDTOBK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 Apr 2015 10:01:10 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org, lars@metafoo.de, knaack.h@gmx.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	octavian.purdila@intel.com, pebolle@tiscali.nl,
	patrick.porlan@intel.com, adriana.reus@intel.com,
	constantin.musca@intel.com, marten@intuitiveaerial.com
Subject: [PATCH v4 1/4] iio: core: Introduce IIO software triggers
Date: Mon, 20 Apr 2015 17:02:40 +0300
Message-Id: <1429538563-23430-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com>
References: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A software trigger associates an IIO device trigger with a software
interrupt source (e.g: timer, sysfs). This patch adds the generic
infrastructure for handling software triggers.

Software interrupts sources are kept in a iio_trigger_types_list and
registered separately when the associated kernel module is loaded.

Software triggers can be created directly from drivers or from user
space via configfs interface.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/Kconfig                   |   8 +++
 drivers/iio/Makefile                  |   1 +
 drivers/iio/industrialio-sw-trigger.c | 111 ++++++++++++++++++++++++++++++++++
 include/linux/iio/sw_trigger.h        |  50 +++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 drivers/iio/industrialio-sw-trigger.c
 create mode 100644 include/linux/iio/sw_trigger.h

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 4011eff..de7f1d9 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -58,6 +58,14 @@ config IIO_CONSUMERS_PER_TRIGGER
 	This value controls the maximum number of consumers that a
 	given trigger may handle. Default is 2.
 
+config IIO_SW_TRIGGER
+	bool "Enable software triggers support"
+	depends on IIO_TRIGGER
+	help
+	 Provides IIO core support for software triggers. A software
+	 trigger can be created via configfs or directly by a driver
+	 using the API provided.
+
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 698afc2..df87975 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
+industrialio-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
 industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
 
 obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
new file mode 100644
index 0000000..567c675
--- /dev/null
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -0,0 +1,111 @@
+/*
+ * The Industrial I/O core, software trigger functions
+ *
+ * Copyright (c) 2015 Intel Corporation
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
+#include <linux/iio/sw_trigger.h>
+
+static LIST_HEAD(iio_trigger_types_list);
+static DEFINE_RWLOCK(iio_trigger_types_lock);
+
+static
+struct iio_sw_trigger_type *iio_find_sw_trigger_type(char *name, unsigned len)
+{
+	struct iio_sw_trigger_type *t = NULL, *iter;
+
+	list_for_each_entry(iter, &iio_trigger_types_list, list)
+		if (!strncmp(iter->name, name, len)) {
+			t = iter;
+			break;
+		}
+
+	return t;
+}
+
+int iio_register_sw_trigger_type(struct iio_sw_trigger_type *t)
+{
+	struct iio_sw_trigger_type *iter;
+	int ret = 0;
+
+	write_lock(&iio_trigger_types_lock);
+	iter = iio_find_sw_trigger_type(t->name, strlen(t->name));
+	if (iter)
+		ret = -EBUSY;
+	else
+		list_add_tail(&t->list, &iio_trigger_types_list);
+	write_unlock(&iio_trigger_types_lock);
+	return ret;
+}
+EXPORT_SYMBOL(iio_register_sw_trigger_type);
+
+int iio_unregister_sw_trigger_type(struct iio_sw_trigger_type *t)
+{
+	struct iio_sw_trigger_type *iter;
+	int ret = 0;
+
+	write_lock(&iio_trigger_types_lock);
+	iter = iio_find_sw_trigger_type(t->name, strlen(t->name));
+	if (!iter)
+		ret = -EINVAL;
+	else
+		list_del(&t->list);
+	write_unlock(&iio_trigger_types_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(iio_unregister_sw_trigger_type);
+
+static
+struct iio_sw_trigger_type *iio_get_sw_trigger_type(char *name)
+{
+	struct iio_sw_trigger_type *t;
+
+	read_lock(&iio_trigger_types_lock);
+	t = iio_find_sw_trigger_type(name, strlen(name));
+	if (t && !try_module_get(t->owner))
+		t = NULL;
+	read_unlock(&iio_trigger_types_lock);
+
+	return t;
+}
+
+struct iio_sw_trigger *iio_sw_trigger_create(char *type, char *name)
+{
+	struct iio_sw_trigger *t;
+	struct iio_sw_trigger_type *tt;
+
+	tt = iio_get_sw_trigger_type(type);
+	if (!tt) {
+		pr_err("Invalid trigger type: %s\n", type);
+		return ERR_PTR(-EINVAL);
+	}
+	t = tt->ops->probe(name);
+	if (IS_ERR(t))
+		goto out_module_put;
+
+	return t;
+out_module_put:
+	module_put(tt->owner);
+	return t;
+}
+EXPORT_SYMBOL(iio_sw_trigger_create);
+
+void iio_sw_trigger_destroy(struct iio_sw_trigger *t)
+{
+	struct iio_sw_trigger_type *tt = t->trigger_type;
+
+	tt->ops->remove(t);
+	module_put(tt->owner);
+}
+EXPORT_SYMBOL(iio_sw_trigger_destroy);
diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
new file mode 100644
index 0000000..2e6659b
--- /dev/null
+++ b/include/linux/iio/sw_trigger.h
@@ -0,0 +1,50 @@
+#ifndef __IIO_SW_TRIGGER
+#define __IIO_SW_TRIGGER
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/configfs.h>
+
+#define module_iio_sw_trigger_driver(__iio_sw_trigger_type) \
+	module_driver(__iio_sw_trigger_type, iio_register_sw_trigger_type, \
+		      iio_unregister_sw_trigger_type)
+
+struct iio_sw_trigger_ops;
+
+struct iio_sw_trigger_type {
+	char *name;
+	struct module *owner;
+	struct iio_sw_trigger_ops *ops;
+	struct list_head list;
+};
+
+struct iio_sw_trigger {
+	struct iio_trigger *trigger;
+	struct iio_sw_trigger_type *trigger_type;
+#ifdef CONFIG_CONFIGFS_FS
+	struct config_group group;
+#endif
+};
+
+struct iio_sw_trigger_ops {
+	struct iio_sw_trigger* (*probe)(const char *);
+	int (*remove)(struct iio_sw_trigger *);
+};
+
+int iio_register_sw_trigger_type(struct iio_sw_trigger_type *);
+int iio_unregister_sw_trigger_type(struct iio_sw_trigger_type *);
+
+struct iio_sw_trigger *iio_sw_trigger_create(char *, char *);
+void iio_sw_trigger_destroy(struct iio_sw_trigger *);
+
+#ifdef CONFIG_CONFIGFS_FS
+static inline
+struct iio_sw_trigger *to_iio_sw_trigger(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct iio_sw_trigger,
+			    group);
+}
+#endif
+
+#endif /* __IIO_SW_TRIGGER */
-- 
1.9.1

