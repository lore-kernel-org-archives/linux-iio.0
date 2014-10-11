Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 3/4] iio: accel: bmc150: set low default thresholds
Date: Fri, 10 Oct 2014 20:35:33 -0700
Message-Id: <1412998534-31971-4-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Set the threshold to low by default. With this thresholds any movement
on the device with this sensor will generate event.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index c6df8ee..969cb21 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -95,9 +95,9 @@
 #define BMC150_ACCEL_SLOPE_THRES_MASK		0xFF
 
 /* Slope duration in terms of number of samples */
-#define BMC150_ACCEL_DEF_SLOPE_DURATION	2
+#define BMC150_ACCEL_DEF_SLOPE_DURATION		1
 /* in terms of multiples of g's/LSB, based on range */
-#define BMC150_ACCEL_DEF_SLOPE_THRESHOLD	5
+#define BMC150_ACCEL_DEF_SLOPE_THRESHOLD	1
 
 #define BMC150_ACCEL_REG_XOUT_L		0x02
 
-- 
1.9.1
