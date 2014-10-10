Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36038 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbaJJQbe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Oct 2014 12:31:34 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] iio: accel: bmc150: Error handling when mode set fails
Date: Fri, 10 Oct 2014 09:30:26 -0700
Message-Id: <1412958629-30776-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When mode set fails due to some transient failures, it will atleast
reset the state of runtime usage count and also let the runtime
suspend retry from the driver framework.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 22c096c..fdb101c 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -536,6 +536,9 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: bmc150_accel_set_power_state for %d\n", on);
+		if (on)
+			pm_runtime_put_noidle(&data->client->dev);
+
 		return ret;
 	}
 
@@ -811,6 +814,7 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 
 	ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
+		bmc150_accel_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -1054,6 +1058,7 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	else
 		ret = bmc150_accel_setup_new_data_interrupt(data, state);
 	if (ret < 0) {
+		bmc150_accel_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -1354,10 +1359,14 @@ static int bmc150_accel_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	int ret;
 
 	dev_dbg(&data->client->dev,  __func__);
+	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, 0);
+	if (ret < 0)
+		return -EAGAIN;
 
-	return bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, 0);
+	return 0;
 }
 
 static int bmc150_accel_runtime_resume(struct device *dev)
-- 
1.9.3

