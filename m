Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 7/8] iio: hid-sensor-incl-3d: Introduce PM
Date: Tue,  6 Jan 2015 16:58:46 -0800
Message-Id: <1420592328-9942-23-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Use common hid sensor iio pm functions. Also the poll time read and
wait is part of power up function of hid sensor iio pm function, so
remove from the client drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 45bed08..5930fa3 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -111,20 +111,12 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
-	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		poll_value = hid_sensor_read_poll_value(
-					&incl_state->common_attributes);
-		if (poll_value < 0)
-			return -EINVAL;
-
 		hid_sensor_power_state(&incl_state->common_attributes, true);
-		msleep_interruptible(poll_value * 2);
-
 		report_id =
 			incl_state->incl[chan->scan_index].report_id;
 		address = incl_3d_addresses[chan->scan_index];
@@ -438,6 +430,7 @@ static struct platform_driver hid_incl_3d_platform_driver = {
 	.id_table = hid_incl_3d_ids,
 	.driver = {
 		.name	= KBUILD_MODNAME,
+		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_incl_3d_probe,
 	.remove		= hid_incl_3d_remove,
-- 
1.9.1
