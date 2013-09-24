Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:53154 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3IXMFk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2013 08:05:40 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so4555569pdi.28
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2013 05:05:39 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 1/8] iio: core: Implement devm_iio_device_{register,unregister}
Date: Tue, 24 Sep 2013 17:35:31 +0530
Message-Id: <1380024338-30204-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
References: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device managed devm_iio_device_{register,unregister}()
to automatically unregister IIO drivers thus leading to
simplified IIO driver code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 Documentation/driver-model/devres.txt |    2 ++
 drivers/iio/industrialio-core.c       |   35 +++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h               |   25 +++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index fcb34a5..ffeab1d 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -242,6 +242,8 @@ IIO
   devm_iio_device_free()
   devm_iio_trigger_alloc()
   devm_iio_trigger_free()
+  devm_iio_device_register()
+  devm_iio_device_unregister()
 
 IO region
   devm_request_region()
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 24db185..58f494b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1125,6 +1125,41 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	device_del(&indio_dev->dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
+
+static void devm_iio_device_unreg(struct device *dev, void *res)
+{
+	iio_device_unregister(*(struct iio_dev **)res);
+}
+
+int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
+{
+	void *ptr;
+	int iio_dev;
+
+	ptr = devres_alloc(devm_iio_device_unreg, 0, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	iio_dev = iio_device_register(indio_dev);
+	if (!iio_dev)
+		devres_add(dev, ptr);
+	else
+		devres_free(ptr);
+
+	return iio_dev;
+}
+EXPORT_SYMBOL_GPL(devm_iio_device_register);
+
+void devm_iio_device_unregister(struct device *dev, struct iio_dev *iio_dev)
+{
+	int rc;
+
+	rc = devres_release(dev, devm_iio_device_unreg,
+			    devm_iio_device_match, iio_dev);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
+
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ac1cb8f..be16dd6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -453,6 +453,31 @@ int iio_device_register(struct iio_dev *indio_dev);
 void iio_device_unregister(struct iio_dev *indio_dev);
 
 /**
+ * devm_iio_device_register - Resource-managed iio_device_register()
+ * @dev:	Device to allocate iio_dev for
+ * @indio_dev:	Device structure filled by the device driver
+ *
+ * Managed iio_device_register.  iio_dev registered with this function is
+ * automatically unregistered on driver detach.
+ *
+ * If an iio_dev registered with this function needs to be unregistered
+ * separately, devm_iio_device_unregister() must be used.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
+
+/**
+ * devm_iio_device_unregister - Resource-managed iio_device_unregister()
+ * @dev:	Device this iio_dev belongs to
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * Unregister iio_dev registered with devm_iio_device_register().
+ */
+void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
+
+/**
  * iio_push_event() - try to add event to the list for userspace reading
  * @indio_dev:		IIO device structure
  * @ev_code:		What event
-- 
1.7.9.5

