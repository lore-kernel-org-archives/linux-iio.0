Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35012 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbcCATC5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2016 14:02:57 -0500
From: Alison Schofield <amsfield22@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: [RFC PATCH 1/2] iio: core: implement iio_{claim|release}_direct_mode()
Date: Tue,  1 Mar 2016 11:02:45 -0800
Message-Id: <9a2950402af7277a4928a10eade4cc8b1187d8c8.1456794364.git.amsfield22@gmail.com>
In-Reply-To: <cover.1456794364.git.amsfield22@gmail.com>
References: <cover.1456794364.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is often the case that the driver wants to be sure a device stays
in direct mode while it is executing a task or series of tasks.  To
accomplish this today, the driver performs this sequence: 1) take the
device state lock, 2)verify it is not in a buffered mode, 3) execute
some tasks, and 4) release that lock.

This patch introduces a pair of helper functions that simplify these
steps and make it more semantically expressive.

iio_claim_direct_mode()
        If the device is not in any buffered mode it is guaranteed
        to stay that way until iio_release_direct_mode() is called.

iio_release_direct_mode()
        Release the claim. Device is no longer guaranteed to stay
        in direct mode.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/industrialio-core.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 70cb7eb..f6f0c89 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
+#include <linux/mutex.h>
 #include <linux/iio/iio.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
@@ -1375,6 +1376,44 @@ void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
 
+/**
+ * iio_claim_direct_mode - Keep device in direct mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * If the device is in direct mode it is guaranteed to
+ * stay that way until iio_release_direct_mode() is called.
+ *
+ * Use with iio_release_direct_mode()
+ *
+ * Returns: 0 on success, -EINVAL on failure
+ */
+int iio_claim_direct_mode(struct iio_dev *indio_dev)
+{
+	mutex_lock(&indio_dev->mlock);
+
+	if (iio_buffer_enabled(indio_dev)) {
+		mutex_unlock(&indio_dev->mlock);
+		return -EINVAL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_claim_direct_mode);
+
+/**
+ * iio_release_direct_mode - releases claim on direct mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * Release the claim. Device is no longer guaranteed to stay
+ * in direct mode.
+ *
+ * Use with iio_claim_direct_mode()
+ */
+void iio_release_direct_mode(struct iio_dev *indio_dev)
+{
+	mutex_unlock(&indio_dev->mlock);
+}
+EXPORT_SYMBOL_GPL(iio_release_direct_mode);
+
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ce9e9c1..9efe2af 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -527,6 +527,8 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
 void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
+int iio_claim_direct_mode(struct iio_dev *indio_dev);
+void iio_release_direct_mode(struct iio_dev *indio_dev);
 
 extern struct bus_type iio_bus_type;
 
-- 
2.1.4

