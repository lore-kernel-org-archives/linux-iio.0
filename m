Return-Path: <ktsai@capellamicro.com>
From: Kevin Tsai <ktsai@capellamicro.com>
To: Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron <jic23@kernel.org>,
  Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
  Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/1] iio: light: Added PM support for Capella CM3232 ambient light sensor driver.
Date: Thu, 19 Feb 2015 15:02:51 -0800
Message-Id: <1424386971-811-1-git-send-email-ktsai@capellamicro.com>
List-ID: <linux-iio@vger.kernel.org>

Added Power Management Support.

Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
---
v2:
Added CONFIG_PM_SLEEP to suspend/resume functions to fix the build warning
when CONFIG_PM_SLEEP is not selected.

v1:
Added Power Management support.

 drivers/iio/light/cm3232.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 90e3519..39c8d99 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -378,6 +378,39 @@ static const struct i2c_device_id cm3232_id[] = {
 	{}
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int cm3232_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct cm3232_chip *chip = iio_priv(indio_dev);
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	chip->regs_cmd |= CM3232_CMD_ALS_DISABLE;
+	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
+					chip->regs_cmd);
+
+	return ret;
+}
+
+static int cm3232_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct cm3232_chip *chip = iio_priv(indio_dev);
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	chip->regs_cmd &= ~CM3232_CMD_ALS_DISABLE;
+	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
+					chip->regs_cmd | CM3232_CMD_ALS_RESET);
+
+	return ret;
+}
+
+static const struct dev_pm_ops cm3232_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cm3232_suspend, cm3232_resume)};
+#endif
+
 MODULE_DEVICE_TABLE(i2c, cm3232_id);
 
 static const struct of_device_id cm3232_of_match[] = {
@@ -390,6 +423,9 @@ static struct i2c_driver cm3232_driver = {
 		.name	= "cm3232",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(cm3232_of_match),
+#ifdef CONFIG_PM_SLEEP
+		.pm	= &cm3232_pm_ops,
+#endif
 	},
 	.id_table	= cm3232_id,
 	.probe		= cm3232_probe,
-- 
1.8.3.1
