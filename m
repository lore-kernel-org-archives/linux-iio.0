Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35716 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbKHU1D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 15:27:03 -0500
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	k.kozlowski@samsung.com, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 1/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sun,  8 Nov 2015 12:26:58 -0800
Message-Id: <1447014418-27849-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1447014418-27849-1-git-send-email-mranostay@gmail.com>
References: <1447014418-27849-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add runtime PM support for the lidar-lite module to enable low power
mode when last device requested reading is over a second.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54 ++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 961f9f99..1a5481f 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -13,7 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
- * TODO: runtime pm, interrupt mode, and signal strength reporting
+ * TODO: interrupt mode, and signal strength reporting
  */
 
 #include <linux/err.h>
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -37,6 +38,7 @@
 
 #define LIDAR_REG_DATA_HBYTE	0x0f
 #define LIDAR_REG_DATA_LBYTE	0x10
+#define LIDAR_REG_PWR_CONTROL	0x65
 
 #define LIDAR_DRV_NAME "lidar"
 
@@ -90,6 +92,12 @@ static inline int lidar_write_control(struct lidar_data *data, int val)
 	return i2c_smbus_write_byte_data(data->client, LIDAR_REG_CONTROL, val);
 }
 
+static inline int lidar_write_power(struct lidar_data *data, int val)
+{
+	return i2c_smbus_write_byte_data(data->client,
+					 LIDAR_REG_PWR_CONTROL, val);
+}
+
 static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
 {
 	int ret;
@@ -116,6 +124,8 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 	int tries = 10;
 	int ret;
 
+	pm_runtime_get_sync(&client->dev);
+
 	/* start sample */
 	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
 	if (ret < 0) {
@@ -144,6 +154,8 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 		}
 		ret = -EIO;
 	}
+	pm_runtime_mark_last_busy(&client->dev);
+	pm_runtime_put_autosuspend(&client->dev);
 
 	return ret;
 }
@@ -243,6 +255,15 @@ static int lidar_probe(struct i2c_client *client,
 	if (ret)
 		goto error_unreg_buffer;
 
+	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+
+	pm_runtime_mark_last_busy(&client->dev);
+	pm_runtime_idle(&client->dev);
+
 	return 0;
 
 error_unreg_buffer:
@@ -258,6 +279,9 @@ static int lidar_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+
 	return 0;
 }
 
@@ -273,10 +297,38 @@ static const struct of_device_id lidar_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, lidar_dt_ids);
 
+#ifdef CONFIG_PM
+static int lidar_pm_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct lidar_data *data = iio_priv(indio_dev);
+
+	return lidar_write_power(data, 0x0f);
+}
+
+static int lidar_pm_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct lidar_data *data = iio_priv(indio_dev);
+	int ret = lidar_write_power(data, 0);
+
+	/* regulator and FPGA needs settling time */
+	usleep_range(15000, 20000);
+
+	return ret;
+}
+#endif
+
+static const struct dev_pm_ops lidar_pm_ops = {
+	SET_RUNTIME_PM_OPS(lidar_pm_runtime_suspend,
+			   lidar_pm_runtime_resume, NULL)
+};
+
 static struct i2c_driver lidar_driver = {
 	.driver = {
 		.name	= LIDAR_DRV_NAME,
 		.of_match_table	= of_match_ptr(lidar_dt_ids),
+		.pm	= &lidar_pm_ops,
 	},
 	.probe		= lidar_probe,
 	.remove		= lidar_remove,
-- 
1.9.1

