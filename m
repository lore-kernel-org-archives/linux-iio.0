Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63374 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbaHVUsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Aug 2014 16:48:11 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 5/8] iio: st_sensors: Fix indio_dev->trig assignment
Date: Fri, 22 Aug 2014 13:48:33 -0700
Message-Id: <1408740516-31261-6-git-send-email-srinivas.pandruvada@linux.intel.com>
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
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 8fc3a97..8d8ca6f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -49,7 +49,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
 		goto iio_trigger_register_error;
 	}
-	indio_dev->trig = sdata->trig;
+	indio_dev->trig = iio_trigger_get(sdata->trig);
 
 	return 0;
 
-- 
1.9.3

