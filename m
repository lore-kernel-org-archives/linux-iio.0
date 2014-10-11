Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 2/4] iio: accel: bmc150: Send x, y and z motion separately
Date: Fri, 10 Oct 2014 20:35:32 -0700
Message-Id: <1412998534-31971-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This chip is capable to identify motion across x, y and z axes. So
send different events.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index fdb101c..c6df8ee 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -44,6 +44,9 @@
 
 #define BMC150_ACCEL_REG_INT_STATUS_2		0x0B
 #define BMC150_ACCEL_ANY_MOTION_MASK		0x07
+#define BMC150_ACCEL_ANY_MOTION_BIT_X		BIT(0)
+#define BMC150_ACCEL_ANY_MOTION_BIT_Y		BIT(1)
+#define BMC150_ACCEL_ANY_MOTION_BIT_Z		BIT(2)
 #define BMC150_ACCEL_ANY_MOTION_BIT_SIGN	BIT(3)
 
 #define BMC150_ACCEL_REG_PMU_LPW		0x11
@@ -1097,12 +1100,26 @@ static irqreturn_t bmc150_accel_event_handler(int irq, void *private)
 	else
 		dir = IIO_EV_DIR_RISING;
 
-	if (ret & BMC150_ACCEL_ANY_MOTION_MASK)
+	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_X)
 		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
 							0,
-							IIO_MOD_X_OR_Y_OR_Z,
+							IIO_MOD_X,
 							IIO_EV_TYPE_ROC,
-							IIO_EV_DIR_EITHER),
+							dir),
+							data->timestamp);
+	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Y)
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
+							0,
+							IIO_MOD_Y,
+							IIO_EV_TYPE_ROC,
+							dir),
+							data->timestamp);
+	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Z)
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
+							0,
+							IIO_MOD_Z,
+							IIO_EV_TYPE_ROC,
+							dir),
 							data->timestamp);
 ack_intr_status:
 	if (!data->dready_trigger_on)
-- 
1.9.1
