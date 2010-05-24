Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/11] staging:iio:max1363 trivial code and comment cleanups.
Date: Mon, 24 May 2010 22:02:47 +0100
Message-Id: <1274734976-7941-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |    7 +++----
 drivers/staging/iio/adc/max1363_ring.c |   10 +++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 0b21c1c..3d2f8d9 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -23,16 +23,15 @@
   */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/i2c.h>
-#include <linux/rtc.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/err.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -48,7 +47,7 @@
 	IIO_SCAN_EL_C(in##number, number, IIO_UNSIGNED(16), 0, NULL);
 #define MAX1363_SCAN_EL_D(p, n, number)					\
 	IIO_SCAN_NAMED_EL_C(in##p##m##in##n, in##p-in##n,		\
-			number, IIO_SIGNED(16), 0 , NULL);
+			number, IIO_SIGNED(16), 0, NULL);
 
 static MAX1363_SCAN_EL(0);
 static MAX1363_SCAN_EL(1);
@@ -167,7 +166,7 @@ static int max1363_write_basic_config(struct i2c_client *client,
 				      unsigned char d2)
 {
 	int ret;
-	u8 *tx_buf = kmalloc(2 , GFP_KERNEL);
+	u8 *tx_buf = kmalloc(2, GFP_KERNEL);
 
 	if (!tx_buf)
 		return -ENOMEM;
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 56688dc..a69d1ec 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -68,7 +68,7 @@ error_ret:
 }
 
 /**
- * max1363_ring_preenable() setup the parameters of the ring before enabling
+ * max1363_ring_preenable() - setup the parameters of the ring before enabling
  *
  * The complex nature of the setting of the nuber of bytes per datum is due
  * to this driver currently ensuring that the timestamp is stored at an 8
@@ -106,7 +106,7 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 }
 
 /**
- * max1363_ring_postenable() typical ring post enable
+ * max1363_ring_postenable() - typical ring post enable
  *
  * Only not moved into the core for the hardware ring buffer cases
  * that are more sophisticated.
@@ -120,7 +120,7 @@ static int max1363_ring_postenable(struct iio_dev *indio_dev)
 }
 
 /**
- * max1363_ring_predisable() runs just prior to ring buffer being disabled
+ * max1363_ring_predisable() - runs just prior to ring buffer being disabled
  *
  * Typical predisable function which ensures that no trigger events can
  * occur before we disable the ring buffer (and hence would have no idea
@@ -136,7 +136,7 @@ static int max1363_ring_predisable(struct iio_dev *indio_dev)
 }
 
 /**
- * max1363_poll_func_th() th of trigger launched polling to ring buffer
+ * max1363_poll_func_th() - th of trigger launched polling to ring buffer
  *
  * As sampling only occurs on i2c comms occuring, leave timestamping until
  * then.  Some triggers will generate their own time stamp.  Currently
@@ -151,7 +151,7 @@ static void max1363_poll_func_th(struct iio_dev *indio_dev)
 	return;
 }
 /**
- * max1363_poll_bh_to_ring() bh of trigger launched polling to ring buffer
+ * max1363_poll_bh_to_ring() - bh of trigger launched polling to ring buffer
  * @work_s:	the work struct through which this was scheduled
  *
  * Currently there is no option in this driver to disable the saving of
-- 
1.7.0.4
