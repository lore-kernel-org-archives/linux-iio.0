Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/9] staging:iio:triggers. Add a reference get to the core for triggers.
Date: Wed, 24 Aug 2011 17:28:33 +0100
Message-Id: <1314203321-21926-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
References: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is to do with dynamically allocated triggers and the need to ensure
the underlying structures don't go away when a consumer is using them.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index ebacfda..89a9934 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/device.h>
@@ -478,6 +477,7 @@ struct iio_trigger *iio_allocate_trigger(const char *fmt, ...)
 					  IRQ_NOPROBE);
 		}
 		iio_get();
+		get_device(&trig->dev);
 	}
 	return trig;
 }
@@ -501,6 +501,9 @@ EXPORT_SYMBOL(iio_device_register_trigger_consumer);
 
 int iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
 {
+	/* Clean up and associated but not attached triggers references */
+	if (dev_info->trig)
+		iio_put_trigger(dev_info->trig);
 	sysfs_remove_group(&dev_info->dev.kobj,
 			   &iio_trigger_consumer_attr_group);
 	return 0;
-- 
1.7.3.4
