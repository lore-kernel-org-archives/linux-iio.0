Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35115 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965241AbdGTPYv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2017 11:24:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so3034504pgc.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2017 08:24:51 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 02/11] iio: adc: ti-ads1015: fix scale information for ADS1115
Date: Fri, 21 Jul 2017 00:24:18 +0900
Message-Id: <1500564267-8613-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ti-ads1015 driver supports ADS1015 and ADS1115 devices.  The same
scale information is used for both devices in this driver, however they
have actually different values and the ADS1115's one is not correct.

These devices have the same full-scale input voltage range for each PGA
selection.  So instead of adding another hardcoded scale information,
compute a correct scale on demand from each device's resolution.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 48 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 443444c..f32d046 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -81,18 +81,12 @@ static const unsigned int ads1115_data_rate[] = {
 	8, 16, 32, 64, 128, 250, 475, 860
 };
 
-static const struct {
-	int scale;
-	int uscale;
-} ads1015_scale[] = {
-	{3, 0},
-	{2, 0},
-	{1, 0},
-	{0, 500000},
-	{0, 250000},
-	{0, 125000},
-	{0, 125000},
-	{0, 125000},
+/*
+ * Translation from PGA bits to full-scale positive and negative input voltage
+ * range in mV
+ */
+static int ads1015_fullscale_range[] = {
+	6144, 4096, 2048, 1024, 512, 256, 256, 256
 };
 
 #define ADS1015_V_CHAN(_chan, _addr) {				\
@@ -300,17 +294,20 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ads1015_set_scale(struct ads1015_data *data, int chan,
+static int ads1015_set_scale(struct ads1015_data *data,
+			     struct iio_chan_spec const *chan,
 			     int scale, int uscale)
 {
 	int i, ret, rindex = -1;
+	int fullscale = div_s64((scale * 1000000LL + uscale) <<
+				(chan->scan_type.realbits - 1), 1000000);
 
-	for (i = 0; i < ARRAY_SIZE(ads1015_scale); i++)
-		if (ads1015_scale[i].scale == scale &&
-		    ads1015_scale[i].uscale == uscale) {
+	for (i = 0; i < ARRAY_SIZE(ads1015_fullscale_range); i++) {
+		if (ads1015_fullscale_range[i] == fullscale) {
 			rindex = i;
 			break;
 		}
+	}
 	if (rindex < 0)
 		return -EINVAL;
 
@@ -320,7 +317,7 @@ static int ads1015_set_scale(struct ads1015_data *data, int chan,
 	if (ret < 0)
 		return ret;
 
-	data->channel_data[chan].pga = rindex;
+	data->channel_data[chan->address].pga = rindex;
 
 	return 0;
 }
@@ -378,9 +375,9 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 	}
 	case IIO_CHAN_INFO_SCALE:
 		idx = data->channel_data[chan->address].pga;
-		*val = ads1015_scale[idx].scale;
-		*val2 = ads1015_scale[idx].uscale;
-		ret = IIO_VAL_INT_PLUS_MICRO;
+		*val = ads1015_fullscale_range[idx];
+		*val2 = chan->scan_type.realbits - 1;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		idx = data->channel_data[chan->address].data_rate;
@@ -407,7 +404,7 @@ static int ads1015_write_raw(struct iio_dev *indio_dev,
 	mutex_lock(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = ads1015_set_scale(data, chan->address, val, val2);
+		ret = ads1015_set_scale(data, chan, val, val2);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = ads1015_set_data_rate(data, chan->address, val);
@@ -439,7 +436,10 @@ static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
 
-static IIO_CONST_ATTR(scale_available, "3 2 1 0.5 0.25 0.125");
+static IIO_CONST_ATTR_NAMED(ads1015_scale_available, scale_available,
+	"3 2 1 0.5 0.25 0.125");
+static IIO_CONST_ATTR_NAMED(ads1115_scale_available, scale_available,
+	"0.1875 0.125 0.0625 0.03125 0.015625 0.007813");
 
 static IIO_CONST_ATTR_NAMED(ads1015_sampling_frequency_available,
 	sampling_frequency_available, "128 250 490 920 1600 2400 3300");
@@ -447,7 +447,7 @@ static IIO_CONST_ATTR_NAMED(ads1115_sampling_frequency_available,
 	sampling_frequency_available, "8 16 32 64 128 250 475 860");
 
 static struct attribute *ads1015_attributes[] = {
-	&iio_const_attr_scale_available.dev_attr.attr,
+	&iio_const_attr_ads1015_scale_available.dev_attr.attr,
 	&iio_const_attr_ads1015_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
@@ -457,7 +457,7 @@ static const struct attribute_group ads1015_attribute_group = {
 };
 
 static struct attribute *ads1115_attributes[] = {
-	&iio_const_attr_scale_available.dev_attr.attr,
+	&iio_const_attr_ads1115_scale_available.dev_attr.attr,
 	&iio_const_attr_ads1115_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
-- 
2.7.4

