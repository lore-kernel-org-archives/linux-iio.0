Return-Path: <SRS0=rqCY=7P=gmail.com=arvind.yadav.cs@kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH] HID: sensor: constify platform_device_id
Date: Sun, 13 Aug 2017 15:15:32 +0530
Message-Id: <2ae0f9137a673466f09a9d5169c9ef13bbe66a30.1502617403.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

platform_device_id are not supposed to change at runtime. All functions
working with platform_device_id provided by <linux/platform_device.h>
work with const platform_device_id. So mark the non-const structs as
const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 3a84aaf..5ad39fd 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -823,7 +823,7 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id hid_sensor_custom_ids[] = {
+static const struct platform_device_id hid_sensor_custom_ids[] = {
 	{
 		.name = "HID-SENSOR-2000e1",
 	},
-- 
2.7.4
