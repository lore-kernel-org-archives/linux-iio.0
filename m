Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:59281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756103AbcJYBDO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Oct 2016 21:03:14 -0400
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] iio: orientation: hid-sensor-rotation: Add PM function
Date: Tue, 25 Oct 2016 01:06:03 +0000
Message-Id: <1477357563-16794-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rotation sensor function does not work due to miss PM function.
Add common hid sensor iio pm function for rotation sensor.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index b98b9d9..a97e802c 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -335,6 +335,7 @@ static int hid_dev_rot_remove(struct platform_device *pdev)
 	.id_table = hid_dev_rot_ids,
 	.driver = {
 		.name	= KBUILD_MODNAME,
+		.pm     = &hid_sensor_pm_ops,
 	},
 	.probe		= hid_dev_rot_probe,
 	.remove		= hid_dev_rot_remove,
-- 
1.9.1

