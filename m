Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36251 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbcFSSgF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2016 14:36:05 -0400
Received: by mail-lf0-f52.google.com with SMTP id q132so25416013lfe.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2016 11:34:34 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/9] iio: pressure: bmp280: split driver in logical parts
Date: Sun, 19 Jun 2016 20:33:58 +0200
Message-Id: <1466361242-2994-6-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
References: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This splits the BMP280 driver in three logical parts: the core driver
bmp280-core that only operated on a struct device * and a struct regmap *,
the regmap driver bmp280-regmap that can be shared between I2C and other
transports and the I2C module driver bmp280-i2c.

Cleverly bake all functionality into a single object bmp280.o so that
we still get the same module binary built for the device in the end,
without any fuzz exporting symbols to the left and right.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/Makefile                    |   1 +
 drivers/iio/pressure/{bmp280.c => bmp280-core.c} | 263 +++--------------------
 drivers/iio/pressure/bmp280-i2c.c                |  78 +++++++
 drivers/iio/pressure/bmp280-regmap.c             |  78 +++++++
 drivers/iio/pressure/bmp280.h                    |  85 ++++++++
 5 files changed, 274 insertions(+), 231 deletions(-)
 rename drivers/iio/pressure/{bmp280.c => bmp280-core.c} (71%)
 create mode 100644 drivers/iio/pressure/bmp280-i2c.c
 create mode 100644 drivers/iio/pressure/bmp280-regmap.c
 create mode 100644 drivers/iio/pressure/bmp280.h

diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 17d6e7afa1ff..2d98a7ff77a8 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -4,6 +4,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_BMP280) += bmp280.o
+bmp280-objs := bmp280-core.o bmp280-regmap.o bmp280-i2c.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
 obj-$(CONFIG_HP03) += hp03.o
 obj-$(CONFIG_MPL115) += mpl115.o
diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280-core.c
similarity index 71%
rename from drivers/iio/pressure/bmp280.c
rename to drivers/iio/pressure/bmp280-core.c
index 343e97efad19..5455e9c44953 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -14,10 +14,7 @@
 
 #define pr_fmt(fmt) "bmp280: " fmt
 
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/acpi.h>
-#include <linux/of.h>
+#include <linux/device.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -25,80 +22,10 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 
-/* BMP280 specific registers */
-#define BMP280_REG_TEMP_XLSB		0xFC
-#define BMP280_REG_TEMP_LSB		0xFB
-#define BMP280_REG_TEMP_MSB		0xFA
-#define BMP280_REG_PRESS_XLSB		0xF9
-#define BMP280_REG_PRESS_LSB		0xF8
-#define BMP280_REG_PRESS_MSB		0xF7
-
-#define BMP280_REG_CONFIG		0xF5
-#define BMP280_REG_STATUS		0xF3
-
-#define BMP280_REG_COMP_TEMP_START	0x88
-#define BMP280_COMP_TEMP_REG_COUNT	6
-
-#define BMP280_REG_COMP_PRESS_START	0x8E
-#define BMP280_COMP_PRESS_REG_COUNT	18
-
-#define BMP280_FILTER_MASK		(BIT(4) | BIT(3) | BIT(2))
-#define BMP280_FILTER_OFF		0
-#define BMP280_FILTER_2X		BIT(2)
-#define BMP280_FILTER_4X		BIT(3)
-#define BMP280_FILTER_8X		(BIT(3) | BIT(2))
-#define BMP280_FILTER_16X		BIT(4)
-
-#define BMP280_OSRS_TEMP_MASK		(BIT(7) | BIT(6) | BIT(5))
-#define BMP280_OSRS_TEMP_SKIP		0
-#define BMP280_OSRS_TEMP_X(osrs_t)	((osrs_t) << 5)
-#define BMP280_OSRS_TEMP_1X		BMP280_OSRS_TEMP_X(1)
-#define BMP280_OSRS_TEMP_2X		BMP280_OSRS_TEMP_X(2)
-#define BMP280_OSRS_TEMP_4X		BMP280_OSRS_TEMP_X(3)
-#define BMP280_OSRS_TEMP_8X		BMP280_OSRS_TEMP_X(4)
-#define BMP280_OSRS_TEMP_16X		BMP280_OSRS_TEMP_X(5)
-
-#define BMP280_OSRS_PRESS_MASK		(BIT(4) | BIT(3) | BIT(2))
-#define BMP280_OSRS_PRESS_SKIP		0
-#define BMP280_OSRS_PRESS_X(osrs_p)	((osrs_p) << 2)
-#define BMP280_OSRS_PRESS_1X		BMP280_OSRS_PRESS_X(1)
-#define BMP280_OSRS_PRESS_2X		BMP280_OSRS_PRESS_X(2)
-#define BMP280_OSRS_PRESS_4X		BMP280_OSRS_PRESS_X(3)
-#define BMP280_OSRS_PRESS_8X		BMP280_OSRS_PRESS_X(4)
-#define BMP280_OSRS_PRESS_16X		BMP280_OSRS_PRESS_X(5)
-
-#define BMP280_MODE_MASK		(BIT(1) | BIT(0))
-#define BMP280_MODE_SLEEP		0
-#define BMP280_MODE_FORCED		BIT(0)
-#define BMP280_MODE_NORMAL		(BIT(1) | BIT(0))
-
-/* BMP180 specific registers */
-#define BMP180_REG_OUT_XLSB		0xF8
-#define BMP180_REG_OUT_LSB		0xF7
-#define BMP180_REG_OUT_MSB		0xF6
-
-#define BMP180_REG_CALIB_START		0xAA
-#define BMP180_REG_CALIB_COUNT		22
-
-#define BMP180_MEAS_SCO			BIT(5)
-#define BMP180_MEAS_TEMP		(0x0E | BMP180_MEAS_SCO)
-#define BMP180_MEAS_PRESS_X(oss)	((oss) << 6 | 0x14 | BMP180_MEAS_SCO)
-#define BMP180_MEAS_PRESS_1X		BMP180_MEAS_PRESS_X(0)
-#define BMP180_MEAS_PRESS_2X		BMP180_MEAS_PRESS_X(1)
-#define BMP180_MEAS_PRESS_4X		BMP180_MEAS_PRESS_X(2)
-#define BMP180_MEAS_PRESS_8X		BMP180_MEAS_PRESS_X(3)
-
-/* BMP180 and BMP280 common registers */
-#define BMP280_REG_CTRL_MEAS		0xF4
-#define BMP280_REG_RESET		0xE0
-#define BMP280_REG_ID			0xD0
-
-#define BMP180_CHIP_ID			0x55
-#define BMP280_CHIP_ID			0x58
-#define BMP280_SOFT_RESET_VAL		0xB6
+#include "bmp280.h"
 
 struct bmp280_data {
-	struct i2c_client *client;
+	struct device *dev;
 	struct mutex lock;
 	struct regmap *regmap;
 	const struct bmp280_chip_info *chip_info;
@@ -117,8 +44,6 @@ struct bmp280_data {
 };
 
 struct bmp280_chip_info {
-	const struct regmap_config *regmap_config;
-
 	const int *oversampling_temp_avail;
 	int num_oversampling_temp_avail;
 
@@ -150,45 +75,6 @@ static const struct iio_chan_spec bmp280_channels[] = {
 	},
 };
 
-static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case BMP280_REG_CONFIG:
-	case BMP280_REG_CTRL_MEAS:
-	case BMP280_REG_RESET:
-		return true;
-	default:
-		return false;
-	};
-}
-
-static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case BMP280_REG_TEMP_XLSB:
-	case BMP280_REG_TEMP_LSB:
-	case BMP280_REG_TEMP_MSB:
-	case BMP280_REG_PRESS_XLSB:
-	case BMP280_REG_PRESS_LSB:
-	case BMP280_REG_PRESS_MSB:
-	case BMP280_REG_STATUS:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static const struct regmap_config bmp280_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-
-	.max_register = BMP280_REG_TEMP_XLSB,
-	.cache_type = REGCACHE_RBTREE,
-
-	.writeable_reg = bmp280_is_writeable_reg,
-	.volatile_reg = bmp280_is_volatile_reg,
-};
-
 /*
  * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
  * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
@@ -206,7 +92,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
 			       buf, BMP280_COMP_TEMP_REG_COUNT);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"failed to read temperature calibration parameters\n");
 		return ret;
 	}
@@ -246,7 +132,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
 			       buf, BMP280_COMP_PRESS_REG_COUNT);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"failed to read pressure calibration parameters\n");
 		return ret;
 	}
@@ -281,7 +167,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
 			       (u8 *) &tmp, 3);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "failed to read temperature\n");
+		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
 	}
 
@@ -316,7 +202,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
 			       (u8 *) &tmp, 3);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "failed to read pressure\n");
+		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
 	}
 
@@ -507,7 +393,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				 BMP280_MODE_MASK,
 				 osrs | BMP280_MODE_NORMAL);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"failed to write ctrl_meas register\n");
 		return ret;
 	}
@@ -516,7 +402,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				 BMP280_FILTER_MASK,
 				 BMP280_FILTER_4X);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"failed to write config register\n");
 		return ret;
 	}
@@ -527,8 +413,6 @@ static int bmp280_chip_config(struct bmp280_data *data)
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 
 static const struct bmp280_chip_info bmp280_chip_info = {
-	.regmap_config = &bmp280_regmap_config,
-
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 
@@ -540,41 +424,6 @@ static const struct bmp280_chip_info bmp280_chip_info = {
 	.read_press = bmp280_read_press,
 };
 
-static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case BMP280_REG_CTRL_MEAS:
-	case BMP280_REG_RESET:
-		return true;
-	default:
-		return false;
-	};
-}
-
-static bool bmp180_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case BMP180_REG_OUT_XLSB:
-	case BMP180_REG_OUT_LSB:
-	case BMP180_REG_OUT_MSB:
-	case BMP280_REG_CTRL_MEAS:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static const struct regmap_config bmp180_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-
-	.max_register = BMP180_REG_OUT_XLSB,
-	.cache_type = REGCACHE_RBTREE,
-
-	.writeable_reg = bmp180_is_writeable_reg,
-	.volatile_reg = bmp180_is_volatile_reg,
-};
-
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 {
 	int ret;
@@ -690,7 +539,7 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 
 	ret = bmp180_read_calib(data, &calib);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"failed to read calibration coefficients\n");
 		return ret;
 	}
@@ -760,7 +609,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 
 	ret = bmp180_read_calib(data, &calib);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"failed to read calibration coefficients\n");
 		return ret;
 	}
@@ -820,8 +669,6 @@ static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 
 static const struct bmp280_chip_info bmp180_chip_info = {
-	.regmap_config = &bmp180_regmap_config,
-
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
 		ARRAY_SIZE(bmp180_oversampling_temp_avail),
@@ -835,8 +682,10 @@ static const struct bmp280_chip_info bmp180_chip_info = {
 	.read_press = bmp180_read_press,
 };
 
-static int bmp280_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+int bmp280_common_probe(struct device *dev,
+			struct regmap *regmap,
+			unsigned int chip,
+			const char *name)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -844,22 +693,22 @@ static int bmp280_probe(struct i2c_client *client,
 	unsigned int chip_id;
 	struct gpio_desc *gpiod;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	mutex_init(&data->lock);
-	data->client = client;
+	data->dev = dev;
 
-	indio_dev->dev.parent = &client->dev;
-	indio_dev->name = id->name;
+	indio_dev->dev.parent = dev;
+	indio_dev->name = name;
 	indio_dev->channels = bmp280_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmp280_channels);
 	indio_dev->info = &bmp280_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	switch (id->driver_data) {
+	switch (chip) {
 	case BMP180_CHIP_ID:
 		data->chip_info = &bmp180_chip_info;
 		data->oversampling_press = ilog2(8);
@@ -875,40 +724,34 @@ static int bmp280_probe(struct i2c_client *client,
 	}
 
 	/* Optionally bring up regulators */
-	data->vddd = devm_regulator_get_optional(&client->dev, "vddd");
+	data->vddd = devm_regulator_get_optional(dev, "vddd");
 	if (!IS_ERR(data->vddd)) {
 		ret = regulator_enable(data->vddd);
 		if (ret)
-			dev_err(&client->dev, "failed to enable VDDD\n");
+			dev_err(dev, "failed to enable VDDD\n");
 	}
-	data->vdda = devm_regulator_get_optional(&client->dev, "vdda");
+	data->vdda = devm_regulator_get_optional(dev, "vdda");
 	if (!IS_ERR(data->vdda)) {
 		ret = regulator_enable(data->vdda);
 		if (ret)
-			dev_err(&client->dev, "failed to enable VDDA\n");
+			dev_err(dev, "failed to enable VDDA\n");
 	}
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
-	gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
+	gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	/* Deassert the signal */
 	if (!IS_ERR(gpiod)) {
-		dev_info(&client->dev, "release reset\n");
+		dev_info(dev, "release reset\n");
 		gpiod_set_value(gpiod, 0);
 	}
 
-	data->regmap = devm_regmap_init_i2c(client,
-					data->chip_info->regmap_config);
-	if (IS_ERR(data->regmap)) {
-		dev_err(&client->dev, "failed to allocate register map\n");
-		return PTR_ERR(data->regmap);
-	}
-
-	ret = regmap_read(data->regmap, BMP280_REG_ID, &chip_id);
+	data->regmap = regmap;
+	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
 	if (ret < 0)
 		return ret;
-	if (chip_id != id->driver_data) {
-		dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
-			BMP280_CHIP_ID, chip_id);
+	if (chip_id != chip) {
+		dev_err(dev, "bad chip id: expected %x got %x\n",
+			chip, chip_id);
 		return -EINVAL;
 	}
 
@@ -916,47 +759,5 @@ static int bmp280_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
-
-static const struct acpi_device_id bmp280_acpi_match[] = {
-	{"BMP0280", BMP280_CHIP_ID },
-	{"BMP0180", BMP180_CHIP_ID },
-	{"BMP0085", BMP180_CHIP_ID },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
-
-#ifdef CONFIG_OF
-static const struct of_device_id bmp280_of_match[] = {
-	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
-	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
-	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
-};
-MODULE_DEVICE_TABLE(of, bmp280_of_match);
-#else
-#define bmp280_of_match NULL
-#endif
-
-static const struct i2c_device_id bmp280_id[] = {
-	{"bmp280", BMP280_CHIP_ID },
-	{"bmp180", BMP180_CHIP_ID },
-	{"bmp085", BMP180_CHIP_ID },
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, bmp280_id);
-
-static struct i2c_driver bmp280_driver = {
-	.driver = {
-		.name	= "bmp280",
-		.acpi_match_table = ACPI_PTR(bmp280_acpi_match),
-		.of_match_table = of_match_ptr(bmp280_of_match),
-	},
-	.probe		= bmp280_probe,
-	.id_table	= bmp280_id,
-};
-module_i2c_driver(bmp280_driver);
-
-MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
-MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
new file mode 100644
index 000000000000..b422600f34e0
--- /dev/null
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -0,0 +1,78 @@
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include "bmp280.h"
+
+static int bmp280_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	const struct regmap_config *regmap_config;
+
+	switch (id->driver_data) {
+	case BMP180_CHIP_ID:
+		regmap_config = &bmp180_regmap_config;
+		break;
+	case BMP280_CHIP_ID:
+		regmap_config = &bmp280_regmap_config;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap = devm_regmap_init_i2c(client, regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "failed to allocate register map\n");
+		return PTR_ERR(regmap);
+	}
+
+	return bmp280_common_probe(&client->dev,
+				   regmap,
+				   id->driver_data,
+				   id->name);
+}
+
+static const struct acpi_device_id bmp280_acpi_i2c_match[] = {
+	{"BMP0280", BMP280_CHIP_ID },
+	{"BMP0180", BMP180_CHIP_ID },
+	{"BMP0085", BMP180_CHIP_ID },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, bmp280_acpi_i2c_match);
+
+#ifdef CONFIG_OF
+static const struct of_device_id bmp280_of_i2c_match[] = {
+	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
+	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
+	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
+};
+MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
+#else
+#define bmp280_of_i2c_match NULL
+#endif
+
+static const struct i2c_device_id bmp280_i2c_id[] = {
+	{"bmp280", BMP280_CHIP_ID },
+	{"bmp180", BMP180_CHIP_ID },
+	{"bmp085", BMP180_CHIP_ID },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
+
+static struct i2c_driver bmp280_i2c_driver = {
+	.driver = {
+		.name	= "bmp280",
+		.acpi_match_table = ACPI_PTR(bmp280_acpi_i2c_match),
+		.of_match_table = of_match_ptr(bmp280_of_i2c_match),
+	},
+	.probe		= bmp280_i2c_probe,
+	.id_table	= bmp280_i2c_id,
+};
+module_i2c_driver(bmp280_i2c_driver);
+
+MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
+MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
new file mode 100644
index 000000000000..8c04e9a630ce
--- /dev/null
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -0,0 +1,78 @@
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+#include "bmp280.h"
+
+static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP280_REG_CTRL_MEAS:
+	case BMP280_REG_RESET:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool bmp180_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP180_REG_OUT_XLSB:
+	case BMP180_REG_OUT_LSB:
+	case BMP180_REG_OUT_MSB:
+	case BMP280_REG_CTRL_MEAS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct regmap_config bmp180_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BMP180_REG_OUT_XLSB,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = bmp180_is_writeable_reg,
+	.volatile_reg = bmp180_is_volatile_reg,
+};
+
+static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP280_REG_CONFIG:
+	case BMP280_REG_CTRL_MEAS:
+	case BMP280_REG_RESET:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP280_REG_TEMP_XLSB:
+	case BMP280_REG_TEMP_LSB:
+	case BMP280_REG_TEMP_MSB:
+	case BMP280_REG_PRESS_XLSB:
+	case BMP280_REG_PRESS_LSB:
+	case BMP280_REG_PRESS_MSB:
+	case BMP280_REG_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct regmap_config bmp280_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BMP280_REG_TEMP_XLSB,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = bmp280_is_writeable_reg,
+	.volatile_reg = bmp280_is_volatile_reg,
+};
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
new file mode 100644
index 000000000000..9249956bc8bf
--- /dev/null
+++ b/drivers/iio/pressure/bmp280.h
@@ -0,0 +1,85 @@
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+/* BMP280 specific registers */
+#define BMP280_REG_TEMP_XLSB		0xFC
+#define BMP280_REG_TEMP_LSB		0xFB
+#define BMP280_REG_TEMP_MSB		0xFA
+#define BMP280_REG_PRESS_XLSB		0xF9
+#define BMP280_REG_PRESS_LSB		0xF8
+#define BMP280_REG_PRESS_MSB		0xF7
+
+#define BMP280_REG_CONFIG		0xF5
+#define BMP280_REG_STATUS		0xF3
+
+#define BMP280_REG_COMP_TEMP_START	0x88
+#define BMP280_COMP_TEMP_REG_COUNT	6
+
+#define BMP280_REG_COMP_PRESS_START	0x8E
+#define BMP280_COMP_PRESS_REG_COUNT	18
+
+#define BMP280_FILTER_MASK		(BIT(4) | BIT(3) | BIT(2))
+#define BMP280_FILTER_OFF		0
+#define BMP280_FILTER_2X		BIT(2)
+#define BMP280_FILTER_4X		BIT(3)
+#define BMP280_FILTER_8X		(BIT(3) | BIT(2))
+#define BMP280_FILTER_16X		BIT(4)
+
+#define BMP280_OSRS_TEMP_MASK		(BIT(7) | BIT(6) | BIT(5))
+#define BMP280_OSRS_TEMP_SKIP		0
+#define BMP280_OSRS_TEMP_X(osrs_t)	((osrs_t) << 5)
+#define BMP280_OSRS_TEMP_1X		BMP280_OSRS_TEMP_X(1)
+#define BMP280_OSRS_TEMP_2X		BMP280_OSRS_TEMP_X(2)
+#define BMP280_OSRS_TEMP_4X		BMP280_OSRS_TEMP_X(3)
+#define BMP280_OSRS_TEMP_8X		BMP280_OSRS_TEMP_X(4)
+#define BMP280_OSRS_TEMP_16X		BMP280_OSRS_TEMP_X(5)
+
+#define BMP280_OSRS_PRESS_MASK		(BIT(4) | BIT(3) | BIT(2))
+#define BMP280_OSRS_PRESS_SKIP		0
+#define BMP280_OSRS_PRESS_X(osrs_p)	((osrs_p) << 2)
+#define BMP280_OSRS_PRESS_1X		BMP280_OSRS_PRESS_X(1)
+#define BMP280_OSRS_PRESS_2X		BMP280_OSRS_PRESS_X(2)
+#define BMP280_OSRS_PRESS_4X		BMP280_OSRS_PRESS_X(3)
+#define BMP280_OSRS_PRESS_8X		BMP280_OSRS_PRESS_X(4)
+#define BMP280_OSRS_PRESS_16X		BMP280_OSRS_PRESS_X(5)
+
+#define BMP280_MODE_MASK		(BIT(1) | BIT(0))
+#define BMP280_MODE_SLEEP		0
+#define BMP280_MODE_FORCED		BIT(0)
+#define BMP280_MODE_NORMAL		(BIT(1) | BIT(0))
+
+/* BMP180 specific registers */
+#define BMP180_REG_OUT_XLSB		0xF8
+#define BMP180_REG_OUT_LSB		0xF7
+#define BMP180_REG_OUT_MSB		0xF6
+
+#define BMP180_REG_CALIB_START		0xAA
+#define BMP180_REG_CALIB_COUNT		22
+
+#define BMP180_MEAS_SCO			BIT(5)
+#define BMP180_MEAS_TEMP		(0x0E | BMP180_MEAS_SCO)
+#define BMP180_MEAS_PRESS_X(oss)	((oss) << 6 | 0x14 | BMP180_MEAS_SCO)
+#define BMP180_MEAS_PRESS_1X		BMP180_MEAS_PRESS_X(0)
+#define BMP180_MEAS_PRESS_2X		BMP180_MEAS_PRESS_X(1)
+#define BMP180_MEAS_PRESS_4X		BMP180_MEAS_PRESS_X(2)
+#define BMP180_MEAS_PRESS_8X		BMP180_MEAS_PRESS_X(3)
+
+/* BMP180 and BMP280 common registers */
+#define BMP280_REG_CTRL_MEAS		0xF4
+#define BMP280_REG_RESET		0xE0
+#define BMP280_REG_ID			0xD0
+
+#define BMP180_CHIP_ID			0x55
+#define BMP280_CHIP_ID			0x58
+#define BMP280_SOFT_RESET_VAL		0xB6
+
+/* Regmap configurations */
+extern const struct regmap_config bmp180_regmap_config;
+extern const struct regmap_config bmp280_regmap_config;
+
+/* Probe called from different transports */
+int bmp280_common_probe(struct device *dev,
+			struct regmap *regmap,
+			unsigned int chip,
+			const char *name);
-- 
2.4.11

