Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 6/8] iio: hid-sensor-magn-3d: Introduce PM
Date: Tue,  6 Jan 2015 16:58:45 -0800
Message-Id: <1420592328-9942-22-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Use common hid sensor iio pm functions. Also the poll time read and
wait is part of power up function of hid sensor iio pm function, so
remove from the client drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 4d299f3..4f9c0be 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -157,20 +157,12 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
-	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
 	case 0:
-		poll_value = hid_sensor_read_poll_value(
-					&magn_state->common_attributes);
-		if (poll_value < 0)
-				return -EINVAL;
-
 		hid_sensor_power_state(&magn_state->common_attributes, true);
-		msleep_interruptible(poll_value * 2);
-
 		report_id =
 			magn_state->magn[chan->address].report_id;
 		address = magn_3d_addresses[chan->address];
@@ -531,6 +523,7 @@ static struct platform_driver hid_magn_3d_platform_driver = {
 	.id_table = hid_magn_3d_ids,
 	.driver = {
 		.name	= KBUILD_MODNAME,
+		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_magn_3d_probe,
 	.remove		= hid_magn_3d_remove,
-- 
1.9.1
