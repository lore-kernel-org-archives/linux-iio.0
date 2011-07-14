Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49456 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1GNMdt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2011 08:33:49 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/7] staging:iio:core flatten convenience function that only has one user.
Date: Thu, 14 Jul 2011 13:33:42 +0100
Message-Id: <1310646827-25690-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
References: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix trivial wrong index (no effect on any current drivers).

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 7d15bce..d0e039b 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -991,18 +991,17 @@ error_ret:
 	return ret;
 }
 
-static inline void __iio_remove_all_event_sysfs(struct iio_dev *dev_info,
-						const char *groupname,
-						int num)
+static inline void __iio_remove_event_config_attrs(struct iio_dev *dev_info,
+						  int i)
 {
 	struct iio_dev_attr *p, *n;
 	list_for_each_entry_safe(p, n,
-				 &dev_info->event_interfaces[num].
+				 &dev_info->event_interfaces[i].
 				 dev_attr_list, l) {
 		sysfs_remove_file_from_group(&dev_info
-					     ->event_interfaces[num].dev.kobj,
+					     ->event_interfaces[i].dev.kobj,
 					     &p->dev_attr.attr,
-					     groupname);
+					     NULL);
 		kfree(p->dev_attr.attr.name);
 		kfree(p);
 	}
@@ -1012,7 +1011,7 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
 {
 	int j;
 	int ret;
-	INIT_LIST_HEAD(&dev_info->event_interfaces[0].dev_attr_list);
+	INIT_LIST_HEAD(&dev_info->event_interfaces[i].dev_attr_list);
 	/* Dynically created from the channels array */
 	if (dev_info->channels) {
 		for (j = 0; j < dev_info->num_channels; j++) {
@@ -1026,18 +1025,11 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
 	return 0;
 
 error_clear_attrs:
-	__iio_remove_all_event_sysfs(dev_info, NULL, i);
+	__iio_remove_event_config_attrs(dev_info, i);
 
 	return ret;
 }
 
-static inline int __iio_remove_event_config_attrs(struct iio_dev *dev_info,
-						  int i)
-{
-	__iio_remove_all_event_sysfs(dev_info, NULL, i);
-	return 0;
-}
-
 static int iio_device_register_eventset(struct iio_dev *dev_info)
 {
 	int ret = 0, i, j;
-- 
1.7.3.4

