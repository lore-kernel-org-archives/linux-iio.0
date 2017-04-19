Return-Path: <SRS0=kKly=33=canonical.com=shrirang.bagul@kernel.org>
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linus.walleij@linaro.org,
	lorenzo.bianconi83@gmail.com,
	gregor.boirie@parrot.com,
	rob@kernel.org,
	linux-kernel@vger.kernel.org,
	m.niestroj@grinn-global.com
Subject: [PATCH] iio: st_pressure: st_accel: Initialise sensor platform data properly
Date: Wed, 19 Apr 2017 22:05:00 +0800
Message-Id: <20170419140500.7793-1-shrirang.bagul@canonical.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the sensor platform data initialisation for st_pressure
and st_accel device drivers. Without this patch, the driver fails to
register the sensors when the user removes and re-loads the driver.

1. Unload the kernel modules for st_pressure
$ sudo rmmod st_pressure_i2c
$ sudo rmmod st_pressure

2. Re-load the driver
$ sudo insmod st_pressure
$ sudo insmod st_pressure_i2c
--- OR ---
$ sudo modprobe st_pressure_i2c

dmesg errors:

[ 160.935707] iio iio:device2: DRDY on pdata not valid.
[ 160.941505] st-press-i2c: probe of i2c-SMO9210:00 failed with error -22

The driver fails to register the pressure sensor device. Devices
supported by st_accel driver also suffer from the same bug.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 drivers/iio/accel/st_accel_core.c       | 7 ++++---
 drivers/iio/pressure/st_pressure_core.c | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 784670e2736b..07d1489cd457 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -710,6 +710,8 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =
+		(struct st_sensors_platform_data *)adata->dev->platform_data;
 	int irq = adata->get_irq_data_ready(indio_dev);
 	int err;
 
@@ -736,9 +738,8 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 					&adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!adata->dev->platform_data)
-		adata->dev->platform_data =
-			(struct st_sensors_platform_data *)&default_accel_pdata;
+	if (!pdata)
+		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
 
 	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
 	if (err < 0)
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 5f2680855552..0d8d5665769a 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -567,6 +567,8 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =
+		(struct st_sensors_platform_data *)press_data->dev->platform_data;
 	int irq = press_data->get_irq_data_ready(indio_dev);
 	int err;
 
@@ -602,10 +604,8 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
 
 	/* Some devices don't support a data ready pin. */
-	if (!press_data->dev->platform_data &&
-				press_data->sensor_settings->drdy_irq.addr)
-		press_data->dev->platform_data =
-			(struct st_sensors_platform_data *)&default_press_pdata;
+	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
+		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
 
 	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
 	if (err < 0)
-- 
2.11.0
