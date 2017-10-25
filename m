Return-Path: <SRS0=aVu3=BY=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/accel/bmc150: Improve unlocking of a mutex in two
 functions
Message-ID: <66d582a4-a77e-cd78-4215-49587ec2259e@users.sourceforge.net>
Date: Wed, 25 Oct 2017 16:33:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Oct 2017 16:26:29 +0200

Add a jump target so that a call of the function "mutex_unlock" is mostly
stored at the end of these function implementations.
Replace five calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/accel/bmc150-accel-core.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 870f92ef61c2..f2a85a11a5e4 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -554,18 +554,15 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 
 	mutex_lock(&data->mutex);
 	ret = bmc150_accel_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock_after_failure;
 
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
 			       &raw_val, sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
 		bmc150_accel_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock_after_failure;
 	}
 	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
@@ -575,6 +572,10 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 		return ret;
 
 	return IIO_VAL_INT;
+
+unlock_after_failure:
+	mutex_unlock(&data->mutex);
+	return ret;
 }
 
 static int bmc150_accel_read_raw(struct iio_dev *indio_dev,
@@ -1170,28 +1171,23 @@ static int bmc150_accel_trigger_set_state(struct iio_trigger *trig,
 	mutex_lock(&data->mutex);
 
 	if (t->enabled == state) {
-		mutex_unlock(&data->mutex);
-		return 0;
+		ret = 0;
+		goto unlock;
 	}
 
 	if (t->setup) {
 		ret = t->setup(t, state);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
 	}
 
 	ret = bmc150_accel_set_interrupt(data, t->intr, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	t->enabled = state;
-
+unlock:
 	mutex_unlock(&data->mutex);
-
 	return ret;
 }
 
-- 
2.14.3
