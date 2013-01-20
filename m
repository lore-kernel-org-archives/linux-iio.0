Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:50590 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATM4Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Jan 2013 07:56:25 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] Make the st_sensors core library stuff build in all combinations.
Date: Sun, 20 Jan 2013 12:56:14 +0000
Message-Id: <1358686575-16779-1-git-send-email-jic23@kernel.org>
In-Reply-To: <50FBE8F8.7010300@kernel.org>
References: <50FBE8F8.7010300@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/iio/common/st_sensors/Kconfig          | 11 ++++++++++-
 drivers/iio/common/st_sensors/Makefile         | 24 ++++++------------------
 drivers/iio/common/st_sensors/st_sensors_i2c.c |  3 ++-
 drivers/iio/common/st_sensors/st_sensors_spi.c |  4 ++--
 include/linux/iio/common/st_i2c.h              |  7 +++++++
 include/linux/iio/common/st_sensors.h          | 14 --------------
 include/linux/iio/common/st_spi.h              |  9 +++++++++
 7 files changed, 36 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/iio/common/st_i2c.h
 create mode 100644 include/linux/iio/common/st_spi.h

diff --git a/drivers/iio/common/st_sensors/Kconfig b/drivers/iio/common/st_sensors/Kconfig
index 0749f5c..58e06eb 100644
--- a/drivers/iio/common/st_sensors/Kconfig
+++ b/drivers/iio/common/st_sensors/Kconfig
@@ -2,5 +2,14 @@
 # Hid Sensor common modules
 #
 
+config IIO_ST_SENSORS_I2C
+       tristate
+
+config IIO_ST_SENSORS_SPI
+       tristate
+
 config IIO_ST_SENSORS_CORE
-	bool
+       tristate
+       select IIO_ST_SENSORS_I2C if I2C
+       select IIO_ST_SENSORS_SPI if SPI_MASTER
+
diff --git a/drivers/iio/common/st_sensors/Makefile b/drivers/iio/common/st_sensors/Makefile
index 8c9a57a..2075ad4 100644
--- a/drivers/iio/common/st_sensors/Makefile
+++ b/drivers/iio/common/st_sensors/Makefile
@@ -1,21 +1,9 @@
 #
 # Makefile for the STMicroelectronics sensor common modules.
 #
-
-ifneq ($(CONFIG_I2C),)
-st_accel_i2c			= st_sensors_i2c.o
-endif
-
-ifneq ($(CONFIG_SPI_MASTER),)
-st_accel_spi			= st_sensors_spi.o
-endif
-
-ifneq ($(CONFIG_IIO_BUFFER),)
-st_sensors_triggered_buffer	= st_sensors_trigger.o st_sensors_buffer.o
-endif
-
-obj-$(CONFIG_IIO_ST_SENSORS_CORE) += 	st_sensors_library.o
-st_sensors_library-y := st_sensors_core.o \
-			$(st_accel_i2c) \
-			$(st_accel_spi) \
-			$(st_sensors_triggered_buffer)
+obj-$(CONFIG_IIO_ST_SENSORS_I2C) += st_sensors_i2c.o
+obj-$(CONFIG_IIO_ST_SENSORS_SPI) += st_sensors_spi.o
+obj-$(CONFIG_IIO_ST_SENSORS_CORE) += st_sensors.o
+st_sensors-y := st_sensors_core.o
+st_sensors-$(CONFIG_IIO_BUFFER) += st_sensors_buffer.o
+st_sensors-$(CONFIG_IIO_TRIGGER) += st_sensors_trigger.o
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index b2d2fdf..43169ce 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -13,12 +13,13 @@
 #include <linux/slab.h>
 #include <linux/iio/iio.h>
 
+#include <linux/iio/common/st_i2c.h>
 #include <linux/iio/common/st_sensors.h>
 
 
 #define ST_SENSORS_I2C_MULTIREAD	0x80
 
-unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev)
+static unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 5030766..f89726f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -12,14 +12,14 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/iio/iio.h>
-
+#include <linux/iio/common/st_spi.h>
 #include <linux/iio/common/st_sensors.h>
 
 
 #define ST_SENSORS_SPI_MULTIREAD	0xc0
 #define ST_SENSORS_SPI_READ		0x80
 
-unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
+static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
diff --git a/include/linux/iio/common/st_i2c.h b/include/linux/iio/common/st_i2c.h
new file mode 100644
index 0000000..c4ff039
--- /dev/null
+++ b/include/linux/iio/common/st_i2c.h
@@ -0,0 +1,7 @@
+
+struct iio_dev;
+struct i2c_client;
+struct st_sensor_data;
+
+void st_sensors_i2c_configure(struct iio_dev *indio_dev,
+		struct i2c_client *client, struct st_sensor_data *sdata);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index a8a0c40..f27b1e0 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -215,20 +215,6 @@ struct st_sensors {
 	unsigned int bootime;
 };
 
-#ifdef CONFIG_SPI_MASTER
-void st_sensors_spi_configure(struct iio_dev *indio_dev,
-			struct spi_device *spi, struct st_sensor_data *sdata);
-
-unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev);
-#endif
-
-#ifdef CONFIG_I2C
-void st_sensors_i2c_configure(struct iio_dev *indio_dev,
-		struct i2c_client *client, struct st_sensor_data *sdata);
-
-unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev);
-#endif
-
 #ifdef CONFIG_IIO_BUFFER
 int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 					struct iio_trigger_ops *trigger_ops);
diff --git a/include/linux/iio/common/st_spi.h b/include/linux/iio/common/st_spi.h
new file mode 100644
index 0000000..d1dddc6
--- /dev/null
+++ b/include/linux/iio/common/st_spi.h
@@ -0,0 +1,9 @@
+
+
+struct iio_dev;
+struct st_sensor_data;
+struct spi_device;
+
+void st_sensors_spi_configure(struct iio_dev *indio_dev,
+			struct spi_device *spi, struct st_sensor_data *sdata);
+
-- 
1.8.1

