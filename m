Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42624 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934Ab3AVQQq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 11:16:46 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 03/10] iio:gyro:st_gyro move header from linux/iio/gyro to .
Date: Tue, 22 Jan 2013 16:16:32 +0000
Message-Id: <1358871399-11216-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1358871399-11216-1-git-send-email-jic23@kernel.org>
References: <50FEBB20.7070407@kernel.org>
 <1358871399-11216-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/iio/gyro/st_gyro.h        | 50 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/gyro/st_gyro_buffer.c |  2 +-
 drivers/iio/gyro/st_gyro_core.c   |  3 +--
 drivers/iio/gyro/st_gyro_i2c.c    |  2 +-
 drivers/iio/gyro/st_gyro_spi.c    |  2 +-
 include/linux/iio/gyro/st_gyro.h  | 50 ---------------------------------------
 6 files changed, 54 insertions(+), 55 deletions(-)
 create mode 100644 drivers/iio/gyro/st_gyro.h
 delete mode 100644 include/linux/iio/gyro/st_gyro.h

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
new file mode 100644
index 0000000..3bc0e22
--- /dev/null
+++ b/drivers/iio/gyro/st_gyro.h
@@ -0,0 +1,50 @@
+/*
+ * STMicroelectronics gyroscopes driver
+ *
+ * Copyright 2012-2013 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_GYRO_H
+#define ST_GYRO_H
+
+#include <linux/types.h>
+#include <linux/iio/common/st_sensors.h>
+
+#define L3G4200D_GYRO_DEV_NAME		"l3g4200d"
+#define LSM330D_GYRO_DEV_NAME		"lsm330d_gyro"
+#define LSM330DL_GYRO_DEV_NAME		"lsm330dl_gyro"
+#define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc_gyro"
+#define L3GD20_GYRO_DEV_NAME		"l3gd20"
+#define L3GD20H_GYRO_DEV_NAME		"l3gd20h"
+#define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
+#define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
+
+int st_gyro_common_probe(struct iio_dev *indio_dev);
+void st_gyro_common_remove(struct iio_dev *indio_dev);
+int st_gyro_set_dataready_irq(struct iio_dev *indio_dev, bool state);
+int st_gyro_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit);
+int st_gyro_set_enable(struct iio_dev *indio_dev, bool enable);
+
+#ifdef CONFIG_IIO_BUFFER
+int st_gyro_allocate_ring(struct iio_dev *indio_dev);
+void st_gyro_deallocate_ring(struct iio_dev *indio_dev);
+int st_gyro_trig_set_state(struct iio_trigger *trig, bool state);
+#else /* CONFIG_IIO_BUFFER */
+static inline int st_gyro_allocate_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
+{
+}
+static inline int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	return 0;
+}
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* ST_GYRO_H */
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index c1fc390..deb8a4b 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -21,8 +21,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/iio/gyro/st_gyro.h>
 #include <linux/iio/common/st_sensors.h>
+#include "st_gyro.h"
 
 
 int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 661886a..12abeb2 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -24,9 +24,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 
-#include <linux/iio/gyro/st_gyro.h>
 #include <linux/iio/common/st_sensors.h>
-
+#include "st_gyro.h"
 
 /* DEFAULT VALUE FOR SENSORS */
 #define ST_GYRO_DEFAULT_OUT_X_L_ADDR		0x28
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 6e8871e..a44b5b4 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -15,9 +15,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-#include <linux/iio/gyro/st_gyro.h>
 #include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
+#include "st_gyro.h"
 
 static int st_gyro_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index a562aee..8b4dcc5 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -15,9 +15,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-#include <linux/iio/gyro/st_gyro.h>
 #include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_spi.h>
+#include "st_gyro.h"
 
 static int st_gyro_spi_probe(struct spi_device *spi)
 {
diff --git a/include/linux/iio/gyro/st_gyro.h b/include/linux/iio/gyro/st_gyro.h
deleted file mode 100644
index a0cca35..0000000
--- a/include/linux/iio/gyro/st_gyro.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * STMicroelectronics gyroscopes driver
- *
- * Copyright 2012-2013 STMicroelectronics Inc.
- *
- * Denis Ciocca <denis.ciocca@st.com>
- * v. 1.0.0
- * Licensed under the GPL-2.
- */
-
-#ifndef ST_GYRO_H
-#define ST_GYRO_H
-
-#include <linux/types.h>
-#include "../common/st_sensors.h"
-
-#define L3G4200D_GYRO_DEV_NAME		"l3g4200d"
-#define LSM330D_GYRO_DEV_NAME		"lsm330d_gyro"
-#define LSM330DL_GYRO_DEV_NAME		"lsm330dl_gyro"
-#define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc_gyro"
-#define L3GD20_GYRO_DEV_NAME		"l3gd20"
-#define L3GD20H_GYRO_DEV_NAME		"l3gd20h"
-#define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
-#define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
-
-int st_gyro_common_probe(struct iio_dev *indio_dev);
-void st_gyro_common_remove(struct iio_dev *indio_dev);
-int st_gyro_set_dataready_irq(struct iio_dev *indio_dev, bool state);
-int st_gyro_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit);
-int st_gyro_set_enable(struct iio_dev *indio_dev, bool enable);
-
-#ifdef CONFIG_IIO_BUFFER
-int st_gyro_allocate_ring(struct iio_dev *indio_dev);
-void st_gyro_deallocate_ring(struct iio_dev *indio_dev);
-int st_gyro_trig_set_state(struct iio_trigger *trig, bool state);
-#else /* CONFIG_IIO_BUFFER */
-static inline int st_gyro_allocate_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-static inline void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
-{
-}
-static inline int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
-{
-	return 0;
-}
-#endif /* CONFIG_IIO_BUFFER */
-
-#endif /* ST_GYRO_H */
-- 
1.8.1.1

