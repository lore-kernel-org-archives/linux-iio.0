Return-Path: <SRS0=7Pcc=YT=linaro.org=linus.walleij@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH] iio: accel: st_accel: handle deprecated bindings
Date: Thu,  5 Jan 2017 14:32:33 +0100
Message-Id: <20170105133233.24237-1-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The earlier deployed LIS3LV02DL driver had already defined a few
DT bindings that need to be supported by the new more generic
driver and listed as compatible but deprecated bindings in the
documentation.

After this we can start to activate the new driver with the old
systems where applicable.

As part of this enablement: make us depend on the old drivers
not being in use so we don't get a kernel with two competing
drivers.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/iio/accel/lis302.txt | 2 +-
 Documentation/devicetree/bindings/iio/st-sensors.txt   | 2 ++
 drivers/iio/accel/Kconfig                              | 2 ++
 drivers/iio/accel/st_accel_i2c.c                       | 5 +++++
 drivers/iio/accel/st_accel_spi.c                       | 9 +++++++++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/lis302.txt b/Documentation/devicetree/bindings/iio/accel/lis302.txt
index 2a19bff9693f..dfdce67826ba 100644
--- a/Documentation/devicetree/bindings/iio/accel/lis302.txt
+++ b/Documentation/devicetree/bindings/iio/accel/lis302.txt
@@ -5,7 +5,7 @@ that apply in on the generic device (independent from the bus).
 
 
 Required properties for the SPI bindings:
- - compatible: 		should be set to "st,lis3lv02d_spi"
+ - compatible: 		should be set to "st,lis3lv02d-spi"
  - reg:			the chipselect index
  - spi-max-frequency:	maximal bus speed, should be set to 1000000 unless
 			constrained by external circuitry
diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index c040c9ad1889..eaa8fbba34e2 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -27,6 +27,8 @@ standard bindings from pinctrl/pinctrl-bindings.txt.
 Valid compatible strings:
 
 Accelerometers:
+- st,lis3lv02d (deprecated, use st,lis3lv02dl-accel)
+- st,lis302dl-spi (deprecated, use st,lis3lv02dl-accel)
 - st,lis3lv02dl-accel
 - st,lsm303dlh-accel
 - st,lsm303dlhc-accel
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index c68bdb649005..ea295fe0f561 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -140,11 +140,13 @@ config IIO_ST_ACCEL_3AXIS
 
 config IIO_ST_ACCEL_I2C_3AXIS
 	tristate
+	depends on !SENSORS_LIS3_I2C
 	depends on IIO_ST_ACCEL_3AXIS
 	depends on IIO_ST_SENSORS_I2C
 
 config IIO_ST_ACCEL_SPI_3AXIS
 	tristate
+	depends on !SENSORS_LIS3_SPI
 	depends on IIO_ST_ACCEL_3AXIS
 	depends on IIO_ST_SENSORS_SPI
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index c0f8867aa1ea..99a7cdbe3d5d 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -21,6 +21,11 @@
 #ifdef CONFIG_OF
 static const struct of_device_id st_accel_of_match[] = {
 	{
+		/* An older compatible */
+		.compatible = "st,lis3lv02d",
+		.data = LIS3LV02DL_ACCEL_DEV_NAME,
+	},
+	{
 		.compatible = "st,lis3lv02dl-accel",
 		.data = LIS3LV02DL_ACCEL_DEV_NAME,
 	},
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index c25ac50d4600..29a15f27a51b 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -65,9 +65,18 @@ static const struct spi_device_id st_accel_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
 
+#ifdef CONFIG_OF
+static const struct of_device_id lis302dl_spi_dt_ids[] = {
+	{ .compatible = "st,lis302dl-spi" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lis302dl_spi_dt_ids);
+#endif
+
 static struct spi_driver st_accel_driver = {
 	.driver = {
 		.name = "st-accel-spi",
+		.of_match_table = of_match_ptr(lis302dl_spi_dt_ids),
 	},
 	.probe = st_accel_spi_probe,
 	.remove = st_accel_spi_remove,
-- 
2.9.3
