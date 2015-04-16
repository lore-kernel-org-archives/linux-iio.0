Return-Path: <robert.dolca@intel.com>
From: Robert Dolca <robert.dolca@intel.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Robert Dolca <robert.dolca@intel.com>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: [PATCH RFC 1/3] iio: Add symlink to triggers in the device's trigger folder
Date: Thu, 16 Apr 2015 12:01:06 +0300
Message-Id: <1429174868-11953-2-git-send-email-robert.dolca@intel.com>
In-Reply-To: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
References: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds a new function called iio_trigger_register_with_dev
which is a wrapper for iio_trigger_register. Besides the iio_trigger
struct this function requires iio_dev struct. It adds the trigger in
the device's trigger list and saves a reference to the device in the
trigger's struct.

When the device is registered, in the trigger folder of the device
(where current_trigger file resides) a symlink is being created for
each trigger that was registered width iio_trigger_register_with_dev.

 # ls -l /sys/bus/iio/devices/iio:device0/trigger/
total 0
-rw-r--r--    1 root     root          4096 Apr 16 08:33 current_trigger
lrwxrwxrwx    1 root     root             0 Apr 16 08:33 trigger0 -> ../../trigg
er0

This should be used for device specific triggers. Doing this the user space
applications can figure out what if the trigger registered by a specific device
and what should they write in the current_trigger file. Currently some
applications rely on the trigger name and this does not always work.

This implementation assumes that the trigger is registered before the device is
registered. If the order is not this the symlink will not be created but
everything else will work as before.

Signed-off-by: Robert Dolca <robert.dolca@intel.com>
---
 drivers/iio/industrialio-core.c    | 20 ++++++++++++
 drivers/iio/industrialio-trigger.c | 64 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h            |  1 +
 include/linux/iio/trigger.h        | 24 ++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 69feb91..94bcd54 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -26,6 +26,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
 #include <linux/iio/sysfs.h>
@@ -988,6 +989,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 		}
 		dev_set_name(&dev->dev, "iio:device%d", dev->id);
 		INIT_LIST_HEAD(&dev->buffer_list);
+		INIT_LIST_HEAD(&dev->triggers);
 	}
 
 	return dev;
@@ -1166,6 +1168,8 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 int iio_device_register(struct iio_dev *indio_dev)
 {
 	int ret;
+	struct iio_trigger *trig_info;
+	struct list_head *pos;
 
 	/* If the calling driver did not initialize of_node, do it here */
 	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
@@ -1222,6 +1226,13 @@ int iio_device_register(struct iio_dev *indio_dev)
 	if (ret < 0)
 		goto error_cdev_del;
 
+	list_for_each(pos, &indio_dev->triggers) {
+		trig_info = list_entry(pos, struct iio_trigger, indio_dev_list);
+		ret = iio_trigger_link(trig_info);
+		if (ret < 0)
+			goto error_cdev_del;
+	}
+
 	return 0;
 error_cdev_del:
 	cdev_del(&indio_dev->chrdev);
@@ -1243,8 +1254,17 @@ EXPORT_SYMBOL(iio_device_register);
  **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
+	struct list_head *pos, *safe;
+	struct iio_trigger *trig_info;
+
 	mutex_lock(&indio_dev->info_exist_lock);
 
+	list_for_each_safe(pos, safe, &indio_dev->triggers) {
+		trig_info = list_entry(pos, struct iio_trigger, indio_dev_list);
+		list_del(pos);
+		iio_trigger_unlink(trig_info);
+	}
+
 	device_del(&indio_dev->dev);
 
 	if (indio_dev->chrdev.dev)
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index d31098e..cebdd10 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -57,6 +57,24 @@ static struct attribute *iio_trig_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(iio_trig_dev);
 
+int iio_trigger_register_with_dev(struct iio_dev *indio_dev,
+				  struct iio_trigger *trig_info)
+{
+	int ret;
+
+	ret = iio_trigger_register(trig_info);
+	if (ret < 0)
+		goto error;
+
+	trig_info->indio_dev = indio_dev;
+	list_add(&trig_info->indio_dev_list, &indio_dev->triggers);
+
+	return 0;
+error:
+	return ret;
+}
+EXPORT_SYMBOL(iio_trigger_register_with_dev);
+
 int iio_trigger_register(struct iio_trigger *trig_info)
 {
 	int ret;
@@ -88,6 +106,11 @@ EXPORT_SYMBOL(iio_trigger_register);
 
 void iio_trigger_unregister(struct iio_trigger *trig_info)
 {
+	if (trig_info->indio_dev) {
+		iio_trigger_unlink(trig_info);
+		list_del(&trig_info->indio_dev_list);
+	}
+
 	mutex_lock(&iio_trigger_list_lock);
 	list_del(&trig_info->list);
 	mutex_unlock(&iio_trigger_list_lock);
@@ -98,6 +121,47 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 }
 EXPORT_SYMBOL(iio_trigger_unregister);
 
+int iio_trigger_link(struct iio_trigger *trig_info)
+{
+	int ret;
+	char *name;
+	struct iio_dev *indio_dev;
+
+	indio_dev = trig_info->indio_dev;
+	if (!indio_dev)
+		return -EINVAL;
+
+	name = kasprintf(GFP_KERNEL, "trigger%d", trig_info->id);
+	if (!name)
+		return -ENOMEM;
+
+	ret = sysfs_add_link_to_group(&indio_dev->dev.kobj, "trigger",
+				      &trig_info->dev.kobj, name);
+	kfree(name);
+	return ret;
+}
+EXPORT_SYMBOL(iio_trigger_link);
+
+int iio_trigger_unlink(struct iio_trigger *trig_info)
+{
+	char *name;
+	struct iio_dev *indio_dev;
+
+	indio_dev = trig_info->indio_dev;
+	if (!trig_info->indio_dev)
+		return -EINVAL;
+
+	name = kasprintf(GFP_KERNEL, "trigger%d", trig_info->id);
+	if (!name)
+		return -ENOMEM;
+
+	sysfs_remove_link_from_group(&indio_dev->dev.kobj, "trigger", name);
+	kfree(name);
+	trig_info->indio_dev = NULL;
+	return 0;
+}
+EXPORT_SYMBOL(iio_trigger_unlink);
+
 static struct iio_trigger *iio_trigger_find_by_name(const char *name,
 						    size_t len)
 {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 878d861..9ff54ef 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -495,6 +495,7 @@ struct iio_dev {
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
 #endif
+	struct list_head		triggers;
 };
 
 const struct iio_chan_spec
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index fa76c79..4001e44 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -70,6 +70,9 @@ struct iio_trigger {
 	struct iio_subirq subirqs[CONFIG_IIO_CONSUMERS_PER_TRIGGER];
 	unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
 	struct mutex			pool_lock;
+
+	struct iio_dev			*indio_dev;
+	struct list_head		indio_dev_list;
 };
 
 
@@ -117,6 +120,15 @@ static inline void *iio_trigger_get_drvdata(struct iio_trigger *trig)
 }
 
 /**
+ * iio_trigger_register_width_dev() - register a trigger with the IIO core
+ * and associate it with a device
+ * @iio_dev: device to associate the trigger with
+ * @trig_info:	trigger to be registered
+ **/
+int iio_trigger_register_with_dev(struct iio_dev *indio_dev,
+				  struct iio_trigger *trig_info);
+
+/**
  * iio_trigger_register() - register a trigger with the IIO core
  * @trig_info:	trigger to be registered
  **/
@@ -129,6 +141,18 @@ int iio_trigger_register(struct iio_trigger *trig_info);
 void iio_trigger_unregister(struct iio_trigger *trig_info);
 
 /**
+ * Add a symlink to the trigger in the devices' trigger folder
+ * @trig_info:  symlink destination trigger
+ */
+int iio_trigger_link(struct iio_trigger *trig_info);
+
+/**
+ * Remove the trigger's symlink from the device's trigger folder
+ * @trig_info: symlink destination trigger
+ */
+int iio_trigger_unlink(struct iio_trigger *trig_info);
+
+/**
  * iio_trigger_poll() - called on a trigger occurring
  * @trig:	trigger which occurred
  *
-- 
1.9.1
