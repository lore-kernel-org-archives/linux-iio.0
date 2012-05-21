Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1150 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752862Ab2EULkN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 07:40:13 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/18] staging:iio:dac:ad5624r: Convert to extended channel attributes
Date: Mon, 21 May 2012 13:42:55 +0200
Message-Id: <1337600587-19848-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1337600587-19848-1-git-send-email-lars@metafoo.de>
References: <1337600587-19848-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use extended channel attributes instead of raw sysfs files for the additional
channel attributes. This allows us to remove some boilerplate code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5624r_spi.c |  208 ++++++++++++++-------------------
 1 file changed, 90 insertions(+), 118 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 42ff644..4c95eae 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -21,56 +21,6 @@
 #include "dac.h"
 #include "ad5624r.h"
 
-#define AD5624R_CHANNEL(_chan, _bits) { \
-	.type = IIO_VOLTAGE, \
-	.indexed = 1, \
-	.output = 1, \
-	.channel = (_chan), \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		     IIO_CHAN_INFO_SCALE_SHARED_BIT, \
-	.address = (_chan), \
-	.scan_type = IIO_ST('u', (_bits), 16, 16 - (_bits)), \
-}
-
-#define DECLARE_AD5624R_CHANNELS(_name, _bits) \
-	const struct iio_chan_spec _name##_channels[] = { \
-		AD5624R_CHANNEL(0, _bits), \
-		AD5624R_CHANNEL(1, _bits), \
-		AD5624R_CHANNEL(2, _bits), \
-		AD5624R_CHANNEL(3, _bits), \
-}
-
-static DECLARE_AD5624R_CHANNELS(ad5624r, 12);
-static DECLARE_AD5624R_CHANNELS(ad5644r, 14);
-static DECLARE_AD5624R_CHANNELS(ad5664r, 16);
-
-static const struct ad5624r_chip_info ad5624r_chip_info_tbl[] = {
-	[ID_AD5624R3] = {
-		.channels = ad5624r_channels,
-		.int_vref_mv = 1250,
-	},
-	[ID_AD5624R5] = {
-		.channels = ad5624r_channels,
-		.int_vref_mv = 2500,
-	},
-	[ID_AD5644R3] = {
-		.channels = ad5644r_channels,
-		.int_vref_mv = 1250,
-	},
-	[ID_AD5644R5] = {
-		.channels = ad5644r_channels,
-		.int_vref_mv = 2500,
-	},
-	[ID_AD5664R3] = {
-		.channels = ad5664r_channels,
-		.int_vref_mv = 1250,
-	},
-	[ID_AD5664R5] = {
-		.channels = ad5664r_channels,
-		.int_vref_mv = 2500,
-	},
-};
-
 static int ad5624r_spi_write(struct spi_device *spi,
 			     u8 cmd, u8 addr, u16 val, u8 len)
 {
@@ -138,67 +88,62 @@ static int ad5624r_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static ssize_t ad5624r_read_powerdown_mode(struct device *dev,
-				      struct device_attribute *attr, char *buf)
+static const char * const ad5624r_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"100kohm_to_gnd",
+	"three_state"
+};
+
+static int ad5624r_get_powerdown_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad5624r_state *st = iio_priv(indio_dev);
 
-	char mode[][15] = {"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"};
-
-	return sprintf(buf, "%s\n", mode[st->pwr_down_mode]);
+	return st->pwr_down_mode;
 }
 
-static ssize_t ad5624r_write_powerdown_mode(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t len)
+static int ad5624r_set_powerdown_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int mode)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad5624r_state *st = iio_priv(indio_dev);
-	int ret;
 
-	if (sysfs_streq(buf, "1kohm_to_gnd"))
-		st->pwr_down_mode = AD5624R_LDAC_PWRDN_1K;
-	else if (sysfs_streq(buf, "100kohm_to_gnd"))
-		st->pwr_down_mode = AD5624R_LDAC_PWRDN_100K;
-	else if (sysfs_streq(buf, "three_state"))
-		st->pwr_down_mode = AD5624R_LDAC_PWRDN_3STATE;
-	else
-		ret = -EINVAL;
+	st->pwr_down_mode = mode;
 
-	return ret ? ret : len;
+	return 0;
 }
 
-static ssize_t ad5624r_read_dac_powerdown(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static const struct iio_enum ad5624r_powerdown_mode_enum = {
+	.items = ad5624r_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad5624r_powerdown_modes),
+	.get = ad5624r_get_powerdown_mode,
+	.set = ad5624r_set_powerdown_mode,
+};
+
+static ssize_t ad5624r_read_dac_powerdown(struct iio_dev *indio_dev,
+	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad5624r_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	return sprintf(buf, "%d\n",
-			!!(st->pwr_down_mask & (1 << this_attr->address)));
+			!!(st->pwr_down_mask & (1 << chan->channel)));
 }
 
-static ssize_t ad5624r_write_dac_powerdown(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static ssize_t ad5624r_write_dac_powerdown(struct iio_dev *indio_dev,
+	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	size_t len)
 {
 	long readin;
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad5624r_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = strict_strtol(buf, 10, &readin);
 	if (ret)
 		return ret;
 
 	if (readin == 1)
-		st->pwr_down_mask |= (1 << this_attr->address);
+		st->pwr_down_mask |= (1 << chan->channel);
 	else if (!readin)
-		st->pwr_down_mask &= ~(1 << this_attr->address);
+		st->pwr_down_mask &= ~(1 << chan->channel);
 	else
 		ret = -EINVAL;
 
@@ -209,47 +154,74 @@ static ssize_t ad5624r_write_dac_powerdown(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out_voltage_powerdown_mode, S_IRUGO |
-			S_IWUSR, ad5624r_read_powerdown_mode,
-			ad5624r_write_powerdown_mode, 0);
-
-static IIO_CONST_ATTR(out_voltage_powerdown_mode_available,
-			"1kohm_to_gnd 100kohm_to_gnd three_state");
-
-#define IIO_DEV_ATTR_DAC_POWERDOWN(_num, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(out_voltage##_num##_powerdown,			\
-			S_IRUGO | S_IWUSR, _show, _store, _addr)
-
-static IIO_DEV_ATTR_DAC_POWERDOWN(0, ad5624r_read_dac_powerdown,
-				   ad5624r_write_dac_powerdown, 0);
-static IIO_DEV_ATTR_DAC_POWERDOWN(1, ad5624r_read_dac_powerdown,
-				   ad5624r_write_dac_powerdown, 1);
-static IIO_DEV_ATTR_DAC_POWERDOWN(2, ad5624r_read_dac_powerdown,
-				   ad5624r_write_dac_powerdown, 2);
-static IIO_DEV_ATTR_DAC_POWERDOWN(3, ad5624r_read_dac_powerdown,
-				   ad5624r_write_dac_powerdown, 3);
-
-static struct attribute *ad5624r_attributes[] = {
-	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_voltage1_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_voltage2_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_voltage3_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
-	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad5624r_attribute_group = {
-	.attrs = ad5624r_attributes,
-};
-
 static const struct iio_info ad5624r_info = {
 	.write_raw = ad5624r_write_raw,
 	.read_raw = ad5624r_read_raw,
-	.attrs = &ad5624r_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_chan_spec_ext_info ad5624r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5624r_read_dac_powerdown,
+		.write = ad5624r_write_dac_powerdown,
+	},
+	IIO_ENUM("powerdown_mode", true, &ad5624r_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5624r_powerdown_mode_enum),
+	{ },
+};
+
+#define AD5624R_CHANNEL(_chan, _bits) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = (_chan), \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+		     IIO_CHAN_INFO_SCALE_SHARED_BIT, \
+	.address = (_chan), \
+	.scan_type = IIO_ST('u', (_bits), 16, 16 - (_bits)), \
+	.ext_info = ad5624r_ext_info, \
+}
+
+#define DECLARE_AD5624R_CHANNELS(_name, _bits) \
+	const struct iio_chan_spec _name##_channels[] = { \
+		AD5624R_CHANNEL(0, _bits), \
+		AD5624R_CHANNEL(1, _bits), \
+		AD5624R_CHANNEL(2, _bits), \
+		AD5624R_CHANNEL(3, _bits), \
+}
+
+static DECLARE_AD5624R_CHANNELS(ad5624r, 12);
+static DECLARE_AD5624R_CHANNELS(ad5644r, 14);
+static DECLARE_AD5624R_CHANNELS(ad5664r, 16);
+
+static const struct ad5624r_chip_info ad5624r_chip_info_tbl[] = {
+	[ID_AD5624R3] = {
+		.channels = ad5624r_channels,
+		.int_vref_mv = 1250,
+	},
+	[ID_AD5624R5] = {
+		.channels = ad5624r_channels,
+		.int_vref_mv = 2500,
+	},
+	[ID_AD5644R3] = {
+		.channels = ad5644r_channels,
+		.int_vref_mv = 1250,
+	},
+	[ID_AD5644R5] = {
+		.channels = ad5644r_channels,
+		.int_vref_mv = 2500,
+	},
+	[ID_AD5664R3] = {
+		.channels = ad5664r_channels,
+		.int_vref_mv = 1250,
+	},
+	[ID_AD5664R5] = {
+		.channels = ad5664r_channels,
+		.int_vref_mv = 2500,
+	},
+};
+
 static int __devinit ad5624r_probe(struct spi_device *spi)
 {
 	struct ad5624r_state *st;
-- 
1.7.10

