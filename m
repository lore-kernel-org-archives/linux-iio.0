Return-Path: <k.kozlowski@samsung.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] iio: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 14:54:14 +0900
Message-id: <1436507654-17570-1-git-send-email-k.kozlowski@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/iio/accel/bma180.c                 | 1 -
 drivers/iio/accel/st_accel_i2c.c           | 1 -
 drivers/iio/adc/mcp3422.c                  | 1 -
 drivers/iio/adc/ti-adc081c.c               | 1 -
 drivers/iio/dac/ad5064.c                   | 1 -
 drivers/iio/dac/ad5380.c                   | 1 -
 drivers/iio/dac/ad5446.c                   | 1 -
 drivers/iio/dac/max5821.c                  | 1 -
 drivers/iio/gyro/itg3200_core.c            | 1 -
 drivers/iio/gyro/st_gyro_i2c.c             | 1 -
 drivers/iio/humidity/si7005.c              | 1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 1 -
 drivers/iio/light/apds9300.c               | 1 -
 drivers/iio/light/bh1750.c                 | 1 -
 drivers/iio/light/cm32181.c                | 1 -
 drivers/iio/light/cm3232.c                 | 1 -
 drivers/iio/light/cm36651.c                | 1 -
 drivers/iio/light/gp2ap020a00f.c           | 1 -
 drivers/iio/light/isl29125.c               | 1 -
 drivers/iio/light/jsa1212.c                | 1 -
 drivers/iio/light/ltr501.c                 | 1 -
 drivers/iio/light/tcs3414.c                | 1 -
 drivers/iio/light/tcs3472.c                | 1 -
 drivers/iio/light/tsl4531.c                | 1 -
 drivers/iio/light/vcnl4000.c               | 1 -
 drivers/iio/magnetometer/st_magn_i2c.c     | 1 -
 drivers/iio/pressure/ms5611_i2c.c          | 1 -
 drivers/iio/pressure/st_pressure_i2c.c     | 1 -
 drivers/iio/temperature/mlx90614.c         | 1 -
 drivers/iio/temperature/tmp006.c           | 1 -
 30 files changed, 30 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 75c6d2103e07..f04b88406995 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -846,7 +846,6 @@ MODULE_DEVICE_TABLE(i2c, bma180_ids);
 static struct i2c_driver bma180_driver = {
 	.driver = {
 		.name	= "bma180",
-		.owner	= THIS_MODULE,
 		.pm	= BMA180_PM_OPS,
 	},
 	.probe		= bma180_probe,
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index d4ad72ca4a3d..a2f1c20319eb 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -122,7 +122,6 @@ MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
 
 static struct i2c_driver st_accel_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "st-accel-i2c",
 		.of_match_table = of_match_ptr(st_accel_of_match),
 	},
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index b96c636470ef..3555122008b4 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -404,7 +404,6 @@ MODULE_DEVICE_TABLE(of, mcp3422_of_match);
 static struct i2c_driver mcp3422_driver = {
 	.driver = {
 		.name = "mcp3422",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(mcp3422_of_match),
 	},
 	.probe = mcp3422_probe,
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index b3a82b4d1a75..2c8374f86252 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -140,7 +140,6 @@ MODULE_DEVICE_TABLE(of, adc081c_of_match);
 static struct i2c_driver adc081c_driver = {
 	.driver = {
 		.name = "adc081c",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(adc081c_of_match),
 	},
 	.probe = adc081c_probe,
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index f03b92fd3803..c067e6821496 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -630,7 +630,6 @@ MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
 static struct i2c_driver ad5064_i2c_driver = {
 	.driver = {
 		   .name = "ad5064",
-		   .owner = THIS_MODULE,
 	},
 	.probe = ad5064_i2c_probe,
 	.remove = ad5064_i2c_remove,
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 9de4c4d38280..130de9b3e0bf 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -593,7 +593,6 @@ MODULE_DEVICE_TABLE(i2c, ad5380_i2c_ids);
 static struct i2c_driver ad5380_i2c_driver = {
 	.driver = {
 		   .name = "ad5380",
-		   .owner = THIS_MODULE,
 	},
 	.probe = ad5380_i2c_probe,
 	.remove = ad5380_i2c_remove,
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 46bb62a5c1d4..07e17d72a3f3 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -569,7 +569,6 @@ MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
 static struct i2c_driver ad5446_i2c_driver = {
 	.driver = {
 		   .name = "ad5446",
-		   .owner = THIS_MODULE,
 	},
 	.probe = ad5446_i2c_probe,
 	.remove = ad5446_i2c_remove,
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 6e914495b346..28b8748ea824 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -392,7 +392,6 @@ static struct i2c_driver max5821_driver = {
 	.driver = {
 		.name	= "max5821",
 		.pm     = MAX5821_PM_OPS,
-		.owner	= THIS_MODULE,
 	},
 	.probe		= max5821_probe,
 	.remove		= max5821_remove,
diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index f0fd94055d88..c102a6325bb0 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -379,7 +379,6 @@ MODULE_DEVICE_TABLE(i2c, itg3200_id);
 
 static struct i2c_driver itg3200_driver = {
 	.driver = {
-		.owner  = THIS_MODULE,
 		.name	= "itg3200",
 		.pm	= &itg3200_pm_ops,
 	},
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 64480b16c689..6848451f817a 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -99,7 +99,6 @@ MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
 
 static struct i2c_driver st_gyro_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "st-gyro-i2c",
 		.of_match_table = of_match_ptr(st_gyro_of_match),
 	},
diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
index bdd586e6d955..91972ccd8aaf 100644
--- a/drivers/iio/humidity/si7005.c
+++ b/drivers/iio/humidity/si7005.c
@@ -177,7 +177,6 @@ MODULE_DEVICE_TABLE(i2c, si7005_id);
 static struct i2c_driver si7005_driver = {
 	.driver = {
 		.name	= "si7005",
-		.owner	= THIS_MODULE,
 	},
 	.probe = si7005_probe,
 	.id_table = si7005_id,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 17d4bb15be4d..438961233df7 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -903,7 +903,6 @@ static struct i2c_driver inv_mpu_driver = {
 	.remove		=	inv_mpu_remove,
 	.id_table	=	inv_mpu_id,
 	.driver = {
-		.owner	=	THIS_MODULE,
 		.name	=	"inv-mpu6050",
 		.pm     =       INV_MPU6050_PMOPS,
 		.acpi_match_table = ACPI_PTR(inv_acpi_match),
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 9ddde0ca9c34..e1b9fa5a7e91 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -515,7 +515,6 @@ MODULE_DEVICE_TABLE(i2c, apds9300_id);
 static struct i2c_driver apds9300_driver = {
 	.driver = {
 		.name	= APDS9300_DRV_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= APDS9300_PM_OPS,
 	},
 	.probe		= apds9300_probe,
diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 564c2b3c1a83..8b4164343f20 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -319,7 +319,6 @@ MODULE_DEVICE_TABLE(i2c, bh1750_id);
 static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
-		.owner = THIS_MODULE,
 		.pm = BH1750_PM_OPS,
 	},
 	.probe = bh1750_probe,
diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 5d12ae54d088..1c0de2f8885d 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -358,7 +358,6 @@ static struct i2c_driver cm32181_driver = {
 	.driver = {
 		.name	= "cm32181",
 		.of_match_table = of_match_ptr(cm32181_of_match),
-		.owner	= THIS_MODULE,
 	},
 	.id_table       = cm32181_id,
 	.probe		= cm32181_probe,
diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 39c8d99cc48e..1b508c65877c 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -421,7 +421,6 @@ static const struct of_device_id cm3232_of_match[] = {
 static struct i2c_driver cm3232_driver = {
 	.driver = {
 		.name	= "cm3232",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(cm3232_of_match),
 #ifdef CONFIG_PM_SLEEP
 		.pm	= &cm3232_pm_ops,
diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 39fc67e82138..2a39e141e90c 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -736,7 +736,6 @@ static struct i2c_driver cm36651_driver = {
 	.driver = {
 		.name	= "cm36651",
 		.of_match_table = cm36651_of_match,
-		.owner	= THIS_MODULE,
 	},
 	.probe		= cm36651_probe,
 	.remove		= cm36651_remove,
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 32b6449833fa..0334a814b5eb 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1640,7 +1640,6 @@ static struct i2c_driver gp2ap020a00f_driver = {
 	.driver = {
 		.name	= GP2A_I2C_NAME,
 		.of_match_table = of_match_ptr(gp2ap020a00f_of_match),
-		.owner	= THIS_MODULE,
 	},
 	.probe		= gp2ap020a00f_probe,
 	.remove		= gp2ap020a00f_remove,
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index c82f4a6f8464..acf91261af02 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -334,7 +334,6 @@ static struct i2c_driver isl29125_driver = {
 	.driver = {
 		.name	= ISL29125_DRV_NAME,
 		.pm	= &isl29125_pm_ops,
-		.owner	= THIS_MODULE,
 	},
 	.probe		= isl29125_probe,
 	.remove		= isl29125_remove,
diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 3a3af89beaf9..c4e8c6b6c3c3 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -457,7 +457,6 @@ static struct i2c_driver jsa1212_driver = {
 	.driver = {
 		.name	= JSA1212_DRIVER_NAME,
 		.pm	= JSA1212_PM_OPS,
-		.owner	= THIS_MODULE,
 		.acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
 	},
 	.probe		= jsa1212_probe,
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 1ef7d3773ab9..f4c9a5cdfed6 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1551,7 +1551,6 @@ static struct i2c_driver ltr501_driver = {
 		.name   = LTR501_DRV_NAME,
 		.pm	= &ltr501_pm_ops,
 		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
-		.owner  = THIS_MODULE,
 	},
 	.probe  = ltr501_probe,
 	.remove	= ltr501_remove,
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 71c2bde275aa..8075388aa672 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -392,7 +392,6 @@ static struct i2c_driver tcs3414_driver = {
 	.driver = {
 		.name	= TCS3414_DRV_NAME,
 		.pm	= &tcs3414_pm_ops,
-		.owner	= THIS_MODULE,
 	},
 	.probe		= tcs3414_probe,
 	.remove		= tcs3414_remove,
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 752569985d1d..1b530bf04c89 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -366,7 +366,6 @@ static struct i2c_driver tcs3472_driver = {
 	.driver = {
 		.name	= TCS3472_DRV_NAME,
 		.pm	= &tcs3472_pm_ops,
-		.owner	= THIS_MODULE,
 	},
 	.probe		= tcs3472_probe,
 	.remove		= tcs3472_remove,
diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 63c26e2d5d97..26979183d27c 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -247,7 +247,6 @@ static struct i2c_driver tsl4531_driver = {
 	.driver = {
 		.name   = TSL4531_DRV_NAME,
 		.pm	= TSL4531_PM_OPS,
-		.owner  = THIS_MODULE,
 	},
 	.probe  = tsl4531_probe,
 	.remove = tsl4531_remove,
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index d948c4778ba6..c9d85bbc9230 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -185,7 +185,6 @@ static int vcnl4000_probe(struct i2c_client *client,
 static struct i2c_driver vcnl4000_driver = {
 	.driver = {
 		.name   = VCNL4000_DRV_NAME,
-		.owner  = THIS_MODULE,
 	},
 	.probe  = vcnl4000_probe,
 	.id_table = vcnl4000_id,
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 5311d8aea8cc..28aa80731cea 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -85,7 +85,6 @@ MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
 
 static struct i2c_driver st_magn_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "st-magn-i2c",
 		.of_match_table = of_match_ptr(st_magn_of_match),
 	},
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 748fd9acaad8..9e878019bd28 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -116,7 +116,6 @@ MODULE_DEVICE_TABLE(i2c, ms5611_id);
 static struct i2c_driver ms5611_driver = {
 	.driver = {
 		.name = "ms5611",
-		.owner = THIS_MODULE,
 	},
 	.id_table = ms5611_id,
 	.probe = ms5611_i2c_probe,
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 137788bba4a3..8fcf9766eaec 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -79,7 +79,6 @@ MODULE_DEVICE_TABLE(i2c, st_press_id_table);
 
 static struct i2c_driver st_press_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "st-press-i2c",
 		.of_match_table = of_match_ptr(st_press_of_match),
 	},
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index cb2e8ad8bfdc..90f70b461567 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -551,7 +551,6 @@ static const struct dev_pm_ops mlx90614_pm_ops = {
 static struct i2c_driver mlx90614_driver = {
 	.driver = {
 		.name	= "mlx90614",
-		.owner	= THIS_MODULE,
 		.pm	= &mlx90614_pm_ops,
 	},
 	.probe = mlx90614_probe,
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index fcc49f89b946..1e979c751b0d 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -277,7 +277,6 @@ static struct i2c_driver tmp006_driver = {
 	.driver = {
 		.name	= "tmp006",
 		.pm	= &tmp006_pm_ops,
-		.owner	= THIS_MODULE,
 	},
 	.probe = tmp006_probe,
 	.remove = tmp006_remove,
-- 
1.9.1
