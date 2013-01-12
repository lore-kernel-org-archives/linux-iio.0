Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:52178 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab3ALKmY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 05:42:24 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/3] staging:iio:light:tsl2583 apply in_ prefix to attributes.
Date: Sat, 12 Jan 2013 10:42:18 +0000
Message-Id: <1357987339-11800-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1357987339-11800-1-git-send-email-jic23@kernel.org>
References: <1357987339-11800-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Bring the naming of remaining attributes in line with those
created via the channel spec.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2583.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 30c1a36..944db26 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -652,29 +652,29 @@ static ssize_t taos_luxtable_store(struct device *dev,
 static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
 		taos_power_state_show, taos_power_state_store);
 
-static DEVICE_ATTR(illuminance0_calibscale_available, S_IRUGO,
+static DEVICE_ATTR(in_illuminance0_calibscale_available, S_IRUGO,
 		taos_gain_available_show, NULL);
 
-static DEVICE_ATTR(illuminance0_integration_time, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(in_illuminance0_integration_time, S_IRUGO | S_IWUSR,
 		taos_als_time_show, taos_als_time_store);
-static DEVICE_ATTR(illuminance0_integration_time_available, S_IRUGO,
+static DEVICE_ATTR(in_illuminance0_integration_time_available, S_IRUGO,
 		taos_als_time_available_show, NULL);
 
-static DEVICE_ATTR(illuminance0_input_target, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(in_illuminance0_input_target, S_IRUGO | S_IWUSR,
 		taos_als_cal_target_show, taos_als_cal_target_store);
 
-static DEVICE_ATTR(illuminance0_calibrate, S_IWUSR, NULL, taos_do_calibrate);
-static DEVICE_ATTR(illuminance0_lux_table, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(in_illuminance0_calibrate, S_IWUSR, NULL, taos_do_calibrate);
+static DEVICE_ATTR(in_illuminance0_lux_table, S_IRUGO | S_IWUSR,
 		taos_luxtable_show, taos_luxtable_store);
 
 static struct attribute *sysfs_attrs_ctrl[] = {
 	&dev_attr_power_state.attr,
-	&dev_attr_illuminance0_calibscale_available.attr,
-	&dev_attr_illuminance0_integration_time.attr,	/* I time*/
-	&dev_attr_illuminance0_integration_time_available.attr,
-	&dev_attr_illuminance0_input_target.attr,
-	&dev_attr_illuminance0_calibrate.attr,
-	&dev_attr_illuminance0_lux_table.attr,
+	&dev_attr_in_illuminance0_calibscale_available.attr,
+	&dev_attr_in_illuminance0_integration_time.attr,	/* I time*/
+	&dev_attr_in_illuminance0_integration_time_available.attr,
+	&dev_attr_in_illuminance0_input_target.attr,
+	&dev_attr_in_illuminance0_calibrate.attr,
+	&dev_attr_in_illuminance0_lux_table.attr,
 	NULL
 };
 
-- 
1.8.1

