Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-060.synserver.de ([212.40.185.60]:1177 "EHLO
	smtp-out-056.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752022Ab2BURgt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2012 12:36:49 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] staging:iio:dac:ad5064: Convert to extended channel info attributes
Date: Tue, 21 Feb 2012 18:38:13 +0100
Message-Id: <1329845897-23364-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1329845897-23364-1-git-send-email-lars@metafoo.de>
References: <1329845897-23364-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use extended channel info attributes for the powerdown, powerdown_mode and
powerdown_mode_available attributes.

Note that this patch moves the chip info defintion around to avoid having to use
forward declarations for the extended channel info attributes callbacks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5064.c |  188 +++++++++++++++++---------------------
 1 files changed, 82 insertions(+), 106 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 049a855..52fef75 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -86,47 +86,6 @@ enum ad5064_type {
 	ID_AD5064_1,
 };
 
-#define AD5064_CHANNEL(chan, bits) {				\
-	.type = IIO_VOLTAGE,					\
-	.indexed = 1,						\
-	.output = 1,						\
-	.channel = (chan),					\
-	.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
-	.address = AD5064_ADDR_DAC(chan),			\
-	.scan_type = IIO_ST('u', (bits), 16, 20 - (bits))	\
-}
-
-static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
-	[ID_AD5024] = {
-		.shared_vref = false,
-		.channel[0] = AD5064_CHANNEL(0, 12),
-		.channel[1] = AD5064_CHANNEL(1, 12),
-		.channel[2] = AD5064_CHANNEL(2, 12),
-		.channel[3] = AD5064_CHANNEL(3, 12),
-	},
-	[ID_AD5044] = {
-		.shared_vref = false,
-		.channel[0] = AD5064_CHANNEL(0, 14),
-		.channel[1] = AD5064_CHANNEL(1, 14),
-		.channel[2] = AD5064_CHANNEL(2, 14),
-		.channel[3] = AD5064_CHANNEL(3, 14),
-	},
-	[ID_AD5064] = {
-		.shared_vref = false,
-		.channel[0] = AD5064_CHANNEL(0, 16),
-		.channel[1] = AD5064_CHANNEL(1, 16),
-		.channel[2] = AD5064_CHANNEL(2, 16),
-		.channel[3] = AD5064_CHANNEL(3, 16),
-	},
-	[ID_AD5064_1] = {
-		.shared_vref = true,
-		.channel[0] = AD5064_CHANNEL(0, 16),
-		.channel[1] = AD5064_CHANNEL(1, 16),
-		.channel[2] = AD5064_CHANNEL(2, 16),
-		.channel[3] = AD5064_CHANNEL(3, 16),
-	},
-};
-
 static int ad5064_spi_write(struct ad5064_state *st, unsigned int cmd,
 	unsigned int addr, unsigned int val, unsigned int shift)
 {
@@ -160,22 +119,25 @@ static const char ad5064_powerdown_modes[][15] = {
 	[AD5064_LDAC_PWRDN_3STATE]	= "three_state",
 };
 
-static ssize_t ad5064_read_powerdown_mode(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t ad5064_read_powerdown_mode_available(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, char *buf)
+{
+	return sprintf(buf, "%s %s %s\n", ad5064_powerdown_modes[1],
+		ad5064_powerdown_modes[2], ad5064_powerdown_modes[3]);
+}
+
+static ssize_t ad5064_read_powerdown_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, char *buf)
 {
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5064_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%s\n",
-		ad5064_powerdown_modes[st->pwr_down_mode[this_attr->address]]);
+		ad5064_powerdown_modes[st->pwr_down_mode[chan->channel]]);
 }
 
-static ssize_t ad5064_write_powerdown_mode(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t ad5064_write_powerdown_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, const char *buf, size_t len)
 {
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5064_state *st = iio_priv(indio_dev);
 	unsigned int mode, i;
 	int ret;
@@ -192,31 +154,26 @@ static ssize_t ad5064_write_powerdown_mode(struct device *dev,
 		return  -EINVAL;
 
 	mutex_lock(&indio_dev->mlock);
-	st->pwr_down_mode[this_attr->address] = mode;
+	st->pwr_down_mode[chan->channel] = mode;
 
-	ret = ad5064_sync_powerdown_mode(st, this_attr->address);
+	ret = ad5064_sync_powerdown_mode(st, chan->channel);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
 
-static ssize_t ad5064_read_dac_powerdown(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5064_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	return sprintf(buf, "%d\n", st->pwr_down[this_attr->address]);
+	return sprintf(buf, "%d\n", st->pwr_down[chan->channel]);
 }
 
-static ssize_t ad5064_write_dac_powerdown(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5064_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	bool pwr_down;
 	int ret;
 
@@ -225,54 +182,13 @@ static ssize_t ad5064_write_dac_powerdown(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	st->pwr_down[this_attr->address] = pwr_down;
+	st->pwr_down[chan->channel] = pwr_down;
 
-	ret = ad5064_sync_powerdown_mode(st, this_attr->address);
+	ret = ad5064_sync_powerdown_mode(st, chan->channel);
 	mutex_unlock(&indio_dev->mlock);
 	return ret ? ret : len;
 }
 
-static IIO_CONST_ATTR(out_voltage_powerdown_mode_available,
-			"1kohm_to_gnd 100kohm_to_gnd three_state");
-
-#define IIO_DEV_ATTR_DAC_POWERDOWN_MODE(_chan) \
-	IIO_DEVICE_ATTR(out_voltage##_chan##_powerdown_mode, \
-			S_IRUGO | S_IWUSR, \
-			ad5064_read_powerdown_mode, \
-			ad5064_write_powerdown_mode, _chan);
-
-#define IIO_DEV_ATTR_DAC_POWERDOWN(_chan)				\
-	IIO_DEVICE_ATTR(out_voltage##_chan##_powerdown,			\
-			S_IRUGO | S_IWUSR,				\
-			ad5064_read_dac_powerdown,			\
-			ad5064_write_dac_powerdown, _chan)
-
-static IIO_DEV_ATTR_DAC_POWERDOWN(0);
-static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(0);
-static IIO_DEV_ATTR_DAC_POWERDOWN(1);
-static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(1);
-static IIO_DEV_ATTR_DAC_POWERDOWN(2);
-static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(2);
-static IIO_DEV_ATTR_DAC_POWERDOWN(3);
-static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(3);
-
-static struct attribute *ad5064_attributes[] = {
-	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_voltage1_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_voltage2_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_voltage3_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_voltage0_powerdown_mode.dev_attr.attr,
-	&iio_dev_attr_out_voltage1_powerdown_mode.dev_attr.attr,
-	&iio_dev_attr_out_voltage2_powerdown_mode.dev_attr.attr,
-	&iio_dev_attr_out_voltage3_powerdown_mode.dev_attr.attr,
-	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad5064_attribute_group = {
-	.attrs = ad5064_attributes,
-};
-
 static int ad5064_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -331,10 +247,70 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5064_info = {
 	.read_raw = ad5064_read_raw,
 	.write_raw = ad5064_write_raw,
-	.attrs = &ad5064_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
+static struct iio_chan_spec_ext_info ad5064_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5064_read_dac_powerdown,
+		.write = ad5064_write_dac_powerdown,
+	},
+	{
+		.name = "powerdown_mode",
+		.read = ad5064_read_powerdown_mode,
+		.write = ad5064_write_powerdown_mode,
+	},
+	{
+		.name = "powerdown_mode_available",
+		.shared = true,
+		.read = ad5064_read_powerdown_mode_available,
+	},
+	{ },
+};
+
+#define AD5064_CHANNEL(chan, bits) {				\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.output = 1,						\
+	.channel = (chan),					\
+	.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
+	.address = AD5064_ADDR_DAC(chan),			\
+	.scan_type = IIO_ST('u', (bits), 16, 20 - (bits)),	\
+	.ext_info = ad5064_ext_info,				\
+}
+
+static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
+	[ID_AD5024] = {
+		.shared_vref = false,
+		.channel[0] = AD5064_CHANNEL(0, 12),
+		.channel[1] = AD5064_CHANNEL(1, 12),
+		.channel[2] = AD5064_CHANNEL(2, 12),
+		.channel[3] = AD5064_CHANNEL(3, 12),
+	},
+	[ID_AD5044] = {
+		.shared_vref = false,
+		.channel[0] = AD5064_CHANNEL(0, 14),
+		.channel[1] = AD5064_CHANNEL(1, 14),
+		.channel[2] = AD5064_CHANNEL(2, 14),
+		.channel[3] = AD5064_CHANNEL(3, 14),
+	},
+	[ID_AD5064] = {
+		.shared_vref = false,
+		.channel[0] = AD5064_CHANNEL(0, 16),
+		.channel[1] = AD5064_CHANNEL(1, 16),
+		.channel[2] = AD5064_CHANNEL(2, 16),
+		.channel[3] = AD5064_CHANNEL(3, 16),
+	},
+	[ID_AD5064_1] = {
+		.shared_vref = true,
+		.channel[0] = AD5064_CHANNEL(0, 16),
+		.channel[1] = AD5064_CHANNEL(1, 16),
+		.channel[2] = AD5064_CHANNEL(2, 16),
+		.channel[3] = AD5064_CHANNEL(3, 16),
+	},
+};
+
 static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
 {
 	return st->chip_info->shared_vref ? 1 : AD5064_DAC_CHANNELS;
-- 
1.7.9

