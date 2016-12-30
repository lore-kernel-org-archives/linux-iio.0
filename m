Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44378 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbcL3BAr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Dec 2016 20:00:47 -0500
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH 3/4] iio: hid-sensor-attributes: Add input sample frequency check
Date: Fri, 30 Dec 2016 17:23:11 +0800
Message-Id: <1483089792-11324-3-git-send-email-hongyan.song@intel.com>
In-Reply-To: <1483089792-11324-1-git-send-email-hongyan.song@intel.com>
References: <1483089792-11324-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check the validity of the sampling frequency set by user.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index ad30814..408c16e 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -221,12 +221,26 @@ int hid_sensor_read_max_samp_freq_value(struct hid_sensor_common *st,
 int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 				int val1, int val2)
 {
+	int max_freq_int, max_freq_dec;
 	s32 value;
 	int ret;
 
 	if (val1 < 0 || val2 < 0)
 		ret = -EINVAL;
 
+	ret = hid_sensor_read_max_samp_freq_value(st, &max_freq_int,
+						&max_freq_dec);
+	if (ret >= 0) {
+		/*
+		 * check whether the input sample freqency value is larger than
+		 * the max_freq_value.
+		 */
+		if (val1 > max_freq_int || (val1 == max_freq_int &&
+				val2 > max_freq_dec))
+			return -EINVAL;
+	} else {
+		hid_info(st->hsdev->hdev, "No max_sample_frequency!!!\n");
+	}
 	value = val1 * pow_10(6) + val2;
 	if (value) {
 		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
-- 
1.9.1

