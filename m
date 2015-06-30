Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:56338 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbbF3L23 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 30 Jun 2015 07:28:29 -0400
From: Martin Kepplinger <martink@posteo.de>
To: pmeerw@pmeerw.net, jic23@kernel.org
Cc: christoph.muellner@theobroma-systems.com,
	martin.kepplinger@theobroma-systems.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/2] iio: mma8452: add support for 3 more accelerometer chips
Date: Tue, 30 Jun 2015 13:26:41 +0200
Message-Id: <1435663602-29868-2-git-send-email-martink@posteo.de>
In-Reply-To: <1435663602-29868-1-git-send-email-martink@posteo.de>
References: <1435663602-29868-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The one that supports the existing event interrupt settings, uses it. The
others use their motion detection interrupts.

This is tested on the MMA8653FC.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 .../devicetree/bindings/iio/accel/mma8452.txt      |  21 ++
 drivers/iio/accel/Kconfig                          |   6 +-
 drivers/iio/accel/mma8452.c                        | 328 +++++++++++++++++----
 3 files changed, 290 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
new file mode 100644
index 0000000..8d98e05
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
@@ -0,0 +1,21 @@
+Freescale MMA8452Q, MMA8453Q, MMA8652FC or MMA8653FC triaxial accelerometer
+
+Required properties:
+
+  - compatible: should be "fsl,mma8653", "fsl,mma8652", "fsl,mma8453" or
+    "fsl,mma8452" respectively.
+  - reg: the I2C address of the chip
+
+Optional properties:
+
+  - interrupt-parent: should be the phandle for the interrupt controller
+  - interrupts: interrupt mapping for GPIO IRQ
+
+Example:
+
+	mma8653fc@1d {
+		compatible = "fsl,mma8653";
+		reg = <0x1d>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <5 0>;
+	};
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 00e7bcb..684c8b5 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -87,13 +87,13 @@ config KXSD9
 	  will be called kxsd9.
 
 config MMA8452
-	tristate "Freescale MMA8452Q Accelerometer Driver"
+	tristate "Freescale MMA8452 Accelerometer Driver"
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say yes here to build support for the Freescale MMA8452Q 3-axis
-	  accelerometer.
+	  Say yes here to build support for the following Freescale 3-axis
+	  accelerometers: MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called mma8452.
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index e8e2077..a5fd3ff 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1,6 +1,12 @@
 /*
- * mma8452.c - Support for Freescale MMA8452Q 3-axis 12-bit accelerometer
+ * mma8452.c - Support for following Freescale 3-axis accelerometers:
  *
+ *	MMA8452Q
+ *	MMA8453Q
+ *	MMA8652FC
+ *	MMA8653FC
+ *
+ * Copyright 2015 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
  * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
  * This file is subject to the terms and conditions of version 2 of
@@ -23,9 +29,12 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/events.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
+
+#define DRIVER_NAME "mma8452"
 
 #define MMA8452_STATUS 0x00
-#define MMA8452_OUT_X 0x01 /* MSB first, 12-bit  */
+#define MMA8452_OUT_X 0x01 /* MSB first, 10 or 12-bit  */
 #define MMA8452_OUT_Y 0x03
 #define MMA8452_OUT_Z 0x05
 #define MMA8452_INT_SRC 0x0c
@@ -33,9 +42,18 @@
 #define MMA8452_DATA_CFG 0x0e
 #define MMA8452_HP_FILTER_CUTOFF 0x0f
 #define MMA8452_HP_FILTER_CUTOFF_SEL_MASK	(BIT(0) | BIT(1))
+#define MMA8452_FF_MT_CFG 0x15
+#define MMA8452_FF_MT_CFG_OAE			BIT(6)
+#define MMA8452_FF_MT_CFG_ELE			BIT(7)
+#define MMA8452_FF_MT_SRC 0x16
+#define MMA8452_FF_MT_SRC_XHE			BIT(1)
+#define MMA8452_FF_MT_SRC_YHE			BIT(3)
+#define MMA8452_FF_MT_SRC_ZHE			BIT(5)
+#define MMA8452_FF_MT_THS 0x17
+#define MMA8452_FF_MT_THS_MASK 0x7f
+#define MMA8452_FF_MT_COUNT 0x18
 #define MMA8452_TRANSIENT_CFG 0x1d
 #define MMA8452_TRANSIENT_CFG_ELE		BIT(4)
-#define MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
 #define MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
 #define MMA8452_TRANSIENT_SRC 0x1e
 #define MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
@@ -69,15 +87,38 @@
 #define MMA8452_DATA_CFG_HPF_MASK BIT(4)
 
 #define MMA8452_INT_DRDY	BIT(0)
+#define MMA8452_INT_FF_MT	BIT(2)
 #define MMA8452_INT_TRANS	BIT(5)
 
 #define MMA8452_DEVICE_ID 0x2a
+#define MMA8453_DEVICE_ID 0x3a
+#define MMA8652_DEVICE_ID 0x4a
+#define MMA8653_DEVICE_ID 0x5a
 
 struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	const struct mma_chip_info *chip_info;
+};
+
+struct mma_chip_info {
+	u8 chip_id;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	/* 3 modes: 2g, 4g, 8g; 2 ints: m/s^2 and micro m/s^2 */
+	const int mma_scales[3][2];
+	u8 ev_cfg;
+	u8 ev_cfg_ele;
+	u8 ev_cfg_chan_shift;
+	u8 ev_src;
+	u8 ev_src_xe;
+	u8 ev_src_ye;
+	u8 ev_src_ze;
+	u8 ev_ths;
+	u8 ev_ths_mask;
+	u8 ev_count;
 };
 
 static int mma8452_drdy(struct mma8452_data *data)
@@ -143,16 +184,6 @@ static const int mma8452_samp_freq[8][2] = {
 	{6, 250000}, {1, 560000}
 };
 
-/*
- * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
- * The userspace interface uses m/s^2 and we declare micro units
- * So scale factor is given by:
- * 	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
- */
-static const int mma8452_scales[3][2] = {
-	{0, 9577}, {0, 19154}, {0, 38307}
-};
-
 /* Datasheet table 35  (step time vs sample frequency) */
 static const int mma8452_transient_time_step_us[8] = {
 	1250,
@@ -187,8 +218,11 @@ static ssize_t mma8452_show_samp_freq_avail(struct device *dev,
 static ssize_t mma8452_show_scale_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return mma8452_show_int_plus_micros(buf, mma8452_scales,
-		ARRAY_SIZE(mma8452_scales));
+	struct mma8452_data *data = iio_priv(i2c_get_clientdata(
+					     to_i2c_client(dev)));
+
+	return mma8452_show_int_plus_micros(buf, data->chip_info->mma_scales,
+		ARRAY_SIZE(data->chip_info->mma_scales));
 }
 
 static ssize_t mma8452_show_hp_cutoff_avail(struct device *dev,
@@ -219,8 +253,8 @@ static int mma8452_get_samp_freq_index(struct mma8452_data *data,
 static int mma8452_get_scale_index(struct mma8452_data *data,
 	int val, int val2)
 {
-	return mma8452_get_int_plus_micros_index(mma8452_scales,
-		ARRAY_SIZE(mma8452_scales), val, val2);
+	return mma8452_get_int_plus_micros_index(data->chip_info->mma_scales,
+		ARRAY_SIZE(data->chip_info->mma_scales), val, val2);
 }
 
 static int mma8452_get_hp_filter_index(struct mma8452_data *data,
@@ -229,7 +263,7 @@ static int mma8452_get_hp_filter_index(struct mma8452_data *data,
 	int i = mma8452_get_odr_index(data);
 
 	return mma8452_get_int_plus_micros_index(mma8452_hp_filter_cutoff[i],
-		ARRAY_SIZE(mma8452_scales[0]), val, val2);
+		ARRAY_SIZE(data->chip_info->mma_scales[0]), val, val2);
 }
 
 static int mma8452_read_hp_filter(struct mma8452_data *data, int *hz, int *uHz)
@@ -266,13 +300,14 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
-		*val = sign_extend32(
-			be16_to_cpu(buffer[chan->scan_index]) >> 4, 11);
+		*val = sign_extend32(be16_to_cpu(
+			buffer[chan->scan_index]) >> chan->scan_type.shift,
+			chan->scan_type.realbits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
-		*val = mma8452_scales[i][0];
-		*val2 = mma8452_scales[i][1];
+		*val = data->chip_info->mma_scales[i][0];
+		*val2 = data->chip_info->mma_scales[i][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		i = mma8452_get_odr_index(data);
@@ -420,16 +455,16 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		ret = i2c_smbus_read_byte_data(data->client,
-					       MMA8452_TRANSIENT_THS);
+					       data->chip_info->ev_ths);
 		if (ret < 0)
 			return ret;
 
-		*val = ret & MMA8452_TRANSIENT_THS_MASK;
+		*val = ret & data->chip_info->ev_ths_mask;
 		return IIO_VAL_INT;
 
 	case IIO_EV_INFO_PERIOD:
 		ret = i2c_smbus_read_byte_data(data->client,
-					       MMA8452_TRANSIENT_COUNT);
+					       data->chip_info->ev_count);
 		if (ret < 0)
 			return ret;
 
@@ -472,8 +507,11 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		return mma8452_change_config(data, MMA8452_TRANSIENT_THS,
-					     val & MMA8452_TRANSIENT_THS_MASK);
+		if (val < 0 || val > 127) /* LSB 0.6178 m/s^2 */
+			return -EINVAL;
+
+		return mma8452_change_config(data, data->chip_info->ev_ths,
+					     val);
 
 	case IIO_EV_INFO_PERIOD:
 		steps = (val * USEC_PER_SEC + val2) /
@@ -483,8 +521,9 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 		if (steps > 0xff)
 			return -EINVAL;
 
-		return mma8452_change_config(data, MMA8452_TRANSIENT_COUNT,
+		return mma8452_change_config(data, data->chip_info->ev_count,
 					     steps);
+
 	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
 		reg = i2c_smbus_read_byte_data(data->client,
 					       MMA8452_TRANSIENT_CFG);
@@ -512,13 +551,15 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_direction dir)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
+	const struct mma_chip_info *chip = data->chip_info;
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_CFG);
+	ret = i2c_smbus_read_byte_data(data->client,
+				       data->chip_info->ev_cfg);
 	if (ret < 0)
 		return ret;
 
-	return ret & MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index) ? 1 : 0;
+	return ret & BIT(chan->scan_index + chip->ev_cfg_chan_shift) ? 1 : 0;
 }
 
 static int mma8452_write_event_config(struct iio_dev *indio_dev,
@@ -528,47 +569,53 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 				      int state)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
+	const struct mma_chip_info *chip = data->chip_info;
 	int val;
 
-	val = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_CFG);
+	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
 	if (val < 0)
 		return val;
 
 	if (state)
-		val |= MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
+		val |= BIT(chan->scan_index + chip->ev_cfg_chan_shift);
 	else
-		val &= ~MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
+		val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
 
-	val |= MMA8452_TRANSIENT_CFG_ELE;
+	val |= chip->ev_cfg_ele;
+	val |= MMA8452_FF_MT_CFG_OAE; /* motion mode */
 
-	return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, val);
+	return mma8452_change_config(data, chip->ev_cfg, val);
 }
 
 static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	s64 ts = iio_get_time_ns();
-	int src;
+	int src, ff;
 
-	src = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_SRC);
+	src = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_src);
 	if (src < 0)
 		return;
 
-	if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
+	ff = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_cfg);
+	if (ff < 0)
+		return;
+
+	if (src & data->chip_info->ev_src_xe)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_RISING),
 			       ts);
 
-	if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
+	if (src & data->chip_info->ev_src_ye)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_RISING),
 			       ts);
 
-	if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
+	if (src & data->chip_info->ev_src_ze)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
 						  IIO_EV_TYPE_THRESH,
@@ -580,6 +627,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
+	const struct mma_chip_info *chip = data->chip_info;
 	int ret = IRQ_NONE;
 	int src;
 
@@ -592,7 +640,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 		ret = IRQ_HANDLED;
 	}
 
-	if (src & MMA8452_INT_TRANS) {
+	if ((src & MMA8452_INT_TRANS &&
+	     chip->ev_src == MMA8452_TRANSIENT_SRC) ||
+	    (src & MMA8452_INT_FF_MT &&
+	     chip->ev_src == MMA8452_FF_MT_SRC)) {
 		mma8452_transient_interrupt(indio_dev);
 		ret = IRQ_HANDLED;
 	}
@@ -653,6 +704,16 @@ static const struct iio_event_spec mma8452_transient_event[] = {
 	},
 };
 
+static const struct iio_event_spec mma8452_motion_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+					BIT(IIO_EV_INFO_PERIOD)
+	},
+};
+
 /*
  * Threshold is configured in fixed 8G/127 steps regardless of
  * currently selected scale for measurement.
@@ -666,10 +727,9 @@ static struct attribute *mma8452_event_attributes[] = {
 
 static struct attribute_group mma8452_event_attribute_group = {
 	.attrs = mma8452_event_attributes,
-	.name = "events",
 };
 
-#define MMA8452_CHANNEL(axis, idx) { \
+#define MMA8452_CHANNEL(axis, idx, bits) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
 	.channel2 = IIO_MOD_##axis, \
@@ -681,22 +741,145 @@ static struct attribute_group mma8452_event_attribute_group = {
 	.scan_index = idx, \
 	.scan_type = { \
 		.sign = 's', \
-		.realbits = 12, \
+		.realbits = (bits), \
 		.storagebits = 16, \
-		.shift = 4, \
+		.shift = 16 - (bits), \
 		.endianness = IIO_BE, \
 	}, \
 	.event_spec = mma8452_transient_event, \
 	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
 }
 
+#define MMA8652_CHANNEL(axis, idx, bits) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_##axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_CALIBBIAS), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+		BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_index = idx, \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (bits), \
+		.storagebits = 16, \
+		.shift = 16 - (bits), \
+		.endianness = IIO_BE, \
+	}, \
+	.event_spec = mma8452_motion_event, \
+	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
+}
+
 static const struct iio_chan_spec mma8452_channels[] = {
-	MMA8452_CHANNEL(X, 0),
-	MMA8452_CHANNEL(Y, 1),
-	MMA8452_CHANNEL(Z, 2),
+	MMA8452_CHANNEL(X, 0, 12),
+	MMA8452_CHANNEL(Y, 1, 12),
+	MMA8452_CHANNEL(Z, 2, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec mma8453_channels[] = {
+	MMA8452_CHANNEL(X, 0, 10),
+	MMA8452_CHANNEL(Y, 1, 10),
+	MMA8452_CHANNEL(Z, 2, 10),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec mma8652_channels[] = {
+	MMA8652_CHANNEL(X, 0, 12),
+	MMA8652_CHANNEL(Y, 1, 12),
+	MMA8652_CHANNEL(Z, 2, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec mma8653_channels[] = {
+	MMA8652_CHANNEL(X, 0, 10),
+	MMA8652_CHANNEL(Y, 1, 10),
+	MMA8652_CHANNEL(Z, 2, 10),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+enum {
+	mma8452,
+	mma8453,
+	mma8652,
+	mma8653,
+};
+
+/*
+ * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
+ * for 12 bit or -512 for 10 bit.
+ * The userspace interface uses m/s^2 and we declare micro units
+ * So scale factor is given by:
+ *	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
+ */
+
+static const struct mma_chip_info mma_chip_info_table[] = {
+	[mma8452] = {
+		.chip_id = MMA8452_DEVICE_ID,
+		.channels = mma8452_channels,
+		.num_channels = ARRAY_SIZE(mma8452_channels),
+		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
+		.ev_cfg = MMA8452_TRANSIENT_CFG,
+		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
+		.ev_cfg_chan_shift = 1,
+		.ev_src = MMA8452_TRANSIENT_SRC,
+		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
+		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
+		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
+		.ev_ths = MMA8452_TRANSIENT_THS,
+		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
+		.ev_count = MMA8452_TRANSIENT_COUNT,
+	},
+	[mma8453] = {
+		.chip_id = MMA8453_DEVICE_ID,
+		.channels = mma8453_channels,
+		.num_channels = ARRAY_SIZE(mma8452_channels),
+		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
+		.ev_cfg = MMA8452_TRANSIENT_CFG,
+		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
+		.ev_cfg_chan_shift = 1,
+		.ev_src = MMA8452_TRANSIENT_SRC,
+		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
+		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
+		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
+		.ev_ths = MMA8452_TRANSIENT_THS,
+		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
+		.ev_count = MMA8452_TRANSIENT_COUNT,
+	},
+	[mma8652] = {
+		.chip_id = MMA8652_DEVICE_ID,
+		.channels = mma8652_channels,
+		.num_channels = ARRAY_SIZE(mma8452_channels),
+		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
+		.ev_cfg = MMA8452_FF_MT_CFG,
+		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
+		.ev_cfg_chan_shift = 3,
+		.ev_src = MMA8452_FF_MT_SRC,
+		.ev_src_xe = MMA8452_FF_MT_SRC_XHE,
+		.ev_src_ye = MMA8452_FF_MT_SRC_YHE,
+		.ev_src_ze = MMA8452_FF_MT_SRC_ZHE,
+		.ev_ths = MMA8452_FF_MT_THS,
+		.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
+		.ev_count = MMA8452_FF_MT_COUNT,
+	},
+	[mma8653] = {
+		.chip_id = MMA8653_DEVICE_ID,
+		.channels = mma8653_channels,
+		.num_channels = ARRAY_SIZE(mma8452_channels),
+		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
+		.ev_cfg = MMA8452_FF_MT_CFG,
+		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
+		.ev_cfg_chan_shift = 3,
+		.ev_src = MMA8452_FF_MT_SRC,
+		.ev_src_xe = MMA8452_FF_MT_SRC_XHE,
+		.ev_src_ye = MMA8452_FF_MT_SRC_YHE,
+		.ev_src_ze = MMA8452_FF_MT_SRC_ZHE,
+		.ev_ths = MMA8452_FF_MT_THS,
+		.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
+		.ev_count = MMA8452_FF_MT_COUNT,
+	},
+};
+
 static struct attribute *mma8452_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
@@ -813,19 +996,35 @@ static int mma8452_reset(struct i2c_client *client)
 	return -ETIMEDOUT;
 }
 
+static const struct of_device_id mma8452_dt_ids[] = {
+	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
+	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
+	{ .compatible = "fsl,mma8652", .data = &mma_chip_info_table[mma8652] },
+	{ .compatible = "fsl,mma8653", .data = &mma_chip_info_table[mma8653] },
+	{ }
+};
+
 static int mma8452_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct mma8452_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
+	const struct of_device_id *match;
 
 	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
 	if (ret < 0)
 		return ret;
-	if (ret != MMA8452_DEVICE_ID)
+	if (ret != MMA8452_DEVICE_ID && ret != MMA8453_DEVICE_ID &&
+	    ret != MMA8652_DEVICE_ID && ret != MMA8653_DEVICE_ID)
 		return -ENODEV;
 
+	match = of_match_device(mma8452_dt_ids, &client->dev);
+	if (!match) {
+		dev_err(&client->dev, "unknown device model\n");
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -834,13 +1033,17 @@ static int mma8452_probe(struct i2c_client *client,
 	data->client = client;
 	mutex_init(&data->lock);
 
+	data->chip_info = match->data;
+	dev_info(&client->dev, "registering %s accelerometer, ID 0x%x\n",
+		match->compatible, data->chip_info->chip_id);
+
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &mma8452_info;
-	indio_dev->name = id->name;
+	indio_dev->name = DRIVER_NAME;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = mma8452_channels;
-	indio_dev->num_channels = ARRAY_SIZE(mma8452_channels);
+	indio_dev->channels = data->chip_info->channels;
+	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->available_scan_masks = mma8452_scan_masks;
 
 	ret = mma8452_reset(client);
@@ -864,13 +1067,16 @@ static int mma8452_probe(struct i2c_client *client,
 
 	if (client->irq) {
 		/*
-		 * Although we enable the transient interrupt source once and
+		 * Although we enable the interrupt sources once and
 		 * for all here the transient event detection itself is not
 		 * enabled until userspace asks for it by
 		 * mma8452_write_event_config()
 		 */
-		int supported_interrupts = MMA8452_INT_DRDY | MMA8452_INT_TRANS;
-		int enabled_interrupts = MMA8452_INT_TRANS;
+		int supported_interrupts = MMA8452_INT_DRDY |
+					   MMA8452_INT_TRANS |
+					   MMA8452_INT_FF_MT;
+		int enabled_interrupts = MMA8452_INT_TRANS |
+					 MMA8452_INT_FF_MT;
 
 		/* Assume wired to INT1 pin */
 		ret = i2c_smbus_write_byte_data(client,
@@ -959,19 +1165,17 @@ static SIMPLE_DEV_PM_OPS(mma8452_pm_ops, mma8452_suspend, mma8452_resume);
 #endif
 
 static const struct i2c_device_id mma8452_id[] = {
-	{ "mma8452", 0 },
+	{ "mma8452", mma8452 },
+	{ "mma8453", mma8453 },
+	{ "mma8652", mma8652 },
+	{ "mma8653", mma8653 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mma8452_id);
 
-static const struct of_device_id mma8452_dt_ids[] = {
-	{ .compatible = "fsl,mma8452" },
-	{ }
-};
-
 static struct i2c_driver mma8452_driver = {
 	.driver = {
-		.name	= "mma8452",
+		.name	= DRIVER_NAME,
 		.of_match_table = of_match_ptr(mma8452_dt_ids),
 		.pm	= MMA8452_PM_OPS,
 	},
-- 
2.1.4

