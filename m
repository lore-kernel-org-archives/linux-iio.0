Return-Path: <SRS0=yIYx=6C=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/6] staging: iio: tsl2x7x: add of_match table for device tree support
Date: Thu, 29 Jun 2017 13:03:47 -0400
Message-Id: <20170629170352.11264-2-masneyb@onstation.org>
In-Reply-To: <20170629170352.11264-1-masneyb@onstation.org>
References: <20170629170352.11264-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Add device tree support for the tsl2x7x IIO driver with no custom
properties.

Signed-off-by: Brian Masney <masneyb@onstation.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/trivial-devices.txt | 10 ++++++++++
 drivers/staging/iio/light/tsl2x7x.c                   | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 35f406d..0e6e953 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -21,6 +21,16 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 ams,iaq-core		AMS iAQ-Core VOC Sensor
+amstaos,tsl2571		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2671		AMS/TAOS ALS and proximity sensor
+amstaos,tmd2671		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2771		AMS/TAOS ALS and proximity sensor
+amstaos,tmd2771		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2572		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2672		AMS/TAOS ALS and proximity sensor
+amstaos,tmd2672		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2772		AMS/TAOS ALS and proximity sensor
+amstaos,tmd2772		AMS/TAOS ALS and proximity sensor
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 1467199..3f4f1f3 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -2026,6 +2026,21 @@ static struct i2c_device_id tsl2x7x_idtable[] = {
 
 MODULE_DEVICE_TABLE(i2c, tsl2x7x_idtable);
 
+static const struct of_device_id tsl2x7x_of_match[] = {
+        { .compatible = "amstaos,tsl2571" },
+        { .compatible = "amstaos,tsl2671" },
+        { .compatible = "amstaos,tmd2671" },
+        { .compatible = "amstaos,tsl2771" },
+        { .compatible = "amstaos,tmd2771" },
+        { .compatible = "amstaos,tsl2572" },
+        { .compatible = "amstaos,tsl2672" },
+        { .compatible = "amstaos,tmd2672" },
+        { .compatible = "amstaos,tsl2772" },
+        { .compatible = "amstaos,tmd2772" },
+        {}
+};
+MODULE_DEVICE_TABLE(of, tsl2x7x_of_match);
+
 static const struct dev_pm_ops tsl2x7x_pm_ops = {
 	.suspend = tsl2x7x_suspend,
 	.resume  = tsl2x7x_resume,
@@ -2035,6 +2050,7 @@ static const struct dev_pm_ops tsl2x7x_pm_ops = {
 static struct i2c_driver tsl2x7x_driver = {
 	.driver = {
 		.name = "tsl2x7x",
+		.of_match_table = tsl2x7x_of_match,
 		.pm = &tsl2x7x_pm_ops,
 	},
 	.id_table = tsl2x7x_idtable,
-- 
2.9.4
