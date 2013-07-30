Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 4/6] iio: light: hid-sensor-als: Use devm_iio_device_alloc
Date: Tue, 30 Jul 2013 14:14:26 +0530
Message-Id: <1375173868-13235-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
References: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/iio/light/hid-sensor-als.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 9adfef0..84cf004 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -249,11 +249,9 @@ static int hid_als_probe(struct platform_device *pdev)
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_chan_spec *channels;
 
-	indio_dev = iio_device_alloc(sizeof(struct als_state));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct als_state));
+	if (!indio_dev)
+		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
 
 	als_state = iio_priv(indio_dev);
@@ -264,14 +262,13 @@ static int hid_als_probe(struct platform_device *pdev)
 					&als_state->common_attributes);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
-		goto error_free_dev;
+		return ret;
 	}
 
 	channels = kmemdup(als_channels, sizeof(als_channels), GFP_KERNEL);
 	if (!channels) {
-		ret = -ENOMEM;
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
-		goto error_free_dev;
+		return -ENOMEM;
 	}
 
 	ret = als_parse_report(pdev, hsdev, channels,
@@ -329,9 +326,6 @@ error_unreg_buffer_funcs:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_free_dev_mem:
 	kfree(indio_dev->channels);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -346,7 +340,6 @@ static int hid_als_remove(struct platform_device *pdev)
 	hid_sensor_remove_trigger(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	kfree(indio_dev->channels);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
