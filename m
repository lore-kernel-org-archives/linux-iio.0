Return-Path: <marc.andre@netline.ch>
From: Marc Andre <marc.andre@netline.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Marc Andre <marc.andre@netline.ch>
Subject: [PATCH] iio: Add support for LTC26xx I2C DAC
Date: Mon, 12 Oct 2015 10:52:57 +0200
Message-Id: <1444639977-42834-1-git-send-email-marc.andre@netline.ch>
List-ID: <linux-iio@vger.kernel.org>

This driver adds support for the Linear LTC26x6, LTC26x7 and LTC26x9 I2C
DAC chips. The driver exposes as iio device. It provides interface to all
channels of the DAC plus an additional channel (channel 15) which allows
writing to all channels simultanously.

The scale factor is calculated based on the reference voltage. The
reference voltage is set through a regulator in the device-tree.

Binding documentation is provided in ltc26xx.txt.

Signed-off-by: Marc Andre <marc.andre@netline.ch>
---
 .../devicetree/bindings/iio/dac/ltc26xx.txt        |  50 +++
 drivers/iio/dac/Kconfig                            |  12 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ltc26xx.c                          | 457 +++++++++++++++++++++
 4 files changed, 520 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc26xx.txt
 create mode 100644 drivers/iio/dac/ltc26xx.c

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc26xx.txt b/Documentation/devicetree/bindings/iio/dac/ltc26xx.txt
new file mode 100644
index 0000000..9b51aae
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ltc26xx.txt
@@ -0,0 +1,50 @@
+Driver for LTC2606, LTC2616, LTC2626, LTC2607, LTC2617, LTC2627,
+LTC2609, LTC2619 and LTC2629 DAC with I2C interface
+
+Required properties:
+- compatible: e.g. lltc,ltc2617
+- reg: i2c address
+
+Required parameters for ltc26x6 and ltc26x7:
+- vref-supply: Reference voltage supply
+
+Required parameters for ltc26x9:
+- vref_a-supply: Reference voltage supply channel A
+- vref_b-supply: Reference voltage supply channel B
+- vref_c-supply: Reference voltage supply channel C
+- vref_d-supply: Reference voltage supply channel D
+
+Available compatible strings. (defines the number of channels exposed)
+lltc,ltc2606
+lltc,ltc2616
+lltc,ltc2626
+lltc,ltc2607
+lltc,ltc2617
+lltc,ltc2627
+lltc,ltc2609
+lltc,ltc2619
+lltc,ltc2629
+
+The driver registers a iio_device. The number of iio channels registered is
+the number of channels available by the chip plus 1. The additional
+channel (channel 15) can be used to write to all output simultanously.
+The scale parameter of channel 15 is always 0.
+
+Example
+	i2c@7000c400 {
+		ltc2617: ltc2617@10 {
+			compatible = "lltc,ltc2617";
+			reg = <0x10>;
+			vref-supply = <&vdd_ltc_vref>;
+		};
+	};
+
+	regulators {
+		vdd_ltc_vref: regulator@100 {
+			compatible = "regulator-fixed";
+			reg = <100>;
+			regulator-name = "LTC26xx VREF";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+		};
+	};
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index e701e28..aa3e637 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -142,6 +142,18 @@ config AD7303
 	  To compile this driver as module choose M here: the module will be called
 	  ad7303.
 
+config LTC26xx
+	tristate "LTC26x6, LTC26x7 and LTC26x9 DAC driver"
+	depends on I2C
+	---help---
+	  Say Y here if you want to build a driver for the Linear
+	  LTC2606, LTC2616, LTC2626, LTC2607, LTC2617, LTC2627,
+	  LTC2609, LTC2619 or LTC2629 digital-to-analog converter (DAC)
+	  with I2C interface
+
+	  To compile this driver as a module chose M here: the module
+	  will be called ltc26xx
+
 config M62332
 	tristate "Mitsubishi M62332 DAC driver"
 	depends on I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 63ae056..74bc8cc 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_AD7303) += ad7303.o
+obj-$(CONFIG_LTC26xx) += ltc26xx.o
 obj-$(CONFIG_M62332) += m62332.o
 obj-$(CONFIG_MAX517) += max517.o
 obj-$(CONFIG_MAX5821) += max5821.o
diff --git a/drivers/iio/dac/ltc26xx.c b/drivers/iio/dac/ltc26xx.c
new file mode 100644
index 0000000..4f9b381
--- /dev/null
+++ b/drivers/iio/dac/ltc26xx.c
@@ -0,0 +1,457 @@
+/*
+ *  ltc26xx.c - Support for LTC26x6, LTC26x7 and LTC26x9 I2C DAC chips
+ *
+ *  Copyright (C) 2015 Marc Andre <marc.andre@netline.ch>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define LTC26xx_DRV_NAME	"ltc26xx"
+
+#define MAX_CHANNEL		4
+
+/* Commands to LTC26xx */
+#define COMMAND_WR		0x00 /* Write only */
+#define COMMAND_UP		0x01 /* Update only */
+#define COMMAND_WR_UP		0x03 /* Write & Update */
+#define COMMAND_PD		0x04 /* Power Down */
+
+static int ltc26xx_suspend(struct device *dev);
+static int ltc26xx_resume(struct device *dev);
+
+enum ltc26xx_device_ids {
+	ID_LTC2606,
+	ID_LTC2616,
+	ID_LTC2626,
+	ID_LTC2607,
+	ID_LTC2617,
+	ID_LTC2627,
+	ID_LTC2609,
+	ID_LTC2619,
+	ID_LTC2629
+};
+
+struct ltc26xx_data {
+	struct i2c_client	*client;
+	struct regulator	*reg_vref[MAX_CHANNEL];
+	int channels;
+};
+
+static long ltc26xx_get_scale_nv(struct ltc26xx_data *data,
+				 int channel)
+{
+	long long vref_nv;
+	long scale_nv;
+
+	/* The generic channel 15 always returns 0 scale */
+	if (channel > MAX_CHANNEL)
+		return 0;
+
+	if (data->reg_vref[channel]) {
+		vref_nv = regulator_get_voltage(data->reg_vref[channel]);
+	} else {
+		/* no regulator for the channel. This means we have a single
+		 * reference supply.
+		 */
+		vref_nv = regulator_get_voltage(data->reg_vref[0]);
+	}
+	vref_nv *= 1000;
+
+	/* Corresponds to Vref / 2^(bits) */
+	scale_nv = vref_nv >> 16;
+
+	return scale_nv;
+}
+
+/*
+ * channel: channel no or 0xf for all channels
+ * command: Command to LTC26xx
+ */
+static int ltc26xx_set_value(struct iio_dev *indio_dev,
+			     long val, int channel, int command)
+{
+	struct ltc26xx_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u8 outbuf[3];
+	int res;
+
+	if (val < 0 || val >= 65536)
+		return -EINVAL;
+
+	outbuf[0] = (channel & 0xf) | ((command & 0x0f) << 4);
+	outbuf[1] = (val >> 8) & 0xff;
+	outbuf[2] = (val & 0xff);
+
+	res = i2c_master_send(client, outbuf, 3);
+	if (res < 0)
+		return res;
+	else if (res != 3)
+		return -EIO;
+	else
+		return 0;
+}
+
+static int ltc26xx_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long m)
+{
+	struct ltc26xx_data *data = iio_priv(indio_dev);
+	unsigned long scale_nv;
+	int channel = chan->channel;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		scale_nv = ltc26xx_get_scale_nv(data, channel);
+		*val =  scale_nv / 1000000000;
+		*val2 = scale_nv % 1000000000;
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static int ltc26xx_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ltc26xx_set_value(indio_dev, val, chan->channel,
+					COMMAND_WR_UP);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ltc26xx_suspend(struct device *dev)
+{
+	u8 outbuf[3];
+	int ret;
+	int i;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev =
+		(struct iio_dev *)i2c_get_clientdata(client);
+	struct ltc26xx_data *data = iio_priv(indio_dev);
+
+	outbuf[0] = (COMMAND_PD << 4) | 0xf; /* Suspend all channels */
+	outbuf[1] = 0;
+	outbuf[2] = 0;
+
+	/* Send DAC into suspend */
+	ret = i2c_master_send(client, outbuf, 3);
+	if (ret != 3) {
+		dev_err(dev, "Error sending suspend i2c command: %d", ret);
+		goto exit;
+	}
+	ret = 0;
+
+	/* Disable vref regulators */
+	for (i = 0; i < MAX_CHANNEL; i++) {
+		if (data->reg_vref[i]) {
+			ret = regulator_disable(data->reg_vref[i]);
+			if (ret) {
+				dev_err(dev,
+					"Error disabling regulator %d: %d",
+					i, ret);
+				goto exit;
+			}
+		}
+	}
+
+exit:
+	return ret;
+}
+
+static int ltc26xx_resume(struct device *dev)
+{
+	u8 outbuf[3];
+	int ret;
+	int i;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev =
+		(struct iio_dev *)i2c_get_clientdata(client);
+	struct ltc26xx_data *data = iio_priv(indio_dev);
+
+	/* Enable all vref regulators */
+	for (i = 0; i < MAX_CHANNEL; i++) {
+		if (data->reg_vref[i]) {
+			ret = regulator_enable(data->reg_vref[i]);
+			if (ret) {
+				dev_err(dev,
+					"Error enabling regulator %d: %d",
+					i, ret);
+				goto exit;
+			}
+		}
+	}
+
+	/* Resume DAC */
+	outbuf[0] = (COMMAND_UP << 4) | 0xf; /* Resume all channels */
+	outbuf[1] = 0;
+	outbuf[2] = 0;
+
+	ret = i2c_master_send(to_i2c_client(dev), outbuf, 3);
+	if (ret != 3) {
+		dev_err(dev, "Error sending resume i2c command: %d", ret);
+		goto exit;
+	}
+	ret = 0;
+
+exit:
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(ltc26xx_pm_ops, ltc26xx_suspend, ltc26xx_resume);
+#define LTC26xx_PM_OPS (&ltc26xx_pm_ops)
+#else
+#define LTC26xx_PM_OPS NULL
+#endif
+
+static const struct iio_info ltc26xx_info = {
+	.read_raw = ltc26xx_read_raw,
+	.write_raw = ltc26xx_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+#define LTC26xx_CHANNEL(chan) {				\
+	.type = IIO_VOLTAGE,				\
+	.indexed = 1,					\
+	.output = 1,					\
+	.channel = (chan),				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+	BIT(IIO_CHAN_INFO_SCALE),			\
+}
+
+static const struct iio_chan_spec ltc26xx_channels[] = {
+	LTC26xx_CHANNEL(15), /* All channels simultanously */
+	LTC26xx_CHANNEL(0),
+	LTC26xx_CHANNEL(1),
+	LTC26xx_CHANNEL(2),
+	LTC26xx_CHANNEL(3),
+};
+
+static int ltc26xx_get_regulators(struct i2c_client *client)
+{
+	int err = 0;
+	int i;
+	struct regulator *reg;
+	struct iio_dev *indio_dev =
+		(struct iio_dev *)i2c_get_clientdata(client);
+	struct ltc26xx_data *data = iio_priv(indio_dev);
+
+	for (i = 0; i < MAX_CHANNEL; i++)
+		data->reg_vref[i] = 0;
+
+	/* LTC26x6 and LTCx7 have only one reference voltage */
+	if (data->channels == 1 || data->channels == 2) {
+		reg = devm_regulator_get(&client->dev, "vref");
+		if (IS_ERR(reg)) {
+			dev_err(&client->dev,
+				"Can't get regulator vref: %ld\n",
+				PTR_ERR(reg));
+			err = PTR_ERR(reg);
+			goto exit_cleanup;
+		}
+
+		err = regulator_enable(reg);
+		if (err < 0) {
+			dev_err(&client->dev,
+				"Error enabling regulator vref: %d\n",
+				err);
+			goto exit_cleanup;
+		}
+
+		dev_info(&client->dev,
+			 "Using voltage reference %duV",
+			 regulator_get_voltage(reg));
+
+		data->reg_vref[0] = reg;
+	}
+	/* LTC26x9 have 4 separate reference voltages */
+	else {
+		for (i = 0; i < 4; i++) {
+			char *name = "vref_a";
+
+			name[5] = i + 'a';
+			reg = devm_regulator_get(&client->dev, name);
+			if (IS_ERR(reg)) {
+				dev_err(&client->dev,
+					"Can't get regulator %s: %ld\n",
+					name,
+					PTR_ERR(reg));
+				err = PTR_ERR(reg);
+				goto exit_cleanup;
+			}
+
+			err = regulator_enable(reg);
+			if (err < 0) {
+				dev_err(&client->dev,
+					"Error enabling regulator %s: %d\n",
+					name,
+					err);
+				goto exit_cleanup;
+			}
+
+			dev_info(&client->dev,
+				 "Using voltage reference for %s: %duV",
+				 name,
+				regulator_get_voltage(reg));
+
+			data->reg_vref[i] = reg;
+		}
+	}
+
+	return 0;
+
+exit_cleanup:
+	for (i = 0; i < MAX_CHANNEL; i++) {
+		if (data->reg_vref[i]) {
+			regulator_disable(data->reg_vref[i]);
+			devm_regulator_put(data->reg_vref[i]);
+		}
+	}
+	return err;
+}
+
+static int ltc26xx_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct ltc26xx_data *data;
+	struct iio_dev *indio_dev;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*data));
+	if (!indio_dev) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	/* establish that the iio_dev is a child of the i2c device */
+	indio_dev->dev.parent = &client->dev;
+
+	/* Define channel count based on DAC type */
+	if (id->driver_data == ID_LTC2606 ||
+	    id->driver_data == ID_LTC2616 ||
+	    id->driver_data == ID_LTC2626) {
+		indio_dev->num_channels = 2;
+		data->channels = 1;
+	} else if (id->driver_data == ID_LTC2607 ||
+		   id->driver_data == ID_LTC2617 ||
+		   id->driver_data == ID_LTC2627) {
+		indio_dev->num_channels = 3;
+		data->channels = 2;
+	} else {
+		indio_dev->num_channels = 5;
+		data->channels = 4;
+	}
+	indio_dev->channels = ltc26xx_channels;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ltc26xx_info;
+
+	err = ltc26xx_get_regulators(client);
+	if (err) {
+		dev_err(&client->dev,
+			"Failed to initialized vref: %d. Aborting.",
+			err);
+		goto exit_free_device;
+	}
+
+	err = iio_device_register(indio_dev);
+	if (err) {
+		dev_err(&client->dev,
+			"Failed to register iio device: %d. Aborting.",
+			err);
+		goto exit_free_device;
+	}
+
+	dev_info(&client->dev, "LTC26xx DAC registered\n");
+
+	return 0;
+
+exit_free_device:
+	iio_device_free(indio_dev);
+exit:
+	return err;
+}
+
+static int ltc26xx_remove(struct i2c_client *client)
+{
+	iio_device_unregister(i2c_get_clientdata(client));
+	iio_device_free(i2c_get_clientdata(client));
+
+	dev_dbg(&client->dev, "LTC26xx DAC unregistered\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id ltc26xx_id[] = {
+	{ "ltc2606", ID_LTC2606 },
+	{ "ltc2616", ID_LTC2616 },
+	{ "ltc2626", ID_LTC2626 },
+	{ "ltc2607", ID_LTC2607 },
+	{ "ltc2617", ID_LTC2617 },
+	{ "ltc2627", ID_LTC2627 },
+	{ "ltc2609", ID_LTC2609 },
+	{ "ltc2619", ID_LTC2619 },
+	{ "ltc2629", ID_LTC2629 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc26xx_id);
+
+static const struct of_device_id ltc26xx_dt_ids[] = {
+	{ .compatible = "lltc,ltc2606", .data = (void *)&ltc26xx_id[0] },
+	{ .compatible = "lltc,ltc2616", .data = (void *)&ltc26xx_id[1] },
+	{ .compatible = "lltc,ltc2626", .data = (void *)&ltc26xx_id[2] },
+	{ .compatible = "lltc,ltc2607", .data = (void *)&ltc26xx_id[3] },
+	{ .compatible = "lltc,ltc2617", .data = (void *)&ltc26xx_id[4] },
+	{ .compatible = "lltc,ltc2627", .data = (void *)&ltc26xx_id[5] },
+	{ .compatible = "lltc,ltc2609", .data = (void *)&ltc26xx_id[6] },
+	{ .compatible = "lltc,ltc2619", .data = (void *)&ltc26xx_id[7] },
+	{ .compatible = "lltc,ltc2629", .data = (void *)&ltc26xx_id[8] },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltc26xx_dt_ids);
+
+static struct i2c_driver ltc26xx_driver = {
+	.driver = {
+		.name	= LTC26xx_DRV_NAME,
+		.pm	= LTC26xx_PM_OPS,
+		.of_match_table = of_match_ptr(ltc26xx_dt_ids),
+	},
+	.probe		= ltc26xx_probe,
+	.remove		= ltc26xx_remove,
+	.id_table	= ltc26xx_id,
+};
+module_i2c_driver(ltc26xx_driver);
+
+MODULE_AUTHOR("Marc Andre <marc.andre@netline.ch>");
+MODULE_DESCRIPTION("LTC26x6, LTC26x7 and LTC26x9 DAC driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
