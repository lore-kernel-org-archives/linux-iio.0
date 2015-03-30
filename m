Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:45402
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbbC3IfS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 04:35:18 -0400
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH v3 4/5] iio: mlx90614: Add power management
Date: Mon, 30 Mar 2015 10:35:01 +0200
Message-Id: <1427704502-22347-5-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
References: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for system sleep and runtime power management.

To wake up the device, the SDA line should be held low for at least 33ms
while SCL is high.  As this is not possible using the i2c API (and not
supported by all i2c adapters), a GPIO connected to the SDA line is
needed.  The GPIO is named "wakeup" and can be specified in a device
tree with the "wakeup-gpios" binding.

If the wake-up GPIO is not given, disable power management for the
device.  Entering sleep requires an SMBus byte access, hence power
management is also disabled if byte access is not supported by the
adapter.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>

---

The default autosleep delay (5s) is chosen arbitrarily, trying to take
into account the long startup time (250ms).  Feel free to change it to
another value if you think it is saner.

I did not roll the bodies of _pm_runtime_{suspend,resume} into
one-liners as they would exceed 80 columns, requiring an (IMO ugly) line
break.  Besides, the first two lines are coherent with other functions,
which arguably makes the code easier to read.  No problem changing it
though if you disagree.

v3: * split out basic devicetree documentation in new patch
    * make remove the reverse of probe
v2: return -EINTR when the startup delay is interrupted
---
 .../bindings/iio/temperature/mlx90614.txt          |   9 +
 drivers/iio/temperature/mlx90614.c                 | 246 ++++++++++++++++++++-
 2 files changed, 253 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
index 4c959f3..9be57b0 100644
--- a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
+++ b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
@@ -7,9 +7,18 @@ Required properties:
   - compatible: should be "melexis,mlx90614"
   - reg: the I2C address of the sensor
 
+Optional properties:
+
+  - wakeup-gpios: device tree identifier of the GPIO connected to the SDA line
+      to hold low in order to wake up the device.  In normal operation, the
+      GPIO is set as input and will not interfere in I2C communication.  There
+      is no need for a GPIO driving the SCL line.  If no GPIO is given, power
+      management is disabled.
+
 Example:
 
 mlx90614@5a {
 	compatible = "melexis,mlx90614";
 	reg = <0x5a>;
+	wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
 };
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index a307d8c..73ec767 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -12,13 +12,24 @@
  *
  * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
  *
- * TODO: sleep mode, filter configuration
+ * To wake up from sleep mode, the SDA line must be held low while SCL is high
+ * for at least 33ms.  This is achieved with an extra GPIO that can be connected
+ * directly to the SDA line.  In normal operation, the GPIO is set as input and
+ * will not interfere in I2C communication.  While the GPIO is driven low, the
+ * i2c adapter is locked since it cannot be used by other clients.  The SCL line
+ * always has a pull-up so we do not need an extra GPIO to drive it high.  If
+ * the "wakeup" GPIO is not given, power management will be disabled.
+ *
+ * TODO: filter configuration
  */
 
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/gpio/consumer.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/iio/iio.h>
 
@@ -52,9 +63,13 @@
 #define MLX90614_TIMING_WAKEUP 34 /* time to hold SDA low for wake-up */
 #define MLX90614_TIMING_STARTUP 250 /* time before first data after wake-up */
 
+#define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
+
 struct mlx90614_data {
 	struct i2c_client *client;
 	struct mutex lock; /* for EEPROM access only */
+	struct gpio_desc *wakeup_gpio; /* NULL to disable sleep/wake-up */
+	unsigned long ready_timestamp; /* in jiffies */
 };
 
 /*
@@ -95,6 +110,54 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
 	return ret;
 }
 
+#ifdef CONFIG_PM
+/*
+ * If @startup is true, make sure MLX90614_TIMING_STARTUP ms have elapsed since
+ * the last wake-up.  This is normally only needed to get a valid temperature
+ * reading.  EEPROM access does not need such delay.
+ * Return 0 on success, <0 on error.
+ */
+static int mlx90614_power_get(struct mlx90614_data *data, bool startup)
+{
+	unsigned long now;
+
+	if (!data->wakeup_gpio)
+		return 0;
+
+	pm_runtime_get_sync(&data->client->dev);
+
+	if (startup) {
+		now = jiffies;
+		if (time_before(now, data->ready_timestamp) &&
+		    msleep_interruptible(jiffies_to_msecs(
+				data->ready_timestamp - now)) != 0) {
+			pm_runtime_put_autosuspend(&data->client->dev);
+			return -EINTR;
+		}
+	}
+
+	return 0;
+}
+
+static void mlx90614_power_put(struct mlx90614_data *data)
+{
+	if (!data->wakeup_gpio)
+		return;
+
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+}
+#else
+static inline int mlx90614_power_get(struct mlx90614_data *data, bool startup)
+{
+	return 0;
+}
+
+static inline void mlx90614_power_put(struct mlx90614_data *data)
+{
+}
+#endif
+
 static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long mask)
@@ -125,7 +188,12 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
+		ret = mlx90614_power_get(data, true);
+		if (ret < 0)
+			return ret;
 		ret = i2c_smbus_read_word_data(data->client, cmd);
+		mlx90614_power_put(data);
+
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -138,10 +206,12 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		*val = 20;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
+		mlx90614_power_get(data, false);
 		mutex_lock(&data->lock);
 		ret = i2c_smbus_read_word_data(data->client,
 					       MLX90614_EMISSIVITY);
 		mutex_unlock(&data->lock);
+		mlx90614_power_put(data);
 
 		if (ret < 0)
 			return ret;
@@ -172,10 +242,12 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		val = val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259 */
 
+		mlx90614_power_get(data, false);
 		mutex_lock(&data->lock);
 		ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY,
 					  val);
 		mutex_unlock(&data->lock);
+		mlx90614_power_put(data);
 
 		if (ret < 0)
 			return ret;
@@ -235,6 +307,98 @@ static const struct iio_info mlx90614_info = {
 	.driver_module = THIS_MODULE,
 };
 
+#ifdef CONFIG_PM
+static int mlx90614_sleep(struct mlx90614_data *data)
+{
+	s32 ret;
+
+	if (!data->wakeup_gpio) {
+		dev_dbg(&data->client->dev, "Sleep disabled");
+		return -ENOSYS;
+	}
+
+	dev_dbg(&data->client->dev, "Requesting sleep");
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
+			     data->client->flags | I2C_CLIENT_PEC,
+			     I2C_SMBUS_WRITE, MLX90614_OP_SLEEP,
+			     I2C_SMBUS_BYTE, NULL);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int mlx90614_wakeup(struct mlx90614_data *data)
+{
+	if (!data->wakeup_gpio) {
+		dev_dbg(&data->client->dev, "Wake-up disabled");
+		return -ENOSYS;
+	}
+
+	dev_dbg(&data->client->dev, "Requesting wake-up");
+
+	i2c_lock_adapter(data->client->adapter);
+	gpiod_direction_output(data->wakeup_gpio, 0);
+	msleep(MLX90614_TIMING_WAKEUP);
+	gpiod_direction_input(data->wakeup_gpio);
+	i2c_unlock_adapter(data->client->adapter);
+
+	data->ready_timestamp = jiffies +
+			msecs_to_jiffies(MLX90614_TIMING_STARTUP);
+
+	/*
+	 * Quirk: the i2c controller may get confused right after the
+	 * wake-up signal has been sent.  As a workaround, do a dummy read.
+	 * If the read fails, the controller will probably be reset so that
+	 * further reads will work.
+	 */
+	i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
+
+	return 0;
+}
+
+/* Return wake-up GPIO or NULL if sleep functionality should be disabled. */
+static struct gpio_desc *mlx90614_probe_wakeup(struct i2c_client *client)
+{
+	struct gpio_desc *gpio;
+
+	if (!i2c_check_functionality(client->adapter,
+						I2C_FUNC_SMBUS_WRITE_BYTE)) {
+		dev_info(&client->dev,
+			 "i2c adapter does not support SMBUS_WRITE_BYTE, sleep disabled");
+		return NULL;
+	}
+
+	gpio = devm_gpiod_get_optional(&client->dev, "wakeup", GPIOD_IN);
+
+	if (IS_ERR(gpio)) {
+		dev_warn(&client->dev,
+			 "gpio acquisition failed with error %ld, sleep disabled",
+			 PTR_ERR(gpio));
+		return NULL;
+	} else if (!gpio) {
+		dev_info(&client->dev,
+			 "wakeup-gpio not found, sleep disabled");
+	}
+
+	return gpio;
+}
+#else
+static inline int mlx90614_sleep(struct mlx90614_data *data)
+{
+	return -ENOSYS;
+}
+static inline int mlx90614_wakeup(struct mlx90614_data *data)
+{
+	return -ENOSYS;
+}
+static inline struct gpio_desc *mlx90614_probe_wakeup(struct i2c_client *client)
+{
+	return NULL;
+}
+#endif
+
 /* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
 static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
 {
@@ -266,6 +430,9 @@ static int mlx90614_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
+	data->wakeup_gpio = mlx90614_probe_wakeup(client);
+
+	mlx90614_wakeup(data);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
@@ -288,12 +455,30 @@ static int mlx90614_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	if (data->wakeup_gpio) {
+		pm_runtime_set_autosuspend_delay(&client->dev,
+						 MLX90614_AUTOSLEEP_DELAY);
+		pm_runtime_use_autosuspend(&client->dev);
+		pm_runtime_set_active(&client->dev);
+		pm_runtime_enable(&client->dev);
+	}
+
 	return iio_device_register(indio_dev);
 }
 
 static int mlx90614_remove(struct i2c_client *client)
 {
-	iio_device_unregister(i2c_get_clientdata(client));
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mlx90614_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	if (data->wakeup_gpio) {
+		pm_runtime_disable(&client->dev);
+		if (!pm_runtime_status_suspended(&client->dev))
+			mlx90614_sleep(data);
+		pm_runtime_set_suspended(&client->dev);
+	}
 
 	return 0;
 }
@@ -304,10 +489,67 @@ static const struct i2c_device_id mlx90614_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mlx90614_id);
 
+#ifdef CONFIG_PM_SLEEP
+static int mlx90614_pm_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90614_data *data = iio_priv(indio_dev);
+
+	if (data->wakeup_gpio && pm_runtime_active(dev))
+		return mlx90614_sleep(data);
+
+	return 0;
+}
+
+static int mlx90614_pm_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	int err;
+
+	if (data->wakeup_gpio) {
+		err = mlx90614_wakeup(data);
+		if (err < 0)
+			return err;
+
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int mlx90614_pm_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90614_data *data = iio_priv(indio_dev);
+
+	return mlx90614_sleep(data);
+}
+
+static int mlx90614_pm_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90614_data *data = iio_priv(indio_dev);
+
+	return mlx90614_wakeup(data);
+}
+#endif
+
+static const struct dev_pm_ops mlx90614_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mlx90614_pm_suspend, mlx90614_pm_resume)
+	SET_RUNTIME_PM_OPS(mlx90614_pm_runtime_suspend,
+			   mlx90614_pm_runtime_resume, NULL)
+};
+
 static struct i2c_driver mlx90614_driver = {
 	.driver = {
 		.name	= "mlx90614",
 		.owner	= THIS_MODULE,
+		.pm	= &mlx90614_pm_ops,
 	},
 	.probe = mlx90614_probe,
 	.remove = mlx90614_remove,
-- 
2.3.4

