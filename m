Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/10 v4] iio: pressure: bmp280: add power management
Date: Thu, 30 Jun 2016 03:48:53 +0200
Message-Id: <1467251334-30594-10-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The PM280 has an internal standby-mode, but to really save power
we should shut the sensor down and disconnect the power. With
the proper .pm hooks we can enable both runtime and system power
management of the sensor. We use the *force callbacks from the
system PM hooks. When the sensor comes back we always reconfigure
it to make sure it is ready to roll as expected.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Simplified return statments in runtime suspend/resume hooks.
- Move before calibration optimization patch so the controversial
  stuff is at the end of the series.
- Rebased, edit "runtime PM ops" to "PM ops"
ChangeLog v0->v3:
- New patch on top of the reworked patches: we can add runtime PM,
  so we should.
---
 drivers/iio/pressure/bmp280-core.c | 58 ++++++++++++++++++++++++++++++++++++++
 drivers/iio/pressure/bmp280-i2c.c  |  1 +
 drivers/iio/pressure/bmp280-spi.c  |  1 +
 drivers/iio/pressure/bmp280.h      |  3 ++
 4 files changed, 63 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index b2858fbc1049..e8f534240f2d 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h> /* For irq_get_irq_data() */
 #include <linux/completion.h>
+#include <linux/pm_runtime.h>
 
 #include "bmp280.h"
 
@@ -336,6 +337,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	pm_runtime_get_sync(data->dev);
 	mutex_lock(&data->lock);
 
 	switch (mask) {
@@ -380,6 +382,8 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	}
 
 	mutex_unlock(&data->lock);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
 }
@@ -444,6 +448,7 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		pm_runtime_get_sync(data->dev);
 		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -460,6 +465,8 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		mutex_unlock(&data->lock);
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
 		break;
 	default:
 		return -EINVAL;
@@ -1026,6 +1033,18 @@ int bmp280_common_probe(struct device *dev,
 		dev_err(dev, "unable to register IIO device\n");
 		goto out_disable_vdda;
 	}
+
+	/* Enable runtime PM */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	/*
+	 * Set autosuspend to two orders of magnitude larger than the
+	 * start-up time.
+	 */
+	pm_runtime_set_autosuspend_delay(dev, data->start_up_time *100);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put(dev);
 	return 0;
 
 out_disable_vdda:
@@ -1040,12 +1059,51 @@ int bmp280_common_remove(struct device *dev)
 {
 	struct bmp280_data *data = dev_get_drvdata(dev);
 
+	pm_runtime_get_sync(data->dev);
+	pm_runtime_put_noidle(data->dev);
+	pm_runtime_disable(data->dev);
 	regulator_disable(data->vdda);
 	regulator_disable(data->vddd);
 	return 0;
 }
 EXPORT_SYMBOL(bmp280_common_remove);
 
+#ifdef CONFIG_PM
+static int bmp280_runtime_suspend(struct device *dev)
+{
+	struct bmp280_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_disable(data->vdda);
+	if (ret)
+		return ret;
+	return regulator_disable(data->vddd);
+}
+
+static int bmp280_runtime_resume(struct device *dev)
+{
+	struct bmp280_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_enable(data->vddd);
+	if (ret)
+		return ret;
+	ret = regulator_enable(data->vdda);
+	if (ret)
+		return ret;
+	msleep(data->start_up_time);
+	return data->chip_info->chip_config(data);
+}
+#endif /* CONFIG_PM */
+
+const struct dev_pm_ops bmp280_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(bmp280_runtime_suspend,
+			   bmp280_runtime_resume, NULL)
+};
+EXPORT_SYMBOL(bmp280_dev_pm_ops);
+
 MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
 MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 8cf8a900bdaa..03742b15b72a 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -78,6 +78,7 @@ static struct i2c_driver bmp280_i2c_driver = {
 		.name	= "bmp280",
 		.acpi_match_table = ACPI_PTR(bmp280_acpi_i2c_match),
 		.of_match_table = of_match_ptr(bmp280_of_i2c_match),
+		.pm = &bmp280_dev_pm_ops,
 	},
 	.probe		= bmp280_i2c_probe,
 	.remove		= bmp280_i2c_remove,
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index cd365ba74b68..17bc95586f9e 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -113,6 +113,7 @@ static struct spi_driver bmp280_spi_driver = {
 	.driver = {
 		.name = "bmp280",
 		.of_match_table = bmp280_of_spi_match,
+		.pm = &bmp280_dev_pm_ops,
 	},
 	.id_table = bmp280_spi_id,
 	.probe = bmp280_spi_probe,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 573334b8e93b..2c770e13be0e 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -107,3 +107,6 @@ int bmp280_common_probe(struct device *dev,
 			const char *name,
 			int irq);
 int bmp280_common_remove(struct device *dev);
+
+/* PM ops */
+extern const struct dev_pm_ops bmp280_dev_pm_ops;
-- 
2.4.11
