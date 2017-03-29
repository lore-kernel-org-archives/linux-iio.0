Return-Path: <SRS0=7MEl=3G=linux.intel.com=srinivas.pandruvada@kernel.org>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: accel: hid-sensor-accel-3d: Fix duplicate scan index error
Date: Wed, 29 Mar 2017 16:23:35 -0700
Message-Id: <1490829815-18856-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

When both accel_3d and gravity sensor are present, iio_device_register()
fails with "Duplicate scan index" error.
The reason for this is setting of indio_dev->num_channels based on
accel_3d channel for both gravity and accel-3d sensor. But number of
channels are not same, so for gravity it is pointing to some invalid
memory and getting scan_index to compare which may match.
To fix this issue, set the indio_dev->num_channels correctly based on
the sensor type.

Fixes: 0e377f3b9ae9 ('iio: Add gravity sensor support')
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index ca5759c..43a6cb0 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -370,10 +370,12 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		name = "accel_3d";
 		channel_spec = accel_3d_channels;
 		channel_size = sizeof(accel_3d_channels);
+		indio_dev->num_channels = ARRAY_SIZE(accel_3d_channels);
 	} else {
 		name = "gravity";
 		channel_spec = gravity_channels;
 		channel_size = sizeof(gravity_channels);
+		indio_dev->num_channels = ARRAY_SIZE(gravity_channels);
 	}
 	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
 					&accel_state->common_attributes);
@@ -395,7 +397,6 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->num_channels = ARRAY_SIZE(accel_3d_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &accel_3d_info;
 	indio_dev->name = name;
-- 
2.7.4
