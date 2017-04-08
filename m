Return-Path: <SRS0=wnnm=3Q=linux.intel.com=srinivas.pandruvada@kernel.org>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: hid-sensor: Fix unbalanced pm_runtime_enable error
Date: Fri,  7 Apr 2017 17:16:34 -0700
Message-Id: <20170408001634.4980-1-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

When a hid sensor module is removed and modprobed again we see
error for unbalanced pm_runtime. This issue is caused by not
deactivating runtime PM on removal. So on modprobe again when
activated again, this will print this error.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Not an urgent fix, so targeted for next release only.

 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 6082934..0b5dea0 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -152,6 +152,10 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
 {
+	pm_runtime_disable(&attrb->pdev->dev);
+	pm_runtime_set_suspended(&attrb->pdev->dev);
+	pm_runtime_put_noidle(&attrb->pdev->dev);
+
 	cancel_work_sync(&attrb->work);
 	iio_trigger_unregister(attrb->trigger);
 	iio_trigger_free(attrb->trigger);
-- 
2.9.3
