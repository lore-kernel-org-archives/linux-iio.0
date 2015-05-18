Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26832 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932619AbbERQYX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 May 2015 12:24:23 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] iio: accel: kxcjk1013: Use the new IIO pm runtime helpers
Date: Mon, 18 May 2015 19:25:28 +0300
Message-Id: <1431966328-11058-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com>
References: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 56 +++++++++++-------------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a98b5d2..308499a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -22,12 +22,12 @@
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/pm.h>
-#include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/events.h>
+#include <linux/iio/pm_runtime.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/accel/kxcjk_1013.h>
@@ -376,29 +376,6 @@ static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 }
 #endif
 
-static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
-{
-#ifdef CONFIG_PM
-	int ret;
-
-	if (on)
-		ret = pm_runtime_get_sync(&data->client->dev);
-	else {
-		pm_runtime_mark_last_busy(&data->client->dev);
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: kxcjk1013_set_power_state for %d\n", on);
-		if (on)
-			pm_runtime_put_noidle(&data->client->dev);
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
 	int ret;
@@ -700,19 +677,22 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 		if (iio_buffer_enabled(indio_dev))
 			ret = -EBUSY;
 		else {
-			ret = kxcjk1013_set_power_state(data, true);
+			ret = iio_pm_runtime_set_power(&data->client->dev,
+						       true);
 			if (ret < 0) {
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
 			ret = kxcjk1013_get_acc_reg(data, chan->scan_index);
 			if (ret < 0) {
-				kxcjk1013_set_power_state(data, false);
+				iio_pm_runtime_set_power(&data->client->dev,
+							 false);
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
 			*val = sign_extend32(ret >> 4, 11);
-			ret = kxcjk1013_set_power_state(data, false);
+			ret = iio_pm_runtime_set_power(&data->client->dev,
+						       false);
 		}
 		mutex_unlock(&data->mutex);
 
@@ -855,7 +835,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 	 * enable operation. When runtime pm is disabled the mode
 	 * is always on so sequence doesn't matter
 	 */
-	ret = kxcjk1013_set_power_state(data, state);
+	ret = iio_pm_runtime_set_power(&data->client->dev, state);
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -863,7 +843,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 
 	ret =  kxcjk1013_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
-		kxcjk1013_set_power_state(data, false);
+		iio_pm_runtime_set_power(&data->client->dev, false);
 		data->ev_enable_state = 0;
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -1005,7 +985,7 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		return 0;
 	}
 
-	ret = kxcjk1013_set_power_state(data, state);
+	ret = iio_pm_runtime_set_power(&data->client->dev, state);
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -1015,7 +995,7 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	else
 		ret = kxcjk1013_setup_new_data_interrupt(data, state);
 	if (ret < 0) {
-		kxcjk1013_set_power_state(data, false);
+		iio_pm_runtime_set_power(&data->client->dev, false);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -1293,16 +1273,11 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		dev_err(&client->dev, "unable to register iio device\n");
 		goto err_buffer_cleanup;
 	}
-
-	ret = pm_runtime_set_active(&client->dev);
+	ret = iio_pm_runtime_setup(&client->dev, KXCJK1013_SLEEP_DELAY_MS,
+				   false);
 	if (ret)
 		goto err_iio_unregister;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev,
-					 KXCJK1013_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
-
 	return 0;
 
 err_iio_unregister:
@@ -1326,10 +1301,7 @@ static int kxcjk1013_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
-
+	iio_pm_runtime_cleanup(&client->dev);
 	iio_device_unregister(indio_dev);
 
 	if (data->dready_trig) {
-- 
1.9.1

