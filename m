Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38125 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbcKXFfo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 00:35:44 -0500
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        denis.ciocca@st.com, tiberiu.a.breana@intel.com,
        lorenzo.bianconi83@gmail.com, linus.walleij@linaro.org,
        gregor.boirie@parrot.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH 3/3] iio: st_pressure: Support i2c probe using acpi
Date: Thu, 24 Nov 2016 13:33:45 +0800
Message-Id: <20161124053345.11254-4-shrirang.bagul@canonical.com>
In-Reply-To: <20161124053345.11254-1-shrirang.bagul@canonical.com>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Compatible strings are not available on ACPI based systems. This patch adds
support to use DSDT information read from platform BIOS instead for probing
st pressure sensors.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 drivers/iio/pressure/st_pressure.h     |  8 ++++++
 drivers/iio/pressure/st_pressure_i2c.c | 51 +++++++++++++++++++++++++---------
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index 903a21e..7d99593 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -14,6 +14,14 @@
 #include <linux/types.h>
 #include <linux/iio/common/st_sensors.h>
 
+enum st_press_type {
+	LPS001WP,
+	LPS25H,
+	LPS331AP,
+	LPS22HB,
+	ST_PRESS_MAX,
+};
+
 #define LPS001WP_PRESS_DEV_NAME		"lps001wp"
 #define LPS25H_PRESS_DEV_NAME		"lps25h"
 #define LPS331AP_PRESS_DEV_NAME		"lps331ap"
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index ed18701..17417a4 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
@@ -43,25 +44,56 @@ MODULE_DEVICE_TABLE(of, st_press_of_match);
 #define st_press_of_match NULL
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id st_press_acpi_match[] = {
+	{"SNO9210", LPS22HB},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, st_press_acpi_match);
+#else
+#define st_press_acpi_match NULL
+#endif
+
+static const struct i2c_device_id st_press_id_table[] = {
+	{ LPS001WP_PRESS_DEV_NAME, LPS001WP },
+	{ LPS25H_PRESS_DEV_NAME,  LPS25H },
+	{ LPS331AP_PRESS_DEV_NAME, LPS331AP },
+	{ LPS22HB_PRESS_DEV_NAME, LPS22HB },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, st_press_id_table);
+
 static int st_press_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *press_data;
-	int err;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*press_data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	press_data = iio_priv(indio_dev);
-	st_sensors_of_i2c_probe(client, st_press_of_match);
+
+	if (client->dev.of_node) {
+		st_sensors_of_i2c_probe(client, st_press_of_match);
+	} else if (ACPI_HANDLE(&client->dev)) {
+		ret = st_sensors_match_acpi_device(&client->dev);
+		if ((ret < 0) || (ret >= ST_PRESS_MAX))
+			return -ENODEV;
+
+		strncpy(client->name, st_press_id_table[ret].name,
+				sizeof(client->name));
+		client->name[sizeof(client->name) - 1] = '\0';
+	} else if (!id)
+		return -ENODEV;
 
 	st_sensors_i2c_configure(indio_dev, client, press_data);
 
-	err = st_press_common_probe(indio_dev);
-	if (err < 0)
-		return err;
+	ret = st_press_common_probe(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -73,18 +105,11 @@ static int st_press_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id st_press_id_table[] = {
-	{ LPS001WP_PRESS_DEV_NAME },
-	{ LPS25H_PRESS_DEV_NAME },
-	{ LPS331AP_PRESS_DEV_NAME },
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, st_press_id_table);
-
 static struct i2c_driver st_press_driver = {
 	.driver = {
 		.name = "st-press-i2c",
 		.of_match_table = of_match_ptr(st_press_of_match),
+		.acpi_match_table = ACPI_PTR(st_press_acpi_match),
 	},
 	.probe = st_press_i2c_probe,
 	.remove = st_press_i2c_remove,
-- 
2.9.3

