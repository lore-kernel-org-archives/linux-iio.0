Return-Path: <SRS0=rP5t=JT=mail.steuer-voss.de=nv@kernel.org>
Message-Id: <1212fde5edcf360231282c9d2487712fc5b4d6f8.1530599660.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date: Tue, 3 Jul 2018 07:41:00 +0200
Subject: [PATCH v2 1/2] IIO: st_accel_i2c.c: Simplify access to driver data
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, nv@vosn.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

Use device_get_match_data API to simplify access to driver data.
Let acpi_device_id table entries point to the same driver data as
of_device_id table entries and uniquify access to driver data by using
device_get_match_data API.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel_i2c.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 6bdec8c451e0..163f7ec189b0 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -14,8 +14,8 @@
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/of_device.h>
 
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
@@ -143,6 +143,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *adata;
+	const char *match;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
@@ -151,19 +152,13 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 
 	adata = iio_priv(indio_dev);
 
-	if (client->dev.of_node) {
-		st_sensors_of_name_probe(&client->dev, st_accel_of_match,
-					 client->name, sizeof(client->name));
-	} else if (ACPI_HANDLE(&client->dev)) {
-		ret = st_sensors_match_acpi_device(&client->dev);
-		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
-			return -ENODEV;
+	match = of_device_get_match_data(&client->dev);
 
-		strlcpy(client->name, st_accel_id_table[ret].name,
-				sizeof(client->name));
-	} else if (!id)
-		return -ENODEV;
+	if (!match)
+		match = acpi_device_get_match_data(&client->dev);
 
+	if (match)
+		strlcpy(client->name, match, sizeof(client->name));
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
-- 
2.17.1
