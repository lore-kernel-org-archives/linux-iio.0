Return-Path: <SRS0=DglD=JU=mail.steuer-voss.de=nv@kernel.org>
Message-Id: <e8cb86f843d6b524b671f8fd79fece02475a61c0.1530710826.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de>
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date: Tue, 3 Jul 2018 07:41:00 +0200
Subject: [PATCH v3 1/2] IIO: st_accel_i2c.c: Simplify access to driver data
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

Use device_get_match_data API to simplify access to driver data.
Let acpi_device_id table entries point to the same driver data as
of_device_id table entries and uniquify access to driver data by using
device_get_match_data API. Remove unused i2c_device_id .driver_data
fields.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel_i2c.c | 56 ++++++++++++++------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 6bdec8c451e0..c6e08c834f11 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -14,8 +14,8 @@
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/property.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_accel.h"
 
@@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id st_accel_acpi_match[] = {
-	{"SMO8A90", LNG2DM},
+	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
@@ -116,24 +116,24 @@ MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
 #endif
 
 static const struct i2c_device_id st_accel_id_table[] = {
-	{ LSM303DLH_ACCEL_DEV_NAME, LSM303DLH },
-	{ LSM303DLHC_ACCEL_DEV_NAME, LSM303DLHC },
-	{ LIS3DH_ACCEL_DEV_NAME, LIS3DH },
-	{ LSM330D_ACCEL_DEV_NAME, LSM330D },
-	{ LSM330DL_ACCEL_DEV_NAME, LSM330DL },
-	{ LSM330DLC_ACCEL_DEV_NAME, LSM330DLC },
-	{ LIS331DLH_ACCEL_DEV_NAME, LIS331DLH },
-	{ LSM303DL_ACCEL_DEV_NAME, LSM303DL },
-	{ LSM303DLM_ACCEL_DEV_NAME, LSM303DLM },
-	{ LSM330_ACCEL_DEV_NAME, LSM330 },
-	{ LSM303AGR_ACCEL_DEV_NAME, LSM303AGR },
-	{ LIS2DH12_ACCEL_DEV_NAME, LIS2DH12 },
-	{ LIS3L02DQ_ACCEL_DEV_NAME, LIS3L02DQ },
-	{ LNG2DM_ACCEL_DEV_NAME, LNG2DM },
-	{ H3LIS331DL_ACCEL_DEV_NAME, H3LIS331DL },
-	{ LIS331DL_ACCEL_DEV_NAME, LIS331DL },
-	{ LIS3LV02DL_ACCEL_DEV_NAME, LIS3LV02DL },
-	{ LIS2DW12_ACCEL_DEV_NAME, LIS2DW12 },
+	{ LSM303DLH_ACCEL_DEV_NAME },
+	{ LSM303DLHC_ACCEL_DEV_NAME },
+	{ LIS3DH_ACCEL_DEV_NAME },
+	{ LSM330D_ACCEL_DEV_NAME },
+	{ LSM330DL_ACCEL_DEV_NAME },
+	{ LSM330DLC_ACCEL_DEV_NAME },
+	{ LIS331DLH_ACCEL_DEV_NAME },
+	{ LSM303DL_ACCEL_DEV_NAME },
+	{ LSM303DLM_ACCEL_DEV_NAME },
+	{ LSM330_ACCEL_DEV_NAME },
+	{ LSM303AGR_ACCEL_DEV_NAME },
+	{ LIS2DH12_ACCEL_DEV_NAME },
+	{ LIS3L02DQ_ACCEL_DEV_NAME },
+	{ LNG2DM_ACCEL_DEV_NAME },
+	{ H3LIS331DL_ACCEL_DEV_NAME },
+	{ LIS331DL_ACCEL_DEV_NAME },
+	{ LIS3LV02DL_ACCEL_DEV_NAME },
+	{ LIS2DW12_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
@@ -143,6 +143,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *adata;
+	const char *match;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
@@ -151,19 +152,10 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 
 	adata = iio_priv(indio_dev);
 
-	if (client->dev.of_node) {
-		st_sensors_of_name_probe(&client->dev, st_accel_of_match,
-					 client->name, sizeof(client->name));
-	} else if (ACPI_HANDLE(&client->dev)) {
-		ret = st_sensors_match_acpi_device(&client->dev);
-		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
-			return -ENODEV;
-
-		strlcpy(client->name, st_accel_id_table[ret].name,
-				sizeof(client->name));
-	} else if (!id)
-		return -ENODEV;
+	match = device_get_match_data(&client->dev);
 
+	if (match)
+		strlcpy(client->name, match, sizeof(client->name));
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
-- 
2.17.1
