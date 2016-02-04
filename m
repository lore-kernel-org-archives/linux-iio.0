Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35652 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965630AbcBDOu3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2016 09:50:29 -0500
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com, daniel.baluta@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [RFC PATCH 1/2] iio: hmc5843 Add channel attribute for bias configuration
Date: Thu,  4 Feb 2016 16:50:12 +0200
Message-Id: <1454597413-5298-1-git-send-email-cristina.moraru09@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace non standard meas_conf attribute with the standard IIO
calibbias attribute.

API for setting bias measurement configuration:

0 - Normal measurement configuration (default): In normal measurement
    configuration the device follows normal measurement flow. Pins BP
    and BN are left floating and high impedance.

1 - Positive bias configuration: In positive bias configuration, a
    positive current is forced across the resistive load on pins BP
    and BN.

2 - Negative bias configuration. In negative bias configuration, a
    negative current is forced across the resistive load on pins BP
    and BN.

3 - Only available on HMC5983. Magnetic sensor is disabled.
    Temperature sensor is enabled.

With this in place, we can think of moving this driver out of staging.

Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
---
 drivers/staging/iio/magnetometer/hmc5843_core.c | 62 +++++++------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
index 4aab022..c5f16da 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_core.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
@@ -205,50 +205,6 @@ static int hmc5843_set_meas_conf(struct hmc5843_data *data, u8 meas_conf)
 }
 
 static
-ssize_t hmc5843_show_measurement_configuration(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf)
-{
-	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(data->regmap, HMC5843_CONFIG_REG_A, &val);
-	if (ret)
-		return ret;
-	val &= HMC5843_MEAS_CONF_MASK;
-
-	return sprintf(buf, "%d\n", val);
-}
-
-static
-ssize_t hmc5843_set_measurement_configuration(struct device *dev,
-					      struct device_attribute *attr,
-					      const char *buf,
-					      size_t count)
-{
-	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
-	unsigned long meas_conf = 0;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &meas_conf);
-	if (ret)
-		return ret;
-	if (meas_conf >= HMC5843_MEAS_CONF_MASK)
-		return -EINVAL;
-
-	ret = hmc5843_set_meas_conf(data, meas_conf);
-
-	return (ret < 0) ? ret : count;
-}
-
-static IIO_DEVICE_ATTR(meas_conf,
-			S_IWUSR | S_IRUGO,
-			hmc5843_show_measurement_configuration,
-			hmc5843_set_measurement_configuration,
-			0);
-
-static
 ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -371,6 +327,13 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 		*val = data->variant->regval_to_samp_freq[rval][0];
 		*val2 = data->variant->regval_to_samp_freq[rval][1];
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(data->regmap, HMC5843_CONFIG_REG_A, &rval);
+		if (ret)
+			return ret;
+		rval &= HMC5843_MEAS_CONF_MASK;
+		*val = rval;
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -395,6 +358,11 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		return hmc5843_set_range_gain(data, range);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val >= HMC5843_MEAS_CONF_MASK)
+			return -EINVAL;
+
+		return hmc5843_set_meas_conf(data, val);
 	default:
 		return -EINVAL;
 	}
@@ -409,6 +377,8 @@ static int hmc5843_write_raw_get_fmt(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -451,7 +421,8 @@ done:
 		.channel2 = IIO_MOD_##axis,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+					BIT(IIO_CHAN_INFO_SAMP_FREQ) |  \
+					BIT(IIO_CHAN_INFO_CALIBBIAS),   \
 		.scan_index = idx,					\
 		.scan_type = {						\
 			.sign = 's',					\
@@ -477,7 +448,6 @@ static const struct iio_chan_spec hmc5883_channels[] = {
 };
 
 static struct attribute *hmc5843_attributes[] = {
-	&iio_dev_attr_meas_conf.dev_attr.attr,
 	&iio_dev_attr_scale_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
-- 
1.9.1

