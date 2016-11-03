Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54640 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbcKCAmt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Nov 2016 20:42:49 -0400
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] iio: hid-sensor-attributes: Check sample_frequency/hysteresis write data legitimacy
Date: Thu,  3 Nov 2016 00:45:48 +0000
Message-Id: <1478133948-16089-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Neither sample frequency value nor hysteresis value can be set to be a
negative number, check and return "Invalid argument" if they are negative.

If not do this change, sample_frequency will be set into some unknown
value, read hysteresis value after write negative number will return
"Invalid argument".

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index dc33c1d..4509f8475 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -201,7 +201,7 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 	int ret;
 
 	if (val1 < 0 || val2 < 0)
-		ret = -EINVAL;
+		return -EINVAL;
 
 	value = val1 * pow_10(6) + val2;
 	if (value) {
@@ -250,6 +250,9 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
 	s32 value;
 	int ret;
 
+	if (val1 < 0 || val2 < 0)
+		return -EINVAL;
+
 	value = convert_to_vtf_format(st->sensitivity.size,
 				st->sensitivity.unit_expo,
 				val1, val2);
-- 
1.9.1

