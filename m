Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:51862 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860AbcCTPU2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Mar 2016 11:20:28 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 3/3] iio: Add Vishay VEML6070 UV A light sensor driver
Date: Sun, 20 Mar 2016 16:20:24 +0100
Message-Id: <1458487224-3872-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1458487224-3872-1-git-send-email-pmeerw@pmeerw.net>
References: <1458487224-3872-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ultraviolet (UV) light sensor with I2C interface with a peak
sensitivity at 355 nm

strangely, chip uses two addresses 0x38 and 0x39 for LSB and
MSB data, resp.

datasheet: http://www.vishay.com/docs/84277/veml6070.pdf

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/iio/light/Kconfig    |  10 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml6070.c | 218 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/iio/light/veml6070.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index cfd3df8..d2fe64e 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -320,4 +320,14 @@ config VCNL4000
 	 To compile this driver as a module, choose M here: the
 	 module will be called vcnl4000.
 
+config VEML6070
+	tristate "VEML6070 UV A light sensor"
+	depends on I2C
+	help
+	 Say Y here if you want to build a driver for the Vishay VEML6070 UV A
+	 light sensor.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called veml6070.
+
 endmenu
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index b2c3105..a447c62 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_TCS3472)		+= tcs3472.o
 obj-$(CONFIG_TSL4531)		+= tsl4531.o
 obj-$(CONFIG_US5182D)		+= us5182d.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
+obj-$(CONFIG_VEML6070)		+= veml6070.o
diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
new file mode 100644
index 0000000..bc1c4cb
--- /dev/null
+++ b/drivers/iio/light/veml6070.c
@@ -0,0 +1,218 @@
+/*
+ * veml6070.c - Support for Vishay VEML6070 UV A light sensor
+ *
+ * Copyright 2016 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * IIO driver for VEML6070 (7-bit I2C slave addresses 0x38 and 0x39)
+ *
+ * TODO: integration time, ACK signal
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define VEML6070_DRV_NAME "veml6070"
+
+#define VEML6070_ADDR_CONFIG_DATA_MSB 0x38 /* read: MSB data, write: config */
+#define VEML6070_ADDR_DATA_LSB	0x39 /* LSB data */
+
+#define VEML6070_COMMAND_ACK	BIT(5) /* raise interrupt when over threshold */
+#define VEML6070_COMMAND_IT	GENMASK(3, 2) /* bit mask integration time */
+#define VEML6070_COMMAND_RSRVD	BIT(1) /* reserved, set to 1 */
+#define VEML6070_COMMAND_SD	BIT(0) /* shutdown mode when set */
+
+#define VEML6070_IT_10	0x04 /* integration time 1x */
+
+struct veml6070_data {
+	struct i2c_client *client1;
+	struct i2c_client *client2;
+	u8 config;
+	struct mutex lock;
+};
+
+static int veml6070_read(struct veml6070_data *data)
+{
+	int ret;
+	u8 msb, lsb;
+
+	mutex_lock(&data->lock);
+
+	/* disable shutdown */
+	ret = i2c_smbus_write_byte(data->client1,
+	    data->config & ~VEML6070_COMMAND_SD);
+	if (ret < 0)
+		goto out;
+
+	msleep(125 + 10); /* measurement takes up to 125 ms for IT 1x */
+
+	ret = i2c_smbus_read_byte(data->client2); /* read MSB, address 0x39 */
+	if (ret < 0)
+		goto out;
+	msb = ret;
+
+	ret = i2c_smbus_read_byte(data->client1); /* read LSB, address 0x38 */
+	if (ret < 0)
+		goto out;
+	lsb = ret;
+
+	/* shutdown again */
+	ret = i2c_smbus_write_byte(data->client1, data->config);
+	if (ret < 0)
+		goto out;
+
+	ret = (msb << 8) | lsb;
+
+out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static const struct iio_chan_spec veml6070_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_UV,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		.type = IIO_UVINDEX,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	}
+};
+
+static int veml6070_to_uv_index(unsigned val)
+{
+	/*
+	 * conversion of raw UV intensity values to UV index depends on
+	 * integration time (IT) and value of the resistor connected to
+	 * the RSET pin (default: 270 KOhm)
+	 */
+	unsigned uvi[11] = {
+		187, 373, 560, /* low */
+		746, 933, 1120, /* moderate */
+		1308, 1494, /* high */
+		1681, 1868, 2054}; /* very high */
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(uvi); i++)
+		if (val <= uvi[i])
+			return i;
+
+	return 11; /* extreme */
+}
+
+static int veml6070_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct veml6070_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = veml6070_read(data);
+		if (ret < 0)
+			return ret;
+		if (mask == IIO_CHAN_INFO_PROCESSED)
+			*val = veml6070_to_uv_index(ret);
+		else
+			*val = ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info veml6070_info = {
+	.read_raw = veml6070_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int veml6070_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct veml6070_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client1 = client;
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &veml6070_info;
+	indio_dev->channels = veml6070_channels;
+	indio_dev->num_channels = ARRAY_SIZE(veml6070_channels);
+	indio_dev->name = VEML6070_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	data->client2 = i2c_new_dummy(client->adapter, VEML6070_ADDR_DATA_LSB);
+	if (!data->client2) {
+		dev_err(&client->dev, "i2c device for second chip address failed\n");
+		return -ENODEV;
+	}
+
+	data->config = VEML6070_IT_10 | VEML6070_COMMAND_RSRVD |
+		VEML6070_COMMAND_SD;
+	ret = i2c_smbus_write_byte(data->client1, data->config);
+	if (ret < 0)
+		goto fail;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto fail;
+
+	return ret;
+
+fail:
+	i2c_unregister_device(data->client2);
+	return ret;
+}
+
+static int veml6070_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct veml6070_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	i2c_unregister_device(data->client2);
+
+	return 0;
+}
+
+static const struct i2c_device_id veml6070_id[] = {
+	{ "veml6070", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml6070_id);
+
+static struct i2c_driver veml6070_driver = {
+	.driver = {
+		.name   = VEML6070_DRV_NAME,
+	},
+	.probe  = veml6070_probe,
+	.remove  = veml6070_remove,
+	.id_table = veml6070_id,
+};
+
+module_i2c_driver(veml6070_driver);
+
+MODULE_AUTHOR("Peter Meerwald-Stadler <pmeerw@pmeerw.net>");
+MODULE_DESCRIPTION("Vishay VEML6070 UV A light sensor driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1

