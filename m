Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33681 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530AbaDRXTo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 18 Apr 2014 19:19:44 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 04/16] iio: hid-sensors: Gyro 3D : adjust scale and offset
Date: Fri, 18 Apr 2014 16:22:24 -0700
Message-Id: <1397863356-2470-4-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using units and unit exponent to calculate scale which is compliant
to IIO ABI.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 59d6bc3..53ac060 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -42,6 +42,10 @@ struct gyro_3d_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info gyro[GYRO_3D_CHANNEL_MAX];
 	u32 gyro_val[GYRO_3D_CHANNEL_MAX];
+	int scale_pre_decml;
+	int scale_post_decml;
+	int scale_precision;
+	int value_offset;
 };
 
 static const u32 gyro_3d_addresses[GYRO_3D_CHANNEL_MAX] = {
@@ -123,12 +127,12 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
-		*val = gyro_state->gyro[CHANNEL_SCAN_INDEX_X].units;
-		ret_type = IIO_VAL_INT;
+		*val = gyro_state->scale_pre_decml;
+		*val2 = gyro_state->scale_post_decml;
+		ret_type = gyro_state->scale_precision;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-			gyro_state->gyro[CHANNEL_SCAN_INDEX_X].unit_expo);
+		*val = gyro_state->value_offset;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -262,6 +266,11 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 			st->gyro[1].index, st->gyro[1].report_id,
 			st->gyro[2].index, st->gyro[2].report_id);
 
+	st->scale_precision = hid_sensor_format_scale(
+				HID_USAGE_SENSOR_GYRO_3D,
+				&st->gyro[CHANNEL_SCAN_INDEX_X],
+				&st->scale_pre_decml, &st->scale_post_decml);
+
 	/* Set Sensitivity field ids, when there is no individual modifier */
 	if (st->common_attributes.sensitivity.index < 0) {
 		sensor_hub_input_get_attribute_info(hsdev,
-- 
1.7.11.7

