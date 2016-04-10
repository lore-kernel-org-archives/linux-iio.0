Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Matt Ranostay <mranostay@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH V3] iio: pressure: hp03: Add Hope RF HP03 sensor support
Date: Sun, 10 Apr 2016 22:52:24 +0200
Message-Id: <1460321544-8619-1-git-send-email-marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Add support for HopeRF pressure and temperature sensor.

This device uses two fixed I2C addresses, one for storing
calibration coefficients and another for accessing the ADC.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Matt Ranostay <mranostay@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
---
V2: - Expand the binding document with more details on the XCLR pin
    - Switch from IIO_CHAN_INFO_PROCESSED to RAW + SCALE
    - Add failpath into hp03_update_temp_pressure() for the case
      when ADC readout fails. This correctly sets the XCLR pin back
      to LO now.
    - Add comment explaining the need for allocation of child device
      in hp03_probe().
V3: - Fix indent in the DT binding documentation
    - Report raw pressure and temperature unmodified
    - Report pressure scale to be 1 , since pressure is in Pa
    - Report temperature scale to be 0.01 , since temp is in 0.01C steps
---
 .../devicetree/bindings/iio/pressure/hp03.txt      |  17 ++
 drivers/iio/pressure/Kconfig                       |  11 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/hp03.c                        | 307 +++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/hp03.txt
 create mode 100644 drivers/iio/pressure/hp03.c

diff --git a/Documentation/devicetree/bindings/iio/pressure/hp03.txt b/Documentation/devicetree/bindings/iio/pressure/hp03.txt
new file mode 100644
index 0000000..54e7e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/hp03.txt
@@ -0,0 +1,17 @@
+HopeRF HP03 digital pressure/temperature sensors
+
+Required properties:
+- compatible: must be "hoperf,hp03"
+- xclr-gpio: must be device tree identifier of the XCLR pin.
+             The XCLR pin is a reset of the ADC in the chip,
+             it must be pulled HI before the conversion and
+             readout of the value from the ADC registers and
+             pulled LO afterward.
+
+Example:
+
+hp03@0x77 {
+	compatible = "hoperf,hp03";
+	reg = <0x77>;
+	xclr-gpio = <&portc 0 0x0>;
+};
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 8de0192..54c6165 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -30,6 +30,17 @@ config HID_SENSOR_PRESS
 	  To compile this driver as a module, choose M here: the module
 	  will be called hid-sensor-press.
 
+config HP03
+	tristate "Hope RF HP03 temperature and pressure sensor driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for Hope RF HP03 pressure and
+	  temperature sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hp03.
+
 config MPL115
 	tristate
 
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 6e60863..17d6e7a 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -5,6 +5,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_BMP280) += bmp280.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
+obj-$(CONFIG_HP03) += hp03.o
 obj-$(CONFIG_MPL115) += mpl115.o
 obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
 obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
new file mode 100644
index 0000000..202a028
--- /dev/null
+++ b/drivers/iio/pressure/hp03.c
@@ -0,0 +1,307 @@
+/*
+ * Copyright (c) 2016 Marek Vasut <marex@denx.de>
+ *
+ * Driver for Hope RF HP03 digital temperature and pressure sensor.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "hp03: " fmt
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/*
+ * The HP03 sensor occupies two fixed I2C addresses:
+ *  0x50 ... read-only EEPROM with calibration data
+ *  0x77 ... read-write ADC for pressure and temperature
+ */
+#define HP03_EEPROM_ADDR		0x50
+#define HP03_ADC_ADDR			0x77
+
+#define HP03_EEPROM_CX_OFFSET		0x10
+#define HP03_EEPROM_AB_OFFSET		0x1e
+#define HP03_EEPROM_CD_OFFSET		0x20
+
+#define HP03_ADC_WRITE_REG		0xff
+#define HP03_ADC_READ_REG		0xfd
+#define HP03_ADC_READ_PRESSURE		0xf0	/* D1 in datasheet */
+#define HP03_ADC_READ_TEMP		0xe8	/* D2 in datasheet */
+
+struct hp03_priv {
+	struct i2c_client	*client;
+	struct mutex		lock;
+	struct gpio_desc	*xclr_gpio;
+
+	struct i2c_client	*eeprom_client;
+	struct regmap		*eeprom_regmap;
+
+	s32			pressure;	/* kPa */
+	s32			temp;		/* Deg. C */
+};
+
+static const struct iio_chan_spec hp03_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static bool hp03_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	return false;
+}
+
+static bool hp03_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return false;
+}
+
+static const struct regmap_config hp03_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+
+	.max_register	= HP03_EEPROM_CD_OFFSET + 1,
+	.cache_type	= REGCACHE_RBTREE,
+
+	.writeable_reg	= hp03_is_writeable_reg,
+	.volatile_reg	= hp03_is_volatile_reg,
+};
+
+static int hp03_get_temp_pressure(struct hp03_priv *priv, const u8 reg)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(priv->client, HP03_ADC_WRITE_REG, reg);
+	if (ret < 0)
+		return ret;
+
+	msleep(50);	/* Wait for conversion to finish */
+
+	return i2c_smbus_read_word_data(priv->client, HP03_ADC_READ_REG);
+}
+
+static int hp03_update_temp_pressure(struct hp03_priv *priv)
+{
+	struct device *dev = &priv->client->dev;
+	u8 coefs[18];
+	u16 cx_val[7];
+	int ab_val, d1_val, d2_val, diff_val, dut, off, sens, x;
+	int i, ret;
+
+	/* Sample coefficients from EEPROM */
+	ret = regmap_bulk_read(priv->eeprom_regmap, HP03_EEPROM_CX_OFFSET,
+			       coefs, sizeof(coefs));
+	if (ret < 0) {
+		dev_err(dev, "Failed to read EEPROM (reg=%02x)\n",
+			HP03_EEPROM_CX_OFFSET);
+		return ret;
+	}
+
+	/* Sample Temperature and Pressure */
+	gpiod_set_value_cansleep(priv->xclr_gpio, 1);
+
+	ret = hp03_get_temp_pressure(priv, HP03_ADC_READ_PRESSURE);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read pressure\n");
+		goto err_adc;
+	}
+	d1_val = ret;
+
+	ret = hp03_get_temp_pressure(priv, HP03_ADC_READ_TEMP);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read temperature\n");
+		goto err_adc;
+	}
+	d2_val = ret;
+
+	gpiod_set_value_cansleep(priv->xclr_gpio, 0);
+
+	/* The Cx coefficients and Temp/Pressure values are MSB first. */
+	for (i = 0; i < 7; i++)
+		cx_val[i] = (coefs[2 * i] << 8) | (coefs[(2 * i) + 1] << 0);
+	d1_val = ((d1_val >> 8) & 0xff) | ((d1_val & 0xff) << 8);
+	d2_val = ((d2_val >> 8) & 0xff) | ((d2_val & 0xff) << 8);
+
+	/* Coefficient voodoo from the HP03 datasheet. */
+	if (d2_val >= cx_val[4])
+		ab_val = coefs[14];	/* A-value */
+	else
+		ab_val = coefs[15];	/* B-value */
+
+	diff_val = d2_val - cx_val[4];
+	dut = (ab_val * (diff_val >> 7) * (diff_val >> 7)) >> coefs[16];
+	dut = diff_val - dut;
+
+	off = (cx_val[1] + (((cx_val[3] - 1024) * dut) >> 14)) * 4;
+	sens = cx_val[0] + ((cx_val[2] * dut) >> 10);
+	x = ((sens * (d1_val - 7168)) >> 14) - off;
+
+	priv->pressure = ((x * 100) >> 5) + (cx_val[6] * 10);
+	priv->temp = 250 + ((dut * cx_val[5]) >> 16) - (dut >> coefs[17]);
+
+	return 0;
+
+err_adc:
+	gpiod_set_value_cansleep(priv->xclr_gpio, 0);
+	return ret;
+}
+
+static int hp03_read_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int *val, int *val2, long mask)
+{
+	struct hp03_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&priv->lock);
+	ret = hp03_update_temp_pressure(priv);
+	mutex_unlock(&priv->lock);
+
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = priv->pressure;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = priv->temp;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = 1;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = 10000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info hp03_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= &hp03_read_raw,
+};
+
+static int hp03_probe(struct i2c_client *client,
+		      const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct hp03_priv *priv;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->client = client;
+	mutex_init(&priv->lock);
+
+	indio_dev->dev.parent = dev;
+	indio_dev->name = id->name;
+	indio_dev->channels = hp03_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hp03_channels);
+	indio_dev->info = &hp03_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/*
+	 * Allocate another device for the on-sensor EEPROM,
+	 * which has it's dedicated I2C address and contains
+	 * the calibration constants for the sensor.
+	 */
+	priv->eeprom_client = i2c_new_dummy(client->adapter, HP03_EEPROM_ADDR);
+	if (!priv->eeprom_client) {
+		dev_err(dev, "New EEPROM I2C device failed\n");
+		return -ENODEV;
+	}
+
+	priv->eeprom_regmap = devm_regmap_init_i2c(priv->eeprom_client,
+						   &hp03_regmap_config);
+	if (IS_ERR(priv->eeprom_regmap)) {
+		dev_err(dev, "Failed to allocate EEPROM regmap\n");
+		ret = PTR_ERR(priv->eeprom_regmap);
+		goto err;
+	}
+
+	priv->xclr_gpio = devm_gpiod_get_index(dev, "xclr", 0, GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->xclr_gpio)) {
+		dev_err(dev, "Failed to claim XCLR GPIO\n");
+		ret = PTR_ERR(priv->xclr_gpio);
+		goto err;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register IIO device\n");
+		goto err;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+
+	return 0;
+
+err:
+	i2c_unregister_device(priv->eeprom_client);
+	return ret;
+}
+
+static int hp03_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct hp03_priv *priv = iio_priv(indio_dev);
+
+	i2c_unregister_device(priv->eeprom_client);
+
+	return 0;
+}
+
+static const struct i2c_device_id hp03_id[] = {
+	{ "hp03", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, hp03_id);
+
+static struct i2c_driver hp03_driver = {
+	.driver = {
+		.name	= "hp03",
+	},
+	.probe		= hp03_probe,
+	.remove		= hp03_remove,
+	.id_table	= hp03_id,
+};
+module_i2c_driver(hp03_driver);
+
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("Driver for Hope RF HP03 pressure and temperature sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.7.0
