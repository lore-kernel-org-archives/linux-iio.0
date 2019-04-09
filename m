Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E3CC10F13
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 01:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB66213F2
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 01:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDIBSu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:18:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:5477 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfDIBSu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Apr 2019 21:18:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 18:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="289887101"
Received: from shsensorbuild2.sh.intel.com ([10.239.133.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2019 18:18:48 -0700
From:   hongyan.song@intel.com
To:     jikos@kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     srinivas.pandruvada@intel.com, hongyan.song@intel.com
Subject: [PATCH] drivers: iio: Add more data field for iio driver hysteresis parsing
Date:   Tue,  9 Apr 2019 09:31:04 +0800
Message-Id: <1554773465-21882-1-git-send-email-hongyan.song@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Song Hongyan <hongyan.song@intel.com>

Add more data field support for als, incli_3d, rotation, press
hysteresis parsing. In some implementation may uses them as sensitivity
modifier, without this change hysteresis may not be able to read and
write.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/light/hid-sensor-als.c            | 8 ++++++++
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 8 ++++++++
 drivers/iio/orientation/hid-sensor-rotation.c | 7 +++++++
 drivers/iio/pressure/hid-sensor-press.c       | 8 ++++++++
 include/linux/hid-sensor-ids.h                | 1 +
 5 files changed, 32 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 94f3325..bb19178 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -271,6 +271,14 @@ static int als_parse_report(struct platform_device *pdev,
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
 	}
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT |
+			HID_USAGE_SENSOR_LIGHT_ILLUM,
+			&st->common_attributes.sensitivity);
+	}
+
 	return ret;
 }
 
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index bdc5e45..7da1e3f 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -305,6 +305,14 @@ static int incl_3d_parse_report(struct platform_device *pdev,
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
 	}
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_ORIENT_TILT,
+			&st->common_attributes.sensitivity);
+	}
+
 	return ret;
 }
 
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index a69db20..201e320 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -229,6 +229,13 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
 	}
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_ORIENT_QUATERNION,
+			&st->common_attributes.sensitivity);
+	}
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index d7b1c00..bf5d2ac 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -250,6 +250,14 @@ static int press_parse_report(struct platform_device *pdev,
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
 	}
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE,
+			&st->common_attributes.sensitivity);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 76033e0..a875b9be 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -158,6 +158,7 @@
 /* Per data field properties */
 #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
 #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
+#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE000
 
 /* Power state enumerations */
 #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x200850
-- 
2.7.4

