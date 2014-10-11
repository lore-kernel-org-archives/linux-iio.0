Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 1/4] iio: gyro: bmg160: Error handling when mode set fails
Date: Fri, 10 Oct 2014 20:33:25 -0700
Message-Id: <1412998408-31870-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998408-31870-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1412998408-31870-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

When mode set fails due to some transient failures, it will atleast
reset the state of runtime usage count and also let the runtime
suspend retry from the driver framework.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/bmg160.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 1f967e0d..22bf9db 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -250,6 +250,9 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: bmg160_set_power_state for %d\n", on);
+		if (on)
+			pm_runtime_put_noidle(&data->client->dev);
+
 		return ret;
 	}
 #endif
@@ -705,6 +708,7 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 
 	ret =  bmg160_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
+		bmg160_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -871,6 +875,7 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	else
 		ret = bmg160_setup_new_data_interrupt(data, state);
 	if (ret < 0) {
+		bmg160_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -1169,8 +1174,15 @@ static int bmg160_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct bmg160_data *data = iio_priv(indio_dev);
+	int ret;
 
-	return bmg160_set_mode(data, BMG160_MODE_SUSPEND);
+	ret = bmg160_set_mode(data, BMG160_MODE_SUSPEND);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "set mode failed\n");
+		return -EAGAIN;
+	}
+
+	return 0;
 }
 
 static int bmg160_runtime_resume(struct device *dev)
-- 
1.9.1
