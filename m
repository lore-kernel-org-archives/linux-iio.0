Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 4/4] iio: accel: bmc150: Fix iio_event_spec direction
Date: Fri, 10 Oct 2014 20:35:34 -0700
Message-Id: <1412998534-31971-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Change event spec direction from
IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING
to
IIO_EV_DIR_EITHER

Suggested-by: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 969cb21..513bd6d 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -853,7 +853,7 @@ static const struct attribute_group bmc150_accel_attrs_group = {
 
 static const struct iio_event_spec bmc150_accel_event = {
 		.type = IIO_EV_TYPE_ROC,
-		.dir = IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING,
+		.dir = IIO_EV_DIR_EITHER,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 				 BIT(IIO_EV_INFO_ENABLE) |
 				 BIT(IIO_EV_INFO_PERIOD)
-- 
1.9.1
