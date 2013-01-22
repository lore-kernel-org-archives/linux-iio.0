Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/10] iio:accel:st_accel move the header from include/iio/common to .
Date: Tue, 22 Jan 2013 16:16:31 +0000
Message-Id: <1358871399-11216-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1358871399-11216-1-git-send-email-jic23@kernel.org>
References: <50FEBB20.7070407@kernel.org>
 <1358871399-11216-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I can't see why this header would want to be globaly visible.
---
 drivers/iio/accel/st_accel.h        | 52 +++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_buffer.c |  3 +--
 drivers/iio/accel/st_accel_core.c   |  3 +--
 drivers/iio/accel/st_accel_i2c.c    |  2 +-
 drivers/iio/accel/st_accel_spi.c    |  2 +-
 include/linux/iio/accel/st_accel.h  | 52 -------------------------------------
 6 files changed, 56 insertions(+), 58 deletions(-)
 create mode 100644 drivers/iio/accel/st_accel.h
 delete mode 100644 include/linux/iio/accel/st_accel.h

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
new file mode 100644
index 0000000..847b1ea
--- /dev/null
+++ b/drivers/iio/accel/st_accel.h
@@ -0,0 +1,52 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012-2013 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_ACCEL_H
+#define ST_ACCEL_H
+
+#include <linux/types.h>
+#include <linux/iio/common/st_sensors.h>
+
+#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
+#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
+#define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
+#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
+#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
+#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
+#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
+#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
+#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
+#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
+
+int st_accel_common_probe(struct iio_dev *indio_dev);
+void st_accel_common_remove(struct iio_dev *indio_dev);
+int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool state);
+int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit);
+int st_accel_set_enable(struct iio_dev *indio_dev, bool enable);
+
+#ifdef CONFIG_IIO_BUFFER
+int st_accel_allocate_ring(struct iio_dev *indio_dev);
+void st_accel_deallocate_ring(struct iio_dev *indio_dev);
+int st_accel_trig_set_state(struct iio_trigger *trig, bool state);
+#else /* CONFIG_IIO_BUFFER */
+static inline int st_accel_allocate_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void st_accel_deallocate_ring(struct iio_dev *indio_dev)
+{
+}
+static inline int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	return 0;
+}
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* ST_ACCEL_H */
diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index ac90903..4c76787 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -21,9 +21,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/iio/accel/st_accel.h>
 #include <linux/iio/common/st_sensors.h>
-
+#include "st_accel.h"
 
 int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
 {
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 4c32a4d..7af2f8e 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -23,9 +23,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 
-#include <linux/iio/accel/st_accel.h>
 #include <linux/iio/common/st_sensors.h>
-
+#include "st_accel.h"
 
 /* DEFAULT VALUE FOR SENSORS */
 #define ST_ACCEL_DEFAULT_OUT_X_L_ADDR		0x28
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index f225a42..90b8ddf 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -15,9 +15,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-#include <linux/iio/accel/st_accel.h>
 #include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
+#include "st_accel.h"
 
 static int st_accel_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 57e661f..dbd45c0 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -15,9 +15,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-#include <linux/iio/accel/st_accel.h>
 #include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_spi.h>
+#include "st_accel.h"
 
 static int st_accel_spi_probe(struct spi_device *spi)
 {
diff --git a/include/linux/iio/accel/st_accel.h b/include/linux/iio/accel/st_accel.h
deleted file mode 100644
index 847b1ea..0000000
--- a/include/linux/iio/accel/st_accel.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * STMicroelectronics accelerometers driver
- *
- * Copyright 2012-2013 STMicroelectronics Inc.
- *
- * Denis Ciocca <denis.ciocca@st.com>
- * v. 1.0.0
- * Licensed under the GPL-2.
- */
-
-#ifndef ST_ACCEL_H
-#define ST_ACCEL_H
-
-#include <linux/types.h>
-#include <linux/iio/common/st_sensors.h>
-
-#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
-#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
-#define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
-#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
-#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
-#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
-#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
-#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
-#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
-#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
-
-int st_accel_common_probe(struct iio_dev *indio_dev);
-void st_accel_common_remove(struct iio_dev *indio_dev);
-int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool state);
-int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit);
-int st_accel_set_enable(struct iio_dev *indio_dev, bool enable);
-
-#ifdef CONFIG_IIO_BUFFER
-int st_accel_allocate_ring(struct iio_dev *indio_dev);
-void st_accel_deallocate_ring(struct iio_dev *indio_dev);
-int st_accel_trig_set_state(struct iio_trigger *trig, bool state);
-#else /* CONFIG_IIO_BUFFER */
-static inline int st_accel_allocate_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-static inline void st_accel_deallocate_ring(struct iio_dev *indio_dev)
-{
-}
-static inline int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
-{
-	return 0;
-}
-#endif /* CONFIG_IIO_BUFFER */
-
-#endif /* ST_ACCEL_H */
-- 
1.8.1.1
