Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34427 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab3JXLym (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 07:54:42 -0400
Received: by mail-pa0-f46.google.com with SMTP id rd3so2042598pab.19
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2013 04:54:41 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 1/9] iio: core: Use pr_err instead of printk
Date: Thu, 24 Oct 2013 17:23:27 +0530
Message-Id: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use of pr_err is preferred to printk.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/industrialio-core.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f721157..e4780b4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -9,6 +9,8 @@
  * Based on elements of hwmon and input subsystems.
  */
 
+#define pr_fmt(fmt) "iio-core: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/idr.h>
@@ -132,16 +134,13 @@ static int __init iio_init(void)
 	/* Register sysfs bus */
 	ret  = bus_register(&iio_bus_type);
 	if (ret < 0) {
-		printk(KERN_ERR
-		       "%s could not register bus type\n",
-			__FILE__);
+		pr_err("could not register bus type\n");
 		goto error_nothing;
 	}
 
 	ret = alloc_chrdev_region(&iio_devt, 0, IIO_DEV_MAX, "iio");
 	if (ret < 0) {
-		printk(KERN_ERR "%s: failed to allocate char dev region\n",
-		       __FILE__);
+		pr_err("failed to allocate char dev region\n");
 		goto error_unregister_bus_type;
 	}
 
@@ -951,7 +950,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
 		if (dev->id < 0) {
 			/* cannot use a dev_err as the name isn't available */
-			printk(KERN_ERR "Failed to get id\n");
+			pr_err("failed to get device id\n");
 			kfree(dev);
 			return NULL;
 		}
-- 
1.7.9.5

