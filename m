Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:49296 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756098Ab1GAKDN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jul 2011 06:03:13 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 19/25] staging:iio:adc: unused header removals.
Date: Fri,  1 Jul 2011 11:11:10 +0100
Message-Id: <1309515076-12323-20-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

More headers now not needed after iio_chan_spec conversions.
A couple of drivers were using helpers from adc.h.

Given these were trivial, they are pushed down into the drivers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7298_core.c  |    1 -
 drivers/staging/iio/adc/ad7476_core.c  |    1 -
 drivers/staging/iio/adc/ad7606_core.c  |    1 -
 drivers/staging/iio/adc/ad7780.c       |    1 -
 drivers/staging/iio/adc/ad7793.c       |    1 -
 drivers/staging/iio/adc/ad7887_core.c  |    2 +-
 drivers/staging/iio/adc/ad799x_core.c  |   13 +++++++++----
 drivers/staging/iio/adc/max1363_core.c |   23 +++++++++++++++++------
 8 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index b8e4ae2..21d1931 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -18,7 +18,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "adc.h"
 
 #include "ad7298.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 768f3ec..a2a4bf7 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -17,7 +17,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "adc.h"
 
 #include "ad7476.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 459371a..dcdb180 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -20,7 +20,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "adc.h"
 
 #include "ad7606.h"
 
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index e0c7b6c..f90cdea 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -20,7 +20,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "adc.h"
 
 #include "ad7780.h"
 
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 90f6c03..ab6f109 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -22,7 +22,6 @@
 #include "../ring_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
-#include "adc.h"
 
 #include "ad7793.h"
 
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 3d9121e..a7da9e6 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -17,7 +17,7 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "adc.h"
+
 
 #include "ad7887.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 92cfe2e..d42d61d 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -34,9 +34,8 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-
 #include "../ring_generic.h"
-#include "adc.h"
+
 #include "ad799x.h"
 
 /*
@@ -336,8 +335,14 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 		if (status & (1 << i))
 			iio_push_event(indio_dev, 0,
 				       i & 0x1 ?
-				       IIO_EVENT_CODE_IN_HIGH_THRESH(i >> 1) :
-				       IIO_EVENT_CODE_IN_LOW_THRESH(i >> 1),
+				       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+							    (i >> 1),
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING) :
+				       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+							    (i >> 1),
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_FALLING),
 				       iio_get_time_ns());
 	}
 
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 72b0917..3fee89e 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -33,9 +33,8 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-
 #include "../ring_generic.h"
-#include "adc.h"
+
 #include "max1363.h"
 
 #define MAX1363_MODE_SINGLE(_num, _mask) {				\
@@ -592,10 +591,22 @@ static int max1363_write_thresh(struct iio_dev *indio_dev,
 }
 
 static const int max1363_event_codes[] = {
-	IIO_EVENT_CODE_IN_LOW_THRESH(3), IIO_EVENT_CODE_IN_HIGH_THRESH(3),
-	IIO_EVENT_CODE_IN_LOW_THRESH(2), IIO_EVENT_CODE_IN_HIGH_THRESH(2),
-	IIO_EVENT_CODE_IN_LOW_THRESH(1), IIO_EVENT_CODE_IN_HIGH_THRESH(1),
-	IIO_EVENT_CODE_IN_LOW_THRESH(0), IIO_EVENT_CODE_IN_HIGH_THRESH(0)
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 0,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 1,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 2,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 3,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 0,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 1,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 2,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, 3,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
 };
 
 static irqreturn_t max1363_event_handler(int irq, void *private)
-- 
1.7.3.4

