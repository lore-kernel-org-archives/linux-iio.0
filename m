Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36170 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbcIBG2O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 02:28:14 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so5157278pab.3
        for <linux-iio@vger.kernel.org>; Thu, 01 Sep 2016 23:28:14 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>,
        Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v2] iio: trigger: allow immutable triggers to be assigned
Date: Thu,  1 Sep 2016 23:28:05 -0700
Message-Id: <1472797685-12212-1-git-send-email-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Matt Ranostay <mranostay@gmail.com>

There are times when a trigger consumer shouldn't be allowed to change
triggers after intialization.

This is useful with use of callback buffers pushing ADC data back to the
trigger providers iio device.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---

Changes from v1:
 * use bool instead of int for trig_readonly property

 drivers/iio/industrialio-trigger.c | 20 ++++++++++++++++++++
 include/linux/iio/iio.h            |  2 ++
 include/linux/iio/trigger.h        |  9 +++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 7ad82fdd3e5b..a3ae3873f998 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -119,6 +119,22 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 }
 EXPORT_SYMBOL(iio_trigger_unregister);
 
+int iio_trigger_set_immutable(struct iio_dev *dst, struct iio_trigger *trig)
+{
+	if (!dst || !trig)
+		return -EINVAL;
+
+	mutex_lock(&dst->mlock);
+	WARN_ON(dst->trig_readonly);
+
+	dst->trig = iio_trigger_get(trig);
+	dst->trig_readonly = true;
+	mutex_unlock(&dst->mlock);
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_trigger_set_immutable);
+
 /* Search for trigger by name, assuming iio_trigger_list_lock held */
 static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
 {
@@ -384,6 +400,10 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
+	if (indio_dev->trig_readonly) {
+		mutex_unlock(&indio_dev->mlock);
+		return -EPERM;
+	}
 	mutex_unlock(&indio_dev->mlock);
 
 	trig = iio_trigger_find_by_name(buf, len);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 854e2dad1e0d..786952cd509f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -483,6 +483,7 @@ struct iio_buffer_setup_ops {
  * @scan_timestamp:	[INTERN] set if any buffers have requested timestamp
  * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
  * @trig:		[INTERN] current device trigger (buffer modes)
+ * @trig_readonly	[INTERN] mark the current trigger immutable
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @pollfunc_event:	[DRIVER] function run on events trigger being received
  * @channels:		[DRIVER] channel specification structure table
@@ -523,6 +524,7 @@ struct iio_dev {
 	bool				scan_timestamp;
 	unsigned			scan_index_timestamp;
 	struct iio_trigger		*trig;
+	bool				trig_readonly;
 	struct iio_poll_func		*pollfunc;
 	struct iio_poll_func		*pollfunc_event;
 
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 1c9e028e0d4a..9e22284a4122 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -132,6 +132,15 @@ int iio_trigger_register(struct iio_trigger *trig_info);
 void iio_trigger_unregister(struct iio_trigger *trig_info);
 
 /**
+ * iio_trigger_set_immutable() - set an immutable trigger on destination
+ *
+ * @dst - destination device for trigger
+ * @trig - trigger to assign to destination
+ *
+ **/
+int iio_trigger_set_immutable(struct iio_dev *dst, struct iio_trigger *trig);
+
+/**
  * iio_trigger_poll() - called on a trigger occurring
  * @trig:	trigger which occurred
  *
-- 
2.7.4

