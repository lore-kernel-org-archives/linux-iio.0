Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:21812 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965230AbcAZLaI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jan 2016 06:30:08 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, <lars@metafoo.de>,
	<jic23@jic23.retrosnub.co.uk>
Subject: [RFC v2] iio: ad5755: added support for switching between voltage and current output
Date: Tue, 26 Jan 2016 12:29:42 +0100
Message-ID: <1453807782-18961-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for switching modes from userspace.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Changes since v1:
- Channels are exported as two independent channels
- Changes between modes can be done by writing a new scale that fits the channel
- If voltage mode is chosen, the readback from the current channel is -EBUSY

 drivers/iio/dac/ad5755.c | 385 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 297 insertions(+), 88 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index bfb350a..e614884 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -18,7 +18,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/platform_data/ad5755.h>
 
-#define AD5755_NUM_CHANNELS 4
+#define AD5755_NUM_CHANNELS 8	//4
 
 #define AD5755_ADDR(x)			((x) << 16)
 
@@ -91,6 +91,8 @@ struct ad5755_state {
 	unsigned int			ctrl[AD5755_NUM_CHANNELS];
 	struct iio_chan_spec		channels[AD5755_NUM_CHANNELS];
 
+	struct ad5755_platform_data *pdata;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -109,6 +111,153 @@ enum ad5755_type {
 	ID_AD5737,
 };
 
+struct ad5755_ranges {
+	enum ad5755_mode range;
+	unsigned int scale;
+	int offset;
+};
+
+static const struct ad5755_ranges ad5755_range_def[] = {
+	{
+		.range = AD5755_MODE_VOLTAGE_0V_5V,
+		.scale = 76293945,
+		.offset = 0,
+	}, {
+		.range = AD5755_MODE_VOLTAGE_0V_10V,
+		.scale = 152587890,
+		.offset = 0,
+	}, {
+		.range = AD5755_MODE_VOLTAGE_PLUSMINUS_5V,
+		.scale = 152587890,
+		.offset = -(1 << (16 /*REALBITS*/ - 1)),
+	}, {
+		.range = AD5755_MODE_VOLTAGE_PLUSMINUS_10V,
+		.scale = 305175781,
+		.offset = -(1 << (16 /*REALBITS*/ - 1)),
+	}, {
+		.range = AD5755_MODE_CURRENT_4mA_20mA,
+		.scale = 244140,
+		.offset = 16384,
+	}, {
+		.range = AD5755_MODE_CURRENT_0mA_20mA,
+		.scale = 305175,
+		.offset = 0,
+	}, {
+		.range = AD5755_MODE_CURRENT_0mA_24mA,
+		.scale = 366210,
+		.offset = 0,
+	}
+};
+
+static inline enum ad5755_mode ad5755_get_chan_mode(struct ad5755_state *st,
+						    const struct iio_chan_spec
+						    *chan)
+{
+	return st->ctrl[chan->channel] & 7;
+}
+
+static inline int ad5755_get_chan_scale(struct ad5755_state *st,
+					const struct iio_chan_spec *chan)
+{
+	return ad5755_range_def[ad5755_get_chan_mode(st, chan)].scale;
+}
+
+static inline int ad5755_get_chan_offset(struct ad5755_state *st,
+					 const struct iio_chan_spec *chan)
+{
+	return ad5755_range_def[ad5755_get_chan_mode(st, chan)].offset;
+}
+
+static bool ad5755_is_voltage_mode(enum ad5755_mode mode)
+{
+	switch (mode) {
+	case AD5755_MODE_VOLTAGE_0V_5V:
+	case AD5755_MODE_VOLTAGE_0V_10V:
+	case AD5755_MODE_VOLTAGE_PLUSMINUS_5V:
+	case AD5755_MODE_VOLTAGE_PLUSMINUS_10V:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static ssize_t ad5755_scales(char *buf, bool voltage_mode)
+{
+	int i, len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(ad5755_range_def); i++) {
+		if (ad5755_is_voltage_mode(i) != voltage_mode)
+			continue;
+		len += sprintf(buf + len, "0.%09u ", ad5755_range_def[i].scale);
+	}
+	len += sprintf(buf + len, "\n");
+
+	return len;
+}
+
+static ssize_t ad5755_offset(char *buf, bool voltage_mode)
+{
+	int i, len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(ad5755_range_def); i++) {
+		if (ad5755_is_voltage_mode(i) != voltage_mode)
+			continue;
+		len += sprintf(buf + len, "%d ", ad5755_range_def[i].offset);
+	}
+	len += sprintf(buf + len, "\n");
+
+	return len;
+}
+
+static ssize_t ad5755_show_voltage_scales(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return ad5755_scales(buf, true);
+}
+
+static ssize_t ad5755_show_voltage_offset(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return ad5755_offset(buf, true);
+}
+
+static ssize_t ad5755_show_current_scales(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return ad5755_scales(buf, false);
+}
+
+static ssize_t ad5755_show_current_offset(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return ad5755_offset(buf, false);
+}
+
+static IIO_DEVICE_ATTR(out_voltage_scale_available, S_IRUGO,
+		       ad5755_show_voltage_scales, NULL, 0);
+static IIO_DEVICE_ATTR(out_voltage_offset_available, S_IRUGO,
+		       ad5755_show_voltage_offset, NULL, 0);
+static IIO_DEVICE_ATTR(out_current_scale_available, S_IRUGO,
+		       ad5755_show_current_scales, NULL, 0);
+static IIO_DEVICE_ATTR(out_current_offset_available, S_IRUGO,
+		       ad5755_show_current_offset, NULL, 0);
+
+static struct attribute *ad5755_attributes[] = {
+	&iio_dev_attr_out_voltage_scale_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage_offset_available.dev_attr.attr,
+	&iio_dev_attr_out_current_scale_available.dev_attr.attr,
+	&iio_dev_attr_out_current_offset_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad5755_attribute_group = {
+	.attrs = ad5755_attributes,
+};
+
 static int ad5755_write_unlocked(struct iio_dev *indio_dev,
 	unsigned int reg, unsigned int val)
 {
@@ -226,31 +375,54 @@ out_unlock:
 	return 0;
 }
 
-static const int ad5755_min_max_table[][2] = {
-	[AD5755_MODE_VOLTAGE_0V_5V] = { 0, 5000 },
-	[AD5755_MODE_VOLTAGE_0V_10V] = { 0, 10000 },
-	[AD5755_MODE_VOLTAGE_PLUSMINUS_5V] = { -5000, 5000 },
-	[AD5755_MODE_VOLTAGE_PLUSMINUS_10V] = { -10000, 10000 },
-	[AD5755_MODE_CURRENT_4mA_20mA] = { 4, 20 },
-	[AD5755_MODE_CURRENT_0mA_20mA] = { 0, 20 },
-	[AD5755_MODE_CURRENT_0mA_24mA] = { 0, 24 },
-};
+static bool ad5755_is_valid_mode(struct ad5755_state *st, enum ad5755_mode mode)
+{
+	switch (mode) {
+	case AD5755_MODE_VOLTAGE_0V_5V:
+	case AD5755_MODE_VOLTAGE_0V_10V:
+	case AD5755_MODE_VOLTAGE_PLUSMINUS_5V:
+	case AD5755_MODE_VOLTAGE_PLUSMINUS_10V:
+		return st->chip_info->has_voltage_out;
+	case AD5755_MODE_CURRENT_4mA_20mA:
+	case AD5755_MODE_CURRENT_0mA_20mA:
+	case AD5755_MODE_CURRENT_0mA_24mA:
+		return true;
+	default:
+		return false;
+	}
+}
 
-static void ad5755_get_min_max(struct ad5755_state *st,
-	struct iio_chan_spec const *chan, int *min, int *max)
+static int ad5755_clear_dac(struct iio_dev *indio_dev, int channel)
 {
-	enum ad5755_mode mode = st->ctrl[chan->channel] & 7;
-	*min = ad5755_min_max_table[mode][0];
-	*max = ad5755_min_max_table[mode][1];
+	int i = channel;
+	int ret;
+
+	ret = ad5755_update_dac_ctrl(indio_dev, i, 0, UINT_MAX);
+	return ret;
+
 }
 
-static inline int ad5755_get_offset(struct ad5755_state *st,
-	struct iio_chan_spec const *chan)
+static int ad5755_setup_dac(struct iio_dev *indio_dev, int channel)
 {
-	int min, max;
+	int i = channel;
+	int ret;
+	struct ad5755_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	struct ad5755_platform_data *pdata = st->pdata;
+
+	if (!ad5755_is_valid_mode(st, pdata->dac[i].mode))
+		return -EINVAL;
+
+	val = 0;
+	if (!pdata->dac[i].ext_current_sense_resistor)
+		val |= AD5755_DAC_INT_CURRENT_SENSE_RESISTOR;
+	if (pdata->dac[i].enable_voltage_overrange)
+		val |= AD5755_DAC_VOLTAGE_OVERRANGE_EN;
+	val |= pdata->dac[i].mode;
+
+	ret = ad5755_update_dac_ctrl(indio_dev, i, val, 0);
+	return ret;
 
-	ad5755_get_min_max(st, chan, &min, &max);
-	return (min * (1 << chan->scan_type.realbits)) / (max - min);
 }
 
 static int ad5755_chan_reg_info(struct ad5755_state *st,
@@ -289,22 +461,29 @@ static int ad5755_chan_reg_info(struct ad5755_state *st,
 	return 0;
 }
 
+static int ad5755_channel_report(int type, int mode)
+{
+	return (type == IIO_VOLTAGE) == ad5755_is_voltage_mode(mode);
+
+}
+
 static int ad5755_read_raw(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val, int *val2, long info)
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
 	unsigned int reg, shift, offset;
-	int min, max;
 	int ret;
 
+	if(!ad5755_channel_report(chan->type,st->pdata->dac[chan->address].mode))
+		return -EBUSY;
+
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
-		ad5755_get_min_max(st, chan, &min, &max);
-		*val = max - min;
-		*val2 = chan->scan_type.realbits;
-		return IIO_VAL_FRACTIONAL_LOG2;
+		*val = 0;
+		*val2 = ad5755_get_chan_scale(st, chan);
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = ad5755_get_offset(st, chan);
+		*val = ad5755_get_chan_offset(st, chan);
 		return IIO_VAL_INT;
 	default:
 		ret = ad5755_chan_reg_info(st, chan, info, false,
@@ -328,21 +507,82 @@ static int ad5755_write_raw(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int val, int val2, long info)
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
-	unsigned int shift, reg, offset;
-	int ret;
-
-	ret = ad5755_chan_reg_info(st, chan, info, true,
-					&reg, &shift, &offset);
-	if (ret)
-		return ret;
+	unsigned int shift, reg;
+	int offset;
+	unsigned int scale;
+	int ret, i;
+
+	/* Lets us select mode only when a new scale is applied */
+	if(info != IIO_CHAN_INFO_SCALE) {
+		if(!ad5755_channel_report(chan->type,st->pdata->dac[chan->address].mode))
+		return -EBUSY;
+	}
 
-	val <<= shift;
-	val += offset;
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+	case IIO_CHAN_INFO_OFFSET:
+		if (!(bool) (st->pwr_down & (1 << chan->channel))) {
+			printk("POWER DOWN off - Power down before shifting modes\n");
+			return -EPERM;
+		}
+	}
 
-	if (val < 0 || val > 0xffff)
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		offset = ad5755_range_def[st->pdata->dac[chan->address].mode].offset;
+		/* is new scale allowed */
+		for (i = 0; i < ARRAY_SIZE(ad5755_range_def); i++) {
+			if (val2 == ad5755_range_def[i].scale &&
+			    offset == ad5755_range_def[i].offset &&
+			    ad5755_channel_report(chan->type, i)) {
+				st->pdata->dac[chan->address].mode = i;
+				ad5755_clear_dac(indio_dev, chan->address);
+				return ad5755_setup_dac(indio_dev, chan->address);
+			}
+		}
 		return -EINVAL;
+	case IIO_CHAN_INFO_OFFSET:
+		scale = ad5755_range_def[st->pdata->dac[chan->address].mode].scale;
+		/* is new offset allowed */
+		for (i = 0; i < ARRAY_SIZE(ad5755_range_def); i++) {
+			if (val == ad5755_range_def[i].offset &&
+			    scale == ad5755_range_def[i].scale &&
+			    ad5755_channel_report(chan->type, i)) {
+				st->pdata->dac[chan->address].mode = i;
+				ad5755_clear_dac(indio_dev, chan->address);
+				return ad5755_setup_dac(indio_dev, chan->address);
+			}
+		}
+		return -EINVAL;
+	default:
+		ret = ad5755_chan_reg_info(st, chan, info, true,
+					   &reg, &shift, &offset);
+		if (ret)
+			return ret;
+
+		val <<= shift;
+		val += offset;
+
+		if (val < 0 || val > 0xffff)
+			return -EINVAL;
+
+		return ad5755_write(indio_dev, reg, val);
+	}
+
+	return -EINVAL;
+}
+
+static int ad5755_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT;
+	}
 
-	return ad5755_write(indio_dev, reg, val);
+	return -EINVAL;
 }
 
 static ssize_t ad5755_read_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
@@ -371,6 +611,8 @@ static ssize_t ad5755_write_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
 static const struct iio_info ad5755_info = {
 	.read_raw = ad5755_read_raw,
 	.write_raw = ad5755_write_raw,
+	.write_raw_get_fmt = &ad5755_write_raw_get_fmt,
+	.attrs = &ad5755_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -424,27 +666,9 @@ static const struct ad5755_chip_info ad5755_chip_info_tbl[] = {
 	},
 };
 
-static bool ad5755_is_valid_mode(struct ad5755_state *st, enum ad5755_mode mode)
-{
-	switch (mode) {
-	case AD5755_MODE_VOLTAGE_0V_5V:
-	case AD5755_MODE_VOLTAGE_0V_10V:
-	case AD5755_MODE_VOLTAGE_PLUSMINUS_5V:
-	case AD5755_MODE_VOLTAGE_PLUSMINUS_10V:
-		return st->chip_info->has_voltage_out;
-	case AD5755_MODE_CURRENT_4mA_20mA:
-	case AD5755_MODE_CURRENT_0mA_20mA:
-	case AD5755_MODE_CURRENT_0mA_24mA:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static int ad5755_setup_pdata(struct iio_dev *indio_dev,
-			      const struct ad5755_platform_data *pdata)
+			      struct ad5755_platform_data *pdata)
 {
-	struct ad5755_state *st = iio_priv(indio_dev);
 	unsigned int val;
 	unsigned int i;
 	int ret;
@@ -479,17 +703,7 @@ static int ad5755_setup_pdata(struct iio_dev *indio_dev,
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pdata->dac); ++i) {
-		if (!ad5755_is_valid_mode(st, pdata->dac[i].mode))
-			return -EINVAL;
-
-		val = 0;
-		if (!pdata->dac[i].ext_current_sense_resistor)
-			val |= AD5755_DAC_INT_CURRENT_SENSE_RESISTOR;
-		if (pdata->dac[i].enable_voltage_overrange)
-			val |= AD5755_DAC_VOLTAGE_OVERRANGE_EN;
-		val |= pdata->dac[i].mode;
-
-		ret = ad5755_update_dac_ctrl(indio_dev, i, val, 0);
+		ret = ad5755_setup_dac(indio_dev, i);
 		if (ret < 0)
 			return ret;
 	}
@@ -497,21 +711,8 @@ static int ad5755_setup_pdata(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static bool ad5755_is_voltage_mode(enum ad5755_mode mode)
-{
-	switch (mode) {
-	case AD5755_MODE_VOLTAGE_0V_5V:
-	case AD5755_MODE_VOLTAGE_0V_10V:
-	case AD5755_MODE_VOLTAGE_PLUSMINUS_5V:
-	case AD5755_MODE_VOLTAGE_PLUSMINUS_10V:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static int ad5755_init_channels(struct iio_dev *indio_dev,
-				const struct ad5755_platform_data *pdata)
+				struct ad5755_platform_data *pdata)
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
 	struct iio_chan_spec *channels = st->channels;
@@ -519,12 +720,18 @@ static int ad5755_init_channels(struct iio_dev *indio_dev,
 
 	for (i = 0; i < AD5755_NUM_CHANNELS; ++i) {
 		channels[i] = st->chip_info->channel_template;
-		channels[i].channel = i;
-		channels[i].address = i;
-		if (pdata && ad5755_is_voltage_mode(pdata->dac[i].mode))
-			channels[i].type = IIO_VOLTAGE;
-		else
+		if (i <= 3) {
+			channels[i].channel = i;
+			channels[i].address = i;
 			channels[i].type = IIO_CURRENT;
+		} else {
+			channels[i].channel = i - 4;
+			channels[i].address = i - 4;
+			channels[i].type = IIO_VOLTAGE;
+		}
+		/*if(!st->chip_info->has_voltage_out)
+			if(i>3)
+				break;*/
 	}
 
 	indio_dev->channels = channels;
@@ -543,7 +750,7 @@ static int ad5755_init_channels(struct iio_dev *indio_dev,
 		}, \
 	}
 
-static const struct ad5755_platform_data ad5755_default_pdata = {
+struct ad5755_platform_data ad5755_default_pdata = {
 	.ext_dc_dc_compenstation_resistor = false,
 	.dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE,
 	.dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ,
@@ -559,7 +766,7 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
 static int ad5755_probe(struct spi_device *spi)
 {
 	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
-	const struct ad5755_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct ad5755_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad5755_state *st;
 	int ret;
@@ -586,6 +793,8 @@ static int ad5755_probe(struct spi_device *spi)
 	if (!pdata)
 		pdata = &ad5755_default_pdata;
 
+	st->pdata = pdata;
+
 	ret = ad5755_init_channels(indio_dev, pdata);
 	if (ret)
 		return ret;
-- 
2.7.0

