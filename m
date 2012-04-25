Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43714 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab2DYOzI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 10:55:08 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/5] IIO: Move core headers to include/linux/iio
Date: Wed, 25 Apr 2012 15:54:58 +0100
Message-Id: <1335365700-1138-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1335365700-1138-1-git-send-email-jic23@kernel.org>
References: <1335365700-1138-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Step 1 in moving the IIO core out of staging.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 .../staging/iio/Documentation/iio_event_monitor.c  |    2 +-
 drivers/staging/iio/accel/adis16201_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16201_ring.c         |    4 ++--
 drivers/staging/iio/accel/adis16201_trigger.c      |    4 ++--
 drivers/staging/iio/accel/adis16203_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16203_ring.c         |    4 ++--
 drivers/staging/iio/accel/adis16203_trigger.c      |    4 ++--
 drivers/staging/iio/accel/adis16204_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16204_ring.c         |    4 ++--
 drivers/staging/iio/accel/adis16204_trigger.c      |    4 ++--
 drivers/staging/iio/accel/adis16209_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16209_ring.c         |    4 ++--
 drivers/staging/iio/accel/adis16209_trigger.c      |    4 ++--
 drivers/staging/iio/accel/adis16220_core.c         |    4 ++--
 drivers/staging/iio/accel/adis16240_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16240_ring.c         |    4 ++--
 drivers/staging/iio/accel/adis16240_trigger.c      |    4 ++--
 drivers/staging/iio/accel/kxsd9.c                  |    4 ++--
 drivers/staging/iio/accel/lis3l02dq_core.c         |    8 ++++----
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    8 ++++----
 drivers/staging/iio/accel/sca3000_core.c           |    8 ++++----
 drivers/staging/iio/accel/sca3000_ring.c           |    6 +++---
 drivers/staging/iio/adc/ad7192.c                   |   10 +++++-----
 drivers/staging/iio/adc/ad7280a.c                  |    6 +++---
 drivers/staging/iio/adc/ad7291.c                   |    6 +++---
 drivers/staging/iio/adc/ad7298_core.c              |    6 +++---
 drivers/staging/iio/adc/ad7298_ring.c              |    6 +++---
 drivers/staging/iio/adc/ad7476_core.c              |    6 +++---
 drivers/staging/iio/adc/ad7476_ring.c              |    6 +++---
 drivers/staging/iio/adc/ad7606_core.c              |    6 +++---
 drivers/staging/iio/adc/ad7606_par.c               |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c              |    6 +++---
 drivers/staging/iio/adc/ad7606_spi.c               |    2 +-
 drivers/staging/iio/adc/ad7780.c                   |    4 ++--
 drivers/staging/iio/adc/ad7793.c                   |   10 +++++-----
 drivers/staging/iio/adc/ad7816.c                   |    6 +++---
 drivers/staging/iio/adc/ad7887_core.c              |    6 +++---
 drivers/staging/iio/adc/ad7887_ring.c              |    6 +++---
 drivers/staging/iio/adc/ad799x_core.c              |    8 ++++----
 drivers/staging/iio/adc/ad799x_ring.c              |    6 +++---
 drivers/staging/iio/adc/adt7310.c                  |    6 +++---
 drivers/staging/iio/adc/adt7410.c                  |    6 +++---
 drivers/staging/iio/adc/lpc32xx_adc.c              |    4 ++--
 drivers/staging/iio/adc/max1363_core.c             |   10 +++++-----
 drivers/staging/iio/adc/max1363_ring.c             |    6 +++---
 drivers/staging/iio/adc/spear_adc.c                |    4 ++--
 drivers/staging/iio/addac/adt7316.c                |    6 +++---
 drivers/staging/iio/cdc/ad7150.c                   |    6 +++---
 drivers/staging/iio/cdc/ad7152.c                   |    4 ++--
 drivers/staging/iio/cdc/ad7746.c                   |    4 ++--
 drivers/staging/iio/dac/ad5064.c                   |    4 ++--
 drivers/staging/iio/dac/ad5360.c                   |    4 ++--
 drivers/staging/iio/dac/ad5380.c                   |    4 ++--
 drivers/staging/iio/dac/ad5421.c                   |    6 +++---
 drivers/staging/iio/dac/ad5446.c                   |    4 ++--
 drivers/staging/iio/dac/ad5504.c                   |    6 +++---
 drivers/staging/iio/dac/ad5624r_spi.c              |    4 ++--
 drivers/staging/iio/dac/ad5686.c                   |    4 ++--
 drivers/staging/iio/dac/ad5764.c                   |    4 ++--
 drivers/staging/iio/dac/ad5791.c                   |    4 ++--
 drivers/staging/iio/dac/max517.c                   |    4 ++--
 drivers/staging/iio/dds/ad5930.c                   |    4 ++--
 drivers/staging/iio/dds/ad9832.c                   |    4 ++--
 drivers/staging/iio/dds/ad9834.c                   |    4 ++--
 drivers/staging/iio/dds/ad9850.c                   |    4 ++--
 drivers/staging/iio/dds/ad9852.c                   |    4 ++--
 drivers/staging/iio/dds/ad9910.c                   |    4 ++--
 drivers/staging/iio/dds/ad9951.c                   |    4 ++--
 drivers/staging/iio/gyro/adis16060_core.c          |    4 ++--
 drivers/staging/iio/gyro/adis16080_core.c          |    4 ++--
 drivers/staging/iio/gyro/adis16130_core.c          |    4 ++--
 drivers/staging/iio/gyro/adis16260_core.c          |    6 +++---
 drivers/staging/iio/gyro/adis16260_ring.c          |    4 ++--
 drivers/staging/iio/gyro/adis16260_trigger.c       |    4 ++--
 drivers/staging/iio/gyro/adxrs450_core.c           |    4 ++--
 drivers/staging/iio/iio_dummy_evgen.c              |    4 ++--
 drivers/staging/iio/iio_hwmon.c                    |    4 ++--
 drivers/staging/iio/iio_simple_dummy.c             |    8 ++++----
 drivers/staging/iio/iio_simple_dummy_buffer.c      |    6 +++---
 drivers/staging/iio/iio_simple_dummy_events.c      |    6 +++---
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    6 +++---
 drivers/staging/iio/imu/adis16400_core.c           |    6 +++---
 drivers/staging/iio/imu/adis16400_ring.c           |    4 ++--
 drivers/staging/iio/imu/adis16400_trigger.c        |    4 ++--
 drivers/staging/iio/industrialio-buffer.c          |    6 +++---
 drivers/staging/iio/industrialio-core.c            |    6 +++---
 drivers/staging/iio/industrialio-event.c           |    6 +++---
 drivers/staging/iio/industrialio-trigger.c         |    6 +++---
 drivers/staging/iio/inkern.c                       |    8 ++++----
 drivers/staging/iio/kfifo_buf.c                    |    3 +--
 drivers/staging/iio/light/isl29018.c               |    4 ++--
 drivers/staging/iio/light/isl29028.c               |    4 ++--
 drivers/staging/iio/light/tsl2563.c                |    6 +++---
 drivers/staging/iio/light/tsl2583.c                |    2 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |    6 +++---
 drivers/staging/iio/magnetometer/ak8975.c          |    4 ++--
 drivers/staging/iio/magnetometer/hmc5843.c         |    4 ++--
 drivers/staging/iio/meter/ade7753.c                |    4 ++--
 drivers/staging/iio/meter/ade7754.c                |    4 ++--
 drivers/staging/iio/meter/ade7758_core.c           |    6 +++---
 drivers/staging/iio/meter/ade7758_ring.c           |    4 ++--
 drivers/staging/iio/meter/ade7758_trigger.c        |    4 ++--
 drivers/staging/iio/meter/ade7759.c                |    4 ++--
 drivers/staging/iio/meter/ade7854-i2c.c            |    2 +-
 drivers/staging/iio/meter/ade7854-spi.c            |    2 +-
 drivers/staging/iio/meter/ade7854.c                |    4 ++--
 drivers/staging/iio/meter/meter.h                  |    2 +-
 drivers/staging/iio/resolver/ad2s1200.c            |    4 ++--
 drivers/staging/iio/resolver/ad2s1210.c            |    4 ++--
 drivers/staging/iio/resolver/ad2s90.c              |    4 ++--
 drivers/staging/iio/ring_sw.c                      |    2 +-
 drivers/staging/iio/ring_sw.h                      |    2 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |    4 ++--
 drivers/staging/iio/trigger/iio-trig-gpio.c        |    4 ++--
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    4 ++--
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |    4 ++--
 {drivers/staging => include/linux}/iio/buffer.h    |    2 +-
 {drivers/staging => include/linux}/iio/consumer.h  |    2 +-
 {drivers/staging => include/linux}/iio/driver.h    |    0
 {drivers/staging => include/linux}/iio/events.h    |    2 +-
 {drivers/staging => include/linux}/iio/iio.h       |    2 +-
 {drivers/staging => include/linux}/iio/kfifo_buf.h |    4 ++--
 {drivers/staging => include/linux}/iio/machine.h   |    0
 {drivers/staging => include/linux}/iio/sysfs.h     |    0
 {drivers/staging => include/linux}/iio/trigger.h   |    0
 .../linux}/iio/trigger_consumer.h                  |    0
 {drivers/staging => include/linux}/iio/types.h     |    0
 127 files changed, 286 insertions(+), 287 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 0d21a27..2227584 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -27,7 +27,7 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include "iio_utils.h"
-#include "../events.h"
+#include <linux/iio/events.h>
 
 static const char * const iio_chan_type_name_spec[] = {
 	[IIO_VOLTAGE] = "voltage",
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 8022bbd..9dce7b8 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -15,9 +15,9 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "adis16201.h"
 
diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 49912e2..247602a 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -5,9 +5,9 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 #include "adis16201.h"
 
 
diff --git a/drivers/staging/iio/accel/adis16201_trigger.c b/drivers/staging/iio/accel/adis16201_trigger.c
index bce505e..da687e0 100644
--- a/drivers/staging/iio/accel/adis16201_trigger.c
+++ b/drivers/staging/iio/accel/adis16201_trigger.c
@@ -3,8 +3,8 @@
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "adis16201.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index f23b7c5..cf1a0e5 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -15,9 +15,9 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "adis16203.h"
 
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 5c40f6c..2171f74 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -5,9 +5,9 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 #include "adis16203.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16203_trigger.c b/drivers/staging/iio/accel/adis16203_trigger.c
index 24bcb8e..1e1b981 100644
--- a/drivers/staging/iio/accel/adis16203_trigger.c
+++ b/drivers/staging/iio/accel/adis16203_trigger.c
@@ -3,8 +3,8 @@
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "adis16203.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index bffbbe8..2a15d71 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -18,9 +18,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "adis16204.h"
 
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index bf5488e..0a8b125 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -5,9 +5,9 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 #include "adis16204.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
index 6e542af..e6f2937 100644
--- a/drivers/staging/iio/accel/adis16204_trigger.c
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -3,8 +3,8 @@
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "adis16204.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index b1fbf19..cad4113 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -16,9 +16,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "adis16209.h"
 
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 3101c53..f7ed989 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -5,9 +5,9 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 #include "adis16209.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index c5d82c1..5f5dbed 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -3,8 +3,8 @@
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "adis16209.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 2740c8e..c86a3db 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -15,8 +15,8 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #include "adis16220.h"
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 18ed396..fcc2c19 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -19,9 +19,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "adis16240.h"
 
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index c4459f7..1aa9566 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -5,9 +5,9 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 #include "adis16240.h"
 
 /**
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index 8e0ce56..53eda35 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -3,8 +3,8 @@
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "adis16240.h"
 
 /**
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 601da28..3292390 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -23,8 +23,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define KXSD9_REG_X		0x00
 #define KXSD9_REG_Y		0x02
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index ee8ad3a..bbef0be 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -23,10 +23,10 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
 
 #include "lis3l02dq.h"
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index ebd5b4d..c8b8164 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -6,11 +6,11 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../kfifo_buf.h"
-#include "../trigger.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
 #include "lis3l02dq.h"
 
 /**
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 646e05c..2ee5eb0 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -18,10 +18,10 @@
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
 
 #include "sca3000.h"
 
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 6b824a1..889bc86 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -18,9 +18,9 @@
 #include <linux/sched.h>
 #include <linux/poll.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 #include "../ring_hw.h"
 #include "sca3000.h"
 
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 5d31685..14f9834 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -17,12 +17,12 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
-#include "../trigger.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "ad7192.h"
 
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index f0c0c72..d72780f 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -16,9 +16,9 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 
 #include "ad7280a.h"
 
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 298249f..b8e4fe6 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -17,9 +17,9 @@
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 
 /*
  * Simplified handling
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 5d54a79..974a8e3 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -16,9 +16,9 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "ad7298.h"
 
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 538e3b3..943caa3 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -11,10 +11,10 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
-#include "../iio.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 
 #include "ad7298.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index ce71522..1241b9f 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -15,9 +15,9 @@
 #include <linux/err.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "ad7476.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 8534f6b..5140389 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -13,10 +13,10 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
-#include "../iio.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 
 #include "ad7476.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 802cdaf..9c54064 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -18,9 +18,9 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "ad7606.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index bb152a8..a53faaf 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -12,7 +12,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "ad7606.h"
 
 static int ad7606_par16_read_block(struct device *dev,
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 007b600..3dd9602 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -11,10 +11,10 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 
 #include "ad7606.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 237f1c4..099d347 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "ad7606.h"
 
 #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index eeedbdb..a8e661e 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -18,8 +18,8 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #include "ad7780.h"
 
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 7f68c7c..3a7d1a7 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -18,12 +18,12 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
-#include "../trigger.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "ad7793.h"
 
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 52b720e..586f6c2 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -16,9 +16,9 @@
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 
 /*
  * AD7816 config masks
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 2cce09f..fef9169 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -15,9 +15,9 @@
 #include <linux/err.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 
 #include "ad7887.h"
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 62681a8..f1846db 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -12,10 +12,10 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
-#include "../iio.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 
 #include "ad7887.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 429fb41..561ae17 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -33,10 +33,10 @@
 #include <linux/err.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
 
 #include "ad799x.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 5190e50..18366b5 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -16,10 +16,10 @@
 #include <linux/i2c.h>
 #include <linux/bitops.h>
 
-#include "../iio.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 
 #include "ad799x.h"
 
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index caf57c1..223aea5 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -15,9 +15,9 @@
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 /*
  * ADT7310 registers definition
  */
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index dff3e8c..dab4a5a 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -15,9 +15,9 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 
 /*
  * ADT7410 registers definition
diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index d7f4fe4..0ddd917 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -32,8 +32,8 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 /*
  * LPC32XX registers definitions
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 1a7a027..7ab871c 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -32,11 +32,11 @@
 #include <linux/err.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
-#include "../buffer.h"
-#include "../driver.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/driver.h>
 
 #include "max1363.h"
 
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 8372e98..b302013 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -14,10 +14,10 @@
 #include <linux/i2c.h>
 #include <linux/bitops.h>
 
-#include "../iio.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 
 #include "max1363.h"
 
diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 3ca5cc9..2b4e1eb 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -19,8 +19,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 /*
  * SPEAR registers definitions
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index fd6a454..f469ab3 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -19,9 +19,9 @@
 #include <linux/rtc.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../events.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
 #include "adt7316.h"
 
 /*
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 116e6c2..c0ccbc5 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -13,9 +13,9 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 /*
  * AD7150 registers definition
  */
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 1067ce5..ea40359 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -15,8 +15,8 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 /*
  * TODO: Check compliance of calibbias with abi (units)
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 750bf4b..74a889a 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -16,8 +16,8 @@
 #include <linux/module.h>
 #include <linux/stat.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #include "ad7746.h"
 
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 21893ed..c0fad4f 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 
 #define AD5064_MAX_DAC_CHANNELS			8
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index cb6160d..0978dd2 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 
 #define AD5360_CMD(x)				((x) << 22)
diff --git a/drivers/staging/iio/dac/ad5380.c b/drivers/staging/iio/dac/ad5380.c
index 1d384f0..aa077e6 100644
--- a/drivers/staging/iio/dac/ad5380.c
+++ b/drivers/staging/iio/dac/ad5380.c
@@ -18,8 +18,8 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 
 
diff --git a/drivers/staging/iio/dac/ad5421.c b/drivers/staging/iio/dac/ad5421.c
index a8b5211..b1a893c 100644
--- a/drivers/staging/iio/dac/ad5421.c
+++ b/drivers/staging/iio/dac/ad5421.c
@@ -16,9 +16,9 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 #include "dac.h"
 #include "ad5421.h"
 
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index ec6968b..7a114e1 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -18,8 +18,8 @@
 #include <linux/err.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 
 #include "ad5446.h"
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 796691e..18fc391 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -16,9 +16,9 @@
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 #include "dac.h"
 #include "ad5504.h"
 
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 74eb889..c7786c1 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -16,8 +16,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 #include "ad5624r.h"
 
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index b8acd7e..86c8691 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 
 #define AD5686_DAC_CHANNELS			4
diff --git a/drivers/staging/iio/dac/ad5764.c b/drivers/staging/iio/dac/ad5764.c
index 1c9ff4f..b01d7ee 100644
--- a/drivers/staging/iio/dac/ad5764.c
+++ b/drivers/staging/iio/dac/ad5764.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 
 #define AD5764_REG_SF_NOP			0x0
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index cdb7b10..c013868 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -17,8 +17,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 #include "ad5791.h"
 
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index 41483c7..373127c 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -25,8 +25,8 @@
 #include <linux/i2c.h>
 #include <linux/err.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dac.h"
 
 #include "max517.h"
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index 9c32d1b..6df4d86 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define DRV_NAME "ad5930"
 
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index 2ccf25d..57627ff 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -16,8 +16,8 @@
 #include <linux/module.h>
 #include <asm/div64.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dds.h"
 
 #include "ad9832.h"
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 38a2de0..9b2c879 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -19,8 +19,8 @@
 #include <linux/module.h>
 #include <asm/div64.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "dds.h"
 
 #include "ad9834.h"
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index f4f731b..cc7a87d 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define DRV_NAME "ad9850"
 
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 554266c..2f8df7b 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define DRV_NAME "ad9852"
 
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index 3985766..e91efc5 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define DRV_NAME "ad9910"
 
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index 4d15004..ca1d311 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define DRV_NAME "ad9951"
 
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 2f841cb..08aaf27 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -15,8 +15,8 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define ADIS16060_GYRO		0x20 /* Measure Angular Rate (Gyro) */
 #define ADIS16060_TEMP_OUT	0x10 /* Measure Temperature */
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 608b93d..7e3695b 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -14,8 +14,8 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define ADIS16080_DIN_GYRO   (0 << 10) /* Gyroscope output */
 #define ADIS16080_DIN_TEMP   (1 << 10) /* Temperature output */
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 257bdf2..98aa1b9 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -16,8 +16,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define ADIS16130_CON         0x0
 #define ADIS16130_CON_RD      (1 << 6)
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index bb23018..15253be 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -18,9 +18,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 #include "adis16260.h"
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 046f84d..2528337 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -5,9 +5,9 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 #include "adis16260.h"
 
 /**
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index 8299cd1..dc56f32 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -3,8 +3,8 @@
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "adis16260.h"
 
 /**
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 1293505..06a9e97 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -18,8 +18,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #include "adxrs450.h"
 
diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
index f39f346..0cd4fe9 100644
--- a/drivers/staging/iio/iio_dummy_evgen.c
+++ b/drivers/staging/iio/iio_dummy_evgen.c
@@ -22,8 +22,8 @@
 #include <linux/sysfs.h>
 
 #include "iio_dummy_evgen.h"
-#include "iio.h"
-#include "sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 /* Fiddly bit of faking and irq without hardware */
 #define IIO_EVENTGEN_NO 10
diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
index a603a5f..b03554f 100644
--- a/drivers/staging/iio/iio_hwmon.c
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -14,8 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
-#include "consumer.h"
-#include "types.h"
+#include <linux/iio/consumer.h>
+#include <linux/iio/types.h>
 
 /**
  * struct iio_hwmon_state - device instance state
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index dbeb04c..fa4a653 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -19,10 +19,10 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 
-#include "iio.h"
-#include "sysfs.h"
-#include "events.h"
-#include "buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
 #include "iio_simple_dummy.h"
 
 /*
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 49e7aa1..3726065 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -18,9 +18,9 @@
 #include <linux/irq.h>
 #include <linux/bitmap.h>
 
-#include "iio.h"
-#include "trigger_consumer.h"
-#include "kfifo_buf.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/kfifo_buf.h>
 
 #include "iio_simple_dummy.h"
 
diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
index 449c7a5..f85bd19 100644
--- a/drivers/staging/iio/iio_simple_dummy_events.c
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -12,9 +12,9 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
-#include "iio.h"
-#include "sysfs.h"
-#include "events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 #include "iio_simple_dummy.h"
 
 /* Evgen 'fakes' interrupt events for this example */
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8a0485e..9d99a7f 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -19,9 +19,9 @@
 #include <linux/module.h>
 #include <asm/div64.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 #include "../ring_sw.h"
 
 #include "ad5933.h"
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 58a150c..68ecc15 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -26,9 +26,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 #include "adis16400.h"
 
 enum adis16400_chip_variant {
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index d964004..e43c0e2 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -6,9 +6,9 @@
 #include <linux/bitops.h>
 #include <linux/export.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 #include "adis16400.h"
 
 /**
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index 5bf0007..bd22e6c 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -3,8 +3,8 @@
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "adis16400.h"
 
 /**
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index b409b95..b5b2c38 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -21,10 +21,10 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 
-#include "iio.h"
+#include <linux/iio/iio.h>
 #include "iio_core.h"
-#include "sysfs.h"
-#include "buffer.h"
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 
 static const char * const iio_endian_prefix[] = {
 	[IIO_BE] = "be",
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index db55b81..dd1a6a2 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -23,11 +23,11 @@
 #include <linux/slab.h>
 #include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
-#include "iio.h"
+#include <linux/iio/iio.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
-#include "sysfs.h"
-#include "events.h"
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 
 /* IDA to assign each registered device a unique id*/
 static DEFINE_IDA(iio_ida);
diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index 5fdf739..5fcf50b 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -20,10 +20,10 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
-#include "iio.h"
+#include <linux/iio/iio.h>
 #include "iio_core.h"
-#include "sysfs.h"
-#include "events.h"
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 
 /**
  * struct iio_event_interface - chrdev interface for an event line
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 47ecadd..03fee2e 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -15,11 +15,11 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 
-#include "iio.h"
-#include "trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
-#include "trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 
 /* RFC - Question of approach
  * Make the common case (single sensor single trigger)
diff --git a/drivers/staging/iio/inkern.c b/drivers/staging/iio/inkern.c
index de2c8ea..22ddf62 100644
--- a/drivers/staging/iio/inkern.c
+++ b/drivers/staging/iio/inkern.c
@@ -11,11 +11,11 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 
-#include "iio.h"
+#include <linux/iio/iio.h>
 #include "iio_core.h"
-#include "machine.h"
-#include "driver.h"
-#include "consumer.h"
+#include <linux/iio/machine.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/consumer.h>
 
 struct iio_map_internal {
 	struct iio_dev *indio_dev;
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index 9f3bd59..6bf9d05 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -5,8 +5,7 @@
 #include <linux/workqueue.h>
 #include <linux/kfifo.h>
 #include <linux/mutex.h>
-
-#include "kfifo_buf.h"
+#include <linux/iio/kfifo_buf.h>
 
 struct iio_kfifo {
 	struct iio_buffer buffer;
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 2c894a6..92283eb 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -28,8 +28,8 @@
 #include <linux/delay.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define CONVERSION_TIME_MS		100
 
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 7057d9b..2ada20e 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -24,8 +24,8 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define CONVERSION_TIME_MS		100
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index a1e5cbe..6351360 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -35,9 +35,9 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../events.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 #include "tsl2563.h"
 
 /* Use this many bits for fraction part. */
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 8671d98..51b6362 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -28,7 +28,7 @@
 #include <linux/unistd.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include "../iio.h"
+#include <linux/iio/iio.h>
 
 #define TSL258X_MAX_DEVICE_REGS		32
 
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index ff44989..4960784 100755
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -28,10 +28,10 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/version.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "tsl2x7x.h"
-#include "../events.h"
-#include "../iio.h"
-#include "../sysfs.h"
 
 /* Cal defs*/
 #define PROX_STAT_CAL        0
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 000886f..d088548 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -30,8 +30,8 @@
 
 #include <linux/gpio.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 /*
  * Register definitions, as well as various shifts and masks to get at the
  * individual fields of the registers.
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 27c2629..3433c41 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -22,8 +22,8 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define HMC5843_I2C_ADDRESS			0x1E
 
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 57baac6..9b26ae1 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -18,8 +18,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "meter.h"
 #include "ade7753.h"
 
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 8d81c92..02d10df 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -18,8 +18,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "meter.h"
 #include "ade7754.h"
 
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 729c033..4a3b429 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -18,9 +18,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
 #include "meter.h"
 #include "ade7758.h"
 
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index b37bc98..7b9be8a 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -12,9 +12,9 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "../ring_sw.h"
-#include "../trigger_consumer.h"
+#include <linux/iio/trigger_consumer.h>
 #include "ade7758.h"
 
 /**
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index b6569c7..5c48d38 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -11,8 +11,8 @@
 #include <linux/spi/spi.h>
 #include <linux/export.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include "ade7758.h"
 
 /**
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 0beab47..1f2b74a 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -18,8 +18,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "meter.h"
 #include "ade7759.h"
 
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 1e1faa0..c87c86b 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "ade7854.h"
 
 static int ade7854_i2c_write_reg_8(struct device *dev,
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 8112186..11c2cef 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#include "../iio.h"
+#include <linux/iio/iio.h>
 #include "ade7854.h"
 
 static int ade7854_spi_write_reg_8(struct device *dev,
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 49c01c5..2f3c1e2 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -17,8 +17,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "meter.h"
 #include "ade7854.h"
 
diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
index 6a3db14..23e1b5f 100644
--- a/drivers/staging/iio/meter/meter.h
+++ b/drivers/staging/iio/meter/meter.h
@@ -1,4 +1,4 @@
-#include "../sysfs.h"
+#include <linux/iio/sysfs.h>
 
 /* metering ic types of attribute */
 
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 0465e5d..48e70e9 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -19,8 +19,8 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #define DRV_NAME "ad2s1200"
 
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index c6ced16..4d580e2 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -18,8 +18,8 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "ad2s1210.h"
 
 #define DRV_NAME "ad2s1210"
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 20ca529..cb68910 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -16,8 +16,8 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 
-#include "../iio.h"
-#include "../sysfs.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 struct ad2s90_state {
 	struct mutex lock;
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index b9945ec..9358c6c 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -15,7 +15,7 @@
 #include <linux/sched.h>
 #include <linux/poll.h>
 #include "ring_sw.h"
-#include "trigger.h"
+#include <linux/iio/trigger.h>
 
 /**
  * struct iio_sw_ring_buffer - software ring buffer
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 7556e21..a5857aa 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -23,7 +23,7 @@
 
 #ifndef _IIO_RING_SW_H_
 #define _IIO_RING_SW_H_
-#include "buffer.h"
+#include <linux/iio/buffer.h>
 
 struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev);
 void iio_sw_rb_free(struct iio_buffer *ring);
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 665653d..999fd2e 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -15,8 +15,8 @@
 
 #include <asm/gptimers.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 
 struct bfin_timer {
 	unsigned short id, bit;
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index a346594..95fd2f7 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -22,8 +22,8 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 
 static LIST_HEAD(iio_gpio_trigger_list);
 static DEFINE_MUTEX(iio_gpio_trigger_list_lock);
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index a80cf67..2c3ccda 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -16,8 +16,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/rtc.h>
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 
 static LIST_HEAD(iio_prtc_trigger_list);
 static DEFINE_MUTEX(iio_prtc_trigger_list_lock);
diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 174dc65..404ef19 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -11,8 +11,8 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 
-#include "../iio.h"
-#include "../trigger.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 
 struct iio_sysfs_trig {
 	struct iio_trigger *trig;
diff --git a/drivers/staging/iio/buffer.h b/include/linux/iio/buffer.h
similarity index 99%
rename from drivers/staging/iio/buffer.h
rename to include/linux/iio/buffer.h
index 3d3ea9e..fb0fe46 100644
--- a/drivers/staging/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -10,7 +10,7 @@
 #ifndef _IIO_BUFFER_GENERIC_H_
 #define _IIO_BUFFER_GENERIC_H_
 #include <linux/sysfs.h>
-#include "iio.h"
+#include <linux/iio/iio.h>
 
 #ifdef CONFIG_IIO_BUFFER
 
diff --git a/drivers/staging/iio/consumer.h b/include/linux/iio/consumer.h
similarity index 99%
rename from drivers/staging/iio/consumer.h
rename to include/linux/iio/consumer.h
index 36a060c..1a15e56 100644
--- a/drivers/staging/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -9,7 +9,7 @@
  */
 #ifndef _IIO_INKERN_CONSUMER_H_
 #define _IIO_INKERN_CONSUMER_H
-#include "types.h"
+#include <linux/iio/types.h>
 
 struct iio_dev;
 struct iio_chan_spec;
diff --git a/drivers/staging/iio/driver.h b/include/linux/iio/driver.h
similarity index 100%
rename from drivers/staging/iio/driver.h
rename to include/linux/iio/driver.h
diff --git a/drivers/staging/iio/events.h b/include/linux/iio/events.h
similarity index 99%
rename from drivers/staging/iio/events.h
rename to include/linux/iio/events.h
index c25f0e3..b5acbf9 100644
--- a/drivers/staging/iio/events.h
+++ b/include/linux/iio/events.h
@@ -11,7 +11,7 @@
 
 #include <linux/ioctl.h>
 #include <linux/types.h>
-#include "types.h"
+#include <linux/iio/types.h>
 
 /**
  * struct iio_event_data - The actual event being pushed to userspace
diff --git a/drivers/staging/iio/iio.h b/include/linux/iio/iio.h
similarity index 99%
rename from drivers/staging/iio/iio.h
rename to include/linux/iio/iio.h
index 0770340..9c0908a 100644
--- a/drivers/staging/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -12,7 +12,7 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
-#include "types.h"
+#include <linux/iio/types.h>
 /* IIO TODO LIST */
 /*
  * Provide means of adjusting timer accuracy.
diff --git a/drivers/staging/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
similarity index 70%
rename from drivers/staging/iio/kfifo_buf.h
rename to include/linux/iio/kfifo_buf.h
index 9f7da01..014d5a1 100644
--- a/drivers/staging/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -1,7 +1,7 @@
 
 #include <linux/kfifo.h>
-#include "iio.h"
-#include "buffer.h"
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 
 struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
 void iio_kfifo_free(struct iio_buffer *r);
diff --git a/drivers/staging/iio/machine.h b/include/linux/iio/machine.h
similarity index 100%
rename from drivers/staging/iio/machine.h
rename to include/linux/iio/machine.h
diff --git a/drivers/staging/iio/sysfs.h b/include/linux/iio/sysfs.h
similarity index 100%
rename from drivers/staging/iio/sysfs.h
rename to include/linux/iio/sysfs.h
diff --git a/drivers/staging/iio/trigger.h b/include/linux/iio/trigger.h
similarity index 100%
rename from drivers/staging/iio/trigger.h
rename to include/linux/iio/trigger.h
diff --git a/drivers/staging/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
similarity index 100%
rename from drivers/staging/iio/trigger_consumer.h
rename to include/linux/iio/trigger_consumer.h
diff --git a/drivers/staging/iio/types.h b/include/linux/iio/types.h
similarity index 100%
rename from drivers/staging/iio/types.h
rename to include/linux/iio/types.h
-- 
1.7.0.4

