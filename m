Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30913 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755782AbcKKAz4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 19:55:56 -0500
From: Song Hongyan <hongyan.song@intel.com>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH v2] hid: hid-sensor-hub: clear memory to avoid random data
Date: Fri, 11 Nov 2016 00:58:43 +0000
Message-Id: <1478825923-12153-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Initialize user buffer with 0s. This will avoid random data in the buffer,
when the user buffer size is bigger than the actual report size.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
Changes in v2:
    -clear memory in get_feature() instead of set_feature()

 drivers/hid/hid-sensor-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 658a607..b74d954 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -252,6 +252,7 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	int report_size;
 	int ret = 0;
 
+	memset(buffer, 0, buffer_size);
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
 	if (!report || (field_index >= report->maxfield) ||
-- 
1.9.1

