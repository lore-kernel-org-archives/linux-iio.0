Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/3] IIO: DAC: AD5446: Add power down support
Date: Thu, 10 Mar 2011 12:52:45 +0100
Message-ID: <1299757966-25592-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1299757966-25592-1-git-send-email-michael.hennerich@analog.com>
References: <1299757966-25592-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/ad5446.c |  153 ++++++++++++++++++++++++++++++++++----
 drivers/staging/iio/dac/ad5446.h |   19 ++++-
 2 files changed, 153 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 4f1d881..861a7ea 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -48,6 +48,20 @@ static void ad5660_store_sample(struct ad5446_state *st, unsigned val)
 	st->data.d24[2] = val & 0xFF;
 }
 
+static void ad5620_store_pwr_down(struct ad5446_state *st, unsigned mode)
+{
+	st->data.d16 = cpu_to_be16(mode << 14);
+}
+
+static void ad5660_store_pwr_down(struct ad5446_state *st, unsigned mode)
+{
+	unsigned val = mode << 16;
+
+	st->data.d24[0] = (val >> 16) & 0xFF;
+	st->data.d24[1] = (val >> 8) & 0xFF;
+	st->data.d24[2] = val & 0xFF;
+}
+
 static ssize_t ad5446_write(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -68,6 +82,7 @@ static ssize_t ad5446_write(struct device *dev,
 	}
 
 	mutex_lock(&dev_info->mlock);
+	st->cached_val = val;
 	st->chip_info->store_sample(st, val);
 	ret = spi_sync(st->spi, &st->msg);
 	mutex_unlock(&dev_info->mlock);
@@ -102,15 +117,119 @@ static ssize_t ad5446_show_name(struct device *dev,
 }
 static IIO_DEVICE_ATTR(name, S_IRUGO, ad5446_show_name, NULL, 0);
 
+static ssize_t ad5446_write_powerdown_mode(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad5446_state *st = dev_info->dev_data;
+
+	if (sysfs_streq(buf, "1kohm_to_gnd"))
+		st->pwr_down_mode = MODE_PWRDWN_1k;
+	else if (sysfs_streq(buf, "100kohm_to_gnd"))
+		st->pwr_down_mode = MODE_PWRDWN_100k;
+	else if (sysfs_streq(buf, "three_state"))
+		st->pwr_down_mode = MODE_PWRDWN_TRISTATE;
+	else
+		return -EINVAL;
+
+	return len;
+}
+
+static ssize_t ad5446_read_powerdown_mode(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad5446_state *st = dev_info->dev_data;
+
+	char mode[][15] = {"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"};
+
+	return sprintf(buf, "%s\n", mode[st->pwr_down_mode]);
+}
+
+static ssize_t ad5446_read_dac_powerdown(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad5446_state *st = dev_info->dev_data;
+
+	return sprintf(buf, "%d\n", st->pwr_down);
+}
+
+static ssize_t ad5446_write_dac_powerdown(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad5446_state *st = dev_info->dev_data;
+	unsigned long readin;
+	int ret;
+
+	ret = strict_strtol(buf, 10, &readin);
+	if (ret)
+		return ret;
+
+	if (readin > 1)
+		ret = -EINVAL;
+
+	mutex_lock(&dev_info->mlock);
+	st->pwr_down = readin;
+
+	if (st->pwr_down)
+		st->chip_info->store_pwr_down(st, st->pwr_down_mode);
+	else
+		st->chip_info->store_sample(st, st->cached_val);
+
+	ret = spi_sync(st->spi, &st->msg);
+	mutex_unlock(&dev_info->mlock);
+
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(out_powerdown_mode, S_IRUGO | S_IWUSR,
+			ad5446_read_powerdown_mode,
+			ad5446_write_powerdown_mode, 0);
+
+static IIO_CONST_ATTR(out_powerdown_mode_available,
+			"1kohm_to_gnd 100kohm_to_gnd three_state");
+
+static IIO_DEVICE_ATTR(out0_powerdown, S_IRUGO | S_IWUSR,
+			ad5446_read_dac_powerdown,
+			ad5446_write_dac_powerdown, 0);
+
 static struct attribute *ad5446_attributes[] = {
 	&iio_dev_attr_out0_raw.dev_attr.attr,
 	&iio_dev_attr_out_scale.dev_attr.attr,
+	&iio_dev_attr_out0_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
+	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
 	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
+static mode_t ad5446_attr_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_dev_get_devdata(dev_info);
+
+	mode_t mode = attr->mode;
+
+	if (!st->chip_info->store_pwr_down &&
+		(attr == &iio_dev_attr_out0_powerdown.dev_attr.attr ||
+		attr == &iio_dev_attr_out_powerdown_mode.dev_attr.attr ||
+		attr ==
+		&iio_const_attr_out_powerdown_mode_available.dev_attr.attr))
+		mode = 0;
+
+	return mode;
+}
+
 static const struct attribute_group ad5446_attribute_group = {
 	.attrs = ad5446_attributes,
+	.is_visible = ad5446_attr_is_visible,
 };
 
 static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
@@ -156,6 +275,7 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.left_shift = 2,
 		.int_vref_mv = 2500,
 		.store_sample = ad5620_store_sample,
+		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5620_1250] = {
 		.bits = 12,
@@ -163,6 +283,7 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.left_shift = 2,
 		.int_vref_mv = 1250,
 		.store_sample = ad5620_store_sample,
+		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5640_2500] = {
 		.bits = 14,
@@ -170,6 +291,7 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.left_shift = 0,
 		.int_vref_mv = 2500,
 		.store_sample = ad5620_store_sample,
+		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5640_1250] = {
 		.bits = 14,
@@ -177,6 +299,7 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.left_shift = 0,
 		.int_vref_mv = 1250,
 		.store_sample = ad5620_store_sample,
+		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5660_2500] = {
 		.bits = 16,
@@ -184,6 +307,7 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.left_shift = 0,
 		.int_vref_mv = 2500,
 		.store_sample = ad5660_store_sample,
+		.store_pwr_down = ad5660_store_pwr_down,
 	},
 	[ID_AD5660_1250] = {
 		.bits = 16,
@@ -191,6 +315,7 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.left_shift = 0,
 		.int_vref_mv = 1250,
 		.store_sample = ad5660_store_sample,
+		.store_pwr_down = ad5660_store_pwr_down,
 	},
 };
 
@@ -243,20 +368,20 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->xfer, &st->msg);
 
 	switch (spi_get_device_id(spi)->driver_data) {
-		case ID_AD5620_2500:
-		case ID_AD5620_1250:
-		case ID_AD5640_2500:
-		case ID_AD5640_1250:
-		case ID_AD5660_2500:
-		case ID_AD5660_1250:
-			st->vref_mv = st->chip_info->int_vref_mv;
-			break;
-		default:
-			if (voltage_uv)
-				st->vref_mv = voltage_uv / 1000;
-			else
-				dev_warn(&spi->dev,
-					 "reference voltage unspecified\n");
+	case ID_AD5620_2500:
+	case ID_AD5620_1250:
+	case ID_AD5640_2500:
+	case ID_AD5640_1250:
+	case ID_AD5660_2500:
+	case ID_AD5660_1250:
+		st->vref_mv = st->chip_info->int_vref_mv;
+		break;
+	default:
+		if (voltage_uv)
+			st->vref_mv = voltage_uv / 1000;
+		else
+			dev_warn(&spi->dev,
+				 "reference voltage unspecified\n");
 	}
 
 	ret = iio_device_register(st->indio_dev);
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 0cb9c14..e9397a6 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -27,6 +27,10 @@
 
 #define RES_MASK(bits)	((1 << (bits)) - 1)
 
+#define MODE_PWRDWN_1k		0x1
+#define MODE_PWRDWN_100k	0x2
+#define MODE_PWRDWN_TRISTATE	0x3
+
 /**
  * struct ad5446_state - driver instance specific data
  * @indio_dev:		the industrial I/O device
@@ -47,6 +51,9 @@ struct ad5446_state {
 	struct regulator		*reg;
 	struct work_struct		poll_work;
 	unsigned short			vref_mv;
+	unsigned			cached_val;
+	unsigned			pwr_down_mode;
+	unsigned			pwr_down;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
 	union {
@@ -62,14 +69,16 @@ struct ad5446_state {
  * @left_shift:		number of bits the datum must be shifted
  * @int_vref_mv:	AD5620/40/60: the internal reference voltage
  * @store_sample:	chip specific helper function to store the datum
+ * @store_sample:	chip specific helper function to store the powerpown cmd
  */
 
 struct ad5446_chip_info {
-	u8				bits;
-	u8				storagebits;
-	u8				left_shift;
-	u16				int_vref_mv;
-	void (*store_sample)		(struct ad5446_state *st, unsigned val);
+	u8			bits;
+	u8			storagebits;
+	u8			left_shift;
+	u16			int_vref_mv;
+	void (*store_sample)	(struct ad5446_state *st, unsigned val);
+	void (*store_pwr_down)	(struct ad5446_state *st, unsigned mode);
 };
 
 /**
-- 
1.6.0.2
