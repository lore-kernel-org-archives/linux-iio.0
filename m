Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/8] iio: st_sensors: Remove indio_dev->trig assignment
Date: Fri, 11 Jul 2014 10:12:16 -0700
Message-Id: <1405098739-25470-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This can result in wrong reference count for trigger device, leave the binding
to user space via current_trigger sysfs entry.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 8fc3a97..b64f514 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -49,7 +49,6 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
 		goto iio_trigger_register_error;
 	}
-	indio_dev->trig = sdata->trig;
 
 	return 0;
 
-- 
1.9.1
