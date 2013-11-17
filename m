Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50321 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab3KQOOM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:12 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/11] iio:adc:mcp3422: use core to provide _available information rather than custom attrs.
Date: Sun, 17 Nov 2013 15:15:02 +0000
Message-Id: <1384701302-26564-12-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Passing this information through the new core callbacks makes it available
to in kernel consumers of the channels.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/mcp3422.c | 72 ++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index dbdbd77f69ea..1f627cce1029 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -55,6 +55,8 @@
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
 				| BIT(IIO_CHAN_INFO_SCALE), \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
 	}
 
 /* LSB is in nV to eliminate floating point */
@@ -66,11 +68,11 @@ static const u32 rates_to_lsb[] = {1000000, 250000, 62500, 15625};
  *  pga is 1 for 0, 2
  */
 
-static const int mcp3422_scales[4][4] = {
-	{ 1000000, 250000, 62500, 15625 },
-	{ 500000 , 125000, 31250, 7812 },
-	{ 250000 , 62500 , 15625, 3906 },
-	{ 125000 , 31250 , 7812 , 1953 } };
+static const int mcp3422_scales[4][8] = {
+	{ 0, 1000000, 0, 250000, 0, 62500, 0, 15625 },
+	{ 0, 500000, 0, 125000, 0, 31250, 0, 7812 },
+	{ 0, 250000, 0, 62500, 0, 15625, 0, 3906 },
+	{ 0, 125000, 0, 31250, 0, 7812 , 0, 1953 } };
 
 /* Constant msleep times for data acquisitions */
 static const int mcp3422_read_times[4] = {
@@ -181,8 +183,8 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 
 	case IIO_CHAN_INFO_SCALE:
 
-		*val1 = 0;
-		*val2 = mcp3422_scales[sample_rate][pga];
+		*val1 = mcp3422_scales[sample_rate][pga * 2 + 0];
+		*val2 = mcp3422_scales[sample_rate][pga * 2 + 1];
 		return IIO_VAL_INT_PLUS_NANO;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -196,6 +198,33 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 	return -EINVAL;
 }
 
+static const int mcp3422_samp_freqs[] = { 240, 60, 15, 3 };
+static int mcp3422_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals,
+			      int *type,
+			      int *length,
+			      long mask_el)
+{
+	struct mcp3422 *adc = iio_priv(indio_dev);
+	u8 sample_rate;
+
+	switch (mask_el) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = mcp3422_samp_freqs;
+		*length = ARRAY_SIZE(mcp3422_samp_freqs);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		sample_rate = MCP3422_SAMPLE_RATE(adc->config);
+		*vals = mcp3422_scales[sample_rate];
+		*length = ARRAY_SIZE(mcp3422_scales[0]);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	}
+	return -EINVAL;
+}
+
 static int mcp3422_write_raw(struct iio_dev *iio,
 			struct iio_chan_spec const *channel, int val1,
 			int val2, long mask)
@@ -271,33 +300,6 @@ static int mcp3422_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
-static ssize_t mcp3422_show_scales(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
-	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
-
-	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
-		mcp3422_scales[sample_rate][0],
-		mcp3422_scales[sample_rate][1],
-		mcp3422_scales[sample_rate][2],
-		mcp3422_scales[sample_rate][3]);
-}
-
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("240 60 15 3");
-static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-		mcp3422_show_scales, NULL, 0);
-
-static struct attribute *mcp3422_attributes[] = {
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group mcp3422_attribute_group = {
-	.attrs = mcp3422_attributes,
-};
-
 static const struct iio_chan_spec mcp3422_channels[] = {
 	MCP3422_CHAN(0),
 	MCP3422_CHAN(1),
@@ -312,9 +314,9 @@ static const struct iio_chan_spec mcp3424_channels[] = {
 
 static const struct iio_info mcp3422_info = {
 	.read_raw = mcp3422_read_raw,
+	.read_avail = mcp3422_read_avail,
 	.write_raw = mcp3422_write_raw,
 	.write_raw_get_fmt = mcp3422_write_raw_get_fmt,
-	.attrs = &mcp3422_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.8.4.2

