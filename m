Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/13] staging:iio: Move event attributes into the event[n] device in sysfs
Date: Sun, 28 Mar 2010 21:41:12 +0100
Message-Id: <1269808879-28838-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1269808879-28838-6-git-send-email-jic23@cam.ac.uk>
References: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-2-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-3-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-4-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-5-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-6-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 3312d9a..1f49f09 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -675,16 +675,14 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 					 dev_info->event_interfaces[i].id);
 			goto error_free_setup_ev_ints;
 		}
-	}
 
-	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
-		snprintf(dev_info->event_interfaces[i]._attrname, 20,
-			"event_line%d_sources", i);
-		dev_info->event_attrs[i].name
-			= (const char *)
-			(dev_info->event_interfaces[i]._attrname);
-		ret = sysfs_create_group(&dev_info->dev.kobj,
-					 &dev_info->event_attrs[i]);
+		dev_set_drvdata(&dev_info->event_interfaces[i].dev,
+				(void *)dev_info);
+		ret = sysfs_create_group(&dev_info
+					->event_interfaces[i]
+					.dev.kobj,
+					&dev_info->event_attrs[i]);
+
 		if (ret) {
 			dev_err(&dev_info->dev,
 				"Failed to register sysfs for event attrs");
@@ -706,13 +704,13 @@ error_unregister_config_attrs:
 	i = dev_info->num_interrupt_lines - 1;
 error_remove_sysfs_interfaces:
 	for (j = 0; j < i; j++)
-		sysfs_remove_group(&dev_info->dev.kobj,
+		sysfs_remove_group(&dev_info
+				   ->event_interfaces[j].dev.kobj,
 				   &dev_info->event_attrs[j]);
-	i = dev_info->num_interrupt_lines - 1;
 error_free_setup_ev_ints:
 	for (j = 0; j < i; j++) {
 		iio_free_idr_val(&iio_event_idr,
-				 dev_info->event_interfaces[i].id);
+				 dev_info->event_interfaces[j].id);
 		iio_free_ev_int(&dev_info->event_interfaces[j]);
 	}
 	kfree(dev_info->interrupts);
@@ -730,7 +728,8 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 	if (dev_info->num_interrupt_lines == 0)
 		return;
 	for (i = 0; i < dev_info->num_interrupt_lines; i++)
-		sysfs_remove_group(&dev_info->dev.kobj,
+		sysfs_remove_group(&dev_info
+				   ->event_interfaces[i].dev.kobj,
 				   &dev_info->event_attrs[i]);
 
 	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
-- 
1.6.4.4
