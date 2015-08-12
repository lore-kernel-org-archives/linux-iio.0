Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 6/6] iio: bmg160: Add SPI driver
Date: Wed, 12 Aug 2015 16:50:09 +0200
Message-Id: <1439391009-6051-7-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
References: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/gyro/Kconfig      | 11 +++++++++
 drivers/iio/gyro/Makefile     |  1 +
 drivers/iio/gyro/bmg160_spi.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 drivers/iio/gyro/bmg160_spi.c

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 13f8e0051615..a77dbb0062fe 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -71,6 +71,17 @@ config BMG160_I2C
 	  This driver can also be built as a module.  If so, the module
 	  will be called bmg160_i2c.
 
+config BMG160_SPI
+	tristate "Driver for connection via SPI"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
+	  driver connected via SPI. This driver also supports BMI055 gyroscope.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called bmg160_spi.
+
 endif
 
 config HID_SENSOR_GYRO_3D
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 73b41e43a974..848e55c605c0 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16136) += adis16136.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
 obj-$(CONFIG_BMG160_I2C) += bmg160_core.o bmg160_i2c.o
+obj-$(CONFIG_BMG160_I2C) += bmg160_core.o bmg160_spi.o
 
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
 
diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
new file mode 100644
index 000000000000..8a358571b702
--- /dev/null
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -0,0 +1,57 @@
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+
+#include <bmg160.h>
+
+static const struct regmap_config bmg160_regmap_spi_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x3f,
+};
+
+static int bmg160_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	regmap = devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return bmg160_core_probe(&spi->dev, regmap, spi->irq, id->name);
+}
+
+static int bmg160_spi_remove(struct spi_device *spi)
+{
+	bmg160_core_remove(&spi->dev);
+
+	return 0;
+}
+
+static const struct spi_device_id bmg160_spi_id[] = {
+	{"bmg160", 0},
+	{"bmi055_gyro", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
+
+static struct spi_driver bmg160_spi_driver = {
+	.driver = {
+		.name	= "bmg160_spi",
+		.pm	= &bmg160_pm_ops,
+	},
+	.probe		= bmg160_spi_probe,
+	.remove		= bmg160_spi_remove,
+	.id_table	= bmg160_spi_id,
+};
+module_spi_driver(bmg160_spi_driver);
+
+MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BMG160 SPI Gyro driver");
-- 
2.4.6
