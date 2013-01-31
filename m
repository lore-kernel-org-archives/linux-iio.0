Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1148 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3AaO1S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:18 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/11] staging:iio:adxrs450: Move header file contents to main file
Date: Thu, 31 Jan 2013 15:27:57 +0100
Message-Id: <1359642478-9622-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The contents of the adxrs450 header file is not used outside the main drivers
file, so just move the contents from the header file into the drivers main file.
Also rename the adxrs450 driver file from adxrs450_core.c to adxrs450.c.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/Makefile                  |  1 -
 .../iio/gyro/{adxrs450_core.c => adxrs450.c}       | 58 +++++++++++++++++++-
 drivers/staging/iio/gyro/adxrs450.h                | 62 ----------------------
 3 files changed, 57 insertions(+), 64 deletions(-)
 rename drivers/staging/iio/gyro/{adxrs450_core.c => adxrs450.c} (86%)
 delete mode 100644 drivers/staging/iio/gyro/adxrs450.h

diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index e66c5ef..ad35e57 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_ADIS16060) += adis16060.o
 adis16260-y             := adis16260_core.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
 
-adxrs450-y             := adxrs450_core.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450.c
similarity index 86%
rename from drivers/staging/iio/gyro/adxrs450_core.c
rename to drivers/staging/iio/gyro/adxrs450.c
index 714e323..d9d4383 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450.c
@@ -21,7 +21,63 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "adxrs450.h"
+#define ADXRS450_STARTUP_DELAY	50 /* ms */
+
+/* The MSB for the spi commands */
+#define ADXRS450_SENSOR_DATA    (0x20 << 24)
+#define ADXRS450_WRITE_DATA	(0x40 << 24)
+#define ADXRS450_READ_DATA	(0x80 << 24)
+
+#define ADXRS450_RATE1	0x00	/* Rate Registers */
+#define ADXRS450_TEMP1	0x02	/* Temperature Registers */
+#define ADXRS450_LOCST1	0x04	/* Low CST Memory Registers */
+#define ADXRS450_HICST1	0x06	/* High CST Memory Registers */
+#define ADXRS450_QUAD1	0x08	/* Quad Memory Registers */
+#define ADXRS450_FAULT1	0x0A	/* Fault Registers */
+#define ADXRS450_PID1	0x0C	/* Part ID Register 1 */
+#define ADXRS450_SNH	0x0E	/* Serial Number Registers, 4 bytes */
+#define ADXRS450_SNL	0x10
+#define ADXRS450_DNC1	0x12	/* Dynamic Null Correction Registers */
+/* Check bits */
+#define ADXRS450_P	0x01
+#define ADXRS450_CHK	0x02
+#define ADXRS450_CST	0x04
+#define ADXRS450_PWR	0x08
+#define ADXRS450_POR	0x10
+#define ADXRS450_NVM	0x20
+#define ADXRS450_Q	0x40
+#define ADXRS450_PLL	0x80
+#define ADXRS450_UV	0x100
+#define ADXRS450_OV	0x200
+#define ADXRS450_AMP	0x400
+#define ADXRS450_FAIL	0x800
+
+#define ADXRS450_WRERR_MASK	(0x7 << 29)
+
+#define ADXRS450_MAX_RX 4
+#define ADXRS450_MAX_TX 4
+
+#define ADXRS450_GET_ST(a)	((a >> 26) & 0x3)
+
+enum {
+	ID_ADXRS450,
+	ID_ADXRS453,
+};
+
+/**
+ * struct adxrs450_state - device instance specific data
+ * @us:			actual spi_device
+ * @buf_lock:		mutex to protect tx and rx
+ * @tx:			transmit buffer
+ * @rx:			receive buffer
+ **/
+struct adxrs450_state {
+	struct spi_device	*us;
+	struct mutex		buf_lock;
+	__be32			tx ____cacheline_aligned;
+	__be32			rx;
+
+};
 
 /**
  * adxrs450_spi_read_reg_16() - read 2 bytes from a register pair
diff --git a/drivers/staging/iio/gyro/adxrs450.h b/drivers/staging/iio/gyro/adxrs450.h
deleted file mode 100644
index 97abea3..0000000
--- a/drivers/staging/iio/gyro/adxrs450.h
+++ /dev/null
@@ -1,62 +0,0 @@
-#ifndef SPI_ADXRS450_H_
-#define SPI_ADXRS450_H_
-
-#define ADXRS450_STARTUP_DELAY	50 /* ms */
-
-/* The MSB for the spi commands */
-#define ADXRS450_SENSOR_DATA    (0x20 << 24)
-#define ADXRS450_WRITE_DATA	(0x40 << 24)
-#define ADXRS450_READ_DATA	(0x80 << 24)
-
-#define ADXRS450_RATE1	0x00	/* Rate Registers */
-#define ADXRS450_TEMP1	0x02	/* Temperature Registers */
-#define ADXRS450_LOCST1	0x04	/* Low CST Memory Registers */
-#define ADXRS450_HICST1	0x06	/* High CST Memory Registers */
-#define ADXRS450_QUAD1	0x08	/* Quad Memory Registers */
-#define ADXRS450_FAULT1	0x0A	/* Fault Registers */
-#define ADXRS450_PID1	0x0C	/* Part ID Register 1 */
-#define ADXRS450_SNH	0x0E	/* Serial Number Registers, 4 bytes */
-#define ADXRS450_SNL	0x10
-#define ADXRS450_DNC1	0x12	/* Dynamic Null Correction Registers */
-/* Check bits */
-#define ADXRS450_P	0x01
-#define ADXRS450_CHK	0x02
-#define ADXRS450_CST	0x04
-#define ADXRS450_PWR	0x08
-#define ADXRS450_POR	0x10
-#define ADXRS450_NVM	0x20
-#define ADXRS450_Q	0x40
-#define ADXRS450_PLL	0x80
-#define ADXRS450_UV	0x100
-#define ADXRS450_OV	0x200
-#define ADXRS450_AMP	0x400
-#define ADXRS450_FAIL	0x800
-
-#define ADXRS450_WRERR_MASK	(0x7 << 29)
-
-#define ADXRS450_MAX_RX 4
-#define ADXRS450_MAX_TX 4
-
-#define ADXRS450_GET_ST(a)	((a >> 26) & 0x3)
-
-enum {
-	ID_ADXRS450,
-	ID_ADXRS453,
-};
-
-/**
- * struct adxrs450_state - device instance specific data
- * @us:			actual spi_device
- * @buf_lock:		mutex to protect tx and rx
- * @tx:			transmit buffer
- * @rx:			receive buffer
- **/
-struct adxrs450_state {
-	struct spi_device	*us;
-	struct mutex		buf_lock;
-	__be32			tx ____cacheline_aligned;
-	__be32			rx;
-
-};
-
-#endif /* SPI_ADXRS450_H_ */
-- 
1.8.0

