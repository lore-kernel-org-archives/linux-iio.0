Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48083 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbaAMV2i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Jan 2014 16:28:38 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 5/6] staging:iio:accel:sca3000: Move temperature attribute to channels
Date: Mon, 13 Jan 2014 22:28:33 +0100
Message-Id: <1389648514-31429-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net>
References: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

differantiate between channels with_temp and without

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/accel/sca3000_core.c | 125 ++++++++++++-------------------
 1 file changed, 48 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 0123bc0..ed30e32 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -450,6 +450,18 @@ static const struct iio_chan_spec sca3000_channels[] = {
 	SCA3000_CHAN(2, IIO_MOD_Z),
 };
 
+static const struct iio_chan_spec sca3000_channels_with_temp[] = {
+	SCA3000_CHAN(0, IIO_MOD_X),
+	SCA3000_CHAN(1, IIO_MOD_Y),
+	SCA3000_CHAN(2, IIO_MOD_Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OFFSET),
+	},
+};
+
 static u8 sca3000_addresses[3][3] = {
 	[0] = {SCA3000_REG_ADDR_X_MSB, SCA3000_REG_CTRL_SEL_MD_X_TH,
 	       SCA3000_MD_CTRL_OR_X},
@@ -472,19 +484,30 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
-		if (st->mo_det_use_count) {
-			mutex_unlock(&st->lock);
-			return -EBUSY;
-		}
-		address = sca3000_addresses[chan->address][0];
-		ret = sca3000_read_data_short(st, address, 2);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
+		if (chan->type == IIO_ACCEL) {
+			if (st->mo_det_use_count) {
+				mutex_unlock(&st->lock);
+				return -EBUSY;
+			}
+			address = sca3000_addresses[chan->address][0];
+			ret = sca3000_read_data_short(st, address, 2);
+			if (ret < 0) {
+				mutex_unlock(&st->lock);
+				return ret;
+			}
+			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
+			*val = ((*val) << (sizeof(*val)*8 - 13)) >>
+				(sizeof(*val)*8 - 13);
+		} else {
+			/* get the temperature when available */
+			ret = sca3000_read_data_short(st,
+				SCA3000_REG_ADDR_TEMP_MSB, 2);
+			if (ret < 0) {
+				mutex_unlock(&st->lock);
+				return ret;
+			}
+			*val = ((st->rx[0] & 0x3F) << 3) | ((st->rx[1] & 0xE0) >> 5);
 		}
-		*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
-		*val = ((*val) << (sizeof(*val)*8 - 13)) >>
-			(sizeof(*val)*8 - 13);
 		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -494,6 +517,10 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 		else /* temperature */
 			*val2 = 555556;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -214;
+		*val2 = 600000;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -673,37 +700,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 			      sca3000_read_frequency,
 			      sca3000_set_frequency);
 
-
-/**
- * sca3000_read_temp() sysfs interface to get the temperature when available
- *
- * The alignment of data in here is downright odd. See data sheet.
- * Converting this into a meaningful value is left to inline functions in
- * userspace part of header.
- **/
-static ssize_t sca3000_read_temp(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret;
-	int val;
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_TEMP_MSB, 2);
-	if (ret < 0)
-		goto error_ret;
-	val = ((st->rx[0] & 0x3F) << 3) | ((st->rx[1] & 0xE0) >> 5);
-
-	return sprintf(buf, "%d\n", val);
-
-error_ret:
-	return ret;
-}
-static IIO_DEV_ATTR_TEMP_RAW(sca3000_read_temp);
-
-static IIO_CONST_ATTR_TEMP_SCALE("0.555556");
-static IIO_CONST_ATTR_TEMP_OFFSET("-214.6");
-
 /**
  * sca3000_read_thresh() - query of a threshold
  **/
@@ -783,27 +779,10 @@ static struct attribute *sca3000_attributes[] = {
 	NULL,
 };
 
-static struct attribute *sca3000_attributes_with_temp[] = {
-	&iio_dev_attr_revision.dev_attr.attr,
-	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
-	&iio_dev_attr_measurement_mode.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	/* Only present if temp sensor is */
-	&iio_dev_attr_in_temp_raw.dev_attr.attr,
-	&iio_const_attr_in_temp_offset.dev_attr.attr,
-	&iio_const_attr_in_temp_scale.dev_attr.attr,
-	NULL,
-};
-
 static const struct attribute_group sca3000_attribute_group = {
 	.attrs = sca3000_attributes,
 };
 
-static const struct attribute_group sca3000_attribute_group_with_temp = {
-	.attrs = sca3000_attributes_with_temp,
-};
-
 /**
  * sca3000_event_handler() - handling ring and non ring events
  *
@@ -1138,17 +1117,6 @@ static const struct iio_info sca3000_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static const struct iio_info sca3000_info_with_temp = {
-	.attrs = &sca3000_attribute_group_with_temp,
-	.read_raw = &sca3000_read_raw,
-	.event_attrs = &sca3000_event_attribute_group,
-	.read_event_value = &sca3000_read_thresh,
-	.write_event_value = &sca3000_write_thresh,
-	.read_event_config = &sca3000_read_event_config,
-	.write_event_config = &sca3000_write_event_config,
-	.driver_module = THIS_MODULE,
-};
-
 static int sca3000_probe(struct spi_device *spi)
 {
 	int ret;
@@ -1168,12 +1136,15 @@ static int sca3000_probe(struct spi_device *spi)
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	if (st->info->temp_output)
-		indio_dev->info = &sca3000_info_with_temp;
-	else
-		indio_dev->info = &sca3000_info;
-	indio_dev->channels = sca3000_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
+	indio_dev->info = &sca3000_info;
+	if (st->info->temp_output) {
+		indio_dev->channels = sca3000_channels_with_temp;
+		indio_dev->num_channels =
+			ARRAY_SIZE(sca3000_channels_with_temp);
+	} else {
+		indio_dev->channels = sca3000_channels;
+		indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
+	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	sca3000_configure_ring(indio_dev);
-- 
1.8.3.2

