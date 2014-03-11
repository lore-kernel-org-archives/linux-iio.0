Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] iio: imu: inv_mpu6050: ACPI enumeration
Date: Tue, 11 Mar 2014 14:04:12 -0700
Message-Id: <1394571854-6737-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added changes so that the module can be enumerated via ACPI.
Also if there is no platform data available, it will use a default
orientation data.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index df7f1e1..4a76697 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -24,8 +24,16 @@
 #include <linux/kfifo.h>
 #include <linux/spinlock.h>
 #include <linux/iio/iio.h>
+#include <linux/acpi.h>
 #include "inv_mpu_iio.h"
 
+/* Define some default platform data, if not supplied */
+static struct inv_mpu6050_platform_data inv_def_platform_data = {
+	.orientation = {-1,  0,  0,
+			0,  1,  0,
+			0,  0, -1 }
+};
+
 /*
  * this is the gyro scale translated from dynamic range plus/minus
  * {250, 500, 1000, 2000} to rad/s
@@ -662,6 +670,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	struct inv_mpu6050_state *st;
 	struct iio_dev *indio_dev;
 	int result;
+	char *name;
 
 	if (!i2c_check_functionality(client->adapter,
 		I2C_FUNC_SMBUS_I2C_BLOCK))
@@ -673,7 +682,10 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 	st->client = client;
-	st->plat_data = *(struct inv_mpu6050_platform_data
+	if (!dev_get_platdata(&client->dev))
+		st->plat_data = inv_def_platform_data;
+	else
+		st->plat_data = *(struct inv_mpu6050_platform_data
 				*)dev_get_platdata(&client->dev);
 	/* power is turned on inside check chip type*/
 	result = inv_check_and_setup_chip(st, id);
@@ -689,7 +701,14 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->name = id->name;
+	if (id && id->name)
+		name = (char *)id->name;
+	else {
+		name = (char *)dev_name(&client->dev);
+		if (!name)
+			dev_err(&client->dev, "No iio dev name\n");
+	}
+	indio_dev->name = name;
 	indio_dev->channels = inv_mpu_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
 
@@ -770,12 +789,19 @@ static const struct i2c_device_id inv_mpu_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
 
+static const struct acpi_device_id inv_acpi_match[] = {
+	{"INVN6500", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
+
 static struct i2c_driver inv_mpu_driver = {
 	.probe		=	inv_mpu_probe,
 	.remove		=	inv_mpu_remove,
 	.id_table	=	inv_mpu_id,
 	.driver = {
 		.owner	=	THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(inv_acpi_match),
 		.name	=	"inv-mpu6050",
 		.pm     =       INV_MPU6050_PMOPS,
 	},
-- 
1.7.11.7
