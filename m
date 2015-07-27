Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:48362 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265AbbG0OJu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 10:09:50 -0400
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, roberta.dobrescu@gmail.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 4/8] iio: mma8452: add support for MMA8652FC and MMA8653FC accelerometers
Date: Mon, 27 Jul 2015 16:08:11 +0200
Message-Id: <1438006095-26920-5-git-send-email-martink@posteo.de>
In-Reply-To: <1438006095-26920-1-git-send-email-martink@posteo.de>
References: <1438006095-26920-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

MMA8652FC and MMA8653FC don't provide the transient interrupt source, so
the motion interrupt source is used by providing a new iio_chan_spec
definition, so that other supported devices are not affected by this.

Datasheets for the newly supported devices are available at Freescale's
website:

http://cache.freescale.com/files/sensors/doc/data_sheet/MMA8652FC.pdf
http://cache.freescale.com/files/sensors/doc/data_sheet/MMA8653FC.pdf

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/Kconfig   |  2 +-
 drivers/iio/accel/mma8452.c | 98 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 92 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index dc80dc9..fdb59e0 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -93,7 +93,7 @@ config MMA8452
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the following Freescale 3-axis
-	  accelerometers: MMA8452Q, MMA8453Q.
+	  accelerometers: MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called mma8452.
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index d51ce63..5a8c738 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -3,6 +3,8 @@
  *
  *	MMA8452Q
  *	MMA8453Q
+ *	MMA8652FC
+ *	MMA8653FC
  *
  * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
@@ -87,6 +89,8 @@
 
 #define MMA8452_DEVICE_ID 0x2a
 #define MMA8453_DEVICE_ID 0x3a
+#define MMA8652_DEVICE_ID 0x4a
+#define MMA8653_DEVICE_ID 0x5a
 
 struct mma8452_data {
 	struct i2c_client *client;
@@ -766,6 +770,26 @@ static struct attribute_group mma8452_event_attribute_group = {
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
 	MMA8452_CHANNEL(X, 0, 12),
 	MMA8452_CHANNEL(Y, 1, 12),
@@ -780,9 +804,25 @@ static const struct iio_chan_spec mma8453_channels[] = {
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
 enum {
 	mma8452,
 	mma8453,
+	mma8652,
+	mma8653,
 };
 
 static const struct mma_chip_info mma_chip_info_table[] = {
@@ -825,6 +865,38 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
 		.ev_count = MMA8452_TRANSIENT_COUNT,
 	},
+	[mma8652] = {
+		.chip_id = MMA8652_DEVICE_ID,
+		.channels = mma8652_channels,
+		.num_channels = ARRAY_SIZE(mma8652_channels),
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
+		.num_channels = ARRAY_SIZE(mma8653_channels),
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
 };
 
 static struct attribute *mma8452_attributes[] = {
@@ -946,6 +1018,8 @@ static int mma8452_reset(struct i2c_client *client)
 static const struct of_device_id mma8452_dt_ids[] = {
 	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
 	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
+	{ .compatible = "fsl,mma8652", .data = &mma_chip_info_table[mma8652] },
+	{ .compatible = "fsl,mma8653", .data = &mma_chip_info_table[mma8653] },
 	{ }
 };
 
@@ -957,13 +1031,6 @@ static int mma8452_probe(struct i2c_client *client,
 	int ret;
 	const struct of_device_id *match;
 
-	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
-	if (ret < 0)
-		return ret;
-
-	if (ret != MMA8452_DEVICE_ID && ret != MMA8453_DEVICE_ID)
-		return -ENODEV;
-
 	match = of_match_device(mma8452_dt_ids, &client->dev);
 	if (!match) {
 		dev_err(&client->dev, "unknown device model\n");
@@ -979,6 +1046,21 @@ static int mma8452_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 	data->chip_info = match->data;
 
+	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case MMA8452_DEVICE_ID:
+	case MMA8453_DEVICE_ID:
+	case MMA8652_DEVICE_ID:
+	case MMA8653_DEVICE_ID:
+		if (ret == data->chip_info->chip_id)
+			break;
+	default:
+		return -ENODEV;
+	}
+
 	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
 		 match->compatible, data->chip_info->chip_id);
 
@@ -1111,6 +1193,8 @@ static SIMPLE_DEV_PM_OPS(mma8452_pm_ops, mma8452_suspend, mma8452_resume);
 static const struct i2c_device_id mma8452_id[] = {
 	{ "mma8452", mma8452 },
 	{ "mma8453", mma8453 },
+	{ "mma8652", mma8652 },
+	{ "mma8653", mma8653 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mma8452_id);
-- 
2.1.4

