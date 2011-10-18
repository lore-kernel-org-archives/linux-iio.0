Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:13928 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973Ab1JRKzW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2011 06:55:22 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] staging:iio:dac:ad5446: Convert to channel spec
Date: Tue, 18 Oct 2011 12:54:49 +0200
Message-ID: <1318935292-28847-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.c |  182 +++++++++++++++++---------------------
 drivers/staging/iio/dac/ad5446.h |   10 +--
 2 files changed, 84 insertions(+), 108 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index e1c204d..1528516 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -26,19 +26,17 @@
 
 static void ad5446_store_sample(struct ad5446_state *st, unsigned val)
 {
-	st->data.d16 = cpu_to_be16(AD5446_LOAD |
-					(val << st->chip_info->left_shift));
+	st->data.d16 = cpu_to_be16(AD5446_LOAD | val);
 }
 
 static void ad5542_store_sample(struct ad5446_state *st, unsigned val)
 {
-	st->data.d16 = cpu_to_be16(val << st->chip_info->left_shift);
+	st->data.d16 = cpu_to_be16(val);
 }
 
 static void ad5620_store_sample(struct ad5446_state *st, unsigned val)
 {
-	st->data.d16 = cpu_to_be16(AD5620_LOAD |
-					(val << st->chip_info->left_shift));
+	st->data.d16 = cpu_to_be16(AD5620_LOAD | val);
 }
 
 static void ad5660_store_sample(struct ad5446_state *st, unsigned val)
@@ -63,50 +61,6 @@ static void ad5660_store_pwr_down(struct ad5446_state *st, unsigned mode)
 	st->data.d24[2] = val & 0xFF;
 }
 
-static ssize_t ad5446_write(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(indio_dev);
-	int ret;
-	long val;
-
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-
-	if (val > RES_MASK(st->chip_info->bits)) {
-		ret = -EINVAL;
-		goto error_ret;
-	}
-
-	mutex_lock(&indio_dev->mlock);
-	st->cached_val = val;
-	st->chip_info->store_sample(st, val);
-	ret = spi_sync(st->spi, &st->msg);
-	mutex_unlock(&indio_dev->mlock);
-
-error_ret:
-	return ret ? ret : len;
-}
-
-static IIO_DEV_ATTR_OUT_RAW(0, ad5446_write, 0);
-
-static ssize_t ad5446_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(indio_dev);
-	/* Corresponds to Vref / 2^(bits) */
-	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
-}
-static IIO_DEVICE_ATTR(out_voltage_scale, S_IRUGO, ad5446_show_scale, NULL, 0);
-
 static ssize_t ad5446_write_powerdown_mode(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
@@ -189,8 +143,6 @@ static IIO_DEVICE_ATTR(out_voltage0_powerdown, S_IRUGO | S_IWUSR,
 			ad5446_write_dac_powerdown, 0);
 
 static struct attribute *ad5446_attributes[] = {
-	&iio_dev_attr_out_voltage0_raw.dev_attr.attr,
-	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
 	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
@@ -223,121 +175,149 @@ static const struct attribute_group ad5446_attribute_group = {
 	.is_visible = ad5446_attr_is_visible,
 };
 
+#define AD5446_CHANNEL(bits, storage, shift) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = 0, \
+	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED), \
+	.address = 0, \
+	.scan_type = IIO_ST('u', (bits), (storage), (shift)) \
+}
+
 static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 	[ID_AD5444] = {
-		.bits = 12,
-		.storagebits = 16,
-		.left_shift = 2,
+		.channel = AD5446_CHANNEL(12, 16, 2),
 		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5446] = {
-		.bits = 14,
-		.storagebits = 16,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(14, 16, 0),
 		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5541A] = {
-		.bits = 16,
-		.storagebits = 16,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(16, 16, 0),
 		.store_sample = ad5542_store_sample,
 	},
 	[ID_AD5542A] = {
-		.bits = 16,
-		.storagebits = 16,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(16, 16, 0),
 		.store_sample = ad5542_store_sample,
 	},
 	[ID_AD5543] = {
-		.bits = 16,
-		.storagebits = 16,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(16, 16, 0),
 		.store_sample = ad5542_store_sample,
 	},
 	[ID_AD5512A] = {
-		.bits = 12,
-		.storagebits = 16,
-		.left_shift = 4,
+		.channel = AD5446_CHANNEL(12, 16, 4),
 		.store_sample = ad5542_store_sample,
 	},
 	[ID_AD5553] = {
-		.bits = 14,
-		.storagebits = 16,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(14, 16, 0),
 		.store_sample = ad5542_store_sample,
 	},
 	[ID_AD5601] = {
-		.bits = 8,
-		.storagebits = 16,
-		.left_shift = 6,
+		.channel = AD5446_CHANNEL(8, 16, 6),
 		.store_sample = ad5542_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5611] = {
-		.bits = 10,
-		.storagebits = 16,
-		.left_shift = 4,
+		.channel = AD5446_CHANNEL(10, 16, 4),
 		.store_sample = ad5542_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5621] = {
-		.bits = 12,
-		.storagebits = 16,
-		.left_shift = 2,
+		.channel = AD5446_CHANNEL(12, 16, 2),
 		.store_sample = ad5542_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5620_2500] = {
-		.bits = 12,
-		.storagebits = 16,
-		.left_shift = 2,
+		.channel = AD5446_CHANNEL(12, 16, 2),
 		.int_vref_mv = 2500,
 		.store_sample = ad5620_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5620_1250] = {
-		.bits = 12,
-		.storagebits = 16,
-		.left_shift = 2,
+		.channel = AD5446_CHANNEL(12, 16, 2),
 		.int_vref_mv = 1250,
 		.store_sample = ad5620_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5640_2500] = {
-		.bits = 14,
-		.storagebits = 16,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(14, 16, 0),
 		.int_vref_mv = 2500,
 		.store_sample = ad5620_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5640_1250] = {
-		.bits = 14,
-		.storagebits = 16,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(14, 16, 0),
 		.int_vref_mv = 1250,
 		.store_sample = ad5620_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5660_2500] = {
-		.bits = 16,
-		.storagebits = 24,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(16, 16, 0),
 		.int_vref_mv = 2500,
 		.store_sample = ad5660_store_sample,
 		.store_pwr_down = ad5660_store_pwr_down,
 	},
 	[ID_AD5660_1250] = {
-		.bits = 16,
-		.storagebits = 24,
-		.left_shift = 0,
+		.channel = AD5446_CHANNEL(16, 16, 0),
 		.int_vref_mv = 1250,
 		.store_sample = ad5660_store_sample,
 		.store_pwr_down = ad5660_store_pwr_down,
 	},
 };
 
+static int ad5446_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct ad5446_state *st = iio_priv(indio_dev);
+	unsigned long scale_uv;
+
+	switch (m) {
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
+		*val =  scale_uv / 1000;
+		*val2 = (scale_uv % 1000) * 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	}
+	return -EINVAL;
+}
+
+static int ad5446_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct ad5446_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case 0:
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
+			return -EINVAL;
+
+		val <<= chan->scan_type.shift;
+		mutex_lock(&indio_dev->mlock);
+		st->cached_val = val;
+		st->chip_info->store_sample(st, val);
+		ret = spi_sync(st->spi, &st->msg);
+		mutex_unlock(&indio_dev->mlock);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static const struct iio_info ad5446_info = {
+	.read_raw = ad5446_read_raw,
+	.write_raw = ad5446_write_raw,
 	.attrs = &ad5446_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -376,11 +356,13 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5446_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &st->chip_info->channel;
+	indio_dev->num_channels = 1;
 
 	/* Setup default message */
 
 	st->xfer.tx_buf = &st->data;
-	st->xfer.len = st->chip_info->storagebits / 8;
+	st->xfer.len = st->chip_info->channel.scan_type.storagebits / 8;
 
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 7118d65..4ea3476 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -25,8 +25,6 @@
 #define AD5660_PWRDWN_100k	(0x2 << 16) /* Power-down: 100kOhm to GND */
 #define AD5660_PWRDWN_TRISTATE	(0x3 << 16) /* Power-down: Three-state */
 
-#define RES_MASK(bits)	((1 << (bits)) - 1)
-
 #define MODE_PWRDWN_1k		0x1
 #define MODE_PWRDWN_100k	0x2
 #define MODE_PWRDWN_TRISTATE	0x3
@@ -62,18 +60,14 @@ struct ad5446_state {
 
 /**
  * struct ad5446_chip_info - chip specific information
- * @bits:		accuracy of the DAC in bits
- * @storagebits:	number of bits written to the DAC
- * @left_shift:		number of bits the datum must be shifted
+ * @channel:		channel spec for the DAC
  * @int_vref_mv:	AD5620/40/60: the internal reference voltage
  * @store_sample:	chip specific helper function to store the datum
  * @store_sample:	chip specific helper function to store the powerpown cmd
  */
 
 struct ad5446_chip_info {
-	u8			bits;
-	u8			storagebits;
-	u8			left_shift;
+	struct iio_chan_spec	channel;
 	u16			int_vref_mv;
 	void (*store_sample)	(struct ad5446_state *st, unsigned val);
 	void (*store_pwr_down)	(struct ad5446_state *st, unsigned mode);
-- 
1.7.6.3


