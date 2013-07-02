Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:31978 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab3GBMQP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 08:16:15 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MPB006AC60P0J10@mailout1.w1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 02 Jul 2013 13:16:13 +0100 (BST)
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@kernel.org, denis.ciocca@st.com
Cc: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Lukasz Czerwinski <l.czerwinski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 1/4] iio: st_sensors:  Add DT bindings for st_accel and st_gyro
Date: Tue, 02 Jul 2013 14:15:35 +0200
Message-id: <1372767338-13179-2-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
References: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds DT support for the STM accelometers and gyroscopes.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../bindings/iio/accelerometer/st_accel.txt        |   53 ++++++++++++++++++++
 .../devicetree/bindings/iio/gyroscope/st_gyro.txt  |   51 +++++++++++++++++++
 drivers/iio/accel/st_accel.h                       |   19 ++++---
 drivers/iio/accel/st_accel_core.c                  |   10 ++--
 drivers/iio/accel/st_accel_i2c.c                   |   19 ++++++-
 drivers/iio/accel/st_accel_spi.c                   |   19 ++++++-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    7 +--
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |   48 ++++++++++++++++--
 drivers/iio/common/st_sensors/st_sensors_spi.c     |   48 ++++++++++++++++--
 drivers/iio/gyro/st_gyro.h                         |   15 +++---
 drivers/iio/gyro/st_gyro_core.c                    |    8 +--
 drivers/iio/gyro/st_gyro_i2c.c                     |   18 ++++++-
 drivers/iio/gyro/st_gyro_spi.c                     |   18 ++++++-
 drivers/iio/magnetometer/st_magn.h                 |    3 +-
 drivers/iio/magnetometer/st_magn_core.c            |    5 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |    2 +-
 drivers/iio/magnetometer/st_magn_spi.c             |    2 +-
 drivers/iio/pressure/st_pressure.h                 |    3 +-
 drivers/iio/pressure/st_pressure_core.c            |   12 ++---
 drivers/iio/pressure/st_pressure_i2c.c             |    2 +-
 drivers/iio/pressure/st_pressure_spi.c             |    2 +-
 include/linux/iio/common/st_sensors.h              |    9 +++-
 include/linux/platform_data/st_sensors_pdata.h     |    2 +
 23 files changed, 312 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/st_gyro.txt

diff --git a/Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt b/Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt
new file mode 100644
index 0000000..9eab7d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt
@@ -0,0 +1,53 @@
+STMicroelectronics 3D  accelerometer
+
+Required properties:
+
+  - compatible : should be one from
+	"st,lsm330dlhc-accel"
+	"st,lis3dh"
+	"st,lsm330d-accel"
+	"st,lsm330dl-accel"
+	"st,lsm330dlc-accel"
+	"st,lsm331dlh"
+	"st,lsm303dl-accel"
+	"st,lsm303dlh-accel"
+	"st,lsm303dlm-accel"
+	"st,lsm330-accel"
+
+  - reg : the I2C address of the accelerometer
+
+Optional properties:
+  - drdy-int-pin: default DRDY interrupt pin number (u8)
+  - interrupt-parent : phandle to the interrupt map subnode
+  - interrupts : interrupt mapping for st_accel interrupt sources:
+	0: INT1 irq_data_ready
+  - irq-map : irq sub-node defining interrupt map
+              (all properties listed below are required):
+      - #interrupt-cells : should be 1
+      - #address-cells : should be 0
+      - #size-cells : should be 0
+      - interrupt-map : table of entries consisting of three child elements:
+          - unit_interrupt_specifier - 0 : INT1, 1 : INT2
+          - interrupt parent phandle
+          - parent unit interrupt specifier consisiting of two elements:
+              - index of the interrupt within the controller
+              - flags : should be 0
+
+Example:
+
+lsm330dlc_accel@19 {
+	compatible = "st,lsm330dlc-accel";
+	reg = <0x19>;
+	drdy-int-pin = /bits/ 8 <1>;
+	interrupt-parent = <&lsm330dlc_accel_map>;
+	interrupts= <0>, <1>;
+
+	lsm330dlc_accel_map: lsm330dlc-accel-map {
+		compatible = "samsung,lsm330dlc-accel-map";
+		#interrupt-cells = <1>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		interrupt-map = <1 &gpx0 0 0>;
+	};
+};
+
diff --git a/Documentation/devicetree/bindings/iio/gyroscope/st_gyro.txt b/Documentation/devicetree/bindings/iio/gyroscope/st_gyro.txt
new file mode 100644
index 0000000..f4bf233
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/st_gyro.txt
@@ -0,0 +1,51 @@
+STMicroelectronics 3D  gyroscope
+
+Required properties:
+
+  - compatible : should be one from
+	"st,l3g4200d"
+	"st,lsm330d-gyro"
+	"st,lsm330dl-gyro"
+	"st,lsm330dlc-gyro"
+	"st,l3gd20"
+	"st,l3gd20h"
+	"st,l3g4is-ui"
+	"st,lsm330-gyro"
+
+  - reg : the I2C address of the gyroscope
+
+Optional properties:
+
+  - drdy-int-pin: default DRDY interrupt pin number (u8)
+  - interrupt-parent : phandle to the interrupt map subnode
+  - interrupts : interrupt mapping for st_accel interrupt sources:
+	0: INT1 irq_data_ready
+  - irq-map : irq sub-node defining interrupt map
+              (all properties listed below are required):
+      - #interrupt-cells : should be 1
+      - #address-cells : should be 0
+      - #size-cells : should be 0
+      - interrupt-map : table of entries consisting of three child elements:
+          - unit_interrupt_specifier - 0 : INT1, 1 : INT2
+          - interrupt parent phandle
+          - parent unit interrupt specifier consisiting of two elements:
+              - index of the interrupt within the controller
+              - flags : should be 0
+
+Example:
+
+lsm330dlc_gyro@6b {
+	compatible = "st,lsm330dlc-gyro";
+	reg = <0x6b>;
+	drdy-int-pin = /bits/ 8 <1>;
+	interrupt-parent = <&lsm330dlc_gyro_map>;
+	interrupts= <0> , <1>;
+
+	lsm330dlc_gyro_map: lsm330dlc-gyro-map {
+		compatible = "samsung,lsm330dlc-gyro-map";
+		#interrupt-cells = <1>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		interrupt-map = <0 &gpf0 3 0>;
+	};
+};
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index c387763..08a0eb7 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -14,16 +14,16 @@
 #include <linux/types.h>
 #include <linux/iio/common/st_sensors.h>
 
-#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
+#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc-accel"
 #define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
-#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
-#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
-#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
+#define LSM330D_ACCEL_DEV_NAME		"lsm330d-accel"
+#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl-accel"
+#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc-accel"
 #define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
-#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
-#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
-#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
-#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
+#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl-accel"
+#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh-accel"
+#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm-accel"
+#define LSM330_ACCEL_DEV_NAME		"lsm330-accel"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
@@ -33,8 +33,7 @@ static const struct st_sensors_platform_data default_accel_pdata = {
 	.drdy_int_pin = 1,
 };
 
-int st_accel_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_accel_common_probe(struct iio_dev *indio_dev);
 void st_accel_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index aef3c9b..385cd86 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -449,8 +449,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 #define ST_ACCEL_TRIGGER_OPS NULL
 #endif
 
-int st_accel_common_probe(struct iio_dev *indio_dev,
-				struct st_sensors_platform_data *plat_data)
+int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	int err;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
@@ -472,11 +471,10 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
 						&adata->sensor->fs.fs_avl[0];
 	adata->odr = adata->sensor->odr.odr_avl[0].hz;
 
-	if (!plat_data)
-		plat_data =
-			(struct st_sensors_platform_data *)&default_accel_pdata;
+	if (!adata->dev->platform_data && !adata->dev->of_node)
+		adata->drdy_int_pin = default_accel_pdata.drdy_int_pin;
 
-	err = st_sensors_init_sensor(indio_dev, plat_data);
+	err = st_sensors_init_sensor(indio_dev);
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 58d164d..63992f2 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -36,7 +36,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
-	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
+	err = st_accel_common_probe(indio_dev);
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
@@ -70,10 +70,27 @@ static const struct i2c_device_id st_accel_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_accel_dt_match[] = {
+	{ .compatible = "st,lsm330dlhc_accel" },
+	{ .compatible = "st,lis3dh" },
+	{ .compatible = "st,lsm330d-accel" },
+	{ .compatible = "st,lsm330dl-accel" },
+	{ .compatible = "st,lsm330dlc-accel" },
+	{ .compatible = "st,lsm331dlh" },
+	{ .compatible = "st,lsm303dl-accel" },
+	{ .compatible = "st,lsm303dlh-accel" },
+	{ .compatible = "st,lsm303dlm-accel" },
+	{ .compatible = "st,lsm330-accel" },
+	{ }
+};
+#endif
+
 static struct i2c_driver st_accel_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-accel-i2c",
+		.of_match_table = of_match_ptr(st_accel_dt_match),
 	},
 	.probe = st_accel_i2c_probe,
 	.remove = st_accel_i2c_remove,
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 21ed929..671fd48 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -35,7 +35,7 @@ static int st_accel_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, adata);
 
-	err = st_accel_common_probe(indio_dev, spi->dev.platform_data);
+	err = st_accel_common_probe(indio_dev);
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
@@ -69,10 +69,27 @@ static const struct spi_device_id st_accel_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_accel_dt_match[] = {
+	{ .compatible = "st,lsm330dlhc-accel" },
+	{ .compatible = "st,lis3dh" },
+	{ .compatible = "st,lsm330d-accel" },
+	{ .compatible = "st,lsm330dl-accel" },
+	{ .compatible = "st,lsm330dlc-accel" },
+	{ .compatible = "st,lsm331dlh" },
+	{ .compatible = "st,lsm303dl-accel" },
+	{ .compatible = "st,lsm303dlh-accel" },
+	{ .compatible = "st,lsm303dlm-accel" },
+	{ .compatible = "st,lsm330-accel" },
+	{ }
+};
+#endif
+
 static struct spi_driver st_accel_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-accel-spi",
+		.of_match_table = of_match_ptr(st_accel_dt_match),
 	},
 	.probe = st_accel_spi_probe,
 	.remove = st_accel_spi_remove,
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 965ee22..461eaf2 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -198,15 +198,14 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 }
 EXPORT_SYMBOL(st_sensors_set_axis_enable);
 
-int st_sensors_init_sensor(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata)
+int st_sensors_init_sensor(struct iio_dev *indio_dev)
 {
 	int err;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	mutex_init(&sdata->tb.buf_lock);
 
-	switch (pdata->drdy_int_pin) {
+	switch (sdata->drdy_int_pin) {
 	case 1:
 		if (sdata->sensor->drdy_irq.mask_int1 == 0) {
 			dev_err(&indio_dev->dev,
@@ -214,7 +213,6 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 			err = -EINVAL;
 			goto init_error;
 		}
-		sdata->drdy_int_pin = 1;
 		break;
 	case 2:
 		if (sdata->sensor->drdy_irq.mask_int2 == 0) {
@@ -223,7 +221,6 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 			err = -EINVAL;
 			goto init_error;
 		}
-		sdata->drdy_int_pin = 2;
 		break;
 	default:
 		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 38af944..cad5acc 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -8,6 +8,8 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -18,11 +20,48 @@
 
 #define ST_SENSORS_I2C_MULTIREAD	0x80
 
-static unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev)
+static unsigned int st_sensors_i2c_get_data_rdy_irq(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	return to_i2c_client(sdata->dev)->irq;
+	return sdata->irq_map[ST_SENSORS_INT1];
+}
+
+static void st_sensors_parse_platform_data(struct i2c_client *client,
+		struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device_node *np = client->dev.of_node;
+	struct st_sensors_platform_data *pdata = client->dev.platform_data;
+
+	if (pdata)
+		sdata->drdy_int_pin = pdata->drdy_int_pin;
+	else if (np)
+		of_property_read_u8(np, "drdy-int-pin",
+			(u8 *)&sdata->drdy_int_pin);
+}
+
+static unsigned int st_sensors_i2c_map_irq(struct i2c_client *client,
+		unsigned int irq_pos)
+{
+	struct device_node *np = client->dev.of_node;
+	struct st_sensors_platform_data *pdata = client->dev.platform_data;
+
+	if (pdata)
+		return pdata->irqs[irq_pos];
+	else if (np)
+		return irq_of_parse_and_map(np, irq_pos);
+
+	return 0;
+}
+
+static void st_sensors_i2c_map_irqs(struct i2c_client *client,
+		struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+
+	sdata->irq_map[ST_SENSORS_INT1] =
+		st_sensors_i2c_map_irq(client, ST_SENSORS_INT1);
 }
 
 static int st_sensors_i2c_read_byte(struct st_sensor_transfer_buffer *tb,
@@ -71,8 +110,11 @@ void st_sensors_i2c_configure(struct iio_dev *indio_dev,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = client->name;
 
+	st_sensors_parse_platform_data(client, indio_dev);
+
 	sdata->tf = &st_sensors_tf_i2c;
-	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
+	st_sensors_i2c_map_irqs(client, indio_dev);
+	sdata->get_irq_data_ready = st_sensors_i2c_get_data_rdy_irq;
 }
 EXPORT_SYMBOL(st_sensors_i2c_configure);
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 251baf6..5531bd4 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -8,6 +8,8 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -19,11 +21,48 @@
 #define ST_SENSORS_SPI_MULTIREAD	0xc0
 #define ST_SENSORS_SPI_READ		0x80
 
-static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
+static unsigned int st_sensors_spi_get_data_rdy_irq(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	return to_spi_device(sdata->dev)->irq;
+	return sdata->irq_map[ST_SENSORS_INT1];
+}
+
+static void st_sensors_parse_platform_data(struct spi_device *spi,
+		struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device_node *np = spi->dev.of_node;
+	struct st_sensors_platform_data *pdata = spi->dev.platform_data;
+
+	if (pdata)
+		sdata->drdy_int_pin = pdata->drdy_int_pin;
+	else if (np)
+		of_property_read_u8(np, "drdy-int-pin",
+			(u8 *)&sdata->drdy_int_pin);
+}
+
+static unsigned int st_sensors_spi_map_irq(struct spi_device *spi,
+		unsigned int irq_pos)
+{
+	struct device_node *np = spi->dev.of_node;
+	struct st_sensors_platform_data *pdata = spi->dev.platform_data;
+
+	if (pdata)
+		return pdata->irqs[irq_pos];
+	else if (np)
+		return irq_of_parse_and_map(np, irq_pos);
+
+	return 0;
+}
+
+static void st_sensors_spi_map_irqs(struct spi_device *spi,
+		struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+
+	sdata->irq_map[ST_SENSORS_INT1] =
+		st_sensors_spi_map_irq(spi, ST_SENSORS_INT1);
 }
 
 static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
@@ -111,8 +150,11 @@ void st_sensors_spi_configure(struct iio_dev *indio_dev,
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi->modalias;
 
+	st_sensors_parse_platform_data(spi, indio_dev);
+
 	sdata->tf = &st_sensors_tf_spi;
-	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
+	st_sensors_spi_map_irqs(spi, indio_dev);
+	sdata->get_irq_data_ready = st_sensors_spi_get_data_rdy_irq;
 }
 EXPORT_SYMBOL(st_sensors_spi_configure);
 
diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index f8f2bf8..81e5ec3 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -15,24 +15,23 @@
 #include <linux/iio/common/st_sensors.h>
 
 #define L3G4200D_GYRO_DEV_NAME		"l3g4200d"
-#define LSM330D_GYRO_DEV_NAME		"lsm330d_gyro"
-#define LSM330DL_GYRO_DEV_NAME		"lsm330dl_gyro"
-#define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc_gyro"
+#define LSM330D_GYRO_DEV_NAME		"lsm330d-gyro"
+#define LSM330DL_GYRO_DEV_NAME		"lsm330dl-gyro"
+#define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc-gyro"
 #define L3GD20_GYRO_DEV_NAME		"l3gd20"
 #define L3GD20H_GYRO_DEV_NAME		"l3gd20h"
-#define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
-#define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
+#define L3G4IS_GYRO_DEV_NAME		"l3g4is-ui"
+#define LSM330_GYRO_DEV_NAME		"lsm330-gyro"
 
 /**
  * struct st_sensors_platform_data - gyro platform data
  * @drdy_int_pin: DRDY on gyros is available only on INT2 pin.
  */
-static const struct st_sensors_platform_data gyro_pdata = {
+static const struct st_sensors_platform_data default_gyro_pdata = {
 	.drdy_int_pin = 2,
 };
 
-int st_gyro_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_gyro_common_probe(struct iio_dev *indio_dev);
 void st_gyro_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 85fa8d3..e86684c 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -302,8 +302,7 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
 #define ST_GYRO_TRIGGER_OPS NULL
 #endif
 
-int st_gyro_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata)
+int st_gyro_common_probe(struct iio_dev *indio_dev)
 {
 	int err;
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
@@ -325,7 +324,10 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
 						&gdata->sensor->fs.fs_avl[0];
 	gdata->odr = gdata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev, pdata);
+	if (!gdata->dev->platform_data && !gdata->dev->of_node)
+		gdata->drdy_int_pin = default_gyro_pdata.drdy_int_pin;
+
+	err = st_sensors_init_sensor(indio_dev);
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index c7a29a4..413062e 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -36,8 +36,8 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
 
-	err = st_gyro_common_probe(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	err = st_gyro_common_probe(indio_dev);
+
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
@@ -69,10 +69,24 @@ static const struct i2c_device_id st_gyro_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_gyro_dt_match[] = {
+	{ .compatible = "st,l3g4200d" },
+	{ .compatible = "st,lsm330d-gyro" },
+	{ .compatible = "st,lsm330dl-gyro" },
+	{ .compatible = "st,lsm330dlc-gyro" },
+	{ .compatible = "st,l3gd20" },
+	{ .compatible = "st,l3gd20h" },
+	{ .compatible = "st,l3g4is-ui" },
+	{ .compatible = "st,lsm330-gyro" },
+};
+#endif
+
 static struct i2c_driver st_gyro_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-gyro-i2c",
+		.of_match_table = of_match_ptr(st_gyro_dt_match),
 	},
 	.probe = st_gyro_i2c_probe,
 	.remove = st_gyro_i2c_remove,
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 14b0762..4956dcc 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -35,8 +35,8 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
-	err = st_gyro_common_probe(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	err = st_gyro_common_probe(indio_dev);
+
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
@@ -68,10 +68,24 @@ static const struct spi_device_id st_gyro_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_gyro_dt_match[] = {
+	{ .compatible = "st,l3g4200d" },
+	{ .compatible = "st,lsm330d-gyro" },
+	{ .compatible = "st,lsm330dl-gyro" },
+	{ .compatible = "st,lsm330dlc-gyro" },
+	{ .compatible = "st,l3gd20" },
+	{ .compatible = "st,l3gd20h" },
+	{ .compatible = "st,l3g4is-ui" },
+	{ .compatible = "st,lsm330-gyro" },
+};
+#endif
+
 static struct spi_driver st_gyro_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-gyro-spi",
+		.of_match_table = of_match_ptr(st_gyro_dt_match),
 	},
 	.probe = st_gyro_spi_probe,
 	.remove = st_gyro_spi_remove,
diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 694e33e..7e81d00 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -18,8 +18,7 @@
 #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
 #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
 
-int st_magn_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_magn_common_probe(struct iio_dev *indio_dev);
 void st_magn_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 7cd784f..ebfe8f1 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -345,8 +345,7 @@ static const struct iio_info magn_info = {
 	.write_raw = &st_magn_write_raw,
 };
 
-int st_magn_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata)
+int st_magn_common_probe(struct iio_dev *indio_dev)
 {
 	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
@@ -368,7 +367,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 						&mdata->sensor->fs.fs_avl[0];
 	mdata->odr = mdata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev, pdata);
+	err = st_sensors_init_sensor(indio_dev);
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 1bed117..e6adc4a 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -36,7 +36,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, mdata);
 
-	err = st_magn_common_probe(indio_dev, NULL);
+	err = st_magn_common_probe(indio_dev);
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index a2333a1..51adb79 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -35,7 +35,7 @@ static int st_magn_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, mdata);
 
-	err = st_magn_common_probe(indio_dev, NULL);
+	err = st_magn_common_probe(indio_dev);
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index b0b6306..8a8a900 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -24,8 +24,7 @@ static const struct st_sensors_platform_data default_press_pdata = {
 	.drdy_int_pin = 1,
 };
 
-int st_press_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_press_common_probe(struct iio_dev *indio_dev);
 void st_press_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index b8ecc87..aacea2a 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -202,8 +202,7 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
 #define ST_PRESS_TRIGGER_OPS NULL
 #endif
 
-int st_press_common_probe(struct iio_dev *indio_dev,
-				struct st_sensors_platform_data *plat_data)
+int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	int err;
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
@@ -219,17 +218,18 @@ int st_press_common_probe(struct iio_dev *indio_dev,
 	pdata->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
 	pdata->multiread_bit = pdata->sensor->multi_read_bit;
 	indio_dev->channels = pdata->sensor->ch;
+
 	indio_dev->num_channels = ARRAY_SIZE(st_press_channels);
 
 	pdata->current_fullscale = (struct st_sensor_fullscale_avl *)
 						&pdata->sensor->fs.fs_avl[0];
 	pdata->odr = pdata->sensor->odr.odr_avl[0].hz;
 
-	if (!plat_data)
-		plat_data =
-			(struct st_sensors_platform_data *)&default_press_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, plat_data);
+	if (!pdata->dev->platform_data && !pdata->dev->of_node)
+		pdata->drdy_int_pin = default_press_pdata.drdy_int_pin;
+
+	err = st_sensors_init_sensor(indio_dev);
 	if (err < 0)
 		goto st_press_common_probe_error;
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 3065993..7cebcc7 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -36,7 +36,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, pdata);
 
-	err = st_press_common_probe(indio_dev, client->dev.platform_data);
+	err = st_press_common_probe(indio_dev);
 	if (err < 0)
 		goto st_press_common_probe_error;
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index b2aded6..17a1490 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -35,7 +35,7 @@ static int st_press_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, pdata);
 
-	err = st_press_common_probe(indio_dev, spi->dev.platform_data);
+	err = st_press_common_probe(indio_dev);
 	if (err < 0)
 		goto st_press_common_probe_error;
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index e51f654..07e27e4 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -40,6 +40,10 @@
 #define ST_SENSORS_MAX_NAME			17
 #define ST_SENSORS_MAX_4WAI			7
 
+#define ST_SENSORS_INT_MAX			2
+#define ST_SENSORS_INT1				0
+#define ST_SENSORS_INT2				1
+
 #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
 					ch2, s, endian, rbits, sbits, addr) \
 { \
@@ -205,6 +209,7 @@ struct st_sensors {
  * @buffer_data: Data used by buffer part.
  * @odr: Output data rate of the sensor [Hz].
  * num_data_channels: Number of data channels used in buffer.
+ * @irq_map: Container of mapped IRQs.
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
  * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
  * @tf: Transfer function structure used by I/O operations.
@@ -223,6 +228,7 @@ struct st_sensor_data {
 
 	unsigned int odr;
 	unsigned int num_data_channels;
+	unsigned int irq_map[ST_SENSORS_INT_MAX];
 
 	u8 drdy_int_pin;
 
@@ -256,8 +262,7 @@ static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
 }
 #endif
 
-int st_sensors_init_sensor(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_sensors_init_sensor(struct iio_dev *indio_dev);
 
 int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable);
 
diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
index 7538391..991db72 100644
--- a/include/linux/platform_data/st_sensors_pdata.h
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -19,6 +19,8 @@
  */
 struct st_sensors_platform_data {
 	u8 drdy_int_pin;
+
+	unsigned int irqs[2];
 };
 
 #endif /* ST_SENSORS_PDATA_H */
-- 
1.7.9.5

