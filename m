Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:34953 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473Ab1CQU7Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Mar 2011 16:59:24 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/8] staging:iio: iio_trigger_unregister - remove rather strange search for what we already have.
Date: Thu, 17 Mar 2011 21:00:21 +0000
Message-Id: <1300395627-18547-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
References: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 714ce06..083847c 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -134,14 +134,8 @@ EXPORT_SYMBOL(iio_trigger_register);
 
 void iio_trigger_unregister(struct iio_trigger *trig_info)
 {
-	struct iio_trigger *cursor;
-
 	mutex_lock(&iio_trigger_list_lock);
-	list_for_each_entry(cursor, &iio_trigger_list, list)
-		if (cursor == trig_info) {
-			list_del(&cursor->list);
-			break;
-		}
+	list_del(&trig_info->list);
 	mutex_unlock(&iio_trigger_list_lock);
 
 	iio_trigger_unregister_sysfs(trig_info);
-- 
1.7.3.4

