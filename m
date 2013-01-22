Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42626 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab3AVQQq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 11:16:46 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 04/10] iio:magn:st_magn move header from linux/iio/magn/ to .
Date: Tue, 22 Jan 2013 16:16:33 +0000
Message-Id: <1358871399-11216-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1358871399-11216-1-git-send-email-jic23@kernel.org>
References: <50FEBB20.7070407@kernel.org>
 <1358871399-11216-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/iio/magnetometer/st_magn_buffer.c |  3 +-
 drivers/iio/magnetometer/st_magn_core.c   |  2 +-
 drivers/iio/magnetometer/st_magn_i2c.c    |  2 +-
 drivers/iio/magnetometer/st_magn_spi.c    |  2 +-
 include/linux/iio/magnetometer/st_magn.h  | 47 -------------------------------
 5 files changed, 4 insertions(+), 52 deletions(-)
 delete mode 100644 include/linux/iio/magnetometer/st_magn.h

diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index c396988..06bf621 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -21,9 +21,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/iio/magnetometer/st_magn.h>
 #include <linux/iio/common/st_sensors.h>
-
+#include "st_magn.h"
 
 static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
 {
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index eef9a32..845f5db 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -24,8 +24,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 
-#include <linux/iio/magnetometer/st_magn.h>
 #include <linux/iio/common/st_sensors.h>
+#include "st_magn.h"
 
 
 /* DEFAULT VALUE FOR SENSORS */
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index cc6eaa9..710b256a5 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -15,9 +15,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-#include <linux/iio/magnetometer/st_magn.h>
 #include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
+#include "st_magn.h"
 
 static int st_magn_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index bbd1baf..94547e7 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -15,9 +15,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-#include <linux/iio/magnetometer/st_magn.h>
 #include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_spi.h>
+#include "st_magn.h"
 
 static int st_magn_spi_probe(struct spi_device *spi)
 {
diff --git a/include/linux/iio/magnetometer/st_magn.h b/include/linux/iio/magnetometer/st_magn.h
deleted file mode 100644
index cde476e..0000000
--- a/include/linux/iio/magnetometer/st_magn.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * STMicroelectronics magnetometers driver
- *
- * Copyright 2012-2013 STMicroelectronics Inc.
- *
- * Denis Ciocca <denis.ciocca@st.com>
- * v. 1.0.0
- * Licensed under the GPL-2.
- */
-
-#ifndef ST_MAGN_H
-#define ST_MAGN_H
-
-#include <linux/types.h>
-#include "../common/st_sensors.h"
-
-#define LSM303DLHC_MAGN_DEV_NAME	"lsm303dlhc_magn"
-#define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
-#define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
-
-int st_magn_common_probe(struct iio_dev *indio_dev);
-void st_magn_common_remove(struct iio_dev *indio_dev);
-int st_magn_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit);
-int st_magn_set_enable(struct iio_dev *indio_dev, bool enable);
-
-#ifdef CONFIG_IIO_BUFFER
-int st_magn_allocate_ring(struct iio_dev *indio_dev);
-void st_magn_deallocate_ring(struct iio_dev *indio_dev);
-#else /* CONFIG_IIO_BUFFER */
-static inline int st_magn_probe_trigger(struct iio_dev *indio_dev, int irq)
-{
-	return 0;
-}
-static inline void st_magn_remove_trigger(struct iio_dev *indio_dev, int irq)
-{
-	return;
-}
-static inline int st_magn_allocate_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-static inline void st_magn_deallocate_ring(struct iio_dev *indio_dev)
-{
-}
-#endif /* CONFIG_IIO_BUFFER */
-
-#endif /* ST_MAGN_H */
-- 
1.8.1.1

