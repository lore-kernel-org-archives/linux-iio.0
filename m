Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] iio: accel: bmc150: Send x, y and z motion separately
Date: Fri, 10 Oct 2014 09:30:27 -0700
Message-Id: <1412958629-30776-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412958629-30776-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1412958629-30776-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This chip is capable to identify motion across x, y and z axes. So
send different events.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index fdb101c..352d959 100644
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
@@ -850,7 +853,7 @@ static const struct attribute_group bmc150_accel_attrs_group = {
 
 static const struct iio_event_spec bmc150_accel_event = {
 		.type = IIO_EV_TYPE_ROC,
-		.dir = IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING,
+		.dir = IIO_EV_DIR_EITHER,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 				 BIT(IIO_EV_INFO_ENABLE) |
 				 BIT(IIO_EV_INFO_PERIOD)
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
1.9.3
