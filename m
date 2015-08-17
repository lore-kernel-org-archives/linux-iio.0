Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56224 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbbHQXyJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Aug 2015 19:54:09 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: edubezval@gmail.com, rui.zhang@intel.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 2/2] thermal: x86_pkg_temp: Register threshold callbacks
Date: Mon, 17 Aug 2015 16:52:57 -0700
Message-Id: <1439855577-17114-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1439855577-17114-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1439855577-17114-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Register callbacks to get/set temperature thresholds.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 50d1d2c..4b526b8 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -279,6 +279,8 @@ static struct thermal_zone_device_ops tzone_ops = {
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
+	.get_threshold_temp = sys_get_trip_temp,
+	.set_threshold_temp = sys_set_trip_temp,
 };
 
 static bool pkg_temp_thermal_platform_thermal_rate_control(void)
-- 
2.4.3

