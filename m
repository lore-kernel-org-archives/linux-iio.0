Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47543 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450Ab1F2Ln4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2011 07:43:56 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 20/24] staging:iio:various  header includes that should never have been.
Date: Wed, 29 Jun 2011 12:51:52 +0100
Message-Id: <1309348316-7699-21-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
References: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

