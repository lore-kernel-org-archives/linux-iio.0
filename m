Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:31407 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbcKGBBL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Nov 2016 20:01:11 -0500
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] hid: hid-sensor-hub: clear memory to avoid random data
Date: Mon,  7 Nov 2016 01:04:04 +0000
Message-Id: <1478480644-9160-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Initialize user buffer with 0s. This will avoid random data in the buffer,
when the user buffer size is bigger than the actual report size.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/hid/hid-sensor-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 658a607..980992c 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -212,6 +212,7 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	__s32 value;
 	int ret = 0;
 
+	memset(buffer, 0, buffer_size);
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
 	if (!report || (field_index >= report->maxfield)) {
-- 
1.9.1

