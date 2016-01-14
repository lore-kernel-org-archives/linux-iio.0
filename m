Return-Path: <akinobu.mita@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: pressure: mpl115: support MPL115A1
Date: Fri, 15 Jan 2016 01:30:18 +0900
Message-Id: <1452789018-16255-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1452789018-16255-1-git-send-email-akinobu.mita@gmail.com>
References: <1452789018-16255-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

mpl115 driver currently supports i2c interface (MPL115A2).
There is also SPI version (MPL115A1).  The difference between them
is only physical transport so we can easily support both while sharing
most of the code.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/pressure/Kconfig  |   8 +-
 drivers/iio/pressure/mpl115.c | 258 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 236 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 6f2e7c9..fa628b7 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -31,11 +31,11 @@ config HID_SENSOR_PRESS
           will be called hid-sensor-press.
 
 config MPL115
-	tristate "Freescale MPL115A2 pressure sensor driver"
-	depends on I2C
+	tristate "Freescale MPL115A1/2 pressure sensor driver"
+	depends on (SPI_MASTER && I2C!=m) || I2C
 	help
-	  Say yes here to build support for the Freescale MPL115A2
-	  pressure sensor connected via I2C.
+	  Say yes here to build support for the Freescale MPL115A1/2
+	  pressure sensor connected via I2C or SPI.
 
           To compile this driver as a module, choose M here: the module
           will be called mpl115.
diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 3e1e3353..3ffaae4 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -1,5 +1,5 @@
 /*
- * mpl115.c - Support for Freescale MPL115A2 pressure/temperature sensor
+ * mpl115.c - Support for Freescale MPL115A1/2 pressure/temperature sensor
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
@@ -9,12 +9,17 @@
  *
  * (7-bit I2C slave address 0x60)
  *
+ * Datasheet:
+ *  http://www.nxp.com/files/sensors/doc/data_sheet/MPL115A1.pdf
+ *  http://www.nxp.com/files/sensors/doc/data_sheet/MPL115A2.pdf
+ *
  * TODO: shutdown pin
  *
  */
 
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/delay.h>
 
@@ -27,16 +32,24 @@
 #define MPL115_CONVERT 0x12 /* convert temperature and pressure */
 
 struct mpl115_data {
-	struct i2c_client *client;
+	struct device *dev;
 	struct mutex lock;
 	s16 a0;
 	s16 b1, b2;
 	s16 c12;
+	const struct mpl115_ops *ops;
+};
+
+struct mpl115_ops {
+	int (*init)(struct mpl115_data *);
+	int (*read)(struct mpl115_data *, u8);
+	int (*write)(struct mpl115_data *, u8, u8);
 };
 
 static int mpl115_request(struct mpl115_data *data)
 {
-	int ret = i2c_smbus_write_byte_data(data->client, MPL115_CONVERT, 0);
+	int ret = data->ops->write(data, MPL115_CONVERT, 0);
+
 	if (ret < 0)
 		return ret;
 
@@ -57,12 +70,12 @@ static int mpl115_comp_pressure(struct mpl115_data *data, int *val, int *val2)
 	if (ret < 0)
 		goto done;
 
-	ret = i2c_smbus_read_word_swapped(data->client, MPL115_PADC);
+	ret = data->ops->read(data, MPL115_PADC);
 	if (ret < 0)
 		goto done;
 	padc = ret >> 6;
 
-	ret = i2c_smbus_read_word_swapped(data->client, MPL115_TADC);
+	ret = data->ops->read(data, MPL115_TADC);
 	if (ret < 0)
 		goto done;
 	tadc = ret >> 6;
@@ -90,7 +103,7 @@ static int mpl115_read_temp(struct mpl115_data *data)
 	ret = mpl115_request(data);
 	if (ret < 0)
 		goto done;
-	ret = i2c_smbus_read_word_swapped(data->client, MPL115_TADC);
+	ret = data->ops->read(data, MPL115_TADC);
 done:
 	mutex_unlock(&data->lock);
 	return ret;
@@ -145,65 +158,258 @@ static const struct iio_info mpl115_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int mpl115_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int mpl115_probe(struct device *dev, const char *name,
+			const struct mpl115_ops *ops)
 {
 	struct mpl115_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
-		return -ENODEV;
-
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	data->client = client;
+	data->dev = dev;
+	data->ops = ops;
 	mutex_init(&data->lock);
 
 	indio_dev->info = &mpl115_info;
-	indio_dev->name = id->name;
-	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = name;
+	indio_dev->dev.parent = dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mpl115_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mpl115_channels);
 
-	ret = i2c_smbus_read_word_swapped(data->client, MPL115_A0);
+	ret = data->ops->init(data);
+	if (ret)
+		return ret;
+
+	ret = data->ops->read(data, MPL115_A0);
 	if (ret < 0)
 		return ret;
 	data->a0 = ret;
-	ret = i2c_smbus_read_word_swapped(data->client, MPL115_B1);
+	ret = data->ops->read(data, MPL115_B1);
 	if (ret < 0)
 		return ret;
 	data->b1 = ret;
-	ret = i2c_smbus_read_word_swapped(data->client, MPL115_B2);
+	ret = data->ops->read(data, MPL115_B2);
 	if (ret < 0)
 		return ret;
 	data->b2 = ret;
-	ret = i2c_smbus_read_word_swapped(data->client, MPL115_C12);
+	ret = data->ops->read(data, MPL115_C12);
 	if (ret < 0)
 		return ret;
 	data->c12 = ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+
+#define MPL115_SPI_WRITE(address)	((address) << 1)
+#define MPL115_SPI_READ(address)	(0x80 | (address) << 1)
+
+struct mpl115_spi_buf {
+	u8 tx[4];
+	u8 rx[4];
+};
+
+static int mpl115_spi_init(struct mpl115_data *data)
+{
+	struct spi_device *spi = to_spi_device(data->dev);
+	struct mpl115_spi_buf *buf;
+
+	buf = devm_kzalloc(data->dev, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, buf);
+
+	return 0;
+}
+
+static int mpl115_spi_read(struct mpl115_data *data, u8 address)
+{
+	struct spi_device *spi = to_spi_device(data->dev);
+	struct mpl115_spi_buf *buf = spi_get_drvdata(spi);
+	struct spi_transfer xfer = {
+		.tx_buf = buf->tx,
+		.rx_buf = buf->rx,
+		.len = 4,
+	};
+	int ret;
+
+	buf->tx[0] = MPL115_SPI_READ(address);
+	buf->tx[2] = MPL115_SPI_READ(address + 1);
+
+	ret = spi_sync_transfer(spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	return (buf->rx[1] << 8) | buf->rx[3];
+}
+
+static int mpl115_spi_write(struct mpl115_data *data, u8 address, u8 value)
+{
+	struct spi_device *spi = to_spi_device(data->dev);
+	struct mpl115_spi_buf *buf = spi_get_drvdata(spi);
+	struct spi_transfer xfer = {
+		.tx_buf = buf->tx,
+		.len = 2,
+	};
+
+	buf->tx[0] = MPL115_SPI_WRITE(address);
+	buf->tx[1] = value;
+
+	return spi_sync_transfer(spi, &xfer, 1);
+}
+
+static const struct mpl115_ops mpl115_spi_ops = {
+	.init = mpl115_spi_init,
+	.read = mpl115_spi_read,
+	.write = mpl115_spi_write,
+};
+
+static int mpl115_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	return mpl115_probe(&spi->dev, id->name, &mpl115_spi_ops);
+}
+
+static const struct spi_device_id mpl115_spi_ids[] = {
+	{ "mpl115", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, mpl115_spi_ids);
+
+static struct spi_driver mpl115_spi_driver = {
+	.driver = {
+		.name   = "mpl115",
+	},
+	.probe = mpl115_spi_probe,
+	.id_table = mpl115_spi_ids,
+};
+
+static int mpl115_spi_register_driver(void)
+{
+	return spi_register_driver(&mpl115_spi_driver);
+}
+
+static void mpl115_spi_unregister_driver(void)
+{
+	spi_unregister_driver(&mpl115_spi_driver);
+}
+
+#else
+
+static int mpl115_spi_register_driver(void)
+{
+	return 0;
+}
+
+static void mpl115_spi_unregister_driver(void)
+{
+}
+
+#endif
+
+#if IS_ENABLED(CONFIG_I2C)
+
+static int mpl115_i2c_init(struct mpl115_data *data)
+{
+	return 0;
+}
+
+static int mpl115_i2c_read(struct mpl115_data *data, u8 address)
+{
+	struct i2c_client *client = to_i2c_client(data->dev);
+
+	return i2c_smbus_read_word_swapped(client, address);
+}
+
+static int mpl115_i2c_write(struct mpl115_data *data, u8 address, u8 value)
+{
+	struct i2c_client *client = to_i2c_client(data->dev);
+
+	return i2c_smbus_write_byte_data(client, address, value);
+}
+
+static const struct mpl115_ops mpl115_i2c_ops = {
+	.init = mpl115_i2c_init,
+	.read = mpl115_i2c_read,
+	.write = mpl115_i2c_write,
+};
+
+static int mpl115_i2c_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	return mpl115_probe(&client->dev, id->name, &mpl115_i2c_ops);
 }
 
-static const struct i2c_device_id mpl115_id[] = {
+static const struct i2c_device_id mpl115_i2c_id[] = {
 	{ "mpl115", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, mpl115_id);
+MODULE_DEVICE_TABLE(i2c, mpl115_i2c_id);
 
-static struct i2c_driver mpl115_driver = {
+static struct i2c_driver mpl115_i2c_driver = {
 	.driver = {
 		.name	= "mpl115",
 	},
-	.probe = mpl115_probe,
-	.id_table = mpl115_id,
+	.probe = mpl115_i2c_probe,
+	.id_table = mpl115_i2c_id,
 };
-module_i2c_driver(mpl115_driver);
+
+static int mpl115_i2c_register_driver(void)
+{
+	return i2c_add_driver(&mpl115_i2c_driver);
+}
+
+static void mpl115_i2c_unregister_driver(void)
+{
+	i2c_del_driver(&mpl115_i2c_driver);
+}
+
+#else
+
+static int mpl115_i2c_register_driver(void)
+{
+	return 0;
+}
+
+static void mpl115_i2c_unregister_driver(void)
+{
+}
+
+#endif
+
+static int mpl115_init(void)
+{
+	int ret;
+
+	ret = mpl115_spi_register_driver();
+	if (ret)
+		return ret;
+
+	ret = mpl115_i2c_register_driver();
+	if (ret)
+		mpl115_spi_unregister_driver();
+
+	return ret;
+}
+module_init(mpl115_init);
+
+static void mpl115_exit(void)
+{
+	mpl115_i2c_unregister_driver();
+	mpl115_spi_unregister_driver();
+}
+module_exit(mpl115_exit);
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
 MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");
-- 
2.5.0
