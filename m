Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 1/3] iio: mma8452: add freefall detection for Freescale's accelerometers
Date: Wed, 11 Nov 2015 19:38:12 +0100
Message-Id: <1447267094-2248-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

This adds freefall event detection to the supported devices. It adds
the in_accel_x&y&z_mag_falling_en iio event attribute, which activates
freefall mode.

In freefall mode, the current acceleration values of all activated axis
are added and if the *sum* falls *under* the threshold specified
(in_accel_mag_falling_value), the appropriate IIO event code
is generated.

By enabling freefall mode (in_accel_x&y&z_mag_falling_en)
all 3 axis are enabled too as this describes a classic freefall
detection. Of course the user is free to disable one or more directions.

The values of rising and falling versions of various sysfs files are
shared, which is compliant to the IIO specification.

This is what the sysfs "events" directory for these devices looks
like after this change:

-rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_period
-rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_value
-rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_period
-rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_value
-r--r--r--    4096 Oct 23 08:45 in_accel_scale
-rw-r--r--    4096 Oct 23 08:45 in_accel_x&y&z_mag_falling_en
-rw-r--r--    4096 Oct 23 08:45 in_accel_x_mag_falling_en
-rw-r--r--    4096 Oct 23 08:45 in_accel_x_mag_rising_en
-rw-r--r--    4096 Oct 23 08:45 in_accel_y_mag_falling_en
-rw-r--r--    4096 Oct 23 08:45 in_accel_y_mag_rising_en
-rw-r--r--    4096 Oct 23 08:45 in_accel_z_mag_falling_en
-rw-r--r--    4096 Oct 23 08:45 in_accel_z_mag_rising_en

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 114 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 116a6e4..dedcc1d 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -15,7 +15,7 @@
  *
  * 7-bit I2C slave address 0x1c/0x1d (pin selectable)
  *
- * TODO: orientation / freefall events, autosleep
+ * TODO: orientation events, autosleep
  */
 
 #include <linux/module.h>
@@ -144,6 +144,12 @@ struct mma_chip_info {
 	u8 ev_count;
 };
 
+enum {
+	axis_x,
+	axis_y,
+	axis_z,
+};
+
 static int mma8452_drdy(struct mma8452_data *data)
 {
 	int tries = 150;
@@ -410,6 +416,74 @@ fail:
 	return ret;
 }
 
+static ssize_t mma8452_get_freefall_mode(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	int val;
+	struct mma8452_data *data = iio_priv(i2c_get_clientdata(
+					     to_i2c_client(dev)));
+	const struct mma_chip_info *chip = data->chip_info;
+
+	mutex_lock(&data->lock);
+	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
+	mutex_unlock(&data->lock);
+	if (val < 0)
+		return val;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 !(val & MMA8452_FF_MT_CFG_OAE));
+}
+
+static ssize_t mma8452_set_freefall_mode(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t len)
+{
+	int val, ret;
+	u8 user_val;
+	struct mma8452_data *data = iio_priv(i2c_get_clientdata(
+					     to_i2c_client(dev)));
+	const struct mma_chip_info *chip = data->chip_info;
+
+	ret = kstrtou8(buf, 10, &user_val);
+	if (ret)
+		goto err;
+
+	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
+	if (val < 0) {
+		ret = val;
+		goto err;
+	}
+
+	if (user_val && (val & MMA8452_FF_MT_CFG_OAE)) {
+		val |= BIT(axis_x + chip->ev_cfg_chan_shift);
+		val |= BIT(axis_y + chip->ev_cfg_chan_shift);
+		val |= BIT(axis_z + chip->ev_cfg_chan_shift);
+		val &= ~MMA8452_FF_MT_CFG_OAE;
+	} else if (!user_val && !(val & MMA8452_FF_MT_CFG_OAE)) {
+		val &= ~BIT(axis_x + chip->ev_cfg_chan_shift);
+		val &= ~BIT(axis_y + chip->ev_cfg_chan_shift);
+		val &= ~BIT(axis_z + chip->ev_cfg_chan_shift);
+		val |= MMA8452_FF_MT_CFG_OAE;
+	}
+
+	ret = mma8452_change_config(data, chip->ev_cfg, val);
+	if (ret)
+		goto err;
+
+	return len;
+err:
+	return ret;
+}
+
+static IIO_DEVICE_ATTR_NAMED(accel_xayaz_mag_falling_en,
+			     in_accel_x&y&z_mag_falling_en,
+			     S_IRUGO | S_IWUSR,
+			     mma8452_get_freefall_mode,
+			     mma8452_set_freefall_mode,
+			     0);
+
 static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
 					   int val, int val2)
 {
@@ -631,7 +705,6 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 		val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
 
 	val |= chip->ev_cfg_ele;
-	val |= MMA8452_FF_MT_CFG_OAE;
 
 	return mma8452_change_config(data, chip->ev_cfg, val);
 }
@@ -640,12 +713,26 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	s64 ts = iio_get_time_ns();
-	int src;
+	int src, cfg;
 
 	src = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_src);
 	if (src < 0)
 		return;
 
+	cfg = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_cfg);
+	if (cfg < 0)
+		return;
+
+	if (!(cfg & MMA8452_FF_MT_CFG_OAE)) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_AND_Y_AND_Z,
+						  IIO_EV_TYPE_MAG,
+						  IIO_EV_DIR_FALLING),
+			       ts);
+		return;
+	}
+
 	if (src & data->chip_info->ev_src_xe)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
@@ -758,6 +845,13 @@ static const struct iio_event_spec mma8452_motion_event[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
 					BIT(IIO_EV_INFO_PERIOD)
 	},
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+					BIT(IIO_EV_INFO_PERIOD)
+	},
 };
 
 /*
@@ -768,6 +862,7 @@ static IIO_CONST_ATTR_NAMED(accel_transient_scale, in_accel_scale, "0.617742");
 
 static struct attribute *mma8452_event_attributes[] = {
 	&iio_const_attr_accel_transient_scale.dev_attr.attr,
+	&iio_dev_attr_accel_xayaz_mag_falling_en.dev_attr.attr,
 	NULL,
 };
 
@@ -1057,6 +1152,7 @@ static int mma8452_probe(struct i2c_client *client,
 	struct mma8452_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
+	u8 val;
 	const struct of_device_id *match;
 
 	match = of_match_device(mma8452_dt_ids, &client->dev);
@@ -1158,6 +1254,18 @@ static int mma8452_probe(struct i2c_client *client,
 			return ret;
 	}
 
+	/* don't activate freefall mode on startup */
+	ret = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_cfg);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+	ret = i2c_smbus_write_byte_data(client,
+					data->chip_info->ev_cfg,
+					val | MMA8452_FF_MT_CFG_OAE);
+	if (ret < 0)
+		return ret;
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
-- 
2.1.4
