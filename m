Return-Path: <SRS0=/zAB=JP=mail.steuer-voss.de=nv@kernel.org>
Message-Id: <a84243a1a15d11511061eeae2f09c0ad8154d093.1530268235.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date: Fri, 29 Jun 2018 10:10:10 +0200
Subject: [PATCH 1/3] IIO: st_accel_i2c.c: Use fallback if DT/ACPI enum failed
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

Currently, the driver bails out if not explicitly referred to in
DT or ACPI tables. This prevents fallback mechanisms from coming
into effect, e.g. I2C device ID table match via DT or ACPI
PRP0001 HID. However DT/ACPI enum should take precedence over
the fallback, so evaluate that first.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel_i2c.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 6bdec8c451e0..e360da407027 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
 
-static int st_accel_i2c_probe(struct i2c_client *client,
-						const struct i2c_device_id *id)
+static int st_accel_i2c_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *adata;
@@ -156,14 +155,18 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 					 client->name, sizeof(client->name));
 	} else if (ACPI_HANDLE(&client->dev)) {
 		ret = st_sensors_match_acpi_device(&client->dev);
-		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
-			return -ENODEV;
-
-		strlcpy(client->name, st_accel_id_table[ret].name,
+		if ((ret >= 0) && (ret < ST_ACCEL_MAX))
+			strlcpy(client->name, st_accel_id_table[ret].name,
 				sizeof(client->name));
-	} else if (!id)
-		return -ENODEV;
+	}
 
+	/*
+	 * If OF and ACPI enumeration failed, there could still be platform
+	 * information via fallback enumeration or explicit instantiation, so
+	 * check if id table has been matched via client->name.
+	 */
+	if (!client->name)
+		return -ENODEV;
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
@@ -187,7 +190,7 @@ static struct i2c_driver st_accel_driver = {
 		.of_match_table = of_match_ptr(st_accel_of_match),
 		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
 	},
-	.probe = st_accel_i2c_probe,
+	.probe_new = st_accel_i2c_probe,
 	.remove = st_accel_i2c_remove,
 	.id_table = st_accel_id_table,
 };
-- 
2.17.1
