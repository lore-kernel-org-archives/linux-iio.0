Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-201.synserver.de ([212.40.185.201]:1104 "EHLO
	smtp-out-201.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab2KMN2e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Nov 2012 08:28:34 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] staging:iio: Move adis library out of staging
Date: Tue, 13 Nov 2012 14:28:13 +0100
Message-Id: <1352813293-17975-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1352813293-17975-1-git-send-email-lars@metafoo.de>
References: <1352813293-17975-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now that the adis library no longer depends on the sw_ring buffer implementation
we can move it out of staging.

While we are at it also sort the entries in the iio Kconfig and Makefile to be
in alphabetical order.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/Kconfig                               |  7 ++++---
 drivers/iio/Makefile                              |  7 ++++---
 drivers/iio/imu/Kconfig                           | 11 +++++++++++
 drivers/iio/imu/Makefile                          |  8 ++++++++
 drivers/{staging => }/iio/imu/adis.c              |  3 +--
 drivers/{staging => }/iio/imu/adis_buffer.c       |  3 +--
 drivers/{staging => }/iio/imu/adis_trigger.c      |  3 +--
 drivers/staging/iio/accel/adis16201_core.c        |  2 +-
 drivers/staging/iio/accel/adis16203_core.c        |  2 +-
 drivers/staging/iio/accel/adis16204_core.c        |  2 +-
 drivers/staging/iio/accel/adis16209_core.c        |  2 +-
 drivers/staging/iio/accel/adis16220.h             |  2 +-
 drivers/staging/iio/accel/adis16240_core.c        |  2 +-
 drivers/staging/iio/gyro/adis16260.h              |  2 +-
 drivers/staging/iio/imu/Kconfig                   | 12 ------------
 drivers/staging/iio/imu/Makefile                  |  5 -----
 {drivers/staging => include/linux}/iio/imu/adis.h |  0
 17 files changed, 37 insertions(+), 36 deletions(-)
 create mode 100644 drivers/iio/imu/Kconfig
 create mode 100644 drivers/iio/imu/Makefile
 rename drivers/{staging => }/iio/imu/adis.c (99%)
 rename drivers/{staging => }/iio/imu/adis_buffer.c (99%)
 rename drivers/{staging => }/iio/imu/adis_trigger.c (98%)
 rename {drivers/staging => include/linux}/iio/imu/adis.h (100%)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 65ae734..b2f963b 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -63,11 +63,12 @@ config IIO_CONSUMERS_PER_TRIGGER
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
-source "drivers/iio/light/Kconfig"
-source "drivers/iio/frequency/Kconfig"
-source "drivers/iio/dac/Kconfig"
 source "drivers/iio/common/Kconfig"
+source "drivers/iio/dac/Kconfig"
+source "drivers/iio/frequency/Kconfig"
 source "drivers/iio/gyro/Kconfig"
+source "drivers/iio/imu/Kconfig"
+source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 31d76a0..a0e8cdd 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -14,9 +14,10 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 obj-y += accel/
 obj-y += adc/
 obj-y += amplifiers/
-obj-y += light/
-obj-y += frequency/
-obj-y += dac/
 obj-y += common/
+obj-y += dac/
 obj-y += gyro/
+obj-y += frequency/
+obj-y += imu/
+obj-y += light/
 obj-y += magnetometer/
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
new file mode 100644
index 0000000..9e4bc1a
--- /dev/null
+++ b/drivers/iio/imu/Kconfig
@@ -0,0 +1,11 @@
+config IIO_ADIS_LIB
+	tristate
+	help
+	  A set of IO helper functions for the Analog Devices ADIS* device family.
+
+config IIO_ADIS_LIB_BUFFER
+	bool
+	select IIO_TRIGGERED_BUFFER
+	help
+	  A set of buffer helper functions for the Analog Devices ADIS* device
+	  family.
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
new file mode 100644
index 0000000..97676ab
--- /dev/null
+++ b/drivers/iio/imu/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for Inertial Measurement Units
+#
+
+adis_lib-y += adis.o
+adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_trigger.o
+adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
+obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
diff --git a/drivers/staging/iio/imu/adis.c b/drivers/iio/imu/adis.c
similarity index 99%
rename from drivers/staging/iio/imu/adis.c
rename to drivers/iio/imu/adis.c
index 0bd21022..8259b77 100644
--- a/drivers/staging/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -20,8 +20,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-
-#include "adis.h"
+#include <linux/iio/imu/adis.h>
 
 #define ADIS_MSC_CTRL_DATA_RDY_EN	BIT(2)
 #define ADIS_MSC_CTRL_DATA_RDY_POL_HIGH	BIT(1)
diff --git a/drivers/staging/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
similarity index 99%
rename from drivers/staging/iio/imu/adis_buffer.c
rename to drivers/iio/imu/adis_buffer.c
index 342758c..a91b4cb 100644
--- a/drivers/staging/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -18,8 +18,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-
-#include  "adis.h"
+#include <linux/iio/imu/adis.h>
 
 int adis_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask)
diff --git a/drivers/staging/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
similarity index 98%
rename from drivers/staging/iio/imu/adis_trigger.c
rename to drivers/iio/imu/adis_trigger.c
index 3e89b2e..5a24c9c 100644
--- a/drivers/staging/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -14,8 +14,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
-
-#include "adis.h"
+#include <linux/iio/imu/adis.h>
 
 static int adis_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 833dd6b..ccdc8d2 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -18,9 +18,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/imu/adis.h>
 
 #include "adis16201.h"
-#include "../imu/adis.h"
 
 static const u8 adis16201_addresses[] = {
 	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index f631e57..202985e 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -18,9 +18,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/imu/adis.h>
 
 #include "adis16203.h"
-#include "../imu/adis.h"
 
 #define DRIVER_NAME		"adis16203"
 
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index dbec841..6dafad6 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -21,9 +21,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/imu/adis.h>
 
 #include "adis16204.h"
-#include "../imu/adis.h"
 
 /* Unique to this driver currently */
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index f9f9d58..d2921c3 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -19,9 +19,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/imu/adis.h>
 
 #include "adis16209.h"
-#include "../imu/adis.h"
 
 static const u8 adis16209_addresses[8][1] = {
 	[ADIS16209_SCAN_SUPPLY] = { },
diff --git a/drivers/staging/iio/accel/adis16220.h b/drivers/staging/iio/accel/adis16220.h
index 7cc4d2f..a894ad7 100644
--- a/drivers/staging/iio/accel/adis16220.h
+++ b/drivers/staging/iio/accel/adis16220.h
@@ -1,7 +1,7 @@
 #ifndef SPI_ADIS16220_H_
 #define SPI_ADIS16220_H_
 
-#include "../imu/adis.h"
+#include <linux/iio/imu/adis.h>
 
 #define ADIS16220_STARTUP_DELAY	220 /* ms */
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 3d1a8a9..d098b49 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -22,9 +22,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/imu/adis.h>
 
 #include "adis16240.h"
-#include "../imu/adis.h"
 
 static ssize_t adis16240_spi_read_signed(struct device *dev,
 		struct device_attribute *attr,
diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index ea5eba2..df3c0b7 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -2,7 +2,7 @@
 #define SPI_ADIS16260_H_
 
 #include "adis16260_platform_data.h"
-#include "../imu/adis.h"
+#include <linux/iio/imu/adis.h>
 
 #define ADIS16260_STARTUP_DELAY	220 /* ms */
 
diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 2c564ed..2c2f47d 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -15,15 +15,3 @@ config ADIS16400
 	  (adis16400 series also have magnetometers).
 
 endmenu
-
-config IIO_ADIS_LIB
-	tristate
-	help
-	  A set of IO helper functions for the Analog Devices ADIS* device family.
-
-config IIO_ADIS_LIB_BUFFER
-	bool
-	select IIO_TRIGGERED_BUFFER
-	help
-	  A set of buffer helper functions for the Analog Devices ADIS* device
-	  family.
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
index 65dafba..3400a13 100644
--- a/drivers/staging/iio/imu/Makefile
+++ b/drivers/staging/iio/imu/Makefile
@@ -5,8 +5,3 @@
 adis16400-y             := adis16400_core.o
 adis16400-$(CONFIG_IIO_BUFFER) += adis16400_ring.o adis16400_trigger.o
 obj-$(CONFIG_ADIS16400) += adis16400.o
-
-adis_lib-y += adis.o
-adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_trigger.o
-adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
-obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
diff --git a/drivers/staging/iio/imu/adis.h b/include/linux/iio/imu/adis.h
similarity index 100%
rename from drivers/staging/iio/imu/adis.h
rename to include/linux/iio/imu/adis.h
-- 
1.8.0

