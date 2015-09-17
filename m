Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48161 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbbIQWbZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 17 Sep 2015 18:31:25 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v2 3/4] thermal: use iio binding calls
Date: Thu, 17 Sep 2015 15:30:53 -0700
Message-Id: <1442529054-25803-4-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1442529054-25803-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1442529054-25803-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This change:
Register zone temperature sensor as IIO device during zone registration,
Remove iio device during zone removal,
Notify iio binding during thermal_device_update call.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/thermal_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 18e7802..dbde29f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -43,6 +43,7 @@
 
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
+#include "thermal_iio.h"
 
 MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
@@ -544,6 +545,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (!tz->ops->get_temp)
 		return;
 
+	thermal_iio_sensor_notify(tz, event);
 	update_temperature(tz);
 
 	for (count = 0; count < tz->trips; count++)
@@ -1858,10 +1860,15 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	mutex_unlock(&thermal_governor_lock);
 
+	if (thermal_iio_sensor_register(tz))
+		goto unregister;
+
 	if (!tz->tzp || !tz->tzp->no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);
-		if (result)
+		if (result) {
+			thermal_iio_sensor_unregister(tz);
 			goto unregister;
+		}
 	}
 
 	mutex_lock(&thermal_list_lock);
@@ -1943,6 +1950,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	remove_trip_attrs(tz);
 	thermal_set_governor(tz, NULL);
 
+	thermal_iio_sensor_unregister(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	idr_destroy(&tz->idr);
-- 
1.9.3

