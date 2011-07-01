Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 20/25] staging:iio:various  header includes that should never have been.
Date: Fri,  1 Jul 2011 11:11:11 +0100
Message-Id: <1309515076-12323-21-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I will assume these were cut and pastes messup.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260_ring.c |    1 -
 drivers/staging/iio/imu/adis16400_ring.c  |    1 -
 drivers/staging/iio/meter/ade7758_ring.c  |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index a4df8b3..e9cff3b 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -13,7 +13,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
-#include "../accel/accel.h"
 #include "../trigger.h"
 #include "adis16260.h"
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 3612373..d07c86b 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -14,7 +14,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
-#include "../accel/accel.h"
 #include "../trigger.h"
 #include "adis16400.h"
 
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index b89b7f8..e7a04b4 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -21,7 +21,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_sw.h"
-#include "../accel/accel.h"
 #include "../trigger.h"
 #include "ade7758.h"
 
-- 
1.7.3.4
