Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	jlbec@evilplan.org,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	octavian.purdila@intel.com,
	pebolle@tiscali.nl,
	patrick.porlan@intel.com,
	adriana.reus@intel.com,
	constantin.musca@intel.com,
	marten@intuitiveaerial.com,
	daniel.baluta@intel.com
Subject: [PATCH v6 2/4] iio: core: Introduce IIO configfs support
Date: Fri,  8 May 2015 16:33:43 +0300
Message-Id: <1431092025-14355-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1431092025-14355-1-git-send-email-daniel.baluta@intel.com>
References: <1431092025-14355-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This creates an IIO configfs subystem named "iio", with a default "triggers"
group.

Triggers group is used for handling software triggers. To create a new software
trigger one must create a directory inside the trigger directory.

Software trigger name MUST follow the following convention:
	* <trigger-type>-<trigger-name>
Where:
	* <trigger_type>, specifies the interrupt source (e.g: hrtimer)
	* <trigger-name>, specifies the IIO device trigger name

Failing to follow this convention will result in an directory creation error.

E.g, assuming that hrtimer trigger type is registered with IIO software
trigger core:

$ mkdir /config/iio/triggers/hrtimer-instance1

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/Kconfig                 |   8 +++
 drivers/iio/Makefile                |   1 +
 drivers/iio/industrialio-configfs.c | 117 ++++++++++++++++++++++++++++++++++++
 include/linux/iio/sw_trigger.h      |  27 +++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 drivers/iio/industrialio-configfs.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index de7f1d9..c310156 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -18,6 +18,14 @@ config IIO_BUFFER
 	  Provide core support for various buffer based data
 	  acquisition methods.
 
+config IIO_CONFIGFS
+	tristate "Enable IIO configuration via configfs"
+	select CONFIGFS_FS
+	help
+	  This allows configuring various IIO bits through configfs
+	  (e.g. software triggers). For more info see
+	  Documentation/iio/iio_configfs.txt.
+
 if IIO_BUFFER
 
 config IIO_BUFFER_CB
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index df87975..31aead3 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -10,6 +10,7 @@ industrialio-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
 industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
 
 obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
+obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
 obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 
 obj-y += accel/
diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
new file mode 100644
index 0000000..daf318c
--- /dev/null
+++ b/drivers/iio/industrialio-configfs.c
@@ -0,0 +1,117 @@
+/*
+ * Industrial I/O configfs bits
+ *
+ * Copyright (c) 2015 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/configfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kmod.h>
+#include <linux/slab.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sw_trigger.h>
+
+#define MAX_NAME_LEN 32
+
+static struct config_group *trigger_make_group(struct config_group *group,
+					       const char *name)
+{
+	char *type_name;
+	char *trigger_name;
+	char buf[MAX_NAME_LEN];
+	struct iio_sw_trigger *t;
+
+	snprintf(buf, MAX_NAME_LEN, "%s", name);
+
+	/* group name should have the form <trigger-type>-<trigger-name> */
+	type_name = buf;
+	trigger_name = strchr(buf, '-');
+	if (!trigger_name) {
+		WARN_ONCE(1, "Unable to locate '-' in %s. Use <type>-<name>.\n",
+			  buf);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* replace - with \0, this nicely separates the two strings */
+	*trigger_name = '\0';
+	trigger_name++;
+
+	t = iio_sw_trigger_create(type_name, trigger_name);
+	if (IS_ERR(t))
+		return ERR_CAST(t);
+
+	config_item_set_name(&t->group.cg_item, name);
+
+	return &t->group;
+}
+
+static void trigger_drop_group(struct config_group *group,
+			       struct config_item *item)
+{
+	struct iio_sw_trigger *t = to_iio_sw_trigger(item);
+
+	iio_sw_trigger_destroy(t);
+	config_item_put(item);
+}
+
+static struct configfs_group_operations triggers_ops = {
+	.make_group	= &trigger_make_group,
+	.drop_item	= &trigger_drop_group,
+};
+
+static struct config_item_type iio_triggers_group_type = {
+	.ct_group_ops = &triggers_ops,
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct config_group iio_triggers_group = {
+	.cg_item = {
+		.ci_namebuf = "triggers",
+		.ci_type = &iio_triggers_group_type,
+	},
+};
+
+static struct config_group *iio_root_default_groups[] = {
+	&iio_triggers_group,
+	NULL
+};
+
+static struct config_item_type iio_root_group_type = {
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct configfs_subsystem iio_configfs_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "iio",
+			.ci_type = &iio_root_group_type,
+		},
+		.default_groups = iio_root_default_groups,
+	},
+	.su_mutex = __MUTEX_INITIALIZER(iio_configfs_subsys.su_mutex),
+};
+
+static int __init iio_configfs_init(void)
+{
+	config_group_init(&iio_triggers_group);
+	config_group_init(&iio_configfs_subsys.su_group);
+
+	return configfs_register_subsystem(&iio_configfs_subsys);
+}
+module_init(iio_configfs_init);
+
+static void __exit iio_configfs_exit(void)
+{
+	configfs_unregister_subsystem(&iio_configfs_subsys);
+}
+module_exit(iio_configfs_exit);
+
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
+MODULE_DESCRIPTION("Industrial I/O configfs support");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
index 2771a25..87803c7 100644
--- a/include/linux/iio/sw_trigger.h
+++ b/include/linux/iio/sw_trigger.h
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/iio/iio.h>
+#include <linux/configfs.h>
 
 #define module_iio_sw_trigger_driver(__iio_sw_trigger_type) \
 	module_driver(__iio_sw_trigger_type, iio_register_sw_trigger_type, \
@@ -31,6 +32,9 @@ struct iio_sw_trigger_type {
 struct iio_sw_trigger {
 	struct iio_trigger *trigger;
 	struct iio_sw_trigger_type *trigger_type;
+#ifdef CONFIG_CONFIGFS_FS
+	struct config_group group;
+#endif
 };
 
 struct iio_sw_trigger_ops {
@@ -55,4 +59,27 @@ int iio_unregister_sw_trigger_type(struct iio_sw_trigger_type *tt);
 struct iio_sw_trigger *iio_sw_trigger_create(const char *, const char *);
 void iio_sw_trigger_destroy(struct iio_sw_trigger *);
 
+#ifdef CONFIG_CONFIGFS_FS
+static inline
+struct iio_sw_trigger *to_iio_sw_trigger(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct iio_sw_trigger,
+			    group);
+}
+
+static inline
+void iio_config_group_init_type_name(struct config_group *group,
+				     const char *name,
+				     struct config_item_type *type)
+{
+	config_group_init_type_name(group, name, type);
+}
+#else
+static inline
+void iio_config_group_init_type_name(struct config_group *group,
+				     const char *name,
+				     struct config_item_type *type)
+{ }
+#endif
+
 #endif /* __IIO_SW_TRIGGER */
-- 
1.9.1
