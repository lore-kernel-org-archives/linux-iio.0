Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f73.google.com ([209.85.218.73]:40998 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaKFVZL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Nov 2014 16:25:11 -0500
Received: by mail-oi0-f73.google.com with SMTP id e131so280637oig.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2014 13:25:10 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
	knaack.h@gmx.de
Cc: linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 3/3] iio: ak8975: add ak09911 and ak09912 support
Date: Thu,  6 Nov 2014 13:25:07 -0800
Message-Id: <1415309107-7332-1-git-send-email-gwendal@chromium.org>
In-Reply-To: <1415286329.7340.16.camel@spandruv-hsb-test>
References: <1415286329.7340.16.camel@spandruv-hsb-test>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add 2 new definition entries to support ak0991x compass.
Add a more advanced function to check we are dealing with the
expected device.
Remove standalone driver for ak09911.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Readded CONFIG_AK09911 to ease transition from standalone driver.

 drivers/iio/magnetometer/Kconfig   |  15 +-
 drivers/iio/magnetometer/Makefile  |   1 -
 drivers/iio/magnetometer/ak09911.c | 326 -------------------------------------
 drivers/iio/magnetometer/ak8975.c  | 197 ++++++++++++++++++++--
 4 files changed, 186 insertions(+), 353 deletions(-)
 delete mode 100644 drivers/iio/magnetometer/ak09911.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index b2dba9e..4c7a4c5 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -6,26 +6,21 @@
 menu "Magnetometer sensors"
 
 config AK8975
-	tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
+	tristate "Asahi Kasei AK 3-Axis Magnetometer"
 	depends on I2C
 	depends on GPIOLIB
 	help
-	  Say yes here to build support for Asahi Kasei AK8975 3-Axis
-	  Magnetometer. This driver can also support AK8963, if i2c
-	  device name is identified as ak8963.
+	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
+	  AK09911 or AK09912 3-Axis Magnetometer.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called ak8975.
 
 config AK09911
 	tristate "Asahi Kasei AK09911 3-axis Compass"
-	depends on I2C
+	select AK8975
 	help
-	  Say yes here to build support for Asahi Kasei AK09911 3-Axis
-	  Magnetometer.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ak09911.
+	  Deprecated: AK09911 is now supported by AK8975 driver.
 
 config MAG3110
 	tristate "Freescale MAG3110 3-Axis Magnetometer"
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index b91315e..0f5d3c9 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -3,7 +3,6 @@
 #
 
 # When adding new entries keep the list in alphabetical order
-obj-$(CONFIG_AK09911)	+= ak09911.o
 obj-$(CONFIG_AK8975)	+= ak8975.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
diff --git a/drivers/iio/magnetometer/ak09911.c b/drivers/iio/magnetometer/ak09911.c
deleted file mode 100644
index b2bc942..0000000
--- a/drivers/iio/magnetometer/ak09911.c
+++ /dev/null
@@ -1,326 +0,0 @@
-/*
- * AK09911 3-axis compass driver
- * Copyright (c) 2014, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/acpi.h>
-#include <linux/iio/iio.h>
-
-#define AK09911_REG_WIA1		0x00
-#define AK09911_REG_WIA2		0x01
-#define AK09911_WIA1_VALUE		0x48
-#define AK09911_WIA2_VALUE		0x05
-
-#define AK09911_REG_ST1			0x10
-#define AK09911_REG_HXL			0x11
-#define AK09911_REG_HXH			0x12
-#define AK09911_REG_HYL			0x13
-#define AK09911_REG_HYH			0x14
-#define AK09911_REG_HZL			0x15
-#define AK09911_REG_HZH			0x16
-
-#define AK09911_REG_ASAX		0x60
-#define AK09911_REG_ASAY		0x61
-#define AK09911_REG_ASAZ		0x62
-
-#define AK09911_REG_CNTL1		0x30
-#define AK09911_REG_CNTL2		0x31
-#define AK09911_REG_CNTL3		0x32
-
-#define AK09911_MODE_SNG_MEASURE	0x01
-#define AK09911_MODE_SELF_TEST		0x10
-#define AK09911_MODE_FUSE_ACCESS	0x1F
-#define AK09911_MODE_POWERDOWN		0x00
-#define AK09911_RESET_DATA		0x01
-
-#define AK09911_REG_CNTL1		0x30
-#define AK09911_REG_CNTL2		0x31
-#define AK09911_REG_CNTL3		0x32
-
-#define AK09911_RAW_TO_GAUSS(asa)	((((asa) + 128) * 6000) / 256)
-
-#define AK09911_MAX_CONVERSION_TIMEOUT_MS	500
-#define AK09911_CONVERSION_DONE_POLL_TIME_MS	10
-
-struct ak09911_data {
-	struct i2c_client	*client;
-	struct mutex		lock;
-	u8			asa[3];
-	long			raw_to_gauss[3];
-};
-
-static const int ak09911_index_to_reg[] = {
-	AK09911_REG_HXL, AK09911_REG_HYL, AK09911_REG_HZL,
-};
-
-static int ak09911_set_mode(struct i2c_client *client, u8 mode)
-{
-	int ret;
-
-	switch (mode) {
-	case AK09911_MODE_SNG_MEASURE:
-	case AK09911_MODE_SELF_TEST:
-	case AK09911_MODE_FUSE_ACCESS:
-	case AK09911_MODE_POWERDOWN:
-		ret = i2c_smbus_write_byte_data(client,
-						AK09911_REG_CNTL2, mode);
-		if (ret < 0) {
-			dev_err(&client->dev, "set_mode error\n");
-			return ret;
-		}
-		/* After mode change wait atleast 100us */
-		usleep_range(100, 500);
-		break;
-	default:
-		dev_err(&client->dev,
-			"%s: Unknown mode(%d).", __func__, mode);
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* Get Sensitivity Adjustment value */
-static int ak09911_get_asa(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ak09911_data *data = iio_priv(indio_dev);
-	int ret;
-
-	ret = ak09911_set_mode(client, AK09911_MODE_FUSE_ACCESS);
-	if (ret < 0)
-		return ret;
-
-	/* Get asa data and store in the device data. */
-	ret = i2c_smbus_read_i2c_block_data(client, AK09911_REG_ASAX,
-					    3, data->asa);
-	if (ret < 0) {
-		dev_err(&client->dev, "Not able to read asa data\n");
-		return ret;
-	}
-
-	ret = ak09911_set_mode(client,  AK09911_MODE_POWERDOWN);
-	if (ret < 0)
-		return ret;
-
-	data->raw_to_gauss[0] = AK09911_RAW_TO_GAUSS(data->asa[0]);
-	data->raw_to_gauss[1] = AK09911_RAW_TO_GAUSS(data->asa[1]);
-	data->raw_to_gauss[2] = AK09911_RAW_TO_GAUSS(data->asa[2]);
-
-	return 0;
-}
-
-static int ak09911_verify_chip_id(struct i2c_client *client)
-{
-	u8 wia_val[2];
-	int ret;
-
-	ret = i2c_smbus_read_i2c_block_data(client, AK09911_REG_WIA1,
-					    2, wia_val);
-	if (ret < 0) {
-		dev_err(&client->dev, "Error reading WIA\n");
-		return ret;
-	}
-
-	dev_dbg(&client->dev, "WIA %02x %02x\n", wia_val[0], wia_val[1]);
-
-	if (wia_val[0] != AK09911_WIA1_VALUE ||
-		wia_val[1] != AK09911_WIA2_VALUE) {
-		dev_err(&client->dev, "Device ak09911 not found\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int wait_conversion_complete_polled(struct ak09911_data *data)
-{
-	struct i2c_client *client = data->client;
-	u8 read_status;
-	u32 timeout_ms = AK09911_MAX_CONVERSION_TIMEOUT_MS;
-	int ret;
-
-	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep_interruptible(AK09911_CONVERSION_DONE_POLL_TIME_MS);
-		ret = i2c_smbus_read_byte_data(client, AK09911_REG_ST1);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST1\n");
-			return ret;
-		}
-		read_status = ret & 0x01;
-		if (read_status)
-			break;
-		timeout_ms -= AK09911_CONVERSION_DONE_POLL_TIME_MS;
-	}
-	if (!timeout_ms) {
-		dev_err(&client->dev, "Conversion timeout happened\n");
-		return -EIO;
-	}
-
-	return read_status;
-}
-
-static int ak09911_read_axis(struct iio_dev *indio_dev, int index, int *val)
-{
-	struct ak09911_data *data = iio_priv(indio_dev);
-	struct i2c_client *client = data->client;
-	int ret;
-
-	mutex_lock(&data->lock);
-
-	ret = ak09911_set_mode(client, AK09911_MODE_SNG_MEASURE);
-	if (ret < 0)
-		goto fn_exit;
-
-	ret = wait_conversion_complete_polled(data);
-	if (ret < 0)
-		goto fn_exit;
-
-	/* Read data */
-	ret = i2c_smbus_read_word_data(client, ak09911_index_to_reg[index]);
-	if (ret < 0) {
-		dev_err(&client->dev, "Read axis data fails\n");
-		goto fn_exit;
-	}
-
-	mutex_unlock(&data->lock);
-
-	/* Clamp to valid range. */
-	*val = sign_extend32(clamp_t(s16, ret, -8192, 8191), 13);
-
-	return IIO_VAL_INT;
-
-fn_exit:
-	mutex_unlock(&data->lock);
-
-	return ret;
-}
-
-static int ak09911_read_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int *val, int *val2,
-			    long mask)
-{
-	struct ak09911_data *data = iio_priv(indio_dev);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		return ak09911_read_axis(indio_dev, chan->address, val);
-	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = data->raw_to_gauss[chan->address];
-		return IIO_VAL_INT_PLUS_MICRO;
-	}
-
-	return -EINVAL;
-}
-
-#define AK09911_CHANNEL(axis, index)					\
-	{								\
-		.type = IIO_MAGN,					\
-		.modified = 1,						\
-		.channel2 = IIO_MOD_##axis,				\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
-			     BIT(IIO_CHAN_INFO_SCALE),			\
-		.address = index,					\
-	}
-
-static const struct iio_chan_spec ak09911_channels[] = {
-	AK09911_CHANNEL(X, 0), AK09911_CHANNEL(Y, 1), AK09911_CHANNEL(Z, 2),
-};
-
-static const struct iio_info ak09911_info = {
-	.read_raw = &ak09911_read_raw,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct acpi_device_id ak_acpi_match[] = {
-	{"AK009911", 0},
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
-
-static int ak09911_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	struct iio_dev *indio_dev;
-	struct ak09911_data *data;
-	const char *name;
-	int ret;
-
-	ret = ak09911_verify_chip_id(client);
-	if (ret) {
-		dev_err(&client->dev, "AK00911 not detected\n");
-		return -ENODEV;
-	}
-
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (indio_dev == NULL)
-		return -ENOMEM;
-
-	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
-
-	data->client = client;
-	mutex_init(&data->lock);
-
-	ret = ak09911_get_asa(client);
-	if (ret)
-		return ret;
-
-	if (id)
-		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = dev_name(&client->dev);
-	else
-		return -ENODEV;
-
-	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
-
-	indio_dev->dev.parent = &client->dev;
-	indio_dev->channels = ak09911_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ak09911_channels);
-	indio_dev->info = &ak09911_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = name;
-
-	return devm_iio_device_register(&client->dev, indio_dev);
-}
-
-static const struct i2c_device_id ak09911_id[] = {
-	{"ak09911", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, ak09911_id);
-
-static struct i2c_driver ak09911_driver = {
-	.driver = {
-		.name	= "ak09911",
-		.acpi_match_table = ACPI_PTR(ak_acpi_match),
-	},
-	.probe		= ak09911_probe,
-	.id_table	= ak09911_id,
-};
-module_i2c_driver(ak09911_driver);
-
-MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("AK09911 Compass driver");
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b170654..f8c7046 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -81,6 +81,58 @@
 #define AK8975_MAX_REGS			AK8975_REG_ASAZ
 
 /*
+ * AK09912 Register definitions
+ */
+#define AK09912_REG_WIA1		0x00
+#define AK09912_REG_WIA2		0x01
+#define AK09912_DEVICE_ID		0x04
+#define AK09911_DEVICE_ID		0x05
+
+#define AK09911_REG_INFO1		0x02
+#define AK09911_REG_INFO2		0x03
+
+#define AK09912_REG_ST1			0x10
+
+#define AK09912_REG_ST1_DRDY_SHIFT	0
+#define AK09912_REG_ST1_DRDY_MASK	(1 << AK09912_REG_ST1_DRDY_SHIFT)
+
+#define AK09912_REG_HXL			0x11
+#define AK09912_REG_HXH			0x12
+#define AK09912_REG_HYL			0x13
+#define AK09912_REG_HYH			0x14
+#define AK09912_REG_HZL			0x15
+#define AK09912_REG_HZH			0x16
+#define AK09912_REG_TMPS		0x17
+
+#define AK09912_REG_ST2			0x18
+#define AK09912_REG_ST2_HOFL_SHIFT	3
+#define AK09912_REG_ST2_HOFL_MASK	(1 << AK09912_REG_ST2_HOFL_SHIFT)
+
+#define AK09912_REG_CNTL1		0x30
+
+#define AK09912_REG_CNTL2		0x31
+#define AK09912_REG_CNTL_MODE_POWER_DOWN	0x00
+#define AK09912_REG_CNTL_MODE_ONCE	0x01
+#define AK09912_REG_CNTL_MODE_SELF_TEST	0x10
+#define AK09912_REG_CNTL_MODE_FUSE_ROM	0x1F
+#define AK09912_REG_CNTL2_MODE_SHIFT	0
+#define AK09912_REG_CNTL2_MODE_MASK	(0x1F << AK09912_REG_CNTL2_MODE_SHIFT)
+
+#define AK09912_REG_CNTL3		0x32
+
+#define AK09912_REG_TS1			0x33
+#define AK09912_REG_TS2			0x34
+#define AK09912_REG_TS3			0x35
+#define AK09912_REG_I2CDIS		0x36
+#define AK09912_REG_TS4			0x37
+
+#define AK09912_REG_ASAX		0x60
+#define AK09912_REG_ASAY		0x61
+#define AK09912_REG_ASAZ		0x62
+
+#define AK09912_MAX_REGS		AK09912_REG_ASAZ
+
+/*
  * Miscellaneous values.
  */
 #define AK8975_MAX_CONVERSION_TIMEOUT	500
@@ -130,22 +182,37 @@ long ak8975_raw_to_gauss(u16 data)
 }
 
 /*
- * For AK8963, same calculation, but the device is less sensitive:
+ * For AK8963 and AK09911, same calculation, but the device is less sensitive:
  *
  * H is in the range of +-8190.  The magnetometer has a range of
  * +-4912uT.  To go from the raw value to uT is:
  *
  * HuT = H * 4912/8190, or roughly, 6/10, instead of 3/10.
  */
-long ak8963_raw_to_gauss(u16 data)
+long ak8963_09911_raw_to_gauss(u16 data)
 {
 	return (((long)data + 128) * 6000) / 256;
 }
 
+/*
+ * For AK09912, same calculation, except the device is more sensitive:
+ *
+ * H is in the range of -32752 to 32752.  The magnetometer has a range of
+ * +-4912uT.  To go from the raw value to uT is:
+ *
+ * HuT = H * 4912/32752, or roughly, 3/20, instead of 3/10.
+ */
+long ak09912_raw_to_gauss(u16 data)
+{
+	return (((long)data + 128) * 1500) / 256;
+}
+
 /* Compatible Asahi Kasei Compass parts */
 enum asahi_compass_chipset {
 	AK8975,
 	AK8963,
+	AK09911,
+	AK09912,
 	AK_MAX_TYPE
 };
 
@@ -210,7 +277,7 @@ struct ak_def {
 },
 {
 	.type = AK8963,
-	.raw_to_gauss = ak8963_raw_to_gauss,
+	.raw_to_gauss = ak8963_09911_raw_to_gauss,
 	.range = 8190,
 	.ctrl_regs = {
 		AK8975_REG_ST1,
@@ -233,6 +300,56 @@ struct ak_def {
 		AK8975_REG_HYL,
 		AK8975_REG_HZL},
 },
+{
+	.type = AK09911,
+	.raw_to_gauss = ak8963_09911_raw_to_gauss,
+	.range = 8192,
+	.ctrl_regs = {
+		AK09912_REG_ST1,
+		AK09912_REG_ST2,
+		AK09912_REG_CNTL2,
+		AK09912_REG_ASAX,
+		AK09912_MAX_REGS},
+	.ctrl_masks = {
+		AK09912_REG_ST1_DRDY_MASK,
+		AK09912_REG_ST2_HOFL_MASK,
+		0,
+		AK09912_REG_CNTL2_MODE_MASK},
+	.ctrl_modes = {
+		AK09912_REG_CNTL_MODE_POWER_DOWN,
+		AK09912_REG_CNTL_MODE_ONCE,
+		AK09912_REG_CNTL_MODE_SELF_TEST,
+		AK09912_REG_CNTL_MODE_FUSE_ROM},
+	.data_regs = {
+		AK09912_REG_HXL,
+		AK09912_REG_HYL,
+		AK09912_REG_HZL},
+},
+{
+	.type = AK09912,
+	.raw_to_gauss = ak09912_raw_to_gauss,
+	.range = 32752,
+	.ctrl_regs = {
+		AK09912_REG_ST1,
+		AK09912_REG_ST2,
+		AK09912_REG_CNTL2,
+		AK09912_REG_ASAX,
+		AK09912_MAX_REGS},
+	.ctrl_masks = {
+		AK09912_REG_ST1_DRDY_MASK,
+		AK09912_REG_ST2_HOFL_MASK,
+		0,
+		AK09912_REG_CNTL2_MODE_MASK},
+	.ctrl_modes = {
+		AK09912_REG_CNTL_MODE_POWER_DOWN,
+		AK09912_REG_CNTL_MODE_ONCE,
+		AK09912_REG_CNTL_MODE_SELF_TEST,
+		AK09912_REG_CNTL_MODE_FUSE_ROM},
+	.data_regs = {
+		AK09912_REG_HXL,
+		AK09912_REG_HYL,
+		AK09912_REG_HZL},
+}
 };
 
 /*
@@ -253,6 +370,55 @@ struct ak8975_data {
 };
 
 /*
+ * Return 0 if the i2c device is the one we expect.
+ * return a negative error number otherwise
+ */
+static int ak8975_who_i_am(struct i2c_client *client,
+			   enum asahi_compass_chipset type)
+{
+	u8 wia_val[2];
+	int ret;
+
+	/*
+	 * Signature for each device:
+	 * Device   |  WIA1      |  WIA2
+	 * AK09912  |  DEVICE_ID |  AK09912_DEVICE_ID
+	 * AK09911  |  DEVICE_ID |  AK09911_DEVICE_ID
+	 * AK8975   |  DEVICE_ID |  NA
+	 * AK8963   |  DEVICE_ID |  NA
+	 */
+	ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
+					    2, wia_val);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error reading WIA\n");
+		return ret;
+	}
+
+	ret = -ENODEV;
+
+	if (wia_val[0] != AK8975_DEVICE_ID)
+		return ret;
+
+	switch (type) {
+	case AK8975:
+	case AK8963:
+		ret = 0;
+		break;
+	case AK09911:
+		if (wia_val[1] == AK09911_DEVICE_ID)
+			ret = 0;
+		break;
+	case AK09912:
+		if (wia_val[1] == AK09912_DEVICE_ID)
+			ret = 0;
+		break;
+	default:
+		dev_err(&client->dev, "Type %d unknown\n", type);
+	}
+	return ret;
+}
+
+/*
  * Helper function to write to CNTL register.
  */
 static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
@@ -327,21 +493,8 @@ static int ak8975_setup(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ak8975_data *data = iio_priv(indio_dev);
-	u8 device_id;
 	int ret;
 
-	/* Confirm that the device we're talking to is really an AK8975. */
-	ret = i2c_smbus_read_byte_data(client, AK8975_REG_WIA);
-	if (ret < 0) {
-		dev_err(&client->dev, "Error reading WIA\n");
-		return ret;
-	}
-	device_id = ret;
-	if (device_id != AK8975_DEVICE_ID) {
-		dev_err(&client->dev, "Device ak8975 not found\n");
-		return -ENODEV;
-	}
-
 	/* Write the fused rom access mode. */
 	ret = ak8975_set_mode(data, FUSE_ROM);
 	if (ret < 0) {
@@ -552,6 +705,8 @@ static const struct acpi_device_id ak_acpi_match[] = {
 	{"AK8975", AK8975},
 	{"AK8963", AK8963},
 	{"INVN6500", AK8963},
+	{"AK09911", AK09911},
+	{"AK09912", AK09912},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
@@ -631,6 +786,10 @@ static int ak8975_probe(struct i2c_client *client,
 	}
 
 	data->def = &ak_def_array[chipset];
+	if (ak8975_who_i_am(client, data->def->type) < 0) {
+		dev_err(&client->dev, "Unexpected device\n");
+		return -ENODEV;
+	}
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
@@ -653,6 +812,8 @@ static int ak8975_probe(struct i2c_client *client,
 static const struct i2c_device_id ak8975_id[] = {
 	{"ak8975", AK8975},
 	{"ak8963", AK8963},
+	{"ak09911", AK09911},
+	{"ak09912", AK09912},
 	{}
 };
 
@@ -663,6 +824,10 @@ static const struct of_device_id ak8975_of_match[] = {
 	{ .compatible = "ak8975", },
 	{ .compatible = "asahi-kasei,ak8963", },
 	{ .compatible = "ak8963", },
+	{ .compatible = "asahi-kasei,ak09911", },
+	{ .compatible = "ak09911", },
+	{ .compatible = "asahi-kasei,ak09912", },
+	{ .compatible = "ak09912", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ak8975_of_match);
-- 
2.1.0.rc2.206.gedb03e5

