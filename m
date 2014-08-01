Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 1/2] iio: accel: kxcjk-1013: support runtime pm
Date: Fri,  1 Aug 2014 09:49:21 -0700
Message-Id: <1406911762-6503-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1406911762-6503-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1406911762-6503-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

In an effort to improve raw read performance and at the same time enter
low power state at every possible chance.
For raw reads, it will keep the system powered on for a default or user
specified time, via autosuspend_delay attribute of device power.
This will help read multiple samples without power on/off sequence.
For triggers it will keep the system on till, requested to be turned
off by trigger state by utilizing run time PM usage counters.

When runtime pm is not enabled, then it fallbacks to current scheme
of on/off after each read.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 220 +++++++++++++++++++++++++++++++----------
 1 file changed, 170 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7941cf2..035ba23 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -21,6 +21,8 @@
 #include <linux/string.h>
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -71,15 +73,17 @@
 #define KXCJK1013_DATA_MASK_12_BIT	0x0FFF
 #define KXCJK1013_MAX_STARTUP_TIME_US	100000
 
+#define KXCJK1013_SLEEP_DELAY_MS	2000
+
 struct kxcjk1013_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	bool trig_mode;
 	struct mutex mutex;
 	s16 buffer[8];
-	int power_state;
 	u8 odr_bits;
 	bool active_high_intr;
+	bool trigger_on;
 };
 
 enum kxcjk1013_axis {
@@ -138,6 +142,25 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 	return 0;
 }
 
+static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
+			      enum kxcjk1013_mode *mode)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
+		return ret;
+	}
+
+	if (ret & KXCJK1013_REG_CTRL1_BIT_PC1)
+		*mode = OPERATION;
+	else
+		*mode = STANDBY;
+
+	return 0;
+}
+
 static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 {
 	int ret;
@@ -204,10 +227,64 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	return 0;
 }
 
+static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(odr_start_up_times); ++i) {
+		if (odr_start_up_times[i].odr_bits == data->odr_bits)
+			return odr_start_up_times[i].usec;
+	}
+
+	return KXCJK1013_MAX_STARTUP_TIME_US;
+}
+
+static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
+{
+	int ret;
+
+#ifdef CONFIG_PM_RUNTIME
+	if (on)
+		ret = pm_runtime_get_sync(&data->client->dev);
+	else {
+		pm_runtime_mark_last_busy(&data->client->dev);
+		ret = pm_runtime_put_autosuspend(&data->client->dev);
+	}
+#else
+	if (on) {
+		ret = kxcjk1013_set_mode(data, OPERATION);
+		if (!ret) {
+			int sleep_val;
+
+			sleep_val = kxcjk1013_get_startup_times(data);
+			if (sleep_val < 20000)
+				usleep_range(sleep_val, 20000);
+			else
+				msleep_interruptible(sleep_val/1000);
+
+		}
+	} else
+		ret = kxcjk1013_set_mode(data, STANDBY);
+#endif
+
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"Failed: kxcjk1013_set_power_state for %d\n", on);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int kxcjk1013_chip_setup_interrupt(struct kxcjk1013_data *data,
 					  bool status)
 {
 	int ret;
+	enum kxcjk1013_mode store_mode;
+
+	ret = kxcjk1013_get_mode(data, &store_mode);
+	if (ret < 0)
+		return ret;
 
 	/* This is requirement by spec to change state to STANDBY */
 	ret = kxcjk1013_set_mode(data, STANDBY);
@@ -250,7 +327,13 @@ static int kxcjk1013_chip_setup_interrupt(struct kxcjk1013_data *data,
 		return ret;
 	}
 
-	return ret;
+	if (store_mode == OPERATION) {
+		ret = kxcjk1013_set_mode(data, OPERATION);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int kxcjk1013_convert_freq_to_bit(int val, int val2)
@@ -271,6 +354,11 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 {
 	int ret;
 	int odr_bits;
+	enum kxcjk1013_mode store_mode;
+
+	ret = kxcjk1013_get_mode(data, &store_mode);
+	if (ret < 0)
+		return ret;
 
 	odr_bits = kxcjk1013_convert_freq_to_bit(val, val2);
 	if (odr_bits < 0)
@@ -290,9 +378,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
 	data->odr_bits = odr_bits;
 
-	/* Check, if the ODR is changed after data enable */
-	if (data->power_state) {
-		/* Set the state back to operation */
+	if (store_mode == OPERATION) {
 		ret = kxcjk1013_set_mode(data, OPERATION);
 		if (ret < 0)
 			return ret;
@@ -331,18 +417,6 @@ static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
 	return ret;
 }
 
-static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(odr_start_up_times); ++i) {
-		if (odr_start_up_times[i].odr_bits == data->odr_bits)
-			return odr_start_up_times[i].usec;
-	}
-
-	return KXCJK1013_MAX_STARTUP_TIME_US;
-}
-
 static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan, int *val,
 			      int *val2, long mask)
@@ -356,29 +430,25 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 		if (iio_buffer_enabled(indio_dev))
 			ret = -EBUSY;
 		else {
-			int sleep_val;
-
-			ret = kxcjk1013_set_mode(data, OPERATION);
+			ret = kxcjk1013_set_power_state(data, true);
 			if (ret < 0) {
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
-			++data->power_state;
-			sleep_val = kxcjk1013_get_startup_times(data);
-			if (sleep_val < 20000)
-				usleep_range(sleep_val, 20000);
-			else
-				msleep_interruptible(sleep_val/1000);
 			ret = kxcjk1013_get_acc_reg(data, chan->scan_index);
-			if (--data->power_state == 0)
-				kxcjk1013_set_mode(data, STANDBY);
+			if (ret < 0) {
+				kxcjk1013_set_power_state(data, false);
+				mutex_unlock(&data->mutex);
+				return ret;
+			}
+			*val = sign_extend32(ret >> 4, 11);
+			ret = kxcjk1013_set_power_state(data, false);
 		}
 		mutex_unlock(&data->mutex);
 
 		if (ret < 0)
 			return ret;
 
-		*val = sign_extend32(ret >> 4, 11);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -520,20 +590,21 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (state && data->trigger_on)
+		return 0;
 
 	mutex_lock(&data->mutex);
-	if (state) {
-		kxcjk1013_chip_setup_interrupt(data, true);
-		kxcjk1013_set_mode(data, OPERATION);
-		++data->power_state;
-	} else {
-		if (--data->power_state) {
+	ret = kxcjk1013_chip_setup_interrupt(data, state);
+	if (!ret) {
+		ret = kxcjk1013_set_power_state(data, state);
+		if (ret < 0) {
 			mutex_unlock(&data->mutex);
-			return 0;
+			return ret;
 		}
-		kxcjk1013_chip_setup_interrupt(data, false);
-		kxcjk1013_set_mode(data, STANDBY);
 	}
+	data->trigger_on = state;
 	mutex_unlock(&data->mutex);
 
 	return 0;
@@ -661,14 +732,25 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = devm_iio_device_register(&client->dev, indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "unable to register iio device\n");
 		goto err_buffer_cleanup;
 	}
 
+	ret = pm_runtime_set_active(&client->dev);
+	if (ret)
+		goto err_iio_unregister;
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev,
+					 KXCJK1013_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(&client->dev);
+
 	return 0;
 
+err_iio_unregister:
+	iio_device_unregister(indio_dev);
 err_buffer_cleanup:
 	if (data->trig_mode)
 		iio_triggered_buffer_cleanup(indio_dev);
@@ -687,6 +769,12 @@ static int kxcjk1013_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+
+	iio_device_unregister(indio_dev);
+
 	if (data->trig_mode) {
 		iio_triggered_buffer_cleanup(indio_dev);
 		iio_trigger_unregister(data->trig);
@@ -705,35 +793,67 @@ static int kxcjk1013_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	int ret;
 
 	mutex_lock(&data->mutex);
-	kxcjk1013_set_mode(data, STANDBY);
+	ret = kxcjk1013_set_mode(data, STANDBY);
 	mutex_unlock(&data->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int kxcjk1013_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	int ret = 0;
 
 	mutex_lock(&data->mutex);
+	/* Check, if the suspend occured while active */
+	if (data->trigger_on)
+		ret = kxcjk1013_set_mode(data, OPERATION);
+	mutex_unlock(&data->mutex);
 
-	if (data->power_state)
-		kxcjk1013_set_mode(data, OPERATION);
+	return ret;
+}
+#endif
 
-	mutex_unlock(&data->mutex);
+#ifdef CONFIG_PM_RUNTIME
+static int kxcjk1013_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
-	return 0;
+	return kxcjk1013_set_mode(data, STANDBY);
 }
 
-static SIMPLE_DEV_PM_OPS(kxcjk1013_pm_ops, kxcjk1013_suspend, kxcjk1013_resume);
-#define KXCJK1013_PM_OPS (&kxcjk1013_pm_ops)
-#else
-#define KXCJK1013_PM_OPS NULL
+static int kxcjk1013_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	int ret;
+	int sleep_val;
+
+	ret = kxcjk1013_set_mode(data, OPERATION);
+	if (ret < 0)
+		return ret;
+
+	sleep_val = kxcjk1013_get_startup_times(data);
+	if (sleep_val < 20000)
+		usleep_range(sleep_val, 20000);
+	else
+		msleep_interruptible(sleep_val/1000);
+
+	return 0;
+}
 #endif
 
+static const struct dev_pm_ops kxcjk1013_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(kxcjk1013_suspend, kxcjk1013_resume)
+	SET_RUNTIME_PM_OPS(kxcjk1013_runtime_suspend,
+			   kxcjk1013_runtime_resume, NULL)
+};
+
 static const struct acpi_device_id kx_acpi_match[] = {
 	{"KXCJ1013", 0},
 	{ },
@@ -751,7 +871,7 @@ static struct i2c_driver kxcjk1013_driver = {
 	.driver = {
 		.name	= KXCJK1013_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(kx_acpi_match),
-		.pm	= KXCJK1013_PM_OPS,
+		.pm	= &kxcjk1013_pm_ops,
 	},
 	.probe		= kxcjk1013_probe,
 	.remove		= kxcjk1013_remove,
-- 
1.9.1
