Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57574 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293Ab2ITAPr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 19 Sep 2012 20:15:47 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: hid-sensors: Prevent crash during hot-unplug
Date: Wed, 19 Sep 2012 17:15:44 -0700
Message-Id: <1348100144-1826-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When hid sensor hub is unplugged, there is a crash in
iio_device_unregister_trigger_consumer.
In a typical IIO driver when remove is called, it will unregister and free
trigger and then it will call iio_device_free.
The function iio_trigger_free() will free the allocated memory for trigger.
If this trigger was assigned to iio_dev->trig, then it should be set to NULL.
Othewise when iio_device_free() is called later, it finally calls
iio_device_unregsister_trigger(), which checks for
       if (indio_dev->trig)
                iio_trigger_put(indio_dev->trig);
If indio_dev->trig is not set to NULL, it calls iio_trigger_put on a bad
pointer causing crash.
This scenerio can happen in any driver, which is storing trigger pointer in
iio_dev structure and following current procedure during remove.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 12277e8..d4b790d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -56,6 +56,7 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
 {
 	iio_trigger_unregister(indio_dev->trig);
 	iio_trigger_free(indio_dev->trig);
+	indio_dev->trig = NULL;
 }
 EXPORT_SYMBOL(hid_sensor_remove_trigger);
 
-- 
1.7.11.4

