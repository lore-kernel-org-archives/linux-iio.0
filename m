Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	daniel.baluta@gmail.com
Subject: [PATCH v7 1/2] iio: ltr501: Add support for ltr559 chip
Date: Tue, 14 Apr 2015 16:37:21 +0300
Message-Id: <1429018642-4838-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429018642-4838-1-git-send-email-daniel.baluta@intel.com>
References: <1429018642-4838-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This device is register compatible with LTR501, with a minor difference for
ALS control register as showed below:

ALS Control register for LTR501:

    7      6      5      4      3      2      1      0
+------+------+------+------+------+------+------+------+
|                           |      |      |             |
|        Reserved           | Gain |  SW  |    ALS Mode |
|                           |      | Reset|             |
+------+------+------+------+------+------+------+------+

ALS Control register for LTR559:

    7      6      5      4      3      2      1      0
+------+------+------+------+------+------+------+------+
|                    |                    |      |      |
|     Reserved       |        Gain        |  SW  | ALS  |
|                    |                    | Reset| Mode |
+------+------+------+------+------+------+------+------+

We handle this difference by introducing ltr501_chip_info.

Datasheet for LTR559 is at:
http://optoelectronics.liteon.com/upload/download/DS86-2013-0003/S_110_LTR-559ALS-01_DS_V1.pdf

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/light/Kconfig  |   3 +-
 drivers/iio/light/ltr501.c | 199 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 168 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 01a1a16..16a0ba1 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -169,7 +169,8 @@ config LTR501
 	select IIO_TRIGGERED_BUFFER
 	help
 	 If you say yes here you get support for the Lite-On LTR-501ALS-01
-	 ambient light and proximity sensor.
+	 ambient light and proximity sensor. This driver also supports LTR-559
+	 ALS/PS sensor.
 
 	 This driver can also be built as a module.  If so, the module
          will be called ltr501.
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index f208c98..55ccd5c 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -45,9 +45,63 @@
 
 #define LTR501_PS_DATA_MASK 0x7ff
 
+#define LTR501_RESERVED_GAIN -1
+
+enum {
+	ltr501 = 0,
+	ltr559,
+};
+
+struct ltr501_gain {
+	int scale;
+	int uscale;
+};
+
+static struct ltr501_gain ltr501_als_gain_tbl[] = {
+	{1, 0},
+	{0, 5000},
+};
+
+static struct ltr501_gain ltr559_als_gain_tbl[] = {
+	{1, 0},
+	{0, 500000},
+	{0, 250000},
+	{0, 125000},
+	{LTR501_RESERVED_GAIN, LTR501_RESERVED_GAIN},
+	{LTR501_RESERVED_GAIN, LTR501_RESERVED_GAIN},
+	{0, 20000},
+	{0, 10000},
+};
+
+static struct ltr501_gain ltr501_ps_gain_tbl[] = {
+	{1, 0},
+	{0, 250000},
+	{0, 125000},
+	{0, 62500},
+};
+
+static struct ltr501_gain ltr559_ps_gain_tbl[] = {
+	{0, 62500}, /* x16 gain */
+	{0, 31250}, /* x32 gain */
+	{0, 15625}, /* bits X1 are for x64 gain */
+	{0, 15624},
+};
+
+struct ltr501_chip_info {
+	u8 chip_id;
+	struct ltr501_gain *als_gain;
+	int als_gain_tbl_size;
+	struct ltr501_gain *ps_gain;
+	int ps_gain_tbl_size;
+	u8 als_mode_active;
+	u8 als_gain_mask;
+	u8 als_gain_shift;
+};
+
 struct ltr501_data {
 	struct i2c_client *client;
 	struct mutex lock_als, lock_ps;
+	struct ltr501_chip_info *chip_info;
 	u8 als_contr, ps_contr;
 };
 
@@ -125,10 +179,6 @@ static const struct iio_chan_spec ltr501_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-static const int ltr501_ps_gain[4][2] = {
-	{1, 0}, {0, 250000}, {0, 125000}, {0, 62500}
-};
-
 static int ltr501_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -166,20 +216,16 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_INTENSITY:
-			if (data->als_contr & LTR501_CONTR_ALS_GAIN_MASK) {
-				*val = 0;
-				*val2 = 5000;
-				return IIO_VAL_INT_PLUS_MICRO;
-			} else {
-				*val = 1;
-				*val2 = 0;
-				return IIO_VAL_INT;
-			}
+			i = (data->als_contr & data->chip_info->als_gain_mask)
+			     >> data->chip_info->als_gain_shift;
+			*val = data->chip_info->als_gain[i].scale;
+			*val2 = data->chip_info->als_gain[i].uscale;
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_PROXIMITY:
 			i = (data->ps_contr & LTR501_CONTR_PS_GAIN_MASK) >>
 				LTR501_CONTR_PS_GAIN_SHIFT;
-			*val = ltr501_ps_gain[i][0];
-			*val2 = ltr501_ps_gain[i][1];
+			*val = data->chip_info->ps_gain[i].scale;
+			*val2 = data->chip_info->ps_gain[i].uscale;
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
@@ -188,12 +234,13 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int ltr501_get_ps_gain_index(int val, int val2)
+static int ltr501_get_gain_index(struct ltr501_gain *gain, int size,
+				 int val, int val2)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ltr501_ps_gain); i++)
-		if (val == ltr501_ps_gain[i][0] && val2 == ltr501_ps_gain[i][1])
+	for (i = 0; i < size; i++)
+		if (val == gain[i].scale && val2 == gain[i].uscale)
 			return i;
 
 	return -1;
@@ -204,6 +251,7 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
+	struct ltr501_chip_info *info = data->chip_info;
 	int i;
 
 	if (iio_buffer_enabled(indio_dev))
@@ -213,17 +261,20 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_INTENSITY:
-			if (val == 0 && val2 == 5000)
-				data->als_contr |= LTR501_CONTR_ALS_GAIN_MASK;
-			else if (val == 1 && val2 == 0)
-				data->als_contr &= ~LTR501_CONTR_ALS_GAIN_MASK;
-			else
+			i = ltr501_get_gain_index(info->als_gain,
+						  info->als_gain_tbl_size,
+						  val, val2);
+			if (i < 0)
 				return -EINVAL;
+			data->als_contr &= ~info->als_gain_mask;
+			data->als_contr |= i << info->als_gain_shift;
 			return i2c_smbus_write_byte_data(data->client,
 							 LTR501_ALS_CONTR,
 							 data->als_contr);
 		case IIO_PROXIMITY:
-			i = ltr501_get_ps_gain_index(val, val2);
+			i = ltr501_get_gain_index(info->ps_gain,
+						  info->ps_gain_tbl_size,
+						  val, val2);
 			if (i < 0)
 				return -EINVAL;
 			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
@@ -238,12 +289,58 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static IIO_CONST_ATTR(in_proximity_scale_available, "1 0.25 0.125 0.0625");
-static IIO_CONST_ATTR(in_intensity_scale_available, "1 0.005");
+static ssize_t ltr501_show_proximity_scale_avail(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct ltr501_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct ltr501_chip_info *info = data->chip_info;
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < info->ps_gain_tbl_size; i++) {
+		if (info->ps_gain[i].scale == LTR501_RESERVED_GAIN)
+			continue;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
+				 info->ps_gain[i].scale,
+				 info->ps_gain[i].uscale);
+	}
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t ltr501_show_intensity_scale_avail(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct ltr501_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct ltr501_chip_info *info = data->chip_info;
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < info->als_gain_tbl_size; i++) {
+		if (info->als_gain[i].scale == LTR501_RESERVED_GAIN)
+			continue;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
+				 info->als_gain[i].scale,
+				 info->als_gain[i].uscale);
+	}
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(in_proximity_scale_available, S_IRUGO,
+		       ltr501_show_proximity_scale_avail, NULL, 0);
+static IIO_DEVICE_ATTR(in_intensity_scale_available, S_IRUGO,
+		       ltr501_show_intensity_scale_avail, NULL, 0);
 
 static struct attribute *ltr501_attributes[] = {
-	&iio_const_attr_in_proximity_scale_available.dev_attr.attr,
-	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
+	&iio_dev_attr_in_proximity_scale_available.dev_attr.attr,
+	&iio_dev_attr_in_intensity_scale_available.dev_attr.attr,
 	NULL
 };
 
@@ -258,6 +355,29 @@ static const struct iio_info ltr501_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static struct ltr501_chip_info ltr501_chip_info_tbl[] = {
+	[ltr501] = {
+		.chip_id = 0x08,
+		.als_gain = ltr501_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
+		.ps_gain = ltr501_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
+		.als_mode_active = BIT(0) | BIT(1),
+		.als_gain_mask = BIT(3),
+		.als_gain_shift = 3,
+	},
+	[ltr559] = {
+		.chip_id = 0x09,
+		.als_gain = ltr559_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+		.ps_gain = ltr559_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
+		.als_mode_active = BIT(1),
+		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+		.als_gain_shift = 2,
+	},
+};
+
 static int ltr501_write_contr(struct i2c_client *client, u8 als_val, u8 ps_val)
 {
 	int ret = i2c_smbus_write_byte_data(client, LTR501_ALS_CONTR, als_val);
@@ -326,7 +446,7 @@ static int ltr501_init(struct ltr501_data *data)
 	ret = i2c_smbus_read_byte_data(data->client, LTR501_ALS_CONTR);
 	if (ret < 0)
 		return ret;
-	data->als_contr = ret | LTR501_CONTR_ACTIVE;
+	data->als_contr = ret | data->chip_info->als_mode_active;
 
 	ret = i2c_smbus_read_byte_data(data->client, LTR501_PS_CONTR);
 	if (ret < 0)
@@ -340,7 +460,7 @@ static int ltr501_init(struct ltr501_data *data)
 static int ltr501_powerdown(struct ltr501_data *data)
 {
 	return ltr501_write_contr(data->client,
-				  data->als_contr & ~LTR501_CONTR_ACTIVE,
+				  data->als_contr & ~data->chip_info->als_mode_active,
 				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
 }
 
@@ -349,6 +469,8 @@ static int ltr501_probe(struct i2c_client *client,
 {
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
+	const char *name = NULL;
+	int chip_id;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -361,17 +483,27 @@ static int ltr501_probe(struct i2c_client *client,
 	mutex_init(&data->lock_als);
 	mutex_init(&data->lock_ps);
 
+	/* TODO: Add condition for ACPI */
+	if (id) {
+		name = id->name;
+		chip_id = id->driver_data;
+	} else  {
+		return -ENODEV;
+	}
+
+	data->chip_info = &ltr501_chip_info_tbl[chip_id];
+
 	ret = i2c_smbus_read_byte_data(data->client, LTR501_PART_ID);
 	if (ret < 0)
 		return ret;
-	if ((ret >> 4) != 0x8)
+	if ((ret >> 4) != data->chip_info->chip_id)
 		return -ENODEV;
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ltr501_info;
 	indio_dev->channels = ltr501_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ltr501_channels);
-	indio_dev->name = LTR501_DRV_NAME;
+	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ltr501_init(data);
@@ -428,7 +560,8 @@ static int ltr501_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct i2c_device_id ltr501_id[] = {
-	{ "ltr501", 0 },
+	{ "ltr501", ltr501},
+	{ "ltr559", ltr559},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
-- 
1.9.1
