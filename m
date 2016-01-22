Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:22352 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbcAVNIB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Jan 2016 08:08:01 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [RFC 2/2] iio: ad5755: added support for switching between voltage and current output
Date: Fri, 22 Jan 2016 13:54:56 +0100
Message-ID: <1453467296-26356-2-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1453467296-26356-1-git-send-email-sean.nyekjaer@prevas.dk>
References: <1453467296-26356-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

DAC ad5755 have both support for voltage and current output, before the driver
only had support for switching modes at compile time. Not very smart...

This patch adds support for switching modes from userspace.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---

This patch is not done yet :-) I would like to get some feedback of my work.
I have tested this patch with an ad5755 and it works.

So if you have any ideas on how I should progress please give me some feedback.

 drivers/iio/dac/ad5755.c | 405 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 319 insertions(+), 86 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index bfb350a..6e7ab3f 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -63,6 +63,9 @@
 #define AD5755_SLEW_RATE_SHIFT			3
 #define AD5755_SLEW_ENABLE			BIT(12)
 
+#define AD5755_VOLTAGE_MODE			0
+#define AD5755_CURRENT_MODE			1
+
 /**
  * struct ad5755_chip_info - chip specific information
  * @channel_template:	channel specification
@@ -91,6 +94,8 @@ struct ad5755_state {
 	unsigned int			ctrl[AD5755_NUM_CHANNELS];
 	struct iio_chan_spec		channels[AD5755_NUM_CHANNELS];
 
+	struct ad5755_platform_data *pdata;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -109,6 +114,163 @@ enum ad5755_type {
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
+static ssize_t ad5755_show_voltcur_modes(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sprintf(buf, "voltage: 0\ncurrent: 1\n");
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
+static IIO_DEVICE_ATTR(out_voltcur_modes_available, S_IRUGO,
+		       ad5755_show_voltcur_modes, NULL, 0);
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
+	&iio_dev_attr_out_voltcur_modes_available.dev_attr.attr,
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
@@ -226,31 +388,54 @@ out_unlock:
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
@@ -294,18 +479,25 @@ static int ad5755_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
 	unsigned int reg, shift, offset;
-	int min, max;
 	int ret;
 
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
+	case IIO_CHAN_INFO_MODE:
+		if (ad5755_is_voltage_mode(st->pdata->dac[chan->address].mode)) {
+			*val = AD5755_VOLTAGE_MODE;
+			return IIO_VAL_INT;
+		} else {
+			*val = AD5755_CURRENT_MODE;
+			return IIO_VAL_INT;
+		}
+		break;
 	default:
 		ret = ad5755_chan_reg_info(st, chan, info, false,
 						&reg, &shift, &offset);
@@ -325,24 +517,100 @@ static int ad5755_read_raw(struct iio_dev *indio_dev,
 }
 
 static int ad5755_write_raw(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, int val, int val2, long info)
+			    const struct iio_chan_spec *chan, int val, int val2,
+			    long info)
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
-	unsigned int shift, reg, offset;
-	int ret;
+	unsigned int shift, reg;
+	bool is_voltage;
+	int offset;
+	unsigned int scale;
+	int ret, i;
 
-	ret = ad5755_chan_reg_info(st, chan, info, true,
-					&reg, &shift, &offset);
-	if (ret)
-		return ret;
-
-	val <<= shift;
-	val += offset;
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+	case IIO_CHAN_INFO_OFFSET:
+	case IIO_CHAN_INFO_MODE:
+		if (!(bool) (st->pwr_down & (1 << chan->channel))) {
+			printk
+			    ("POWER DOWN off - Power down before shifting modes\n");
+			return -EPERM;
+		}
+	}
 
-	if (val < 0 || val > 0xffff)
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		is_voltage =
+		    ad5755_is_voltage_mode(st->pdata->dac[chan->address].mode);
+		offset =
+		    ad5755_range_def[st->pdata->dac[chan->address].mode].offset;
+		/* is new scale allowed */
+		for (i = 0; i < ARRAY_SIZE(ad5755_range_def); i++) {
+			if (val2 == ad5755_range_def[i].scale &&
+			    offset == ad5755_range_def[i].offset &&
+			    is_voltage == ad5755_is_voltage_mode(i)) {
+				st->pdata->dac[chan->address].mode = i;
+				ad5755_clear_dac(indio_dev, chan->address);
+				return ad5755_setup_dac(indio_dev, chan->address);
+			}
+		}
 		return -EINVAL;
+	case IIO_CHAN_INFO_OFFSET:
+		is_voltage =
+		    ad5755_is_voltage_mode(st->pdata->dac[chan->address].mode);
+		scale =
+		    ad5755_range_def[st->pdata->dac[chan->address].mode].scale;
+		/* is new offset allowed */
+		for (i = 0; i < ARRAY_SIZE(ad5755_range_def); i++) {
+			if (val == ad5755_range_def[i].offset &&
+			    scale == ad5755_range_def[i].scale &&
+			    is_voltage == ad5755_is_voltage_mode(i)) {
+				st->pdata->dac[chan->address].mode = i;
+				ad5755_clear_dac(indio_dev, chan->address);
+				return ad5755_setup_dac(indio_dev, chan->address);
+			}
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_MODE:
+		if (val2 != 0)
+			return -EINVAL;
+		if (val == AD5755_VOLTAGE_MODE)
+			st->pdata->dac[chan->address].mode = AD5755_MODE_VOLTAGE_0V_5V;
+		else
+			st->pdata->dac[chan->address].mode = AD5755_MODE_CURRENT_0mA_20mA;
+		ad5755_clear_dac(indio_dev, chan->address);
+
+		return ad5755_setup_dac(indio_dev, chan->address);
+		break;
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
@@ -371,6 +639,8 @@ static ssize_t ad5755_write_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
 static const struct iio_info ad5755_info = {
 	.read_raw = ad5755_read_raw,
 	.write_raw = ad5755_write_raw,
+	.write_raw_get_fmt = &ad5755_write_raw_get_fmt,
+	.attrs = &ad5755_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -391,7 +661,8 @@ static const struct iio_chan_spec_ext_info ad5755_ext_info[] = {
 		BIT(IIO_CHAN_INFO_SCALE) |			\
 		BIT(IIO_CHAN_INFO_OFFSET) |			\
 		BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
-		BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		BIT(IIO_CHAN_INFO_CALIBBIAS)  |			\
+		BIT(IIO_CHAN_INFO_MODE),			\
 	.scan_type = {						\
 		.sign = 'u',					\
 		.realbits = (_bits),				\
@@ -424,27 +695,9 @@ static const struct ad5755_chip_info ad5755_chip_info_tbl[] = {
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
@@ -479,39 +732,17 @@ static int ad5755_setup_pdata(struct iio_dev *indio_dev,
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
+
 	}
 
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
@@ -521,8 +752,8 @@ static int ad5755_init_channels(struct iio_dev *indio_dev,
 		channels[i] = st->chip_info->channel_template;
 		channels[i].channel = i;
 		channels[i].address = i;
-		if (pdata && ad5755_is_voltage_mode(pdata->dac[i].mode))
-			channels[i].type = IIO_VOLTAGE;
+		if (st->chip_info->has_voltage_out)
+			channels[i].type = IIO_DUAL_VOLTCUR;
 		else
 			channels[i].type = IIO_CURRENT;
 	}
@@ -543,7 +774,7 @@ static int ad5755_init_channels(struct iio_dev *indio_dev,
 		}, \
 	}
 
-static const struct ad5755_platform_data ad5755_default_pdata = {
+struct ad5755_platform_data ad5755_default_pdata = {
 	.ext_dc_dc_compenstation_resistor = false,
 	.dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE,
 	.dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ,
@@ -559,7 +790,7 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
 static int ad5755_probe(struct spi_device *spi)
 {
 	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
-	const struct ad5755_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct ad5755_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad5755_state *st;
 	int ret;
@@ -586,6 +817,8 @@ static int ad5755_probe(struct spi_device *spi)
 	if (!pdata)
 		pdata = &ad5755_default_pdata;
 
+	st->pdata = pdata;
+
 	ret = ad5755_init_channels(indio_dev, pdata);
 	if (ret)
 		return ret;
-- 
2.7.0

