Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49460 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab1GNMdt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2011 08:33:49 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/7] staging:iio:core simplify and fix a bug in iio_device_(un)register_event_set.
Date: Thu, 14 Jul 2011 13:33:41 +0100
Message-Id: <1310646827-25690-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
References: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The unwinding index was j, not i and it is much simpler to do these as a single
loop unwinding those elements necessary in before jumping to the error handler.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |   40 +++++++++++++++---------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index a9628ed..7d15bce 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1063,7 +1063,7 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 		if (ret) {
 			dev_err(&dev_info->dev,
 				"Could not get chrdev interface\n");
-			goto error_free_setup_ev_ints;
+			goto error_free_setup_event_lines;
 		}
 
 		dev_set_drvdata(&dev_info->event_interfaces[i].dev,
@@ -1079,31 +1079,33 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 		if (ret) {
 			dev_err(&dev_info->dev,
 				"Failed to register sysfs for event attrs");
-			goto error_remove_sysfs_interfaces;
+			iio_free_ev_int(&dev_info->event_interfaces[i]);
+			goto error_free_setup_event_lines;
 		}
-	}
-
-	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
 		ret = __iio_add_event_config_attrs(dev_info, i);
-		if (ret)
-			goto error_unregister_config_attrs;
+		if (ret) {
+			if (dev_info->info->event_attrs != NULL)
+				sysfs_remove_group(&dev_info
+						   ->event_interfaces[i]
+						   .dev.kobj,
+						   &dev_info->info
+						   ->event_attrs[i]);
+			iio_free_ev_int(&dev_info->event_interfaces[i]);
+			goto error_free_setup_event_lines;
+		}
 	}
 
 	return 0;
 
-error_unregister_config_attrs:
-	for (j = 0; j < i; j++)
-		__iio_remove_event_config_attrs(dev_info, i);
-	i = dev_info->info->num_interrupt_lines - 1;
-error_remove_sysfs_interfaces:
-	for (j = 0; j < i; j++)
+error_free_setup_event_lines:
+	for (j = 0; j < i; j++) {
+		__iio_remove_event_config_attrs(dev_info, j);
 		if (dev_info->info->event_attrs != NULL)
 			sysfs_remove_group(&dev_info
-				   ->event_interfaces[j].dev.kobj,
-				   &dev_info->info->event_attrs[j]);
-error_free_setup_ev_ints:
-	for (j = 0; j < i; j++)
+					   ->event_interfaces[j].dev.kobj,
+					   &dev_info->info->event_attrs[j]);
 		iio_free_ev_int(&dev_info->event_interfaces[j]);
+	}
 	kfree(dev_info->event_interfaces);
 error_ret:
 
@@ -1122,10 +1124,8 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 			sysfs_remove_group(&dev_info
 					   ->event_interfaces[i].dev.kobj,
 					   &dev_info->info->event_attrs[i]);
-	}
-
-	for (i = 0; i < dev_info->info->num_interrupt_lines; i++)
 		iio_free_ev_int(&dev_info->event_interfaces[i]);
+	}
 	kfree(dev_info->event_interfaces);
 }
 
-- 
1.7.3.4

