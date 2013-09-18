Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jkosina@suse.cz,
	holler@ahsoftware.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] HID RTC: Open sensor hub open close
Date: Wed, 18 Sep 2013 10:13:19 -0700
Message-Id: <1379524399-16995-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Open sensor hub when module is loaded and close when module is removed.
This helps saving power by opening HID transport only when there is an
user.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Alessandro Zummo <a.zummo@towertech.it>
---
 drivers/rtc/rtc-hid-sensor-time.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index 7273b01..1fe170c 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -279,15 +279,28 @@ static int hid_time_probe(struct platform_device *pdev)
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
 
 	if (IS_ERR(time_state->rtc)) {
 		dev_err(&pdev->dev, "rtc device register failed!\n");
-		return PTR_ERR(time_state->rtc);
+		ret = PTR_ERR(time_state->rtc);
+		goto err_rtc;
 	}
 
+	return 0;
+
+err_rtc:
+	sensor_hub_device_close(hsdev);
+err_open:
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
 	return ret;
 }
 
@@ -295,6 +308,7 @@ static int hid_time_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
+	sensor_hub_device_close(hsdev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
 
 	return 0;
-- 
1.8.3.1
