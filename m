Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 1/4] iio: hid-sensor-accel-3d: Use devm_iio_device_alloc
Date: Tue, 23 Jul 2013 12:17:07 +0530
Message-Id: <1374562030-28621-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
---
This series is compile tested and based on togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
---
 drivers/iio/accel/hid-sensor-accel-3d.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 275c5d7..68df341 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -282,11 +282,11 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_chan_spec *channels;
 
-	indio_dev = iio_device_alloc(sizeof(struct accel_3d_state));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&pdev->dev,
+					  sizeof(struct accel_3d_state));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	accel_state = iio_priv(indio_dev);
@@ -298,15 +298,14 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 					&accel_state->common_attributes);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		goto error_free_dev;
+		return ret;
 	}
 
 	channels = kmemdup(accel_3d_channels, sizeof(accel_3d_channels),
 			   GFP_KERNEL);
 	if (!channels) {
-		ret = -ENOMEM;
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
-		goto error_free_dev;
+		return -ENOMEM;
 	}
 
 	ret = accel_3d_parse_report(pdev, hsdev, channels,
@@ -363,9 +362,6 @@ error_unreg_buffer_funcs:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_free_dev_mem:
 	kfree(indio_dev->channels);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -380,7 +376,6 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
 	hid_sensor_remove_trigger(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	kfree(indio_dev->channels);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
