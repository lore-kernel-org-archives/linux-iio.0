Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44166 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030214AbbEOB0q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 14 May 2015 21:26:46 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iio: ltr501: Add light channel support
Date: Thu, 14 May 2015 18:26:07 -0700
Message-Id: <4c8850e4528f19267255ef6b6940b6a6ae6b470c.1431652926.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added support to calculate lux value from visible
and IR spectrum adc count values. Also added IIO_LIGHT
channel to enable user read the lux value directly
from device using illuminance input ABI.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index ca4bf47..449b0fd 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -66,6 +66,9 @@
 
 #define LTR501_REGMAP_NAME "ltr501_regmap"
 
+#define LTR501_LUX_CONV(vis_coeff, vis_data, ir_coeff, ir_data) \
+			((vis_coeff * vis_data) - (ir_coeff * ir_data))
+
 static const int int_time_mapping[] = {100000, 50000, 200000, 400000};
 
 static const struct reg_field reg_field_it =
@@ -298,6 +301,29 @@ static int ltr501_ps_read_samp_period(struct ltr501_data *data, int *val)
 	return IIO_VAL_INT;
 }
 
+/* IR and visible spectrum coeff's are given in data sheet */
+static unsigned long ltr501_calculate_lux(u16 vis_data, u16 ir_data)
+{
+	unsigned long ratio, lux;
+
+	if (vis_data == 0)
+		return 0;
+
+	/* multiply numerator by 100 to avoid handling ratio < 1 */
+	ratio = DIV_ROUND_UP(ir_data * 100, ir_data + vis_data);
+
+	if (ratio < 45)
+		lux = LTR501_LUX_CONV(1774, vis_data, -1105, ir_data);
+	else if (ratio >= 45 && ratio < 64)
+		lux = LTR501_LUX_CONV(3772, vis_data, 1336, ir_data);
+	else if (ratio >= 64 && ratio < 85)
+		lux = LTR501_LUX_CONV(1690, vis_data, 169, ir_data);
+	else
+		lux = 0;
+
+	return lux / 1000;
+}
+
 static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
 {
 	int tries = 100;
@@ -548,7 +574,20 @@ static const struct iio_event_spec ltr501_pxs_event_spec[] = {
 	.num_event_specs = _evsize,\
 }
 
+#define LTR501_LIGHT_CHANNEL() { \
+	.type = IIO_LIGHT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
+	.scan_index = -1, \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+	}, \
+}
+
 static const struct iio_chan_spec ltr501_channels[] = {
+	LTR501_LIGHT_CHANNEL(),
 	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0,
 				 ltr501_als_event_spec,
 				 ARRAY_SIZE(ltr501_als_event_spec)),
@@ -576,6 +615,7 @@ static const struct iio_chan_spec ltr501_channels[] = {
 };
 
 static const struct iio_chan_spec ltr301_channels[] = {
+	LTR501_LIGHT_CHANNEL(),
 	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0,
 				 ltr501_als_event_spec,
 				 ARRAY_SIZE(ltr501_als_event_spec)),
@@ -596,6 +636,23 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 	int ret, i;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		switch (chan->type) {
+		case IIO_LIGHT:
+			mutex_lock(&data->lock_als);
+			ret = ltr501_read_als(data, buf);
+			mutex_unlock(&data->lock_als);
+			if (ret < 0)
+				return ret;
+			*val = ltr501_calculate_lux(le16_to_cpu(buf[1]),
+						    le16_to_cpu(buf[0]));
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_RAW:
 		if (iio_buffer_enabled(indio_dev))
 			return -EBUSY;
-- 
1.9.1

