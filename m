Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:55026 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbbHBUoK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 16:44:10 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
Subject: [PATCH 6/7] iio:accel:mma8452: coding style cleanup
Date: Sun,  2 Aug 2015 22:43:51 +0200
Message-Id: <a8cc3a2ed5205834a00416a7279a81e1742bda9f.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some coding style cleanups, mainly indicated by checkpatch.pl, which
includes indentation changes, drop spaces after casts and befor tabs.
Also insert empty lines after logical blocks and before unconditional
returns.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma8452.c | 106 ++++++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 10e9623431e4..d29f0dd64f00 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -87,30 +87,34 @@ static int mma8452_drdy(struct mma8452_data *data)
 			return ret;
 		if ((ret & MMA8452_STATUS_DRDY) == MMA8452_STATUS_DRDY)
 			return 0;
+
 		msleep(20);
 	}
 
 	dev_err(&data->client->dev, "data not ready\n");
+
 	return -EIO;
 }
 
 static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 {
 	int ret = mma8452_drdy(data);
+
 	if (ret < 0)
 		return ret;
-	return i2c_smbus_read_i2c_block_data(data->client,
-		MMA8452_OUT_X, 3 * sizeof(__be16), (u8 *) buf);
+
+	return i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
+					     3 * sizeof(__be16), (u8 *)buf);
 }
 
-static ssize_t mma8452_show_int_plus_micros(char *buf,
-	const int (*vals)[2], int n)
+static ssize_t mma8452_show_int_plus_micros(char *buf, const int (*vals)[2],
+					    int n)
 {
 	size_t len = 0;
 
 	while (n-- > 0)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-			"%d.%06d ", vals[n][0], vals[n][1]);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
+				 vals[n][0], vals[n][1]);
 
 	/* replace trailing space by newline */
 	buf[len - 1] = '\n';
@@ -119,7 +123,7 @@ static ssize_t mma8452_show_int_plus_micros(char *buf,
 }
 
 static int mma8452_get_int_plus_micros_index(const int (*vals)[2], int n,
-					int val, int val2)
+					     int val, int val2)
 {
 	while (n-- > 0)
 		if (val == vals[n][0] && val2 == vals[n][1])
@@ -143,7 +147,7 @@ static const int mma8452_samp_freq[8][2] = {
  * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
  * The userspace interface uses m/s^2 and we declare micro units
  * So scale factor is given by:
- * 	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
+ *	g * N * 1000000 / 2048 for N = 2, 4, 8 and g = 9.80665
  */
 static const int mma8452_scales[3][2] = {
 	{0, 9577}, {0, 19154}, {0, 38307}
@@ -174,17 +178,19 @@ static const int mma8452_hp_filter_cutoff[8][4][2] = {
 };
 
 static ssize_t mma8452_show_samp_freq_avail(struct device *dev,
-				struct device_attribute *attr, char *buf)
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	return mma8452_show_int_plus_micros(buf, mma8452_samp_freq,
-		ARRAY_SIZE(mma8452_samp_freq));
+					    ARRAY_SIZE(mma8452_samp_freq));
 }
 
 static ssize_t mma8452_show_scale_avail(struct device *dev,
-				struct device_attribute *attr, char *buf)
+					struct device_attribute *attr,
+					char *buf)
 {
 	return mma8452_show_int_plus_micros(buf, mma8452_scales,
-		ARRAY_SIZE(mma8452_scales));
+					    ARRAY_SIZE(mma8452_scales));
 }
 
 static ssize_t mma8452_show_hp_cutoff_avail(struct device *dev,
@@ -201,22 +207,23 @@ static ssize_t mma8452_show_hp_cutoff_avail(struct device *dev,
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma8452_show_samp_freq_avail);
 static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
-	mma8452_show_scale_avail, NULL, 0);
+		       mma8452_show_scale_avail, NULL, 0);
 static IIO_DEVICE_ATTR(in_accel_filter_high_pass_3db_frequency_available,
-			S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
+		       S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
 
 static int mma8452_get_samp_freq_index(struct mma8452_data *data,
-	int val, int val2)
+				       int val, int val2)
 {
 	return mma8452_get_int_plus_micros_index(mma8452_samp_freq,
-		ARRAY_SIZE(mma8452_samp_freq), val, val2);
+						 ARRAY_SIZE(mma8452_samp_freq),
+						 val, val2);
 }
 
-static int mma8452_get_scale_index(struct mma8452_data *data,
-	int val, int val2)
+static int mma8452_get_scale_index(struct mma8452_data *data, int val, int val2)
 {
 	return mma8452_get_int_plus_micros_index(mma8452_scales,
-		ARRAY_SIZE(mma8452_scales), val, val2);
+						 ARRAY_SIZE(mma8452_scales),
+						 val, val2);
 }
 
 static int mma8452_get_hp_filter_index(struct mma8452_data *data,
@@ -262,25 +269,31 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
-		*val = sign_extend32(
-			be16_to_cpu(buffer[chan->scan_index]) >> 4, 11);
+
+		*val = sign_extend32(be16_to_cpu(buffer[chan->scan_index]) >> 4,
+				     11);
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
 		*val = mma8452_scales[i][0];
 		*val2 = mma8452_scales[i][1];
+
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		i = mma8452_get_odr_index(data);
 		*val = mma8452_samp_freq[i][0];
 		*val2 = mma8452_samp_freq[i][1];
+
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = i2c_smbus_read_byte_data(data->client, MMA8452_OFF_X +
-			chan->scan_index);
+		ret = i2c_smbus_read_byte_data(data->client,
+					      MMA8452_OFF_X + chan->scan_index);
 		if (ret < 0)
 			return ret;
+
 		*val = sign_extend32(ret, 7);
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
 		if (data->data_cfg & MMA8452_DATA_CFG_HPF_MASK) {
@@ -291,21 +304,23 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 			*val = 0;
 			*val2 = 0;
 		}
+
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
+
 	return -EINVAL;
 }
 
 static int mma8452_standby(struct mma8452_data *data)
 {
 	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
-		data->ctrl_reg1 & ~MMA8452_CTRL_ACTIVE);
+					data->ctrl_reg1 & ~MMA8452_CTRL_ACTIVE);
 }
 
 static int mma8452_active(struct mma8452_data *data)
 {
 	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
-		data->ctrl_reg1);
+					 data->ctrl_reg1);
 }
 
 static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
@@ -330,6 +345,7 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
 	ret = 0;
 fail:
 	mutex_unlock(&data->lock);
+
 	return ret;
 }
 
@@ -346,6 +362,7 @@ static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
 				       MMA8452_HP_FILTER_CUTOFF);
 	if (reg < 0)
 		return reg;
+
 	reg &= ~MMA8452_HP_FILTER_CUTOFF_SEL_MASK;
 	reg |= i;
 
@@ -370,21 +387,26 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 
 		data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
 		data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
+
 		return mma8452_change_config(data, MMA8452_CTRL_REG1,
-			data->ctrl_reg1);
+					     data->ctrl_reg1);
 	case IIO_CHAN_INFO_SCALE:
 		i = mma8452_get_scale_index(data, val, val2);
 		if (i < 0)
 			return i;
+
 		data->data_cfg &= ~MMA8452_DATA_CFG_FS_MASK;
 		data->data_cfg |= i;
+
 		return mma8452_change_config(data, MMA8452_DATA_CFG,
-			data->data_cfg);
+					     data->data_cfg);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		if (val < -128 || val > 127)
 			return -EINVAL;
-		return mma8452_change_config(data, MMA8452_OFF_X +
-			chan->scan_index, val);
+
+		return mma8452_change_config(data,
+					     MMA8452_OFF_X + chan->scan_index,
+					     val);
 
 	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
 		if (val == 0 && val2 == 0) {
@@ -395,8 +417,9 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 		}
+
 		return mma8452_change_config(data, MMA8452_DATA_CFG,
-						data->data_cfg);
+					     data->data_cfg);
 
 	default:
 		return -EINVAL;
@@ -421,6 +444,7 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
 			return ret;
 
 		*val = ret & MMA8452_TRANSIENT_THS_MASK;
+
 		return IIO_VAL_INT;
 
 	case IIO_EV_INFO_PERIOD:
@@ -433,6 +457,7 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
 				mma8452_get_odr_index(data)];
 		*val = us / USEC_PER_SEC;
 		*val2 = us % USEC_PER_SEC;
+
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
@@ -449,6 +474,7 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 		}
+
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	default:
@@ -483,6 +509,7 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 
 		return mma8452_change_config(data, MMA8452_TRANSIENT_COUNT,
 					     steps);
+
 	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
 		reg = i2c_smbus_read_byte_data(data->client,
 					       MMA8452_TRANSIENT_CFG);
@@ -497,6 +524,7 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 		}
+
 		return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, reg);
 
 	default:
@@ -606,15 +634,16 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
 	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
 	int ret;
 
-	ret = mma8452_read(data, (__be16 *) buffer);
+	ret = mma8452_read(data, (__be16 *)buffer);
 	if (ret < 0)
 		goto done;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-		iio_get_time_ns());
+					   iio_get_time_ns());
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
+
 	return IRQ_HANDLED;
 }
 
@@ -672,10 +701,10 @@ static struct attribute_group mma8452_event_attribute_group = {
 	.modified = 1, \
 	.channel2 = IIO_MOD_##axis, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-		BIT(IIO_CHAN_INFO_CALIBBIAS), \
+			      BIT(IIO_CHAN_INFO_CALIBBIAS), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
-		BIT(IIO_CHAN_INFO_SCALE) | \
-		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY), \
+			BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY), \
 	.scan_index = idx, \
 	.scan_type = { \
 		.sign = 's', \
@@ -778,6 +807,7 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	indio_dev->trig = trig;
+
 	return 0;
 }
 
@@ -847,7 +877,7 @@ static int mma8452_probe(struct i2c_client *client,
 
 	data->data_cfg = MMA8452_DATA_CFG_FS_2G;
 	ret = i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
-		data->data_cfg);
+					data->data_cfg);
 	if (ret < 0)
 		return ret;
 
@@ -889,14 +919,14 @@ static int mma8452_probe(struct i2c_client *client,
 	}
 
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
-		(MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
+			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
 					data->ctrl_reg1);
 	if (ret < 0)
 		goto trigger_cleanup;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		mma8452_trigger_handler, NULL);
+					 mma8452_trigger_handler, NULL);
 	if (ret < 0)
 		goto trigger_cleanup;
 
-- 
2.4.6

