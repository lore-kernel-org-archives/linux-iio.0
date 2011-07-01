Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:49301 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203Ab1GAKDN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jul 2011 06:03:13 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 17/25] staging:iio:accel: usused header removals.
Date: Fri,  1 Jul 2011 11:11:08 +0100
Message-Id: <1309515076-12323-18-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Missing from the iio_chan_spec conversion patches.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c |    4 ----
 drivers/staging/iio/accel/adis16201_ring.c |    1 -
 drivers/staging/iio/accel/adis16203_core.c |    3 ---
 drivers/staging/iio/accel/adis16203_ring.c |    1 -
 drivers/staging/iio/accel/adis16204_ring.c |    1 -
 drivers/staging/iio/accel/adis16209_core.c |    3 ---
 drivers/staging/iio/accel/adis16209_ring.c |    1 -
 drivers/staging/iio/accel/adis16240_core.c |    2 --
 drivers/staging/iio/accel/adis16240_ring.c |    1 -
 drivers/staging/iio/accel/lis3l02dq_core.c |    2 --
 drivers/staging/iio/accel/lis3l02dq_ring.c |    1 -
 drivers/staging/iio/accel/sca3000_core.c   |    1 -
 drivers/staging/iio/accel/sca3000_ring.c   |    1 -
 13 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index cbc59c5..aff1118 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -18,10 +18,6 @@
 #include "../sysfs.h"
 #include "../ring_generic.h"
 
-#include "accel.h"
-#include "inclinometer.h"
-#include "../adc/adc.h"
-
 #include "adis16201.h"
 
 enum adis16201_chan {
diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 66e708d..aa4e465 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -10,7 +10,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
-#include "accel.h"
 #include "../trigger.h"
 #include "adis16201.h"
 
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index bf19888..034115a 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -16,10 +16,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "accel.h"
-#include "inclinometer.h"
 #include "../ring_generic.h"
-#include "../adc/adc.h"
 
 #include "adis16203.h"
 
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index d2c07c5..7ca9c25 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -13,7 +13,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
-#include "accel.h"
 #include "../trigger.h"
 #include "adis16203.h"
 
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 852df06..537d463 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -13,7 +13,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
-#include "accel.h"
 #include "../trigger.h"
 #include "adis16204.h"
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 55f3a7b..70a7e29 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -18,9 +18,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "accel.h"
-#include "inclinometer.h"
-#include "../adc/adc.h"
 
 #include "adis16209.h"
 
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 45017d3..77b70e3 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -13,7 +13,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
-#include "accel.h"
 #include "../trigger.h"
 #include "adis16209.h"
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 4a4eafc..b9dd92d 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -21,8 +21,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "accel.h"
-#include "../adc/adc.h"
 
 #include "adis16240.h"
 
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index c812a34..3f1e159 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -13,7 +13,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
-#include "accel.h"
 #include "../trigger.h"
 #include "adis16240.h"
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index ba5bc67..c032d60 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -26,8 +26,6 @@
 #include "../sysfs.h"
 #include "../ring_generic.h"
 
-#include "accel.h"
-
 #include "lis3l02dq.h"
 
 /* At the moment the spi framework doesn't allow global setting of cs_change.
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 5795f82..7305c78 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -12,7 +12,6 @@
 #include "../sysfs.h"
 #include "../ring_sw.h"
 #include "../kfifo_buf.h"
-#include "accel.h"
 #include "../trigger.h"
 #include "lis3l02dq.h"
 
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 4313f73..993542f 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -22,7 +22,6 @@
 #include "../sysfs.h"
 #include "../ring_generic.h"
 
-#include "accel.h"
 #include "sca3000.h"
 
 enum sca3000_variant {
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index a704c75..db9cf98 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -24,7 +24,6 @@
 #include "../sysfs.h"
 #include "../ring_generic.h"
 #include "../ring_hw.h"
-#include "accel.h"
 #include "sca3000.h"
 
 /* RFC / future work
-- 
1.7.3.4

