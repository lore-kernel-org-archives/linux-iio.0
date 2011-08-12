Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/19] staging:iio:adc: header cleanup - remove unused.
Date: Fri, 12 Aug 2011 17:08:46 +0100
Message-Id: <1313165333-3951-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
References: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Clear out all the excessive includes in the *_ring.c files.
Mixture of cut and paste bloat and things needed for code that
has gone away.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7298_ring.c  |    3 ---
 drivers/staging/iio/adc/ad7476_ring.c  |    2 --
 drivers/staging/iio/adc/ad7606_ring.c  |    2 --
 drivers/staging/iio/adc/ad7887_ring.c  |    3 ---
 drivers/staging/iio/adc/ad799x_ring.c  |    3 ---
 drivers/staging/iio/adc/max1363_ring.c |    4 ----
 6 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index a04c033..7423d4a 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -7,17 +7,14 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
-#include "../sysfs.h"
 
 #include "ad7298.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index a92fc5a..86bbba8 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -11,14 +11,12 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
-#include "../sysfs.h"
 
 #include "ad7476.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index a199bf4..f8f574a 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -10,13 +10,11 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
-#include "../sysfs.h"
 
 #include "ad7606.h"
 
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 0ac7c0b..b77b120 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -8,17 +8,14 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
 #include "../ring_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
-#include "../sysfs.h"
 
 #include "ad7887.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 0376a82..d84efd6 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -10,10 +10,8 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
-#include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/i2c.h>
 #include <linux/bitops.h>
@@ -22,7 +20,6 @@
 #include "../ring_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
-#include "../sysfs.h"
 
 #include "ad799x.h"
 
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index f43befd..696676f 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -9,11 +9,8 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/i2c.h>
 #include <linux/bitops.h>
 
@@ -21,7 +18,6 @@
 #include "../ring_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
-#include "../sysfs.h"
 
 #include "max1363.h"
 
-- 
1.7.3.4
