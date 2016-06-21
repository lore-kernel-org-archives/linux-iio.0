Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/5] iio: magn: ak8975: deploy runtime PM
Date: Wed, 22 Jun 2016 00:18:18 +0200
Message-Id: <1466547498-15484-6-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466547498-15484-1-git-send-email-linus.walleij@linaro.org>
References: <1466547498-15484-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This adds runtime PM support to the AK8975 driver. It solves two
problems:

- After reading the first value the chip was left in MODE_ONCE,
  meaning (presumably) it may be consuming more power. Now the
  runtime PM hooks kick in and set it to POWER_DOWN.

- Regulators were simply enabled and left on, making it
  impossible to turn the power consuming regulators off because
  of the increased refcount. We now disable the regulators at
  autosuspend.

Inspired by my work on the BH1780 light sensor driver.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8975.c | 80 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 1c6e4157a91f..71a8e3348b8a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -33,6 +33,7 @@
 #include <linux/of_gpio.h>
 #include <linux/acpi.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -691,6 +692,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	const struct ak_def *def = data->def;
 	int ret;
 
+	pm_runtime_get_sync(&data->client->dev);
+
 	mutex_lock(&data->lock);
 
 	ret = ak8975_start_read_axis(data, client);
@@ -703,6 +706,9 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 	mutex_unlock(&data->lock);
 
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
 	/* Clamp to valid range. */
 	*val = clamp_t(s16, ret, -def->range, def->range);
 	return IIO_VAL_INT;
@@ -970,26 +976,95 @@ static int ak8975_probe(struct i2c_client *client,
 		goto cleanup_buffer;
 	}
 
+	/* Enable runtime PM */
+	pm_runtime_get_noresume(&client->dev);
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+	/*
+	 * The device comes online in 500us, so add two orders of magnitude
+	 * of delay before autosuspending: 50 ms.
+	 */
+	pm_runtime_set_autosuspend_delay(&client->dev, 50);
+	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_put(&client->dev);
+
 	return 0;
 
 cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 power_off:
-	ak8975_power_off(client);
+	ak8975_power_off(data);
 	return err;
 }
 
 static int ak8975_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ak8975_data *data = iio_priv(indio_dev);
 
+	pm_runtime_get_sync(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	ak8975_power_off(client);
+	ak8975_set_mode(data, POWER_DOWN);
+	ak8975_power_off(data);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ak8975_runtime_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ak8975_data *data = iio_priv(indio_dev);
+	int ret;
+
+	dev_info(&client->dev, "%s\n", __func__);
+	/* Set the device in power down if it wasn't already */
+	ret = ak8975_set_mode(data, POWER_DOWN);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error in setting power-down mode\n");
+		return ret;
+	}
+	/* Next cut the regulators */
+	ak8975_power_off(data);
 
 	return 0;
 }
 
+static int ak8975_runtime_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ak8975_data *data = iio_priv(indio_dev);
+	int ret;
+
+	dev_info(&client->dev, "%s\n", __func__);
+	/* Take up the regulators */
+	ak8975_power_on(data);
+	/*
+	 * We come up in powered down mode, the reading routines will
+	 * put us in the mode to read values later.
+	 */
+	ret = ak8975_set_mode(data, POWER_DOWN);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error in setting power-down mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops ak8975_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(ak8975_runtime_suspend,
+			   ak8975_runtime_resume, NULL)
+};
+
 static const struct i2c_device_id ak8975_id[] = {
 	{"ak8975", AK8975},
 	{"ak8963", AK8963},
@@ -1017,6 +1092,7 @@ MODULE_DEVICE_TABLE(of, ak8975_of_match);
 static struct i2c_driver ak8975_driver = {
 	.driver = {
 		.name	= "ak8975",
+		.pm = &ak8975_dev_pm_ops,
 		.of_match_table = of_match_ptr(ak8975_of_match),
 		.acpi_match_table = ACPI_PTR(ak_acpi_match),
 	},
-- 
2.4.11
