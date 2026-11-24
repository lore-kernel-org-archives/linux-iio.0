Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514371;
	b=l6dgy6w1laBZeW6WoRUQrEEe2AeFl+Z7QFgM9movoxZvnoOlcTv55aWkd24sHnfN9jAK
	 RbNSUHhL68niHNxVjfhQ4BIYeZ0QKnQUGKywsHyH2YL0W5q/1jiW4PZFduU5meNIgkMpY
	 avACqxzyp6mWGxcTPQroUhIONaSlFKKiSceB+JP0c5lcqwfuSEtd/b30Ah/dbfzJchmtC
	 38KdBA4VeBCJb0V4kkXEIAvIPfX5G8IutuXdieqtrBmGmnmQmInd/v4TnDn1859UMsktq
	 BifmfwEP57UdokS7jabKSul1XsYNLr0OvQf6hM43zZ+TyK75/ttLuwycwWUXmjNQhmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514371;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c2KcwtXX9je21qNR2k8lhPjTHAW6HMkTXQlq7dKiu+4=;
	b=ejdH4PpfaL57ACQsQxcvpmgX35o4zL0uEBq4oJXaji9tlmBfb0a9U0lDafot7jGD+cDq
	 EB+j+1Z0ITn/JVsiB+30WhdGR1ul/0rXg9C2DJREd9bQgYy/ccEor4VG4NEyibt+dZFW5
	 CmWJjzXETsff8d9LMQT1uguId6wNfSNJAmGxYqD+ziE/mSegL3M7cUQHANy3cSSjq/2By
	 P3lYNsdbUZk+Sd4CwXj06RwSjdbV2FBLukPbY0TEBevV5XRewMGBtsrYdbH+hlSJW5584
	 iXiQ5ZwYgLq4O2fg4rXT9/fPNNlWJFhAnUTMhpPkrXI9IztJM+AczYqCmBCPHh/KGMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="fx+yc/Xp";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA6606A326;
	Tue, 24 Nov 2026 09:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93AA6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fx+yc/Xp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795514371; x=1827050371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XjVgSNl4Up2dlfJFOXwJlAkx1MGplOdwLrVoq6QPgX0=;
  b=fx+yc/XpGpMcP/WbyPZE+ZLVA/J4MTVl77CBdlurxf5cTuVtLrjm5lwr
   1SFUDAeAFsKq8GkWaj5OjQe2RWpEuaHJCSs6kWVXwxkhr8ySfNvv6UNp/
   hWXND0ibMUkYaXWLUfVKiD26NrGJPf5SFWT7LmNyYHvUEge/Y4C+uBZY7
   8UwFG++0PfsUYlnTOP4V4HTrrc0328iebGbIn4Y/khUV0N7sOO/7IEQ+C
   OwHgwrKeB1YLzCLNg6aIVA+UZxyxpFbbft530om+NL/gii8/BRubwO4vg
   v7z0FqgCxaKrMsNC743rdgaeOJUW/dk0MQfgznzhLSEu6AvgMz6/bzMAL
   A==;
X-CSE-ConnectionGUID: 1hTQj9ytSxy0QN0/i3SriQ==
X-CSE-MsgGUID: /v6YnTrTS1q9TX/BoapcpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4192180"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4192180"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:45:09 -0800
X-CSE-ConnectionGUID: RpgZRUkxTXuAqrwGFBHKpw==
X-CSE-MsgGUID: uUeD4KhdQ9SQQL6PDIClTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11567160"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2026 01:45:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A74469D; Tue, 24 Nov 2026 10:45:04 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v1 1/1] iio: core: Split debugfs routines
Date: Tue, 24 Nov 2026 10:44:10 +0100
Message-ID: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split debugfs routines into a separate file for easier maintenance.
No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Rupesh, feel free to include this patch into your series as the first one.

Fun fact: This patch was written with zero AI assistance.

 drivers/iio/Makefile               |   1 +
 drivers/iio/iio_core.h             |  14 +++
 drivers/iio/industrialio-core.c    | 152 +-------------------------
 drivers/iio/industrialio-debugfs.c | 165 +++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+), 150 deletions(-)
 create mode 100644 drivers/iio/industrialio-debugfs.c

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 8a897b6729d2..5fd81b20da22 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -8,6 +8,7 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 industrialio-$(CONFIG_ACPI) += industrialio-acpi.o
+industrialio-$(CONFIG_DEBUG_FS) += industrialio-debugfs.o
 
 obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
 obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 59fa1bd9924b..985ac82a37f9 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -16,6 +16,20 @@ struct iio_buffer;
 struct iio_chan_spec;
 struct iio_dev;
 
+#if defined(CONFIG_DEBUG_FS)
+void iio_debugfs_create(void);
+void iio_debugfs_remove(void);
+
+void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
+void iio_device_register_debugfs(struct iio_dev *indio_dev);
+#else
+static inline void iio_debugfs_create(void) {}
+static inline void iio_debugfs_remove(void) {}
+
+static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
+static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}
+#endif /* CONFIG_DEBUG_FS */
+
 extern const struct device_type iio_device_type;
 
 struct iio_dev_buffer_pair {
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 792c2d28835b..3b66d7b765d5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -14,7 +14,6 @@
 #include <linux/anon_inodes.h>
 #include <linux/cdev.h>
 #include <linux/cleanup.h>
-#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -54,8 +53,6 @@ const struct bus_type iio_bus_type = {
 };
 EXPORT_SYMBOL(iio_bus_type);
 
-static struct dentry *iio_debugfs_dentry;
-
 static const char * const iio_direction[] = {
 	[0] = "in",
 	[1] = "out",
@@ -293,20 +290,6 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_buffer_enabled);
 
-#if defined(CONFIG_DEBUG_FS)
-/*
- * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
- * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
- */
-struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
-{
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-
-	return iio_dev_opaque->debugfs_dentry;
-}
-EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
-#endif
-
 /**
  * iio_find_channel_from_si() - get channel from its scan index
  * @indio_dev:		device
@@ -427,7 +410,7 @@ static int __init iio_init(void)
 		goto error_unregister_bus_type;
 	}
 
-	iio_debugfs_dentry = debugfs_create_dir("iio", NULL);
+	iio_debugfs_create();
 
 	return 0;
 
@@ -442,140 +425,9 @@ static void __exit iio_exit(void)
 	if (iio_devt)
 		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
 	bus_unregister(&iio_bus_type);
-	debugfs_remove(iio_debugfs_dentry);
+	iio_debugfs_remove();
 }
 
-#if defined(CONFIG_DEBUG_FS)
-static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
-			      size_t count, loff_t *ppos)
-{
-	struct iio_dev *indio_dev = file->private_data;
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	unsigned int val = 0;
-	u64 val64 = 0;
-	int ret;
-
-	if (*ppos > 0)
-		return simple_read_from_buffer(userbuf, count, ppos,
-					       iio_dev_opaque->read_buf,
-					       iio_dev_opaque->read_buf_len);
-
-	if (indio_dev->info->debugfs_reg64_access) {
-		ret = indio_dev->info->debugfs_reg64_access(indio_dev,
-							    iio_dev_opaque->cached_reg_addr,
-							    0, &val64);
-	} else {
-		ret = indio_dev->info->debugfs_reg_access(indio_dev,
-							  iio_dev_opaque->cached_reg_addr,
-							  0, &val);
-		val64 = val;
-	}
-
-	if (ret) {
-		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
-		return ret;
-	}
-
-	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
-						sizeof(iio_dev_opaque->read_buf),
-						"0x%llX\n", val64);
-
-	return simple_read_from_buffer(userbuf, count, ppos,
-				       iio_dev_opaque->read_buf,
-				       iio_dev_opaque->read_buf_len);
-}
-
-static ssize_t iio_debugfs_write_reg(struct file *file,
-		     const char __user *userbuf, size_t count, loff_t *ppos)
-{
-	struct iio_dev *indio_dev = file->private_data;
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	unsigned int reg;
-	char buf[80];
-	u64 val64;
-	int ret;
-
-	if (*ppos != 0 || count >= sizeof(buf))
-		return -EINVAL;
-
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
-				     count);
-	if (ret < 0)
-		return ret;
-
-	buf[ret] = '\0';
-
-	ret = sscanf(buf, "%i %lli", &reg, &val64);
-
-	switch (ret) {
-	case 1:
-		iio_dev_opaque->cached_reg_addr = reg;
-		break;
-	case 2:
-		iio_dev_opaque->cached_reg_addr = reg;
-		if (indio_dev->info->debugfs_reg64_access)
-			ret = indio_dev->info->debugfs_reg64_access(indio_dev, reg,
-								    val64, NULL);
-		else
-			ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
-								  val64, NULL);
-		if (ret) {
-			dev_err(indio_dev->dev.parent, "%s: write failed\n",
-				__func__);
-			return ret;
-		}
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return count;
-}
-
-static const struct file_operations iio_debugfs_reg_fops = {
-	.open = simple_open,
-	.read = iio_debugfs_read_reg,
-	.write = iio_debugfs_write_reg,
-};
-
-static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
-{
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-
-	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
-}
-
-static void iio_device_register_debugfs(struct iio_dev *indio_dev)
-{
-	struct iio_dev_opaque *iio_dev_opaque;
-
-	if (!indio_dev->info->debugfs_reg_access &&
-	    !indio_dev->info->debugfs_reg64_access)
-		return;
-
-	if (!iio_debugfs_dentry)
-		return;
-
-	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-
-	iio_dev_opaque->debugfs_dentry =
-		debugfs_create_dir(dev_name(&indio_dev->dev),
-				   iio_debugfs_dentry);
-
-	debugfs_create_file("direct_reg_access", 0644,
-			    iio_dev_opaque->debugfs_dentry, indio_dev,
-			    &iio_debugfs_reg_fops);
-}
-#else
-static void iio_device_register_debugfs(struct iio_dev *indio_dev)
-{
-}
-
-static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
-{
-}
-#endif /* CONFIG_DEBUG_FS */
-
 static ssize_t iio_read_channel_ext_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
diff --git a/drivers/iio/industrialio-debugfs.c b/drivers/iio/industrialio-debugfs.c
new file mode 100644
index 000000000000..7ceeb88f9276
--- /dev/null
+++ b/drivers/iio/industrialio-debugfs.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Industrial I/O debugfs bits
+ */
+
+#include <linux/cdev.h>
+#include <linux/debugfs.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/sprintf.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/iio-opaque.h>
+
+#include "iio_core.h"
+
+static struct dentry *iio_debugfs_dentry;
+
+/*
+ * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
+ * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
+ */
+struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	return iio_dev_opaque->debugfs_dentry;
+}
+EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
+
+void __init iio_debugfs_create(void)
+{
+	iio_debugfs_dentry = debugfs_create_dir("iio", NULL);
+}
+
+void __exit iio_debugfs_remove(void)
+{
+	debugfs_remove(iio_debugfs_dentry);
+}
+
+static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	struct iio_dev *indio_dev = file->private_data;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	unsigned int val = 0;
+	u64 val64 = 0;
+	int ret;
+
+	if (*ppos > 0)
+		return simple_read_from_buffer(userbuf, count, ppos,
+					       iio_dev_opaque->read_buf,
+					       iio_dev_opaque->read_buf_len);
+
+	if (indio_dev->info->debugfs_reg64_access) {
+		ret = indio_dev->info->debugfs_reg64_access(indio_dev,
+							    iio_dev_opaque->cached_reg_addr,
+							    0, &val64);
+	} else {
+		ret = indio_dev->info->debugfs_reg_access(indio_dev,
+							  iio_dev_opaque->cached_reg_addr,
+							  0, &val);
+		val64 = val;
+	}
+
+	if (ret) {
+		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
+		return ret;
+	}
+
+	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
+						sizeof(iio_dev_opaque->read_buf),
+						"0x%llX\n", val64);
+
+	return simple_read_from_buffer(userbuf, count, ppos,
+				       iio_dev_opaque->read_buf,
+				       iio_dev_opaque->read_buf_len);
+}
+
+static ssize_t iio_debugfs_write_reg(struct file *file,
+		     const char __user *userbuf, size_t count, loff_t *ppos)
+{
+	struct iio_dev *indio_dev = file->private_data;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	unsigned int reg;
+	char buf[80];
+	u64 val64;
+	int ret;
+
+	if (*ppos != 0 || count >= sizeof(buf))
+		return -EINVAL;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
+				     count);
+	if (ret < 0)
+		return ret;
+
+	buf[ret] = '\0';
+
+	ret = sscanf(buf, "%i %lli", &reg, &val64);
+
+	switch (ret) {
+	case 1:
+		iio_dev_opaque->cached_reg_addr = reg;
+		break;
+	case 2:
+		iio_dev_opaque->cached_reg_addr = reg;
+		if (indio_dev->info->debugfs_reg64_access)
+			ret = indio_dev->info->debugfs_reg64_access(indio_dev, reg,
+								    val64, NULL);
+		else
+			ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
+								  val64, NULL);
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
+	.open = simple_open,
+	.read = iio_debugfs_read_reg,
+	.write = iio_debugfs_write_reg,
+};
+
+static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
+}
+
+static void iio_device_register_debugfs(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque;
+
+	if (!indio_dev->info->debugfs_reg_access &&
+	    !indio_dev->info->debugfs_reg64_access)
+		return;
+
+	if (!iio_debugfs_dentry)
+		return;
+
+	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	iio_dev_opaque->debugfs_dentry =
+		debugfs_create_dir(dev_name(&indio_dev->dev),
+				   iio_debugfs_dentry);
+
+	debugfs_create_file("direct_reg_access", 0644,
+			    iio_dev_opaque->debugfs_dentry, indio_dev,
+			    &iio_debugfs_reg_fops);
+}
-- 
2.50.1

