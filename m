Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: jbrenner@taosinc.com,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/8] staging:iio: iio_trigger_unregister - remove rather strange search for what we already have.
Date: Fri, 15 Apr 2011 18:55:54 +0100
Message-Id: <1302890160-8823-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
References: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
