Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:32199
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751065Ab2BVMdT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2012 07:33:19 -0500
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/3] iio: core: Introduce debugfs support, add support for direct register access
Date: Wed, 22 Feb 2012 13:30:13 +0100
Message-ID: <1329913815-5382-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Changes since V1:

debugfs:

Exclude iio debugfs code in case CONFIG_DEBUG_FS isn't enabled.
	Introduce helper function iio_get_debugfs_dentry.
	Document additions to struct iio_dev

iio_debugfs_read_reg:
	Use snprintf.
	Use a shorter fixed length.
	Introduce len instead of pointer math.

iio_debugfs_write_reg:
	Fix return value use PTR_ERR.
	sscanf scan hex, decimal and octal.
	Ensure zero terminated string.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio.h               |   27 ++++++-
 drivers/staging/iio/industrialio-core.c |  137 ++++++++++++++++++++++++++++++-
 2 files changed, 162 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 42a362c..baf3c45 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -269,6 +269,9 @@ struct iio_info {
 				struct iio_trigger *trig);
 	int (*update_scan_mode)(struct iio_dev *indio_dev,
 				const unsigned long *scan_mask);
+	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
+				  unsigned reg, unsigned writeval,
+				  unsigned *readval);
 };

 /**
@@ -314,7 +317,9 @@ struct iio_buffer_setup_ops {
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
  * @flags:		[INTERN] file ops related flags including busy flag.
- **/
+ * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
+ * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
+**/
 struct iio_dev {
 	int				id;

@@ -347,6 +352,10 @@ struct iio_dev {
 	int				groupcounter;

 	unsigned long			flags;
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry			*debugfs_dentry;
+	unsigned			cached_reg_addr;
+#endif
 };

 /**
@@ -424,4 +433,20 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
 		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE);
 };

+/**
+ * iio_get_debugfs_dentry() - helper function to get the debugfs_dentry
+ * @indio_dev:		IIO device info structure for device
+ **/
+#if defined(CONFIG_DEBUG_FS)
+static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
+{
+	return indio_dev->debugfs_dentry;
+};
+#else
+static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
+{
+	return NULL;
+};
+#endif
+
 #endif /* _INDUSTRIAL_IO_H_ */
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e4824fe..82c9128 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -22,6 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/anon_inodes.h>
+#include <linux/debugfs.h>
 #include "iio.h"
 #include "iio_core.h"
 #include "iio_core_trigger.h"
@@ -39,6 +40,8 @@ struct bus_type iio_bus_type = {
 };
 EXPORT_SYMBOL(iio_bus_type);

+static struct dentry *iio_debugfs_dentry;
+
 static const char * const iio_data_type_name[] = {
 	[IIO_RAW] = "raw",
 	[IIO_PROCESSED] = "input",
@@ -129,6 +132,8 @@ static int __init iio_init(void)
 		goto error_unregister_bus_type;
 	}

+	iio_debugfs_dentry = debugfs_create_dir("iio", NULL);
+
 	return 0;

 error_unregister_bus_type:
@@ -142,8 +147,129 @@ static void __exit iio_exit(void)
 	if (iio_devt)
 		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
 	bus_unregister(&iio_bus_type);
+	debugfs_remove_recursive(iio_debugfs_dentry);
+}
+
+#if defined(CONFIG_DEBUG_FS)
+static int iio_debugfs_open(struct inode *inode, struct file *file)
+{
+	if (inode->i_private)
+		file->private_data = inode->i_private;
+
+	return 0;
+}
+
+static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	struct iio_dev *indio_dev = file->private_data;
+	char buf[20];
+	unsigned val = 0;
+	ssize_t len;
+	int ret;
+
+	ret = indio_dev->info->debugfs_reg_access(indio_dev,
+						  indio_dev->cached_reg_addr,
+						  0, &val);
+	if (ret)
+		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
+
+	len = snprintf(buf, sizeof(buf), "0x%X\n", val);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+}
+
+static ssize_t iio_debugfs_write_reg(struct file *file,
+		     const char __user *userbuf, size_t count, loff_t *ppos)
+{
+	struct iio_dev *indio_dev = file->private_data;
+	unsigned reg, val;
+	char buf[80];
+	int ret;
+
+	count = min_t(size_t, count, (sizeof(buf)-1));
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	buf[count] = 0;
+
+	ret = sscanf(buf, "%i %i", &reg, &val);
+
+	switch (ret) {
+	case 1:
+		indio_dev->cached_reg_addr = reg;
+		break;
+	case 2:
+		indio_dev->cached_reg_addr = reg;
+		ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
+							  val, NULL);
+		if (ret) {
+			dev_err(indio_dev->dev.parent, "%s: write failed\n",
+				__func__);
+			return ret;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations iio_debugfs_reg_fops = {
+	.open = iio_debugfs_open,
+	.read = iio_debugfs_read_reg,
+	.write = iio_debugfs_write_reg,
+};
+
+static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
+{
+	debugfs_remove_recursive(indio_dev->debugfs_dentry);
 }

+static int iio_device_register_debugfs(struct iio_dev *indio_dev)
+{
+	struct dentry *d;
+
+	if (indio_dev->info->debugfs_reg_access == NULL)
+		return 0;
+
+	if (IS_ERR(iio_debugfs_dentry))
+		return 0;
+
+	indio_dev->debugfs_dentry =
+		debugfs_create_dir(dev_name(&indio_dev->dev),
+				   iio_debugfs_dentry);
+	if (IS_ERR(indio_dev->debugfs_dentry))
+		return PTR_ERR(indio_dev->debugfs_dentry);
+
+	if (indio_dev->debugfs_dentry == NULL) {
+		dev_warn(indio_dev->dev.parent,
+			 "Failed to create debugfs directory\n");
+		return -EFAULT;
+	}
+
+	d = debugfs_create_file("direct_reg_access", 0644,
+				indio_dev->debugfs_dentry,
+				indio_dev, &iio_debugfs_reg_fops);
+	if (!d) {
+		iio_device_unregister_debugfs(indio_dev);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+#else
+static int iio_device_register_debugfs(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -565,6 +691,7 @@ static void iio_dev_release(struct device *device)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
+	iio_device_unregister_debugfs(indio_dev);
 }

 static struct device_type iio_dev_type = {
@@ -680,11 +807,17 @@ int iio_device_register(struct iio_dev *indio_dev)
 	/* configure elements for the chrdev */
 	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);

+	ret = iio_device_register_debugfs(indio_dev);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+			"Failed to register debugfs interfaces\n");
+		goto error_ret;
+	}
 	ret = iio_device_register_sysfs(indio_dev);
 	if (ret) {
 		dev_err(indio_dev->dev.parent,
 			"Failed to register sysfs interfaces\n");
-		goto error_ret;
+		goto error_unreg_debugfs;
 	}
 	ret = iio_device_register_eventset(indio_dev);
 	if (ret) {
@@ -711,6 +844,8 @@ error_unreg_eventset:
 	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
 	iio_device_unregister_sysfs(indio_dev);
+error_unreg_debugfs:
+	iio_device_unregister_debugfs(indio_dev);
 error_ret:
 	return ret;
 }
--
1.7.0.4


