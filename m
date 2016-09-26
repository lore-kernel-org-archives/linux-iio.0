Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cache8.mydevil.net ([85.194.246.96]:35325 "EHLO s8.mydevil.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030192AbcIZRXS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Sep 2016 13:23:18 -0400
From: Marcin Malagowski <mrc@bourne.st>
To: linux-iio@vger.kernel.org
Cc: Marcin Malagowski <mrc@bourne.st>
Subject: [PATCH v2] iio: pressure: Add driver for Honeywell ABP family
Date: Mon, 26 Sep 2016 19:23:06 +0200
Message-Id: <1474910586-20632-1-git-send-email-mrc@bourne.st>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds minimal driver for the Honeywell Amplified Basic
Pressure sensors series. Sensors are pretty simple but are
available in many variants:
- psi/mbar/kPa output,
- analog/i2c/spi,
- gage/differential measurement,
- different measure ranges etc.

Refer to datasheets for more details:
http://sensing.honeywell.com/honeywell-sensing-basic-board-mount-pressure-sensors-abp-series-datasheet-323005128-c-en.pdf
http://sensing.honeywell.com/index.php%3Fci_id%3D45841

Driver internals:
- i2c only. measure request is done by the SMBUS QUICK cmd, so if the i2c
  bus doesn't support it, it is required to send a dummy byte to trigger
  measurement,
- since iio sysfs expects kilopascals, mbar-variants are treated as their
  respective kPa-s, hence i2c id-table has doubled entries in one line:
	{ "abp060mg", ABP006KG }, { "abp006kg", ABP006KG },
- psi-variants have prescaled values in config,
- no temperature reads yet.

Work remained:
- optional temperature channel,
- SPI support,
- DT binding.

Changes since v1:
- mutex is now locked in read_raw(),
- corrected error codes,
- fixed coding style issues,
- renamed few defines and functions abp -> abp060mg
(some structs left as they were to keep the sensible meaning).

Signed-off-by: Marcin Malagowski <mrc@bourne.st>
---
 drivers/iio/pressure/Kconfig    |  10 ++
 drivers/iio/pressure/Makefile   |   1 +
 drivers/iio/pressure/abp060mg.c | 275 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)
 create mode 100644 drivers/iio/pressure/abp060mg.c

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index cc090d8..2347bb7 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -5,6 +5,16 @@
 
 menu "Pressure sensors"
 
+config ABP060MG
+	tristate "Honeywell ABP pressure sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for the Honeywell ABP pressure
+	  sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called abp060mg.
+
 config BMP280
 	tristate "Bosch Sensortec BMP180/BMP280 pressure sensor I2C driver"
 	depends on (I2C || SPI_MASTER)
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index fff7718..de3dbc8 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -3,6 +3,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_ABP060MG) += abp060mg.o
 obj-$(CONFIG_BMP280) += bmp280.o
 bmp280-objs := bmp280-core.o bmp280-regmap.o
 obj-$(CONFIG_BMP280_I2C) += bmp280-i2c.o
diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
new file mode 100644
index 0000000..80d896c
--- /dev/null
+++ b/drivers/iio/pressure/abp060mg.c
@@ -0,0 +1,275 @@
+/*
+ * Copyright (C) 2016 - Marcin Malagowski <mrc@bourne.st>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+
+#define ABP060MG_ERROR_MASK   0xC000
+#define ABP060MG_RESP_TIME_MS 40
+#define ABP060MG_MIN_COUNTS   1638  /* = 0x0666 (10% of u14) */
+#define ABP060MG_MAX_COUNTS   14745 /* = 0x3999 (90% of u14) */
+#define ABP060MG_NUM_COUNTS   (ABP060MG_MAX_COUNTS - ABP060MG_MIN_COUNTS)
+
+enum abp_variant {
+	/* gage [kPa] */
+	ABP006KG, ABP010KG, ABP016KG, ABP025KG, ABP040KG, ABP060KG, ABP100KG,
+	ABP160KG, ABP250KG, ABP400KG, ABP600KG, ABP001GG,
+	/* differential [kPa] */
+	ABP006KD, ABP010KD, ABP016KD, ABP025KD, ABP040KD, ABP060KD, ABP100KD,
+	ABP160KD, ABP250KD, ABP400KD,
+	/* gage [psi] */
+	ABP001PG, ABP005PG, ABP015PG, ABP030PG, ABP060PG, ABP100PG, ABP150PG,
+	/* differential [psi] */
+	ABP001PD, ABP005PD, ABP015PD, ABP030PD, ABP060PD,
+};
+
+struct abp_config {
+	int min;
+	int max;
+};
+
+static struct abp_config abp_config[] = {
+	/* mbar & kPa variants */
+	[ABP006KG] = { .min =       0, .max =     6000 },
+	[ABP010KG] = { .min =       0, .max =    10000 },
+	[ABP016KG] = { .min =       0, .max =    16000 },
+	[ABP025KG] = { .min =       0, .max =    25000 },
+	[ABP040KG] = { .min =       0, .max =    40000 },
+	[ABP060KG] = { .min =       0, .max =    60000 },
+	[ABP100KG] = { .min =       0, .max =   100000 },
+	[ABP160KG] = { .min =       0, .max =   160000 },
+	[ABP250KG] = { .min =       0, .max =   250000 },
+	[ABP400KG] = { .min =       0, .max =   400000 },
+	[ABP600KG] = { .min =       0, .max =   600000 },
+	[ABP001GG] = { .min =       0, .max =  1000000 },
+	[ABP006KD] = { .min =   -6000, .max =     6000 },
+	[ABP010KD] = { .min =  -10000, .max =    10000 },
+	[ABP016KD] = { .min =  -16000, .max =    16000 },
+	[ABP025KD] = { .min =  -25000, .max =    25000 },
+	[ABP040KD] = { .min =  -40000, .max =    40000 },
+	[ABP060KD] = { .min =  -60000, .max =    60000 },
+	[ABP100KD] = { .min = -100000, .max =   100000 },
+	[ABP160KD] = { .min = -160000, .max =   160000 },
+	[ABP250KD] = { .min = -250000, .max =   250000 },
+	[ABP400KD] = { .min = -400000, .max =   400000 },
+	/* psi variants (1 psi ~ 6895 Pa) */
+	[ABP001PG] = { .min =       0, .max =     6985 },
+	[ABP005PG] = { .min =       0, .max =    34474 },
+	[ABP015PG] = { .min =       0, .max =   103421 },
+	[ABP030PG] = { .min =       0, .max =   206843 },
+	[ABP060PG] = { .min =       0, .max =   413686 },
+	[ABP100PG] = { .min =       0, .max =   689476 },
+	[ABP150PG] = { .min =       0, .max =  1034214 },
+	[ABP001PD] = { .min =   -6895, .max =     6895 },
+	[ABP005PD] = { .min =  -34474, .max =    34474 },
+	[ABP015PD] = { .min = -103421, .max =   103421 },
+	[ABP030PD] = { .min = -206843, .max =   206843 },
+	[ABP060PD] = { .min = -413686, .max =   413686 },
+};
+
+struct abp_state {
+	struct i2c_client *client;
+	struct mutex lock;
+
+	/* bus-dependent MEASURE_REQUEST length.
+	 * If no SMBUS_QUICK support, need to send dummy byte
+	 */
+	int mreq_len;
+
+	/* model-dependent values (calculated on probe) */
+	int scale;
+	int offset;
+};
+
+static const struct iio_chan_spec abp060mg_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int abp060mg_get_measurement(struct abp_state *state, int *val)
+{
+	struct i2c_client *client = state->client;
+	__be16 buf[2];
+	u16 pressure;
+	int ret;
+
+	buf[0] = 0;
+	ret = i2c_master_send(client, (u8 *)&buf, state->mreq_len);
+	if (ret < 0)
+		return ret;
+
+	msleep_interruptible(ABP060MG_RESP_TIME_MS);
+
+	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	pressure = be16_to_cpu(buf[0]);
+	if (pressure & ABP060MG_ERROR_MASK)
+		return -EIO;
+
+	if (pressure < ABP060MG_MIN_COUNTS || pressure > ABP060MG_MAX_COUNTS)
+		return -EIO;
+
+	*val = pressure;
+
+	return IIO_VAL_INT;
+}
+
+static int abp060mg_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask)
+{
+	struct abp_state *state = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&state->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = abp060mg_get_measurement(state, val);
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = state->offset;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = state->scale;
+		*val2 = ABP060MG_NUM_COUNTS * 1000; /* to kPa */
+		ret = IIO_VAL_FRACTIONAL;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&state->lock);
+	return ret;
+}
+
+static const struct iio_info abp060mg_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = abp060mg_read_raw,
+};
+
+static void abp060mg_init_device(struct iio_dev *indio_dev, unsigned long id)
+{
+	struct abp_state *state = iio_priv(indio_dev);
+	struct abp_config *cfg = &abp_config[id];
+
+	state->scale = cfg->max - cfg->min;
+	state->offset = -ABP060MG_MIN_COUNTS;
+
+	if (cfg->min < 0) /* differential */
+		state->offset -= ABP060MG_NUM_COUNTS >> 1;
+}
+
+static int abp060mg_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct abp_state *state;
+	unsigned long cfg_id = id->driver_data;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(indio_dev);
+	i2c_set_clientdata(client, state);
+	state->client = client;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_QUICK))
+		state->mreq_len = 1;
+
+	abp060mg_init_device(indio_dev, cfg_id);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = dev_name(&client->dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &abp060mg_info;
+
+	indio_dev->channels = abp060mg_channels;
+	indio_dev->num_channels = ARRAY_SIZE(abp060mg_channels);
+
+	mutex_init(&state->lock);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id abp060mg_id_table[] = {
+	/* mbar & kPa variants (abp060m [60 mbar] == abp006k [6 kPa]) */
+	/*    gage: */
+	{ "abp060mg", ABP006KG }, { "abp006kg", ABP006KG },
+	{ "abp100mg", ABP010KG }, { "abp010kg", ABP010KG },
+	{ "abp160mg", ABP016KG }, { "abp016kg", ABP016KG },
+	{ "abp250mg", ABP025KG }, { "abp025kg", ABP025KG },
+	{ "abp400mg", ABP040KG }, { "abp040kg", ABP040KG },
+	{ "abp600mg", ABP060KG }, { "abp060kg", ABP060KG },
+	{ "abp001bg", ABP100KG }, { "abp100kg", ABP100KG },
+	{ "abp1_6bg", ABP160KG }, { "abp160kg", ABP160KG },
+	{ "abp2_5bg", ABP250KG }, { "abp250kg", ABP250KG },
+	{ "abp004bg", ABP400KG }, { "abp400kg", ABP400KG },
+	{ "abp006bg", ABP600KG }, { "abp600kg", ABP600KG },
+	{ "abp010bg", ABP001GG }, { "abp001gg", ABP001GG },
+	/*    differential: */
+	{ "abp060md", ABP006KD }, { "abp006kd", ABP006KD },
+	{ "abp100md", ABP010KD }, { "abp010kd", ABP010KD },
+	{ "abp160md", ABP016KD }, { "abp016kd", ABP016KD },
+	{ "abp250md", ABP025KD }, { "abp025kd", ABP025KD },
+	{ "abp400md", ABP040KD }, { "abp040kd", ABP040KD },
+	{ "abp600md", ABP060KD }, { "abp060kd", ABP060KD },
+	{ "abp001bd", ABP100KD }, { "abp100kd", ABP100KD },
+	{ "abp1_6bd", ABP160KD }, { "abp160kd", ABP160KD },
+	{ "abp2_5bd", ABP250KD }, { "abp250kd", ABP250KD },
+	{ "abp004bd", ABP400KD }, { "abp400kd", ABP400KD },
+	/* psi variants */
+	/*    gage: */
+	{ "abp001pg", ABP001PG },
+	{ "abp005pg", ABP005PG },
+	{ "abp015pg", ABP015PG },
+	{ "abp030pg", ABP030PG },
+	{ "abp060pg", ABP060PG },
+	{ "abp100pg", ABP100PG },
+	{ "abp150pg", ABP150PG },
+	/*    differential: */
+	{ "abp001pd", ABP001PD },
+	{ "abp005pd", ABP005PD },
+	{ "abp015pd", ABP015PD },
+	{ "abp030pd", ABP030PD },
+	{ "abp060pd", ABP060PD },
+	{ /* empty */ },
+};
+MODULE_DEVICE_TABLE(i2c, abp060mg_id_table);
+
+static struct i2c_driver abp060mg_driver = {
+	.driver = {
+		.name = "abp060mg",
+	},
+	.probe = abp060mg_probe,
+	.id_table = abp060mg_id_table,
+};
+module_i2c_driver(abp060mg_driver);
+
+MODULE_AUTHOR("Marcin Malagowski <mrc@bourne.st>");
+MODULE_DESCRIPTION("Honeywell ABP pressure sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.5.5

