Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615681;
	b=IiDB2MB7h25pjwD4VUD7PHQIUFd597uKJ3+2GtMx6kpgMwSHkqo6lUQUUUSC21DYhgQk
	 8fkR27fS7ER6E6SldVq6xXruuDNO2o+RTDT53HKxz0veDq6aSOQTXtJLgCnRWnM+srqGe
	 ocwP95a/Uyqy/icRk/cLxz0+DLI4JmI4x6/KU0lADOFcmox6FPURxuyfHTznk5kedoS9G
	 i9rJP3M7ssLpCh2eXc2EayrEYblxgjX3Fji3NaIebGpCGa+dAvGYMT0abmtNJVy1HZt6Q
	 e096LIesHemwfqDJzZ238z08YyFeXhajKetsOFj6tguIeIWOmqistTYJIeg9ZXr/GGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615681;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s3S1uYBbe+WLK8+jZTyXSDlqlksALYY7qobhGP7XXv8=;
	b=bgImYtFPfqa5fP90WrNeZvGK10FFN86UMVGKtbobRh4l69R6qICsHK+KCi752VhPcl07
	 b2h/iSwG97jsMp6vto8ZLVbuOUR9WWCe4n1r52xOmSJdRxl4Chqy5U8kCYL8ZjRvhkZyP
	 UfQvLwDigtBN09Msb81bWs0A82Y4tHG3tJMcuNJD24lIsEhZi1sfsLTJK54fq+Ycs8m9v
	 gaNUcV2WzlVgZX1X85Q1oX3EestEkw7xemSDeDqJz3wFrxGpwyho1PQe++9gAG5YYDF5F
	 i5fIugzMSmtxEeiX53KXVfKL97Td057rJtCN68mOgOVxKNjc/uww+JxPuQ9tz7a4dTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mAXBMk/x";
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A94606A337;
	Wed, 25 Nov 2026 14:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6A94606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mAXBMk/x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795615681; x=1827151681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ksb2Bww5z94lYzGvv45MK0EVzGB4VMgn1QMrqYZ/M1A=;
  b=mAXBMk/xfZ1+hlfOduirPDBwlJYZZYyHys3ytnsegtMQY6l7R0sbWPs3
   bHqiRChZHyOPxm+8mQ2yqD7kV+E6o6KLigD4vDC64oCrIC3h9EQS+Imi5
   vvvJEBgSl5yuZ0UvH9nzL8PdjFCdvN21LAMFj9dB0xTZbIcWu0dqnIawP
   pjRjQarl4Nwpfttb/bkXievCz1z1w1Jg55vvw8LdbKTS0qJ47t1ojrmbV
   NfonP41BM3RWv7UBGN4rckaDZysG4p/VDY9ih0tcQ2ntKBpUUHC1i5MFN
   UQ2V9IbQCCS3XzRz/W6bsFAtw5amSxTilIVFavejZFx6mgVo4dbBOX2zE
   w==;
X-CSE-ConnectionGUID: 3jSoB2i4Qyi0T3qZQReDlg==
X-CSE-MsgGUID: 4eJnYg0WQ4WUGOk56OgcLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4501263"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4501263"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:02:58 -0800
X-CSE-ConnectionGUID: lVvw+SdIQwuWFcZiWAPniw==
X-CSE-MsgGUID: 24SkPS3MST+VeJF6Dv/rcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12202536"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 25 Nov 2026 06:02:54 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4072298; Wed, 25 Nov 2026 15:02:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v2 1/1] iio: core: Split debugfs routines
Date: Wed, 25 Nov 2026 14:59:40 +0100
Message-ID: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Split debugfs routines into a separate file for easier maintenance.
No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---

v2: fixed compilation errors (LKP, Joshua)

Cc: Rupesh Majhi <zoone.rupert@gmail.com>
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
index 8c4a4e765834..5f9d6e852286 100644
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
index 000000000000..a8a3c7a3e85d
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
+void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
+}
+
+void iio_device_register_debugfs(struct iio_dev *indio_dev)
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

