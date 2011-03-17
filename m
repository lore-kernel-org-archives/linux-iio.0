Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/8] staging:iio:trigger remove export of iio_trigger_find_by_name, use sysfs_streq for matching
Date: Thu, 17 Mar 2011 21:00:20 +0000
Message-Id: <1300395627-18547-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
References: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Trivial reorganization.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |   19 +++++++------------
 drivers/staging/iio/trigger.h              |    7 -------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 57dd923..714ce06 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -151,26 +151,21 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 }
 EXPORT_SYMBOL(iio_trigger_unregister);
 
-struct iio_trigger *iio_trigger_find_by_name(const char *name, size_t len)
+static struct iio_trigger *iio_trigger_find_by_name(const char *name,
+						    size_t len)
 {
-	struct iio_trigger *trig;
-	bool found = false;
-
-	if (len && name[len - 1] == '\n')
-		len--;
+	struct iio_trigger *trig = NULL, *iter;
 
 	mutex_lock(&iio_trigger_list_lock);
-	list_for_each_entry(trig, &iio_trigger_list, list) {
-		if (strncmp(trig->name, name, len) == 0) {
-			found = true;
+	list_for_each_entry(iter, &iio_trigger_list, list)
+		if (sysfs_streq(iter->name, name)) {
+			trig = iter;
 			break;
 		}
-	}
 	mutex_unlock(&iio_trigger_list_lock);
 
-	return found ? trig : NULL;
+	return trig;
 }
-EXPORT_SYMBOL(iio_trigger_find_by_name);
 
 void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 {
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 469beba..c6ab32f 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -77,13 +77,6 @@ ssize_t iio_trigger_read_name(struct device *dev,
 					  NULL);
 
 /**
- * iio_trigger_find_by_name() - search global trigger list
- * @name: trigger name to search for
- * @len: trigger name string length to compare
- **/
-struct iio_trigger *iio_trigger_find_by_name(const char *name, size_t len);
-
-/**
  * iio_trigger_register() - register a trigger with the IIO core
  * @trig_info:	trigger to be registered
  **/
-- 
1.7.3.4
