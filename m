Return-Path: <amsfield22@gmail.com>
Date: Mon, 22 Aug 2016 20:25:32 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ltc2485: add support for Linear Technology LTC2485
 ADC
Message-ID: <20160823032521.GA27711@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Adds basic support for the LTC2485 ADC - a delta-sigma analog-to-digital
converter with an I2C interface that operates in single shot conversion
mode. 

The driver supports an on board 5V reference and the power-on default
configuration which rejects both 50hz & 60hz line frequencies and
operates in 1x speed mode.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---

Reviewers: In addition to commenting on what is present, please comment
on what is absent and the priority in which you would like to see
additional features added to this driver, or needed in this first submittal.

Not supported: 
1. External Vref
2. Additional Configuration Modes
        Temperature Sensor Mode: report temp data (not voltage).

        Line Frequency Rejection Mode: select to reject 50Hz or 60Hz
	or both. (both is default)

        Speed Mode: Default speed mode (1x) performs two conversions each
	cycle and combines the results.  2x speed mode only does one
	conversion each cycle.
3. Power management
4. DT Bindings
5. Triggered buffers
6. What else?


 drivers/iio/adc/Kconfig   |   9 +++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2485.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/iio/adc/ltc2485.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1de31bd..a042611 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -264,6 +264,15 @@ config LPC18XX_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called lpc18xx_adc.
 
+config LTC2485
+	tristate "Linear Technology LTC2485 ADC driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Linear Technology LTC2485 ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ltc2485.
+
 config MAX1027
 	tristate "Maxim max1027 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 0ba0d50..1be5747 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
+obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
diff --git a/drivers/iio/adc/ltc2485.c b/drivers/iio/adc/ltc2485.c
new file mode 100644
index 0000000..a62778b
--- /dev/null
+++ b/drivers/iio/adc/ltc2485.c
@@ -0,0 +1,150 @@
+/*
+ * ltc2485.c - Driver for Linear Technology LTC2485 ADC
+ *
+ * Copyright (C) 2016 Alison Schofield <amsfield22@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Datasheet: http://cds.linear.com/docs/en/datasheet/2485fd.pdf
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* Power-on configuration: rejects both 50/60Hz, operates at 1x speed */
+#define LTC2485_CONFIG_DEFAULT		0
+
+struct ltc2485_data {
+	struct i2c_client	*client;
+	s64			time_prev;	/* last conversion */
+};
+
+static void ltc2485_wait_conv(struct ltc2485_data *data)
+{
+	int conv_time = 147000000;		/* conv time ns */
+	s64 time_elapsed;
+
+	/* delay if conversion time not passed since last read or write */
+	time_elapsed = ktime_get_real_ns() - data->time_prev;
+
+	if (time_elapsed < conv_time) {
+		usleep_range((conv_time - time_elapsed) / 1000,
+			     conv_time / 1000);
+	}
+}
+
+static int ltc2485_read(struct ltc2485_data *data, int *val)
+{
+	struct i2c_client *client = data->client;
+	__be32 buf = 0;
+	int ret;
+
+	ltc2485_wait_conv(data);
+
+	ret = i2c_master_recv(client, (char *)&buf, 4);
+	if (ret < 0)  {
+		dev_err(&client->dev, "i2c_master_recv failed\n");
+		return ret;
+	}
+
+	data->time_prev = ktime_get_real_ns();
+	*val = sign_extend32(be32_to_cpu(buf) >> 6, 24);
+
+	return ret;
+}
+
+static int ltc2485_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ltc2485_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (mask == IIO_CHAN_INFO_RAW) {
+		ret = ltc2485_read(data, val);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	} else if (mask == IIO_CHAN_INFO_SCALE) {
+		*val = 5000;			/* on board vref millivolts */
+		*val2 = 25;			/* 25 (24 + sign) data bits */
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	} else {
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec ltc2485_channel[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)
+	},
+};
+
+static const struct iio_info ltc2485_info = {
+	.read_raw = ltc2485_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int ltc2485_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct ltc2485_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
+				     I2C_FUNC_SMBUS_WRITE_BYTE))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->info = &ltc2485_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ltc2485_channel;
+	indio_dev->num_channels = ARRAY_SIZE(ltc2485_channel);
+
+	ret = i2c_smbus_write_byte(data->client, LTC2485_CONFIG_DEFAULT);
+	if (ret < 0)
+		return ret;
+
+	data->time_prev = ktime_get_real_ns();
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id ltc2485_id[] = {
+	{ "ltc2485", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc2485_id);
+
+static struct i2c_driver ltc2485_driver = {
+	.driver = {
+		.name = "ltc2485",
+	},
+	.probe = ltc2485_probe,
+	.id_table = ltc2485_id,
+};
+module_i2c_driver(ltc2485_driver);
+
+MODULE_AUTHOR("Alison Schofield <amsfield22@gmail.com>");
+MODULE_DESCRIPTION("Linear Technology LTC2485 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
