Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50307 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab3KQOOK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 03/11] iio:accel:bma180 use new read_avail to replace *_available attrs.
Date: Sun, 17 Nov 2013 15:14:54 +0000
Message-Id: <1384701302-26564-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This allows access to all of these parameters via the core.
Patch also adds const to the two value arrays specifying the available
values.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/bma180.c | 61 +++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 28b39283bccf..5c66f62d6f67 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -70,12 +70,6 @@
 #define BMA180_DEF_BW		20
 #define BMA180_DEF_SCALE	250
 
-/* Available values for sysfs */
-#define BMA180_FLP_FREQ_AVAILABLE \
-	"10 20 40 75 150 300"
-#define BMA180_SCALE_AVAILABLE \
-	"0.000130 0.000190 0.000250 0.000380 0.000500 0.000990 0.001980"
-
 struct bma180_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
@@ -93,8 +87,37 @@ enum bma180_axis {
 	AXIS_Z,
 };
 
-static int bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
-static int scale_table[] = { 130, 190, 250, 380, 500, 990, 1980 };
+static const int bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
+static const int scale_table[] = { 0, 130,
+				   0, 190,
+				   0, 250,
+				   0, 380,
+				   0, 500,
+				   0, 990,
+				   0, 1980 };
+
+static int bma180_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals,
+			     int *type,
+			     int *length,
+			     long mask_el)
+{
+	switch (mask_el) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(bw_table);
+		*vals = bw_table;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*length = ARRAY_SIZE(scale_table);
+		*vals = scale_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
 
 static int bma180_get_acc_reg(struct bma180_data *data, enum bma180_axis axis)
 {
@@ -209,8 +232,8 @@ static int bma180_set_scale(struct bma180_data *data, int val)
 	if (data->sleep_state)
 		return -EBUSY;
 
-	for (i = 0; i < ARRAY_SIZE(scale_table); ++i)
-		if (scale_table[i] == val) {
+	for (i = 0; i < ARRAY_SIZE(scale_table) / 2; ++i)
+		if (scale_table[i * 2 + 1] == val) {
 			ret = bma180_set_bits(data,
 					BMA180_OFFSET_LSB1, BMA180_RANGE, i);
 			if (ret) {
@@ -316,20 +339,6 @@ err:
 	dev_err(&data->client->dev, "failed to disable the chip\n");
 }
 
-static IIO_CONST_ATTR(in_accel_filter_low_pass_3db_frequency_available,
-		BMA180_FLP_FREQ_AVAILABLE);
-static IIO_CONST_ATTR(in_accel_scale_available, BMA180_SCALE_AVAILABLE);
-
-static struct attribute *bma180_attributes[] = {
-	&iio_const_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
-	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group bma180_attrs_group = {
-	.attrs = bma180_attributes,
-};
-
 static int bma180_read_raw(struct iio_dev *indio_dev,
 		struct iio_chan_spec const *chan, int *val, int *val2,
 		long mask)
@@ -401,8 +410,8 @@ static int bma180_update_scan_mode(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info bma180_info = {
-	.attrs			= &bma180_attrs_group,
 	.read_raw		= bma180_read_raw,
+	.read_avail		= bma180_read_avail,
 	.write_raw		= bma180_write_raw,
 	.update_scan_mode	= bma180_update_scan_mode,
 	.driver_module		= THIS_MODULE,
@@ -454,6 +463,8 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), 	\
 	.scan_index = (_index),						\
 	.scan_type = IIO_ST('s', 14, 16, 2),				\
 	.ext_info = bma180_ext_info,					\
-- 
1.8.4.2

