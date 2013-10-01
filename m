Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	holler@ahsoftware.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID RTC: Open sensor hub open close
Date: Tue,  1 Oct 2013 09:22:12 -0700
Message-Id: <1380644532-29927-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Open sensor hub when module is loaded and close when module is removed.
This helps saving power by opening HID transport only when there is an
user.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Alessandro Zummo <a.zummo@towertech.it>
---
 drivers/rtc/rtc-hid-sensor-time.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index 4e2a818..45560ff 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -275,6 +275,12 @@ static int hid_time_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = sensor_hub_device_open(hsdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to open sensor hub device!\n");
+		goto err_open;
+	}
+
 	time_state->rtc = devm_rtc_device_register(&pdev->dev,
 					"hid-sensor-time", &hid_time_rtc_ops,
 					THIS_MODULE);
@@ -282,17 +288,24 @@ static int hid_time_probe(struct platform_device *pdev)
 	if (IS_ERR_OR_NULL(time_state->rtc)) {
 		ret = time_state->rtc ? PTR_ERR(time_state->rtc) : -ENODEV;
 		time_state->rtc = NULL;
-		sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
 		dev_err(&pdev->dev, "rtc device register failed!\n");
+		goto err_rtc;
 	}
 
 	return ret;
+
+err_rtc:
+	sensor_hub_device_close(hsdev);
+err_open:
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
+	return ret;
 }
 
 static int hid_time_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
+	sensor_hub_device_close(hsdev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
 
 	return 0;
-- 
1.8.3.1
