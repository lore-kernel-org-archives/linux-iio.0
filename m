Return-Path: <archana.patni@linux.intel.com>
From: Archana Patni <archana.patni@linux.intel.com>
To: jic23@kernel.org
Cc: jkosina@suse.cz,
	linux-iio@vger.kernel.org,
	srinivas.pandruvada@intel.com,
	Archana Patni <archana.patni@linux.intel.com>,
	Archana Patni <archana.patni@intel.com>,
	Subramony Sesha <subramony.sesha@intel.com>
Subject: [PATCH] iio: hid-sensors: Get feature report from sensor hub after changing power state
Date: Mon, 19 May 2014 07:19:23 -0400
Message-Id: <1400498363-18456-1-git-send-email-archana.patni@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Some sensor hubs require a get feature report call to be issued soon after
changing the power state of the sensor. Without this, the sensor remains in
the current state. This patch adds a call soon after the power state.

This is retained as a generic call across all sensor hubs since the behavior
has been noticed on more than one implementation.

Signed-off-by: Archana Patni <archana.patni@intel.com>
Signed-off-by: Subramony Sesha <subramony.sesha@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index dbefbda..f26f52d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -73,6 +73,9 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					(s32)report_val);
 	}
 
+	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
+					st->power_state.index,
+					&state_val);
 	return 0;
 }
 
-- 
1.7.9.5
