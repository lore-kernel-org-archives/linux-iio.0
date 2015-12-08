Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:34703 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933437AbbLHQW5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Dec 2015 11:22:57 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 813B520AE4
	for <linux-iio@vger.kernel.org>; Tue,  8 Dec 2015 17:22:55 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 2/2] iio: mma8452: add freefall detection for Freescale's accelerometers
Date: Tue,  8 Dec 2015 17:21:56 +0100
Message-Id: <1449591716-15231-2-git-send-email-martink@posteo.de>
In-Reply-To: <1449591716-15231-1-git-send-email-martink@posteo.de>
References: <1449591716-15231-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds freefall event detection to the supported devices. It adds
the in_accel_x&y&z_mag_falling_en iio event attribute, which activates
freefall mode.

In freefall mode, the current acceleration magnitude (AND combination
of all axis values) is compared to the specified threshold.
If it falls under the threshold (in_accel_mag_falling_value),
the appropriate IIO event code is generated.

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
-rw-r--r--    4096 Oct 23 08:45 in_accel_x_mag_rising_en
-rw-r--r--    4096 Oct 23 08:45 in_accel_y_mag_rising_en
-rw-r--r--    4096 Oct 23 08:45 in_accel_z_mag_rising_en

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
Other combinations (x&y, x&z or y&z) might be added later. This is the most
useful for freefall detection.


 drivers/iio/accel/mma8452.c | 156 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 137 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 162bbef..c8ac88c 100644
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
@@ -143,6 +143,14 @@ struct mma_chip_info {
 	u8 ev_count;
 };
 
+enum {
+	idx_x,
+	idx_y,
+	idx_z,
+	idx_ts,
+	idx_xyz,
+};
+
 static int mma8452_drdy(struct mma8452_data *data)
 {
 	int tries = 150;
@@ -409,6 +417,46 @@ fail:
 	return ret;
 }
 
+static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
+{
+	int val;
+	const struct mma_chip_info *chip = data->chip_info;
+
+	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
+	if (val < 0)
+		return val;
+
+	return !(val & MMA8452_FF_MT_CFG_OAE);
+}
+
+static int mma8452_set_freefall_mode(struct mma8452_data *data, u8 state)
+{
+	int val, ret;
+	const struct mma_chip_info *chip = data->chip_info;
+
+	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
+	if (val < 0)
+		return val;
+
+	if (state && !(mma8452_freefall_mode_enabled(data))) {
+		val |= BIT(idx_x + chip->ev_cfg_chan_shift);
+		val |= BIT(idx_y + chip->ev_cfg_chan_shift);
+		val |= BIT(idx_z + chip->ev_cfg_chan_shift);
+		val &= ~MMA8452_FF_MT_CFG_OAE;
+	} else if (!state && mma8452_freefall_mode_enabled(data)) {
+		val &= ~BIT(idx_x + chip->ev_cfg_chan_shift);
+		val &= ~BIT(idx_y + chip->ev_cfg_chan_shift);
+		val &= ~BIT(idx_z + chip->ev_cfg_chan_shift);
+		val |= MMA8452_FF_MT_CFG_OAE;
+	}
+
+	ret = mma8452_change_config(data, chip->ev_cfg, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
 					   int val, int val2)
 {
@@ -602,6 +650,11 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
 	const struct mma_chip_info *chip = data->chip_info;
 	int ret;
 
+	switch (chan->channel2) {
+	case IIO_MOD_X_AND_Y_AND_Z:
+		return mma8452_freefall_mode_enabled(data);
+	}
+
 	ret = i2c_smbus_read_byte_data(data->client,
 				       data->chip_info->ev_cfg);
 	if (ret < 0)
@@ -620,6 +673,11 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 	const struct mma_chip_info *chip = data->chip_info;
 	int val;
 
+	switch (chan->channel2) {
+	case IIO_MOD_X_AND_Y_AND_Z:
+		return mma8452_set_freefall_mode(data, state);
+	}
+
 	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
 	if (val < 0)
 		return val;
@@ -630,7 +688,6 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 		val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
 
 	val |= chip->ev_cfg_ele;
-	val |= MMA8452_FF_MT_CFG_OAE;
 
 	return mma8452_change_config(data, chip->ev_cfg, val);
 }
@@ -639,12 +696,26 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
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
@@ -738,6 +809,27 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static const struct iio_event_spec mma8452_freefall_event[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+					BIT(IIO_EV_INFO_PERIOD) |
+					BIT(IIO_EV_INFO_HIGH_PASS_FILTER_3DB)
+	},
+};
+
+static const struct iio_event_spec mma8652_freefall_event[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+					BIT(IIO_EV_INFO_PERIOD)
+	},
+};
+
 static const struct iio_event_spec mma8452_transient_event[] = {
 	{
 		.type = IIO_EV_TYPE_MAG,
@@ -774,6 +866,24 @@ static struct attribute_group mma8452_event_attribute_group = {
 	.attrs = mma8452_event_attributes,
 };
 
+#define MMA8452_FREEFALL_CHANNEL(modifier, idx) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = modifier, \
+	.scan_index = idx, \
+	.event_spec = mma8452_freefall_event, \
+	.num_event_specs = ARRAY_SIZE(mma8452_freefall_event), \
+}
+
+#define MMA8652_FREEFALL_CHANNEL(modifier, idx) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = modifier, \
+	.scan_index = idx, \
+	.event_spec = mma8652_freefall_event, \
+	.num_event_specs = ARRAY_SIZE(mma8652_freefall_event), \
+}
+
 #define MMA8452_CHANNEL(axis, idx, bits) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
@@ -816,31 +926,35 @@ static struct attribute_group mma8452_event_attribute_group = {
 }
 
 static const struct iio_chan_spec mma8452_channels[] = {
-	MMA8452_CHANNEL(X, 0, 12),
-	MMA8452_CHANNEL(Y, 1, 12),
-	MMA8452_CHANNEL(Z, 2, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MMA8452_CHANNEL(X, idx_x, 12),
+	MMA8452_CHANNEL(Y, idx_y, 12),
+	MMA8452_CHANNEL(Z, idx_z, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
+	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z, idx_xyz),
 };
 
 static const struct iio_chan_spec mma8453_channels[] = {
-	MMA8452_CHANNEL(X, 0, 10),
-	MMA8452_CHANNEL(Y, 1, 10),
-	MMA8452_CHANNEL(Z, 2, 10),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MMA8452_CHANNEL(X, idx_x, 10),
+	MMA8452_CHANNEL(Y, idx_y, 10),
+	MMA8452_CHANNEL(Z, idx_z, 10),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
+	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z, idx_xyz),
 };
 
 static const struct iio_chan_spec mma8652_channels[] = {
-	MMA8652_CHANNEL(X, 0, 12),
-	MMA8652_CHANNEL(Y, 1, 12),
-	MMA8652_CHANNEL(Z, 2, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MMA8652_CHANNEL(X, idx_x, 12),
+	MMA8652_CHANNEL(Y, idx_y, 12),
+	MMA8652_CHANNEL(Z, idx_z, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
+	MMA8652_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z, idx_xyz),
 };
 
 static const struct iio_chan_spec mma8653_channels[] = {
-	MMA8652_CHANNEL(X, 0, 10),
-	MMA8652_CHANNEL(Y, 1, 10),
-	MMA8652_CHANNEL(Z, 2, 10),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MMA8652_CHANNEL(X, idx_x, 10),
+	MMA8652_CHANNEL(Y, idx_y, 10),
+	MMA8652_CHANNEL(Z, idx_z, 10),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
+	MMA8652_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z, idx_xyz),
 };
 
 enum {
@@ -1183,6 +1297,10 @@ static int mma8452_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto buffer_cleanup;
 
+	ret = mma8452_set_freefall_mode(data, 0);
+	if (ret)
+		return ret;
+
 	return 0;
 
 buffer_cleanup:
-- 
2.1.4

