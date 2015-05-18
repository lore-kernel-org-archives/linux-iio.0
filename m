Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26832 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932230AbbERQYU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 May 2015 12:24:20 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] iio: pm_runtime: Introduce PM runtime helper functions
Date: Mon, 18 May 2015 19:25:27 +0300
Message-Id: <1431966328-11058-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com>
References: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We need this in order to avoid reimplementing the same functions each time
we add PM runtime support in a driver.

Simple grep shows the following users:
	* accel/mma9551.c
	* accel/mmc9553.c
	* accel/kxcjk1013.c
	* accel/bmc150-accel.c
	* gyro/bmg160.c
	* imu/kmx61.c
	* common/hid-sensors.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 include/linux/iio/pm_runtime.h | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 include/linux/iio/pm_runtime.h

diff --git a/include/linux/iio/pm_runtime.h b/include/linux/iio/pm_runtime.h
new file mode 100644
index 0000000..dc2bca7
--- /dev/null
+++ b/include/linux/iio/pm_runtime.h
@@ -0,0 +1,63 @@
+/*
+ * Industrial I/O runtime PM helper functions
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ */
+#ifndef __IIO_PM_RUNTIME
+#define __IIO_PM_RUNTIME
+
+#include <linux/pm_runtime.h>
+
+static inline int iio_pm_runtime_setup(struct device *dev, int delay,
+				       bool ignore_children)
+{
+	int ret;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
+	pm_suspend_ignore_children(dev, ignore_children);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, delay);
+	pm_runtime_use_autosuspend(dev);
+
+	return 0;
+}
+
+static inline void iio_pm_runtime_cleanup(struct device *dev)
+{
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+}
+
+static inline int iio_pm_runtime_set_power(struct device *dev, bool on)
+{
+#ifdef CONFIG_PM
+	int ret;
+
+	if (on)
+		ret = pm_runtime_get_sync(dev);
+	else {
+		pm_runtime_mark_last_busy(dev);
+		ret = pm_runtime_put_autosuspend(dev);
+	}
+
+	if (ret < 0) {
+		dev_err(dev, "Failed: iio_set_power_state for %d\n", on);
+		if (on)
+			pm_runtime_put_noidle(dev);
+
+		return ret;
+	}
+#endif
+	return 0;
+}
+
+#endif /* __IIO_PM_RUNTIME */
-- 
1.9.1

