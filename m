Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63377 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbaHVUsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Aug 2014 16:48:11 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 4/8] iio: hid_sensor_hub: Fix indio_dev->trig assignment
Date: Fri, 22 Aug 2014 13:48:32 -0700
Message-Id: <1408740516-31261-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This can result in wrong reference count for trigger device, call
iio_trigger_get to increment reference.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index a3109a6..92068cd 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -122,7 +122,8 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 		dev_err(&indio_dev->dev, "Trigger Register Failed\n");
 		goto error_free_trig;
 	}
-	indio_dev->trig = attrb->trigger = trig;
+	attrb->trigger = trig;
+	indio_dev->trig = iio_trigger_get(trig);
 
 	return ret;
 
-- 
1.9.3

