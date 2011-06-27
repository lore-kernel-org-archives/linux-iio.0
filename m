Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48379 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684Ab1F0J5E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2011 05:57:04 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 03/54] iio: trigger: Add filter callback
Date: Mon, 27 Jun 2011 11:04:13 +0100
Message-Id: <1309169104-22139-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Allow devices to reject triggers and vice versa.

Changes since V1:
Added kernel-doc
Moved callback into iio_info
Changed function naming
Revised return value passing
Add forward declaration to avoid warnings

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h                  |    7 +++++++
 drivers/staging/iio/industrialio-trigger.c |   20 +++++++++++++++++++-
 drivers/staging/iio/trigger.h              |    4 ++++
 3 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 78a0927..6e51baa 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -204,6 +204,8 @@ static inline s64 iio_get_time_ns(void)
 #define IIO_VAL_INT_PLUS_MICRO 2
 #define IIO_VAL_INT_PLUS_NANO 3
 
+struct iio_trigger; /* forward declaration */
+
 /**
  * struct iio_info - constant information about device
  * @driver_module:	module structure used to ensure correct
@@ -224,6 +226,8 @@ static inline s64 iio_get_time_ns(void)
  *			is event dependant. event_code specifies which event.
  * @write_event_value:	write the value associate with the event.
  *			Meaning is event dependent.
+ * @validate_trigger:	function to validate the trigger when the
+ *			current trigger gets changed.
  **/
 struct iio_info {
 	struct module			*driver_module;
@@ -256,6 +260,9 @@ struct iio_info {
 	int (*write_event_value)(struct iio_dev *indio_dev,
 				 int event_code,
 				 int val);
+	int (*validate_trigger)(struct iio_dev *indio_dev,
+				struct iio_trigger *trig);
+
 };
 
 /**
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index d504aa2..90ca2df 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -340,6 +340,9 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct iio_trigger *oldtrig = dev_info->trig;
+	struct iio_trigger *trig;
+	int ret;
+
 	mutex_lock(&dev_info->mlock);
 	if (dev_info->currentmode == INDIO_RING_TRIGGERED) {
 		mutex_unlock(&dev_info->mlock);
@@ -347,7 +350,22 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	}
 	mutex_unlock(&dev_info->mlock);
 
-	dev_info->trig = iio_trigger_find_by_name(buf, len);
+	trig = iio_trigger_find_by_name(buf, len);
+
+	if (trig && dev_info->info->validate_trigger) {
+		ret = dev_info->info->validate_trigger(dev_info, trig);
+		if (ret)
+			return ret;
+	}
+
+	if (trig && trig->validate_device) {
+		ret = trig->validate_device(trig, dev_info);
+		if (ret)
+			return ret;
+	}
+
+	dev_info->trig = trig;
+
 	if (oldtrig && dev_info->trig != oldtrig)
 		iio_put_trigger(oldtrig);
 	if (dev_info->trig)
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 7ddaabb..e0b58ed 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -29,6 +29,8 @@ struct iio_subirq {
  * @set_trigger_state:	[DRIVER] switch on/off the trigger on demand
  * @try_reenable:	function to reenable the trigger when the
  *			use count is zero (may be NULL)
+ * @validate_device:	function to validate the device when the
+ *			current trigger gets changed.
  * @subirq_chip:	[INTERN] associate 'virtual' irq chip.
  * @subirq_base:	[INTERN] base number for irqs provided by trigger.
  * @subirqs:		[INTERN] information about the 'child' irqs.
@@ -48,6 +50,8 @@ struct iio_trigger {
 
 	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
 	int (*try_reenable)(struct iio_trigger *trig);
+	int (*validate_device)(struct iio_trigger *trig,
+			       struct iio_dev *indio_dev);
 
 	struct irq_chip			subirq_chip;
 	int				subirq_base;
-- 
1.7.3.4

