Return-Path: <adriana.reus@intel.com>
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	irina.tirdea@intel.com,
	daniel.baluta@intel.com,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH] iio: Reconcile operation order between iio_register/unregister and pm functions
Date: Thu,  5 Nov 2015 16:25:29 +0200
Message-Id: <1446733529-7277-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

At probe, runtime pm should be setup before registering the sysfs interface so
that all the power attributes are accurate and functional when registering.
Also, when removing the device we should unregister first to make sure
that the interfaces that may result in wakeups are no longer available.

Fix this behaviour for the following drivers: bmc150, bmg160, kmx61,
kxcj-1013, mma9551, mma9553, rpr0521.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/accel/bmc150-accel-core.c  | 20 +++++++++-----------
 drivers/iio/accel/kxcjk-1013.c         | 20 +++++++++-----------
 drivers/iio/accel/mma9551.c            | 19 +++++++++----------
 drivers/iio/accel/mma9553.c            | 20 +++++++++-----------
 drivers/iio/gyro/bmg160_core.c         | 19 +++++++++----------
 drivers/iio/imu/kmx61.c                | 24 +++++++++++-------------
 drivers/iio/light/rpr0521.c            | 14 ++++----------
 drivers/iio/magnetometer/bmc150_magn.c | 20 +++++++++-----------
 8 files changed, 69 insertions(+), 87 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 2d33f1e..c73331f7 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1623,24 +1623,22 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		}
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "Unable to register iio device\n");
-		goto err_trigger_unregister;
-	}
-
 	ret = pm_runtime_set_active(dev);
 	if (ret)
-		goto err_iio_unregister;
+		goto err_trigger_unregister;
 
 	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, BMC150_AUTO_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(dev, "Unable to register iio device\n");
+		goto err_trigger_unregister;
+	}
+
 	return 0;
 
-err_iio_unregister:
-	iio_device_unregister(indio_dev);
 err_trigger_unregister:
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
 err_buffer_cleanup:
@@ -1655,12 +1653,12 @@ int bmc150_accel_core_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	pm_runtime_disable(data->dev);
 	pm_runtime_set_suspended(data->dev);
 	pm_runtime_put_noidle(data->dev);
 
-	iio_device_unregister(indio_dev);
-
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
 
 	iio_triggered_buffer_cleanup(indio_dev);
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 18c1b06..edec1d0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1264,25 +1264,23 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		goto err_trigger_unregister;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
-	}
-
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
-		goto err_iio_unregister;
+		goto err_buffer_cleanup;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 KXCJK1013_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to register iio device\n");
+		goto err_buffer_cleanup;
+	}
+
 	return 0;
 
-err_iio_unregister:
-	iio_device_unregister(indio_dev);
 err_buffer_cleanup:
 	if (data->dready_trig)
 		iio_triggered_buffer_cleanup(indio_dev);
@@ -1302,12 +1300,12 @@ static int kxcjk1013_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
-	iio_device_unregister(indio_dev);
-
 	if (data->dready_trig) {
 		iio_triggered_buffer_cleanup(indio_dev);
 		iio_trigger_unregister(data->dready_trig);
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 7db7cc0..d899a4d 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -495,25 +495,23 @@ static int mma9551_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto out_poweroff;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
-		goto out_poweroff;
-	}
-
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		goto out_iio_unregister;
+		goto out_poweroff;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 MMA9551_AUTO_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to register iio device\n");
+		goto out_poweroff;
+	}
+
 	return 0;
 
-out_iio_unregister:
-	iio_device_unregister(indio_dev);
 out_poweroff:
 	mma9551_set_device_state(client, false);
 
@@ -525,11 +523,12 @@ static int mma9551_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma9551_data *data = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
-	iio_device_unregister(indio_dev);
 	mutex_lock(&data->mutex);
 	mma9551_set_device_state(data->client, false);
 	mutex_unlock(&data->mutex);
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 9408ef3..fa7d362 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1133,27 +1133,24 @@ static int mma9553_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
-		goto out_poweroff;
-	}
-
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		goto out_iio_unregister;
+		goto out_poweroff;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 MMA9551_AUTO_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to register iio device\n");
+		goto out_poweroff;
+	}
 
+	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
 	return 0;
 
-out_iio_unregister:
-	iio_device_unregister(indio_dev);
 out_poweroff:
 	mma9551_set_device_state(client, false);
 	return ret;
@@ -1164,11 +1161,12 @@ static int mma9553_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma9553_data *data = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
-	iio_device_unregister(indio_dev);
 	mutex_lock(&data->mutex);
 	mma9551_set_device_state(data->client, false);
 	mutex_unlock(&data->mutex);
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 02ff789..bbce3b0 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1077,25 +1077,23 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		goto err_trigger_unregister;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
-	}
-
 	ret = pm_runtime_set_active(dev);
 	if (ret)
-		goto err_iio_unregister;
+		goto err_buffer_cleanup;
 
 	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev,
 					 BMG160_AUTO_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(dev, "unable to register iio device\n");
+		goto err_buffer_cleanup;
+	}
+
 	return 0;
 
-err_iio_unregister:
-	iio_device_unregister(indio_dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
@@ -1113,11 +1111,12 @@ void bmg160_core_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmg160_data *data = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 	pm_runtime_put_noidle(dev);
 
-	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 
 	if (data->dready_trig) {
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index dbf5e99..e5306b4 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1390,6 +1390,14 @@ static int kmx61_probe(struct i2c_client *client,
 		}
 	}
 
+	ret = pm_runtime_set_active(&client->dev);
+	if (ret < 0)
+		goto err_buffer_cleanup_mag;
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, KMX61_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(&client->dev);
+
 	ret = iio_device_register(data->acc_indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register acc iio device\n");
@@ -1402,18 +1410,8 @@ static int kmx61_probe(struct i2c_client *client,
 		goto err_iio_unregister_acc;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
-	if (ret < 0)
-		goto err_iio_unregister_mag;
-
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev, KMX61_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
-
 	return 0;
 
-err_iio_unregister_mag:
-	iio_device_unregister(data->mag_indio_dev);
 err_iio_unregister_acc:
 	iio_device_unregister(data->acc_indio_dev);
 err_buffer_cleanup_mag:
@@ -1437,13 +1435,13 @@ static int kmx61_remove(struct i2c_client *client)
 {
 	struct kmx61_data *data = i2c_get_clientdata(client);
 
+	iio_device_unregister(data->acc_indio_dev);
+	iio_device_unregister(data->mag_indio_dev);
+
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
-	iio_device_unregister(data->acc_indio_dev);
-	iio_device_unregister(data->mag_indio_dev);
-
 	if (client->irq > 0) {
 		iio_triggered_buffer_cleanup(data->acc_indio_dev);
 		iio_triggered_buffer_cleanup(data->mag_indio_dev);
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 4b75bb0..7de0f39 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -507,34 +507,28 @@ static int rpr0521_probe(struct i2c_client *client,
 		dev_err(&client->dev, "rpr0521 chip init failed\n");
 		return ret;
 	}
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		return ret;
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		goto err_iio_unregister;
+		return ret;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	return 0;
-
-err_iio_unregister:
-	iio_device_unregister(indio_dev);
-	return ret;
+	return iio_device_register(indio_dev);
 }
 
 static int rpr0521_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
+	iio_device_unregister(indio_dev);
+
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
-	iio_device_unregister(indio_dev);
 	rpr0521_poweroff(iio_priv(indio_dev));
 
 	return 0;
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 1615b23..ffcb75e 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -928,27 +928,24 @@ static int bmc150_magn_probe(struct i2c_client *client,
 		goto err_free_irq;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
-	}
-
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
-		goto err_iio_unregister;
+		goto err_buffer_cleanup;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 BMC150_MAGN_AUTO_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to register iio device\n");
+		goto err_buffer_cleanup;
+	}
 
+	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
 	return 0;
 
-err_iio_unregister:
-	iio_device_unregister(indio_dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_free_irq:
@@ -967,11 +964,12 @@ static int bmc150_magn_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
-	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 
 	if (client->irq > 0)
-- 
1.9.1
