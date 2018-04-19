Return-Path: <SRS0=tgte=HI=sang-engineering.com=wsa+renesas@kernel.org>
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH 19/61] iio: common: hid-sensors: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:49 +0200
Message-Id: <20180419140641.27926-20-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
List-ID: <linux-iio@vger.kernel.org>

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index cfb6588565ba..2ce0efd98cc0 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -304,8 +304,7 @@ EXPORT_SYMBOL(hid_sensor_setup_trigger);
 
 static int __maybe_unused hid_sensor_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
 
 	return _hid_sensor_power_state(attrb, false);
@@ -313,8 +312,7 @@ static int __maybe_unused hid_sensor_suspend(struct device *dev)
 
 static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
 	schedule_work(&attrb->work);
 	return 0;
@@ -322,8 +320,7 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
 
 static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
 	return _hid_sensor_power_state(attrb, true);
 }
-- 
2.11.0
