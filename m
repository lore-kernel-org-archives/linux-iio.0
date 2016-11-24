Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38114 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbcKXFfi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 00:35:38 -0500
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        denis.ciocca@st.com, tiberiu.a.breana@intel.com,
        lorenzo.bianconi83@gmail.com, linus.walleij@linaro.org,
        gregor.boirie@parrot.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH 2/3] iio: st_accel: Support sensor i2c probe using acpi
Date: Thu, 24 Nov 2016 13:33:44 +0800
Message-Id: <20161124053345.11254-3-shrirang.bagul@canonical.com>
In-Reply-To: <20161124053345.11254-1-shrirang.bagul@canonical.com>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support to probe st_accel sensors on i2c bus using ACPI. Compatible
strings are not avaialable on ACPI based systems.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 drivers/iio/accel/st_accel.h     | 18 ++++++++++
 drivers/iio/accel/st_accel_i2c.c | 73 +++++++++++++++++++++++++++-------------
 2 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 7c23168..3ad44ce 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -14,6 +14,24 @@
 #include <linux/types.h>
 #include <linux/iio/common/st_sensors.h>
 
+enum st_accel_type {
+	LSM303DLH,
+	LSM303DLHC,
+	LIS3DH,
+	LSM330D,
+	LSM330DL,
+	LSM330DLC,
+	LIS331DLH,
+	LSM303DL,
+	LSM303DLM,
+	LSM330,
+	LSM303AGR,
+	LIS2DH12,
+	LIS3L02DQ,
+	LNG2DM,
+	ST_ACCEL_MAX,
+};
+
 #define H3LIS331DL_DRIVER_NAME		"h3lis331dl_accel"
 #define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl_accel"
 #define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index c0f8867..2840649 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
@@ -95,25 +96,67 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
 #define st_accel_of_match NULL
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id st_accel_acpi_match[] = {
+	{"SMO8A90", LNG2DM},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
+#else
+#define st_accel_acpi_match NULL
+#endif
+
+static const struct i2c_device_id st_accel_id_table[] = {
+	{ LSM303DLH_ACCEL_DEV_NAME, LSM303DLH },
+	{ LSM303DLHC_ACCEL_DEV_NAME, LSM303DLHC },
+	{ LIS3DH_ACCEL_DEV_NAME, LIS3DH },
+	{ LSM330D_ACCEL_DEV_NAME, LSM330D },
+	{ LSM330DL_ACCEL_DEV_NAME, LSM330DL },
+	{ LSM330DLC_ACCEL_DEV_NAME, LSM330DLC },
+	{ LIS331DLH_ACCEL_DEV_NAME, LIS331DLH },
+	{ LSM303DL_ACCEL_DEV_NAME, LSM303DL },
+	{ LSM303DLM_ACCEL_DEV_NAME, LSM303DLM },
+	{ LSM330_ACCEL_DEV_NAME, LSM330 },
+	{ LSM303AGR_ACCEL_DEV_NAME, LSM303AGR },
+	{ LIS2DH12_ACCEL_DEV_NAME, LIS2DH12 },
+	{ LIS3L02DQ_ACCEL_DEV_NAME, LIS3L02DQ },
+	{ LNG2DM_ACCEL_DEV_NAME, LNG2DM },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
+
 static int st_accel_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *adata;
-	int err;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	adata = iio_priv(indio_dev);
-	st_sensors_of_i2c_probe(client, st_accel_of_match);
+
+	if (client->dev.of_node) {
+		st_sensors_of_i2c_probe(client, st_accel_of_match);
+	} else if (ACPI_HANDLE(&client->dev)) {
+		ret = st_sensors_match_acpi_device(&client->dev);
+		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
+			return -ENODEV;
+
+		strncpy(client->name, st_accel_id_table[ret].name,
+				sizeof(client->name));
+		client->name[sizeof(client->name) - 1] = '\0';
+	} else if (!id)
+		return -ENODEV;
+
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
-	err = st_accel_common_probe(indio_dev);
-	if (err < 0)
-		return err;
+	ret = st_accel_common_probe(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -125,29 +168,11 @@ static int st_accel_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id st_accel_id_table[] = {
-	{ LSM303DLH_ACCEL_DEV_NAME },
-	{ LSM303DLHC_ACCEL_DEV_NAME },
-	{ LIS3DH_ACCEL_DEV_NAME },
-	{ LSM330D_ACCEL_DEV_NAME },
-	{ LSM330DL_ACCEL_DEV_NAME },
-	{ LSM330DLC_ACCEL_DEV_NAME },
-	{ LIS331DLH_ACCEL_DEV_NAME },
-	{ LSM303DL_ACCEL_DEV_NAME },
-	{ LSM303DLM_ACCEL_DEV_NAME },
-	{ LSM330_ACCEL_DEV_NAME },
-	{ LSM303AGR_ACCEL_DEV_NAME },
-	{ LIS2DH12_ACCEL_DEV_NAME },
-	{ LIS3L02DQ_ACCEL_DEV_NAME },
-	{ LNG2DM_ACCEL_DEV_NAME },
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
-
 static struct i2c_driver st_accel_driver = {
 	.driver = {
 		.name = "st-accel-i2c",
 		.of_match_table = of_match_ptr(st_accel_of_match),
+		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
 	},
 	.probe = st_accel_i2c_probe,
 	.remove = st_accel_i2c_remove,
-- 
2.9.3

